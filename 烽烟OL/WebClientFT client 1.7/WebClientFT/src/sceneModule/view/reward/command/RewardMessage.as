package sceneModule.view.reward.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.reward.reward2401.GetRewardListRequest;
	import proto.reward.reward2401.GetRewardListResponse;
	import proto.reward.reward2401.RewardInfo;
	import proto.reward.reward2402.ObtainRewardRequest;
	import proto.reward.reward2402.ObtainRewardResponse;
	import proto.reward.reward2403.ObtainAllRewardRequest;
	import proto.reward.reward2403.ObtainAllRewardResponse;
	import proto.reward.reward2404.BattleInfo;
	import proto.reward.reward2404.BattleRoleInfo;
	import proto.reward.reward2404.GetRewardBattleInfoRequest;
	import proto.reward.reward2404.GetRewardBattleInfoResponse;
	
	import sceneModule.view.reward.vo.RewardBattleInfoVO;
	import sceneModule.view.reward.vo.RewardBattleRoleInfoVO;
	import sceneModule.view.reward.vo.RewardInfoVO;
	
	import service.ISocketServer;

	public class RewardMessage
	{
		[Inject]
		public var socketService:ISocketServer;
		
		private static var _instance:RewardMessage;
		
		public static function getInstance():RewardMessage{
			if(null == _instance){
				_instance = new RewardMessage();
			}
			return _instance;
		}
		public function RewardMessage()
		{
		}
		
		/**
		 * 获取某一页数据 
		 * @param curPage
		 * 
		 */		
		public function getRewardList(curPage:int=1):void{
//			if(curPage == 1){
//				onShift();
//			}else{
				var rewardListReq:GetRewardListRequest = new GetRewardListRequest();
				rewardListReq.id = SystemDataModel.roleId;
				rewardListReq.page = curPage;
				var byteArray:ByteArray = new ByteArray();
				rewardListReq.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(rewardListHandler,faultHandler),URLConst.REWARD_LISTINFO_COMMANDID,byteArray);
//			}
			
		}
		
		private function onShift():void{
			SystemDataModel.rewardInfo.curPage = 1;
			SystemDataModel.rewardInfo.maxPage = 1;
			var l:int = 5;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var rewardInfoVo:RewardInfoVO = new RewardInfoVO();
				rewardInfoVo.r_id = i;
				rewardInfoVo.r_type = i;
				rewardInfoVo.t_e1 = i+'aaa';
				rewardInfoVo.t_e2 = i+'aaa';
				rewardInfoVo.t_e3 = i+'aaa';
				rewardInfoVo.t_name = i+'aaa';
				arr.addItem(rewardInfoVo);
			}
			SystemDataModel.rewardInfo.rewardInfoArr.source = arr.toArray();
		}
		
		private function rewardListHandler(data:Object):void{
			var byteArray:ByteArray  = data as ByteArray;
			var responseData:GetRewardListResponse = new GetRewardListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var arr:ArrayCollection = new ArrayCollection();
				if(responseData.rewardListInfo){
					SystemDataModel.rewardInfo.curPage = responseData.rewardListInfo.curPage;
					SystemDataModel.rewardInfo.maxPage = responseData.rewardListInfo.maxPage;
					var l:int = responseData.rewardListInfo.rewardInfo.length;
					for(var i:int=0;i<l;i++){
						var rewardInfo:RewardInfo = responseData.rewardListInfo.rewardInfo[i];
						var rewardInfoVo:RewardInfoVO = new RewardInfoVO();
						rewardInfoVo.r_id = rewardInfo.rId;
						rewardInfoVo.r_type = rewardInfo.rType;
						rewardInfoVo.t_e1 = rewardInfo.tE1;
						rewardInfoVo.t_e2 = rewardInfo.tE2;
						rewardInfoVo.t_e3 = rewardInfo.tE3;
						rewardInfoVo.t_name = rewardInfo.tName;
						rewardInfoVo.t_e4 = rewardInfo.tE4;
						arr.addItem(rewardInfoVo);
					}
					SystemDataModel.rewardInfo.rewardInfoArr.source = arr.toArray();
				}else{
					SystemDataModel.rewardInfo.rewardInfoArr.source = arr.toArray();
				}
			}
		}
		
		public function obtainOneReward(r_id:int):void{
			var obtainOneRewardReq:ObtainRewardRequest = new ObtainRewardRequest();
			obtainOneRewardReq.id = SystemDataModel.roleId;
			obtainOneRewardReq.rId = r_id;
			var byteArray:ByteArray = new ByteArray();
			obtainOneRewardReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(obtainOneRewardHandler,faultHandler),URLConst.REWARD_OBTAINONE_COMMANDID,byteArray);
		}
		
		private function obtainOneRewardHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ObtainRewardResponse = new ObtainRewardResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				//领取奖励成功
				getRewardList(SystemDataModel.rewardInfo.curPage);
			}
		}
		
		public function obtainAllReward():void{
			var obtainAllRewardReq:ObtainAllRewardRequest = new ObtainAllRewardRequest();
			obtainAllRewardReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			obtainAllRewardReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(obtainAllRewardHandler,faultHandler),URLConst.REWARD_OBTAINALL_COMMANDID,byteArray);
		}
		private function obtainAllRewardHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ObtainAllRewardResponse = new ObtainAllRewardResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				//领取所有奖励成功
			}
		}
		
		public function onShiftBattle():void{
			SystemDataModel.rewardBattleVo.curPage = 1;
			SystemDataModel.rewardBattleVo.maxPage = 1;
			SystemDataModel.rewardBattleVo.r_id = 2;
			var l:int = 5;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var rewardBattleInfoVo:RewardBattleInfoVO = new RewardBattleInfoVO();
				rewardBattleInfoVo.battleName = "aaa";
				rewardBattleInfoVo.battleResult = true;
				rewardBattleInfoVo.refreshTime = "2011.11.11";
				var sl:int = 1;
				var s_arr:ArrayCollection = new ArrayCollection();
				for(var si:int=0;si<sl;si++){
					var reBaRoVo:RewardBattleRoleInfoVO = new RewardBattleRoleInfoVO();
					reBaRoVo.roleId = si;
					reBaRoVo.roleName = si+"suc";
					s_arr.addItem(reBaRoVo);
				}
				rewardBattleInfoVo.sucRoleInfoArr.source = s_arr.toArray();
				
				var fl:int = 10;
				var f_arr:ArrayCollection = new ArrayCollection();
				for(var fi:int=0;fi<fl;fi++){
					var freBaRoVo:RewardBattleRoleInfoVO = new RewardBattleRoleInfoVO();
					freBaRoVo.roleId = fi;
					freBaRoVo.roleName = fi+'fail';
					f_arr.addItem(freBaRoVo);
				}
				rewardBattleInfoVo.failRoleInfoArr.source = f_arr.toArray();
				
				arr.addItem(rewardBattleInfoVo);
			}
			SystemDataModel.rewardBattleVo.battleInfoVoArr.source = arr.toArray();
		}
		
		public function getRewardBattleInfo(pg:int=1):void{
			var rewardBattleInfoReq:GetRewardBattleInfoRequest = new GetRewardBattleInfoRequest();
			rewardBattleInfoReq.id = SystemDataModel.roleId;
//			rewardBattleInfoReq.rId = r_id;
			rewardBattleInfoReq.page = pg;
			var byteArray:ByteArray = new ByteArray();
			rewardBattleInfoReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(rewardBattleHandler,faultHandler),URLConst.REWARD_BATTLEINFO_COMMANDID,byteArray);
		}
		private function rewardBattleHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetRewardBattleInfoResponse = new GetRewardBattleInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.rewardBattleVo.curPage = responseData.battleListInfo.curPage;
				SystemDataModel.rewardBattleVo.maxPage = responseData.battleListInfo.maxPage;
				SystemDataModel.rewardBattleVo.r_id = responseData.battleListInfo.rId;
				var l:int = responseData.battleListInfo.battleInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var battleInfo:BattleInfo = responseData.battleListInfo.battleInfo[i];
					var rewardBattleInfoVo:RewardBattleInfoVO = new RewardBattleInfoVO();
					rewardBattleInfoVo.battleName = battleInfo.battleName;
					rewardBattleInfoVo.battleResult = battleInfo.battleResult;
					rewardBattleInfoVo.refreshTime = battleInfo.refreshTime;
					var sl:int = battleInfo.sucRoleInfo.length;
					var s_arr:ArrayCollection = new ArrayCollection();
					for(var si:int=0;si<sl;si++){
						var roleInfo:BattleRoleInfo = battleInfo.sucRoleInfo[si];
						var reBaRoVo:RewardBattleRoleInfoVO = new RewardBattleRoleInfoVO();
						reBaRoVo.roleId = roleInfo.roleId;
						reBaRoVo.roleName = roleInfo.roleName;
						s_arr.addItem(reBaRoVo);
					}
					rewardBattleInfoVo.sucRoleInfoArr.source = s_arr.toArray();
					
					var fl:int = battleInfo.failRoleInfo.length;
					var f_arr:ArrayCollection = new ArrayCollection();
					for(var fi:int=0;fi<fl;fi++){
						var froleInfo:BattleRoleInfo = battleInfo.failRoleInfo[fi];
						var freBaRoVo:RewardBattleRoleInfoVO = new RewardBattleRoleInfoVO();
						freBaRoVo.roleId = froleInfo.roleId;
						freBaRoVo.roleName = froleInfo.roleName;
						f_arr.addItem(freBaRoVo);
					}
					rewardBattleInfoVo.failRoleInfoArr.source = f_arr.toArray();
					
					arr.addItem(rewardBattleInfoVo);
				}
				SystemDataModel.rewardBattleVo.battleInfoVoArr.source = arr.toArray();
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
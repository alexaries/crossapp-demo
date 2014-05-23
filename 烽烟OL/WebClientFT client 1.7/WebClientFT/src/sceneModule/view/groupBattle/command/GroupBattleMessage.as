package sceneModule.view.groupBattle.command
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.groupBattle.groupBattle4400.GetGroupLingDiInfoRequest;
	import proto.groupBattle.groupBattle4400.GetGroupLingDiInfoResponse;
	import proto.groupBattle.groupBattle4401.ObtainJiangLiRequest;
	import proto.groupBattle.groupBattle4401.ObtainJiangLiResponse;
	import proto.groupBattle.groupBattle4402.CityInfo;
	import proto.groupBattle.groupBattle4402.GetCityListInfoRequest;
	import proto.groupBattle.groupBattle4402.GetCityListInfoResponse;
	import proto.groupBattle.groupBattle4403.GroupPKRequest;
	import proto.groupBattle.groupBattle4403.GroupPKResponse;
	import proto.groupBattle.groupBattle4404.GetXuYuanInfoRequest;
	import proto.groupBattle.groupBattle4404.GetXuYuanInfoResponse;
	import proto.groupBattle.groupBattle4404.UsedInfo;
	import proto.groupBattle.groupBattle4405.UseXingYunRequest;
	import proto.groupBattle.groupBattle4405.UseXingYunResponse;
	import proto.groupBattle.groupBattle4406.BattleInfo;
	import proto.groupBattle.groupBattle4406.GetBattleInfoRequest;
	import proto.groupBattle.groupBattle4406.GetBattleInfoResponse;
	import proto.groupBattle.groupBattle4406.GroupMember;
	import proto.groupBattle.groupBattle4407.JoinBattleRequest;
	import proto.groupBattle.groupBattle4407.JoinBattleResponse;
	import proto.groupBattle.groupBattle4408.AutoJoinBattleRequest;
	import proto.groupBattle.groupBattle4408.AutoJoinBattleResponse;
	import proto.groupBattle.groupBattle4409.CancelBattleRequest;
	
	import sceneModule.view.groupBattle.vo.BattleInfoVO;
	import sceneModule.view.groupBattle.vo.CityInfoVO;
	import sceneModule.view.groupBattle.vo.GroupMemberVO;
	import sceneModule.view.groupBattle.vo.UsedInfoVO;
	
	import service.ISocketServer;

	public class GroupBattleMessage extends EventDispatcher
	{
		[Inject]
		public var socket:ISocketServer;
		
		private static var _instance:GroupBattleMessage;
		public function GroupBattleMessage()
		{
		}
		
		public static function getInstance():GroupBattleMessage{
			if(!_instance){
				_instance = new GroupBattleMessage();
			}
			
			return _instance;
		}
		
		/**
		 * 军团领地 
		 */		
		public function getGroupLingDiInfo():void{
			var ldReq:GetGroupLingDiInfoRequest = new GetGroupLingDiInfoRequest();
			ldReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			ldReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(ldHandler,faultHandler),URLConst.GROUPBATTLE_LINGDI_COMMANDID,byteArray);
		}
		
		private function ldHandler(data:Object):void{
			var ldRes:GetGroupLingDiInfoResponse = new GetGroupLingDiInfoResponse();
			var byteArray:ByteArray = data as ByteArray;
			ldRes.readExternal(byteArray);
			if(ldRes.result){
				SystemDataModel.groupBattleInfo.lingdiInfo.battleTime = ldRes.groupInfo.battleTime;
				SystemDataModel.groupBattleInfo.lingdiInfo.groupLeader = ldRes.groupInfo.groupLeader;
				SystemDataModel.groupBattleInfo.lingdiInfo.groupLevel = ldRes.groupInfo.groupLevel;
				SystemDataModel.groupBattleInfo.lingdiInfo.groupName = ldRes.groupInfo.groupName;
				SystemDataModel.groupBattleInfo.lingdiInfo.icon = ldRes.groupInfo.icon;
				SystemDataModel.groupBattleInfo.lingdiInfo.ldType = ldRes.groupInfo.ldType;
				SystemDataModel.groupBattleInfo.lingdiInfo.obtainJL = ldRes.groupInfo.obtainJL;
				SystemDataModel.groupBattleInfo.lingdiInfo.battleInfo.source = ldRes.groupInfo.battleInfo;
			}
		}
		
		public function getGroupLingDiInfoJia():void{
			SystemDataModel.groupBattleInfo.lingdiInfo.battleTime = 360000;
			SystemDataModel.groupBattleInfo.lingdiInfo.groupLeader = '垃圾费';
			SystemDataModel.groupBattleInfo.lingdiInfo.groupLevel = 3;
			SystemDataModel.groupBattleInfo.lingdiInfo.groupName = '大法师';
			SystemDataModel.groupBattleInfo.lingdiInfo.icon = 3;
			SystemDataModel.groupBattleInfo.lingdiInfo.ldType = 2;
			SystemDataModel.groupBattleInfo.lingdiInfo.obtainJL = false;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<4;i++){
				arr.addItem('2012alskdflasdjlfkasdfjaksfdkjalsdfjk');
			}
			SystemDataModel.groupBattleInfo.lingdiInfo.battleInfo.source = arr.toArray();
		}
		
		public function ontainJiangLi():void{
			var obReq:ObtainJiangLiRequest = new ObtainJiangLiRequest();
			obReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			obReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(obHandler,faultHandler),URLConst.GROUPBATTLE_OBTAIN_COMMANDID,byteArray);
		}
		
		private function obHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ObtainJiangLiResponse = new ObtainJiangLiResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.groupBattleInfo.lingdiInfo.obtainJL = true;
			}
		}
		
		public function getCityListInfo():void{
			var clReq:GetCityListInfoRequest = new GetCityListInfoRequest();
			clReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			clReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(clHandler,faultHandler),URLConst.GROUPBATTLE_CITYLIST_COMMANDID,byteArray);
		}
		
		private function clHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetCityListInfoResponse = new GetCityListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.cityInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var cityInfo:CityInfo = responseData.cityInfo[i];
					var cityInfoVo:CityInfoVO = new CityInfoVO();
					cityInfoVo.btnState = cityInfo.btnState;
					cityInfoVo.lzIcon = cityInfo.lzIcon;
					cityInfoVo.lzName = cityInfo.lzName;
					cityInfoVo.tzIcon = cityInfo.tzIcon;
					cityInfoVo.tzName = cityInfo.tzName;
					cityInfoVo.cityId = i + 1;
					arr.addItem(cityInfoVo);
				}
				SystemDataModel.groupBattleInfo.cityList.source = arr.toArray();
			}
		}
		
		public function onPK(pkId:int):void{
			var pkReq:GroupPKRequest = new GroupPKRequest();
			pkReq.id = SystemDataModel.roleId;
			pkReq.pkId = pkId;
			var byteArray:ByteArray = new ByteArray();
			pkReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(pkHandler,faultHandler),URLConst.GROUPBATTLE_PK_COMMANDID,byteArray);
		}
		
		private function pkHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GroupPKResponse = new GroupPKResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getCityListInfo();
			}
		}
		
		public function getCityListInfoJia():void{
			var l:int = 9;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var cityInfoVo:CityInfoVO = new CityInfoVO();
				cityInfoVo.btnState = 0;
				cityInfoVo.lzIcon = 1;
				cityInfoVo.lzName = 'asdfas';
				cityInfoVo.tzIcon = 1;
				cityInfoVo.tzName = 'sfasdfa';
				arr.addItem(cityInfoVo);
			}
			SystemDataModel.groupBattleInfo.cityList.source = arr.toArray();
		}
		
		public function getXuYuanInfo():void{
			var xyReq:GetXuYuanInfoRequest = new GetXuYuanInfoRequest();
			xyReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			xyReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(xyHandler,faultHandler),URLConst.GROUPBATTLE_XUYUAN_COMMANDID,byteArray);
		}
		
		private function xyHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetXuYuanInfoResponse = new GetXuYuanInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.groupBattleInfo.xuyuanInfo.xyValue = responseData.xuYuanInfo.xyValue;
				var l:int = responseData.xuYuanInfo.usedInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var usedInfo:UsedInfo = responseData.xuYuanInfo.usedInfo[i];
					var usedInfoVo:UsedInfoVO = new UsedInfoVO();
					usedInfoVo.name = usedInfo.name;
					usedInfoVo.typ = usedInfo.type;
					switch(usedInfo.type){
						case 0:
							usedInfoVo.des = "<font color='#ff0000'>"+usedInfoVo.name+"</font>通过使用<font color='#ff0000'>四叶草</font>获得<font color='#ff0000'>5</font>点幸运.";
							break;
						case 1:
							usedInfoVo.des = "<font color='#ff0000'>"+usedInfoVo.name+"</font>通过使用<font color='#ff0000'>郁金香</font>获得<font color='#ff0000'>10</font>点幸运.";
							break;
						case 2:
							usedInfoVo.des = "<font color='#ff0000'>"+usedInfoVo.name+"</font>通过使用<font color='#ff0000'>蝴蝶兰</font>获得<font color='#ff0000'>15</font>点幸运.";
							break;
						case 3:
							usedInfoVo.des = "<font color='#ff0000'>"+usedInfoVo.name+"</font>通过使用<font color='#ff0000'>紫罗兰</font>获得<font color='#ff0000'>20</font>点幸运.";
							break;
						case 4:
							usedInfoVo.des = "<font color='#ff0000'>"+usedInfoVo.name+"</font>通过使用<font color='#ff0000'>曼陀罗</font>获得<font color='#ff0000'>25</font>点幸运.";
							break;
					}
					arr.addItem(usedInfoVo);
					
				}
				SystemDataModel.groupBattleInfo.xuyuanInfo.usedInfo.source = arr.toArray();
			}
		}
		
		public function getXuYuanInfoJia():void{
			SystemDataModel.groupBattleInfo.xuyuanInfo.xyValue = 200;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<4;i++){
				var usedInfoVo:UsedInfoVO = new UsedInfoVO();
				usedInfoVo.name = '四谛法';
				usedInfoVo.typ = i+1;
				arr.addItem(usedInfoVo);
				
			}
			SystemDataModel.groupBattleInfo.xuyuanInfo.usedInfo.source = arr.toArray();
		}
		
		public function useXuYuan(type:int):void{
			var useReq:UseXingYunRequest = new UseXingYunRequest();
			useReq.id = SystemDataModel.roleId;
			useReq.type = type;
			var byteArray:ByteArray = new ByteArray();
			useReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(useXYHandler,faultHandler),URLConst.GROUPBATTLE_USEXUYUAN_COMMANDID,byteArray);
		}
		
		private function useXYHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:UseXingYunResponse = new UseXingYunResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getXuYuanInfo();
			}
		}
		
		public function getGroupBattleInfo():void{
			var batReq:GetBattleInfoRequest = new GetBattleInfoRequest();
			batReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			batReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(batHandler,faultHandler),URLConst.GROUPBATTLE_BATTLEINFO_COMMANDID,byteArray);
		}
		
		private function batHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetBattleInfoResponse = new GetBattleInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.groupBattleInfo.groupBattleInfo.failCount = responseData.groupBattleInfo.failCount;
				SystemDataModel.groupBattleInfo.groupBattleInfo.jishaCount = responseData.groupBattleInfo.jishaCount;
				SystemDataModel.groupBattleInfo.groupBattleInfo.obtainCoin = responseData.groupBattleInfo.obtainCoin;
				SystemDataModel.groupBattleInfo.groupBattleInfo.obtainSw = responseData.groupBattleInfo.obtainSw;
				SystemDataModel.groupBattleInfo.groupBattleInfo.remainTime = responseData.groupBattleInfo.remainTime;
				SystemDataModel.groupBattleInfo.groupBattleInfo.roundCount = responseData.groupBattleInfo.roundCount;
				SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.groupCount = responseData.groupBattleInfo.group1Info.groupCount;
				SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.groupName = responseData.groupBattleInfo.group1Info.groupName;
				SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.icon = responseData.groupBattleInfo.group1Info.icon;
				var l1:int=responseData.groupBattleInfo.group1Info.groupMember.length;
				var arr_mem:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l1;i++){
					var gMember:GroupMember = responseData.groupBattleInfo.group1Info.groupMember[i];
					var gMemberVo:GroupMemberVO = new GroupMemberVO();
					gMemberVo.memberId = gMember.memberId;
					gMemberVo.memberName = gMember.memberName;
					arr_mem.addItem(gMemberVo);
				}
				SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.groupMemberArr.source = arr_mem.toArray();
				SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.groupCount = responseData.groupBattleInfo.group2Info.groupCount;
				SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.groupName = responseData.groupBattleInfo.group2Info.groupName;
				SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.icon = responseData.groupBattleInfo.group2Info.icon;
				var l2:int=responseData.groupBattleInfo.group2Info.groupMember.length;
				var arr_mem2:ArrayCollection = new ArrayCollection();
				for(var i2:int=0;i2<l2;i2++){
					var gMember2:GroupMember = responseData.groupBattleInfo.group2Info.groupMember[i2];
					var gMemberVo2:GroupMemberVO = new GroupMemberVO();
					gMemberVo2.memberId = gMember2.memberId;
					gMemberVo2.memberName = gMember2.memberName;
					arr_mem2.addItem(gMemberVo2);
				}
				SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.groupMemberArr.source = arr_mem2.toArray();
				var bl:int = responseData.groupBattleInfo.battleInfoList.length;
				var bArr:ArrayCollection = new ArrayCollection();
				for(var i3:int=0;i3<bl;i3++){
					var bInfo:BattleInfo = responseData.groupBattleInfo.battleInfoList[i3];
					var bInfoVo:BattleInfoVO = new BattleInfoVO();
					bInfoVo.roleId1 = bInfo.roleId1;
					bInfoVo.roleName1 = bInfo.roleName1;
					bInfoVo.roleId2 = bInfo.roleId2;
					bInfoVo.roleName2 = bInfo.roleName2;
					bInfoVo.desBat = '<u><a href="event:'+bInfo.roleId1+'?'+bInfo.roleName1+'">'+bInfo.roleName1+'</a></u>战胜了'+'<u><a href="event:'+bInfo.roleId2+'?'+bInfo.roleName2+'">'+bInfo.roleName2+'</a></u>获得'+bInfo.sucObCoin+'金币,2威望.'
					bArr.addItem(bInfoVo);
				}
				SystemDataModel.groupBattleInfo.groupBattleInfo.battleInfoList.source = bArr.toArray();
			}
		}
		
		public function getGroupBattleInfoJia():void{
			SystemDataModel.groupBattleInfo.groupBattleInfo.failCount = 999;
			SystemDataModel.groupBattleInfo.groupBattleInfo.jishaCount = 9999;
			SystemDataModel.groupBattleInfo.groupBattleInfo.obtainCoin = 99999;
			SystemDataModel.groupBattleInfo.groupBattleInfo.obtainSw = 9;
			SystemDataModel.groupBattleInfo.groupBattleInfo.remainTime = 3600000;
			SystemDataModel.groupBattleInfo.groupBattleInfo.roundCount = 2;
			SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.groupCount = 99;
			SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.groupName = '9999';
			SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.icon = 9;
			var arr_mem:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<20;i++){
				var gMemberVo:GroupMemberVO = new GroupMemberVO();
				gMemberVo.memberId = i+1;
				gMemberVo.memberName = i+'_aaa';
				arr_mem.addItem(gMemberVo);
			}
			SystemDataModel.groupBattleInfo.groupBattleInfo.group1Info.groupMemberArr.source = arr_mem.toArray();
			SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.groupCount = 89;
			SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.groupName = '8989';
			SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.icon = 8;
			var arr_mem2:ArrayCollection = new ArrayCollection();
			for(var i2:int=0;i2<18;i2++){
				var gMemberVo2:GroupMemberVO = new GroupMemberVO();
				gMemberVo2.memberId = i2+20;
				gMemberVo2.memberName = i2+'_bbb';
				arr_mem2.addItem(gMemberVo2);
			}
			SystemDataModel.groupBattleInfo.groupBattleInfo.group2Info.groupMemberArr.source = arr_mem2.toArray();
			var bArr:ArrayCollection = new ArrayCollection();
			for(var i3:int=0;i3<5;i3++){
				var bInfoVo:BattleInfoVO = new BattleInfoVO();
				bInfoVo.roleId1 = i3+10;
				bInfoVo.roleName1 = i3+'ccc';
				bInfoVo.roleId2 = i3+30;
				bInfoVo.roleName2 = i3+'ddd';
				bInfoVo.desBat = '<u><a href="event:'+bInfoVo.roleId1+'?'+bInfoVo.roleName1+'">'+bInfoVo.roleName1+'</a></u>战胜了'+'<u><a href="event:'+bInfoVo.roleId2+'?'+bInfoVo.roleName2+'">'+bInfoVo.roleName2+'</a></u>获得1000金币,50威望.'
				bArr.addItem(bInfoVo);
			}
			SystemDataModel.groupBattleInfo.groupBattleInfo.battleInfoList.source = bArr.toArray();
		}
		
		public function joinGroupBattle():void{
			var jbReq:JoinBattleRequest = new JoinBattleRequest();
			jbReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			jbReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(jbHandler,faultHandler),URLConst.GROUPBATTLE_JOINBATTLE_COMMANDID,byteArray);
		}
		
		private function jbHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JoinBattleResponse = new JoinBattleResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getGroupBattleInfo();
			}
		}
		
		public function autoJoinBattle(flag:Boolean):void{
			var autoReq:AutoJoinBattleRequest = new AutoJoinBattleRequest();
			autoReq.id = SystemDataModel.roleId;
			autoReq.autoJoinFlag = flag;
			var byteArray:ByteArray = new ByteArray();
			autoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(autoHandler,faultHandler),URLConst.GROUPBATTLE_AUTOJOIN_COMMANDID,byteArray);
		}
		
		private function autoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:AutoJoinBattleResponse = new AutoJoinBattleResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				
			}
		}
		
		public function cancelGroupBattle():void{
			var cancelReq:CancelBattleRequest = new CancelBattleRequest();
			cancelReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			cancelReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(cancalHandler,faultHandler),URLConst.GROUPBATTLE_CANCEL_COMMANDID,byteArray);
		}
		
		private function cancalHandler(data:Object):void{
			
		}
		
		public function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
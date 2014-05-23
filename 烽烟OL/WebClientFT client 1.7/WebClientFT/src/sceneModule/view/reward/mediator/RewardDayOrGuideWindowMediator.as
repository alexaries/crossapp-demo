package sceneModule.view.reward.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.reward.reward2410.GetRewardInfoRequest;
	import proto.reward.reward2410.GetRewardInfoResponse;
	import proto.reward.reward2411.ObtainTodayAndEveryDayRewardRequest;
	import proto.reward.reward2411.ObtainTodayAndEveryDayRewardResponse;
	
	import resource.AssetCenter;
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.reward.event.MediatorRegisterRewardEvent;
	import sceneModule.view.reward.view.RewardDayOrGuideWindow;
	import sceneModule.view.reward.vo.RewardDayInfoVO;
	
	import service.ISocketServer;
	
	import util.PackageIitemInfoSettingUtil;

	public class RewardDayOrGuideWindowMediator extends Mediator
	{
		[Inject]
		public var comp:RewardDayOrGuideWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketService:ISocketServer;
		public function RewardDayOrGuideWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			eventMap.mapListener(comp,MediatorRegisterRewardEvent.MEDIATORREGISTERREWARDDAYORGUIDEEVENT,onRegisterItemRenderMediator);
			
			this.eventMap.mapListener(comp.obAllReBtn,MouseEvent.CLICK,onObtainReward);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			getRewardInfo();
			setTitleInfo();
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterRewardEvent):void{
			mediatorMap.createMediator(evt._view);
		}
		
		private function setTitleInfo():void{
			if(comp.data.type != 0){
				for each(var item:XML in AssetCenter.getInstance().rewardDes_xml.info){
					if(comp.data.type == item.@type){
						comp.reward_tile.text = item.@des;
					}
				}
			}
		}
		
		private function getRewardInfo():void{
			var getRewardInfoReq:GetRewardInfoRequest = new GetRewardInfoRequest();
			getRewardInfoReq.id = SystemDataModel.roleId;
			getRewardInfoReq.rType = comp.data.type;
			var byteArray:ByteArray = new ByteArray();
			getRewardInfoReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(rewardHandler,faultHandler),URLConst.REWARD_GETINFO_COMMANDID,byteArray);
		}
		
		private function rewardHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetRewardInfoResponse = new GetRewardInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.rewardInfo){
				var arrCol:ArrayCollection = new ArrayCollection();
				if(responseData.rewardInfo.gold != 0){
					var rewardInfo:RewardDayInfoVO = new RewardDayInfoVO();
					rewardInfo.type = 1;
					rewardInfo.rewardNum = responseData.rewardInfo.gold;
					arrCol.addItem(rewardInfo);
				}
				if(responseData.rewardInfo.zuan != 0){
					var rewardZInfo:RewardDayInfoVO = new RewardDayInfoVO();
					rewardZInfo.type = 2;
					rewardZInfo.rewardNum = responseData.rewardInfo.zuan;
					arrCol.addItem(rewardZInfo);
				}
				if(responseData.rewardInfo.tili != 0){
					var rewardTInfo:RewardDayInfoVO = new RewardDayInfoVO();
					rewardTInfo.type = 3;
					rewardTInfo.rewardNum = responseData.rewardInfo.tili;
					arrCol.addItem(rewardTInfo);
				}
				if(responseData.rewardInfo.itemInfo.length != 0){
					var l:int = responseData.rewardInfo.itemInfo.length;
					for(var i:int=0;i<l;i++){
						var rewardIInfo:RewardDayInfoVO = new RewardDayInfoVO();
						rewardIInfo.type = 0;
						rewardIInfo.itemsBonus = CrotaItemConfig.getItemInfoByTempleteId(responseData.rewardInfo.itemInfo[i].templateId);
						PackageIitemInfoSettingUtil.setItemDefaultInfo2(rewardIInfo.itemsBonus,responseData.rewardInfo.itemInfo[i]);
						arrCol.addItem(rewardIInfo);
					}
				}
				if(arrCol.length > 3){
//					trace('奖励长度出错.....');
					return;
				}
				if(arrCol.length == 1){
					comp.rewardList.x = 136;
				}else if(arrCol.length == 2){
					comp.rewardList.x = 103;
				}else if(arrCol.length == 3){
					comp.rewardList.x = 55;
				}
				comp.rewardList.dataProvider = arrCol;
				comp.iTextArea.htmlText = responseData.rewardInfo.rewardDes;
				comp.obAllReBtn.enabled = true;
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onObtainReward(evt:MouseEvent):void{
			//领取奖励TODO
			var obtainRewardReq:ObtainTodayAndEveryDayRewardRequest = new ObtainTodayAndEveryDayRewardRequest();
			obtainRewardReq.id = SystemDataModel.roleId;
			obtainRewardReq.type = comp.data.type;
			var byteArray:ByteArray = new ByteArray();
			obtainRewardReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(obtainHandler,faultHandler),URLConst.REWARD_OBTAINDAY_COMMAND,byteArray);
			onCloseWindow();
		}
		private function obtainHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ObtainTodayAndEveryDayRewardResponse = new ObtainTodayAndEveryDayRewardResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('reward','rdogIR_lqcg'));
			    //领取成功	
//				WindowManager.createWindow(NCorpAlert.NAME,{msg:'奖励领取成功!'},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			}
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			WindowManager.closeWindow(RewardDayOrGuideWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
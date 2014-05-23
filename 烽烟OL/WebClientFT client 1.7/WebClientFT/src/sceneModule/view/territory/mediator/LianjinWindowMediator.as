package sceneModule.view.territory.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.territory.territory2800.GetWaJueInfoRequest;
	import proto.territory.territory2800.GetWaJueInfoResponse;
	import proto.territory.territory2801.StartWaJueRequest;
	import proto.territory.territory2801.StartWaJueResponse;
	import proto.territory.territory2802.DianShiChengJiRequest;
	import proto.territory.territory2802.DianShiChengJiResponse;
	import proto.territory.territory2803.LevelUpSpeedWaJueRequest;
	import proto.territory.territory2803.LevelUpSpeedWaJueResponse;
	import proto.territory.territory2804.NowSuccWaJueRequest;
	import proto.territory.territory2804.NowSuccWaJueResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.territory.view.LianjinWindow;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class LianjinWindowMediator extends Mediator
	{
		
		[Inject]
		public var comp:LianjinWindow;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function LianjinWindowMediator()
		{
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.stBtn,MouseEvent.CLICK,onStartWaJue);
			this.eventMap.mapListener(comp.nowBtn,MouseEvent.CLICK,onNowSuccess);
			this.eventMap.mapListener(comp.dishiBtn,MouseEvent.CLICK,onDianShi);
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCloseWindow);
			getLianjinInfo();
		}
		
		private function onStartWaJue(evt:MouseEvent):void{
			//开始挖掘
			var startWaReq:StartWaJueRequest = new StartWaJueRequest();
			startWaReq.id = SystemDataModel.roleId;
			startWaReq.type = getCurSelectedType();
			var byteArray:ByteArray = new ByteArray();
			startWaReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(startHandler,faultHandler),URLConst.TERRITORY_STARTWUJUE_COMMANDID,byteArray);
		}
		private function startHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:StartWaJueResponse = new StartWaJueResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_TIEKUANGDONG)]);
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_yks'));
				comp.rb1.enabled=false;
				comp.rb2.enabled=false;
				comp.rb3.enabled=false;
				comp.rb4.enabled=false;
				getLianjinInfo();
			}
		}
		
		private function getLianjinInfo():void{
			var getWaJueReq:GetWaJueInfoRequest = new GetWaJueInfoRequest();
			getWaJueReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getWaJueReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(wajueHandler,faultHandler),URLConst.TERRITORY_GETLIANJININFO_COMMANDID,byteArray);
			if(comp.reward_tile.visible==true)
			{
				comp.rb1.enabled=false;
				comp.rb2.enabled=false;
				comp.rb3.enabled=false;
				comp.rb4.enabled=false;
			}
		}
		
		private function wajueHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetWaJueInfoResponse = new GetWaJueInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.lianjinInfoVo.runningFlag = responseData.runningTask;
				SystemDataModel.lianjinInfoVo.remainTime = responseData.remainTime;
				SystemDataModel.lianjinInfoVo.sptimes = responseData.sptimes;
				SystemDataModel.lianjinInfoVo.coinbound = responseData.coinbound;
				SystemDataModel.lianjinInfoVo.goldreq = responseData.goldreq;
			}
		}
		
		private function onNowSuccess(evt:MouseEvent):void{
			 if(SystemDataModel.roleInfo.gold>=80&&comp.rb1.selected)
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_sf80')+SystemDataModel.roleInfo.level*300*8+"金币",
					null, null, null, null, nowFinishWajue, null);
			}
			else if(SystemDataModel.roleInfo.gold>=120&&comp.rb2.selected)
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_sf120')+SystemDataModel.roleInfo.level*300*12+"金币",
					null, null, null, null, nowFinishWajue, null);
			}
			else if(SystemDataModel.roleInfo.gold>=160&&comp.rb3.selected)
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_sf160')+SystemDataModel.roleInfo.level*300*16+"金币",
					null, null, null, null, nowFinishWajue, null);
			}
			else if(SystemDataModel.roleInfo.gold>=240&&comp.rb4.selected)
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_sf240')+SystemDataModel.roleInfo.level*300*24+"金币",
					null, null, null, null, nowFinishWajue, null);
			}
			else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_wfwj'));
			}
		}
		
		private function nowFinishWajue(data:MouseEvent):void
		{
				var nowReq:NowSuccWaJueRequest = new NowSuccWaJueRequest();
				nowReq.id = SystemDataModel.roleId;
				var byteArray:ByteArray = new ByteArray();
				nowReq.writeExternal(byteArray);
				socketServer.send(new mx.rpc.Responder(nowHandler,faultHandler),URLConst.TERRITORY_NOWSUC_COMMANDID,byteArray);
		}
		
		private function nowHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:NowSuccWaJueResponse = new NowSuccWaJueResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getLianjinInfo();
				comp.rb1.enabled=true;
				comp.rb2.enabled=true;
				comp.rb3.enabled=true;
				comp.rb4.enabled=true;
			}
		}
		
//		private function onSpeedUp(evt:MouseEvent):void{
//			//加速
//			var speedUpReq:LevelUpSpeedWaJueRequest = new LevelUpSpeedWaJueRequest();
//			speedUpReq.id = SystemDataModel.roleId;
//			speedUpReq.type = getCurSelectedType();
//			var byteArray:ByteArray = new ByteArray();
//			speedUpReq.writeExternal(byteArray);
//			socketServer.send(new mx.rpc.Responder(speedUpHandler,faultHandler),URLConst.TERRITORY_SPEEDUP_COMMANDID,byteArray);
//		}
//		
//		private function speedUpHandler(data:Object):void{
//			var byteArray:ByteArray = data as ByteArray;
//			var responseData:LevelUpSpeedWaJueResponse = new LevelUpSpeedWaJueResponse();
//			responseData.readExternal(byteArray);
//			if(responseData.result){
//				getLianjinInfo();
//			}
//		}
		
		private function onDianShi(evt:MouseEvent):void{
			if(comp.showPromptCB.selected)
			{
				nowFinish(evt);
			}else
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('sg','asgCC_sfxh') + SystemDataModel.lianjinInfoVo.goldreq + CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_zhd')+SystemDataModel.lianjinInfoVo.coinbound+CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjW_jb'),
					null, null, null, null, nowFinish, null);
			}
			
		}
		
		private function nowFinish(data:MouseEvent):void
		{
			if(SystemDataModel.roleInfo.gold>0&&SystemDataModel.lianjinInfoVo.sptimes>0)
			{
				//点石成金
				var dianshiReq:DianShiChengJiRequest = new DianShiChengJiRequest();
				dianshiReq.id = SystemDataModel.roleId;
				var byteArray:ByteArray = new ByteArray();
				dianshiReq.writeExternal(byteArray);
				socketServer.send(new mx.rpc.Responder(dianshiHandler,faultHandler),URLConst.TERRITORY_DIANSHICHENGJIN_COMMANDID,byteArray);
				
			}else if(SystemDataModel.roleInfo.gold>0&&SystemDataModel.lianjinInfoVo.sptimes<=0)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_wfds'));
			}else if(SystemDataModel.lianjinInfoVo.sptimes>0&&SystemDataModel.roleInfo.gold<=0)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_zbz'));
			}else if(SystemDataModel.lianjinInfoVo.sptimes<=0&&SystemDataModel.roleInfo.gold<=0)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','lWM_dbz'));
			}
		}
		
		private function dianshiHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:DianShiChengJiResponse = new DianShiChengJiResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				CrotaCommonAlert.createCrotaBasicAlert(responseData.message);
				getLianjinInfo();
			}
		}
		
		private function getCurSelectedType():int{
			var iType:int;
			switch(comp.cardtype.selectedValue){
				case 'no1':
					iType = 1;
					break;
				case 'no2':
					iType = 2;
					break;
				case 'no3':
					iType = 3;
					break;
				case 'no4':
					iType = 4;
					break;
			}
			return iType;
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			WindowManager.closeWindow(LianjinWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
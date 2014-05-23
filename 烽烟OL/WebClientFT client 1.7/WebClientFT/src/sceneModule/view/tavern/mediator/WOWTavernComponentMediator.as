package sceneModule.view.tavern.mediator
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
	
	import mx.events.FlexEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.tavern.tavern3500.GetTavernListInfoRequest;
	import proto.tavern.tavern3500.GetTavernTaskInfoResponse;
	import proto.tavern.tavern3502.Get3502Request;
	import proto.tavern.tavern3502.Get3502Response;
	import proto.tavern.tavern3504.Get3504Request;
	import proto.tavern.tavern3504.Get3504Response;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.tavern.event.WOWEvent;
	import sceneModule.view.tavern.event.WOWItemRenderEvent;
	import sceneModule.view.tavern.event.XingYunWOWEvent;
	import sceneModule.view.tavern.view.WOWTavernComponent;
	import sceneModule.view.tavern.view.WOWXingYunTavernComponent;
	import sceneModule.view.wordmap.view.ChangeColorSp;
	import sceneModule.view.zhanxing.view.JiFengExchangeComponent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	/**
	 *
	 *
	 */
	public class WOWTavernComponentMediator extends Mediator
	{
		[Inject]
		public var comp:WOWTavernComponent;

		[Inject]
		public var socketService:ISocketServer;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;

		public function WOWTavernComponentMediator()
		{
			super();
		}

		override public function preRegister():void
		{
			getMoshouInfo();
			this.eventMap.mapListener(comp, WOWItemRenderEvent.WOWINFOITEMRENDER_EVENT, onWOWItemRenderComp);
			this.eventMap.mapListener(comp, WOWItemRenderEvent.WOWINFOCOMP_EVENT, onWOWItemRenderComp);
			
			this.eventMap.mapListener(comp.closeBtn, MouseEvent.CLICK, onCloseWindow);
			this.eventMap.mapListener(comp.nowRefresh, MouseEvent.CLICK, onfresh);
			this.eventMap.mapListener(comp.luckExchange, MouseEvent.CLICK, onluckExchange);
			this.eventMap.mapListener(comp.showPromptCB,FlexEvent.CHANGING,onChange);
		}
	
		private function onWOWItemRenderComp(evt:WOWItemRenderEvent):void
		{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onChange(evt:FlexEvent):void
		{
			if(comp.showPromptCB.selected)
			{
				var request3504:Get3504Request=new Get3504Request();
				request3504.id=SystemDataModel.roleId;
				request3504.npcId=10001;
				request3504.close=1;
				var byteArray:ByteArray=new ByteArray();
				request3504.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(MoshouHandler, faultHandler), URLConst.PINGBIDUIGOU_COMMANDID, byteArray);
			}else
			{
				var _request3504:Get3504Request=new Get3504Request();
				_request3504.id=SystemDataModel.roleId;
				_request3504.npcId=10001;
				_request3504.close=-1;
				var _byteArray:ByteArray=new ByteArray();
				_request3504.writeExternal(_byteArray);
				socketService.send(new mx.rpc.Responder(MoshouHandler, faultHandler), URLConst.PINGBIDUIGOU_COMMANDID, _byteArray);
			}
		}
		
		private function onluckExchange(evt:MouseEvent):void
		{
			AssetCenter.getInstance().load_package("ui_pet",to_tavernXy,null,true);
		}
		
		private function to_tavernXy():void{
			var obj:Object=new Object();
			WindowManager.createWindow(WOWXingYunTavernComponent.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer, true);
		}
		
		private function getMoshouInfo(page:int=1):void
		{
			var getTaverReq:GetTavernListInfoRequest=new GetTavernListInfoRequest();
			getTaverReq.id=SystemDataModel.roleId;
			getTaverReq.npcId=10001//SystemDataModel.tempId; //npcId
			getTaverReq.istrue=false;
			var byteArray:ByteArray=new ByteArray();
			getTaverReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(MoshouHandler, faultHandler), URLConst.MOSHOUJIUGUAN_COMMANDID, byteArray);
		}

		private function MoshouHandler(data:Object):void
		{
			dispatch(new WOWEvent(WOWEvent.WOW_EVENT, data));
			
			
		}

		private function refreHandler(data:Object):void
		{
			var responseData:GetTavernTaskInfoResponse=new GetTavernTaskInfoResponse();
			var byteArray:ByteArray=data as ByteArray;
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('tavern','wtC_sxcg'));
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.PET_PEIYANG_ACTION)]);

				getMoshouInfo();
			}else
			{
//				CrotaCommonAlert.createCrotaBasicAlert(responseData.message);
			}
			
		}
		
		
		private function faultHandler(evt:FaultEvent):void
		{
			
		}
		
		private function onCloseWindow(evt:MouseEvent):void
		{
			this.eventMap.unmapListener(comp.nowRefresh, MouseEvent.CLICK, onfresh);
			this.eventMap.unmapListener(comp.luckExchange, MouseEvent.CLICK, onluckExchange);
			this.eventMap.unmapListener(comp.showPromptCB,FlexEvent.CHANGING,onChange);
			WindowManager.closeWindow(WOWTavernComponent.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer,mediatorMap);
		}
		
		private function onfresh(evt:MouseEvent):void
		{
//			if(SystemDataModel.roleInfo.level<21){
//				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz21'));
//				return;
//			}
			if(comp.showPromptCB.selected)
			{
				var getTaverReq:GetTavernListInfoRequest=new GetTavernListInfoRequest();
				getTaverReq.id=SystemDataModel.roleId;
				getTaverReq.npcId=10001//SystemDataModel.tempId; //npcId
				getTaverReq.istrue=true;
				var byteArray:ByteArray=new ByteArray();
				getTaverReq.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(MoshouHandler, faultHandler), URLConst.MOSHOUJIUGUAN_COMMANDID, byteArray);
//				CrotaCommonAlert.createCrotaBasicAlert("刷新宠物成功！");
			}else
			{
				var request3502:Get3502Request=new Get3502Request();
				request3502.id=SystemDataModel.roleId;
				request3502.npcId=10001;
//				request3502.close=1;
				var bytearray:ByteArray=new ByteArray();
				request3502.writeExternal(bytearray);
				socketService.send(new mx.rpc.Responder(refreshHandler, faultHandler), URLConst.NOWREFRESH_COMMANDID, bytearray);
				

			}
		}
		
		
		public function refreshHandler(data:Object):void
		{
			var responseData:Get3502Response=new Get3502Response();
			var byteArray:ByteArray=data as ByteArray;
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','cmeIRM_sfff') + responseData.gold + CrotaResourceConfig.getInstance().getTextByModuleAndId('tavern','wtCM_xdcw'),
					null, null, null, null, request_refresh, null);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.ACTION_INPUT_UNION_NAME)]);

			}else
			{
				popUpShow.show(responseData.message);
			}
			
		}
		
		public function request_refresh(data:MouseEvent):void
		{
			
			var getTaverReq:GetTavernListInfoRequest=new GetTavernListInfoRequest();
			var byteArray:ByteArray=new ByteArray();
			getTaverReq.id=SystemDataModel.roleId;
			getTaverReq.npcId=10001//SystemDataModel.tempId; //npcId
			getTaverReq.istrue=true;
			getTaverReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(refreHandler, faultHandler), URLConst.MOSHOUJIUGUAN_COMMANDID, byteArray);

		}
	}
}

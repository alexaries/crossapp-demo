package sceneModule.view.colonMan.mediator
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
	
	import proto.colo.colo2903.GetFuBenColonRequest;
	import proto.colo.colo2903.GetFuBenColonResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.colonMan.view.MainColoPrivilegeFuBenColoInfoWindow;
	import sceneModule.view.copyScene.view.ColonizationBattleByCopySceneComponent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class MainColoPrivilegeFuBenColoInfoWindowMediator extends Mediator
	{
		
		[Inject]
		public var comp:MainColoPrivilegeFuBenColoInfoWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketServer:ISocketServer;
		public function MainColoPrivilegeFuBenColoInfoWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtnWin,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.lijiBtn,MouseEvent.CLICK,onLiJi);
			getFuBenColoInfo();
		}
		private function getFuBenColoInfo():void{
			var coloReq:GetFuBenColonRequest = new GetFuBenColonRequest();
			coloReq.id = SystemDataModel.roleId;
			coloReq.cId = comp.data.cId;
			var byteArray:ByteArray = new ByteArray();
			coloReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(coloHandler,faultHandler),URLConst.COLO_FUBEN_GROUP_COLO_COMMANDID,byteArray);
		}
		
		private function coloHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetFuBenColonResponse = new GetFuBenColonResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				comp.iTextArea.htmlText = responseData.coloDes;
				comp.page_info.text  = responseData.coloNum.toString();
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onLiJi(evt:MouseEvent):void{
			if(SystemDataModel.roleInfo.level<13){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcpfbWM_djbz13'));
				return;
			}
			AssetCenter.getInstance().load_package("ui_battle_suc",to_liji,null,true);
		}
		
		private function to_liji():void{
			onCloseWindow();
			var obj:Object = new Object();
			obj.cId = comp.data.cId;
			obj.camp = comp.data.camp;
			WindowManager.createWindow(ColonizationBattleByCopySceneComponent.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer, false);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_SENCOND_QINGLUE)]);
		}
		
		
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			SystemDataModel.curColonizationFuBenInfo.curColonaztionDes = '';
			WindowManager.closeWindow(MainColoPrivilegeFuBenColoInfoWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
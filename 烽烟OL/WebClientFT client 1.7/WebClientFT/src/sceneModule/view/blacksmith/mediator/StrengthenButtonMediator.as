package sceneModule.view.blacksmith.mediator
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
	
	import proto.blacksmith.blacksmith2120.StrengthenTimeRequest;
	import proto.blacksmith.blacksmith2120.StrengthenTimeResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.announ.AddWindowEvent;
	import sceneModule.view.announ.AddWindowEventDispatcher;
	import sceneModule.view.blacksmith.view.MainStrFunctionComponent;
	import sceneModule.view.blacksmith.view.StrengthenButton;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;

	public class StrengthenButtonMediator extends Mediator
	{
		[Inject]
		public var comp:StrengthenButton;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socket:ISocketServer;
		public function StrengthenButtonMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.openStrBtn,MouseEvent.CLICK,onOpenStrengthenWin);
			
			var byteArray:ByteArray = new ByteArray();
			var req:StrengthenTimeRequest = new StrengthenTimeRequest();
			req.id = SystemDataModel.roleId;
			req.writeExternal(byteArray);
//			socket.send(new mx.rpc.Responder(tHandler,faultHandler),URLConst.BLACKSMITH_TIME_COMMANDID,byteArray);
		}
		
		private function tHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:StrengthenTimeResponse = new StrengthenTimeResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				comp.onSetTime(responseData.reTime);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onOpenStrengthenWin(evt:MouseEvent):void{
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				if(!CommonTools.delayClick())return;
				if(SystemDataModel.roleInfo.level<2){
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz2'));
					return;
				}
				AssetCenter.getInstance().load_package("ui_strengthen",to_blacksmith,null,true);
			}
		}
		
		private function to_blacksmith():void{
			if(SystemDataModel.curOpenWindowName == MainStrFunctionComponent.NAME){
				WindowManager.closeWindow(MainStrFunctionComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer);
			}else
			{
				AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
				SystemDataModel.curOpenWindowName = MainStrFunctionComponent.NAME
				WindowManager.createWindow(MainStrFunctionComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QIANGHUA)]);
				
			}
		}
		
		
	}
}
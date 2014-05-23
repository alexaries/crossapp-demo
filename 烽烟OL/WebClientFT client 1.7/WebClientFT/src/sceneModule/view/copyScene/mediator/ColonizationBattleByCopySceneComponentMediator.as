package sceneModule.view.copyScene.mediator
{
	import event.GuidClearEvent;
	import event.GuidEventCenter;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle712.ColonizationFightRequest;
	
	import sceneModule.event.ColonizationBattleResponseEvent;
	import sceneModule.view.copyScene.view.ColonizationBattleByCopySceneComponent;
	
	import service.ISocketServer;

	public class ColonizationBattleByCopySceneComponentMediator extends Mediator
	{
		
		[Inject]
		public var comp:ColonizationBattleByCopySceneComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ColonizationBattleByCopySceneComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.coloBtn,MouseEvent.CLICK,onColoClick);
			this.eventMap.mapListener(comp.closeWin,MouseEvent.CLICK,onCloseWindow);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			WindowManager.closeWindow(ColonizationBattleByCopySceneComponent.NAME, false, false, null, popUpWindowLayer, mediatorMap);
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_QINLUE));
		}
		
		private function onColoClick(evt:MouseEvent):void{
			var coloizaReq:ColonizationFightRequest = new ColonizationFightRequest();
			coloizaReq.id = SystemDataModel.roleId;
			coloizaReq.copyId = comp.data.cId;
			SystemDataModel.colCopyId = comp.data.cId;
			var byteArray:ByteArray = new ByteArray();
			coloizaReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(colonizationHandler,faultHandler),URLConst.BATTLE_COLONIZATION_COMMANDID,byteArray);
			onCloseWindow();
		}
		private function colonizationHandler(data:Object):void{
			this.dispatch(new ColonizationBattleResponseEvent(ColonizationBattleResponseEvent.COLONIZATIONBATTLERESPONSE,data));
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
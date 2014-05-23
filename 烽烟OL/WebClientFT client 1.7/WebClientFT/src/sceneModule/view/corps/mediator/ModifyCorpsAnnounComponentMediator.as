package sceneModule.view.corps.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1307.ModifyCorpsAnnounRequest;
	import proto.corps.corps1307.ModifyCorpsAnnounResponse;
	
	import sceneModule.view.corps.view.ModifyCorpsAnnounComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class ModifyCorpsAnnounComponentMediator extends Mediator
	{
		[Inject]
		public var comp:ModifyCorpsAnnounComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ModifyCorpsAnnounComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.modifyBtn,MouseEvent.CLICK,onModifyAnnoun);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancelModify);
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCancelModify);
		}
		private function onCancelModify(evt:MouseEvent):void{
			closeWindowAndRemoveListener();
		}
		/**
		 * 修改军团公告
		 */
		private function onModifyAnnoun(evt:MouseEvent):void{
			var modifyAnnounReq:ModifyCorpsAnnounRequest = new ModifyCorpsAnnounRequest();
			modifyAnnounReq.id = SystemDataModel.roleId;
			modifyAnnounReq.announContent = comp.announTextArea.text;
			var byteArray:ByteArray = new ByteArray();
			modifyAnnounReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(modifyAnnounHandler,faultHandler),URLConst.CORPS_MODIFYANNOU_COMMANDID,byteArray);
			
			closeWindowAndRemoveListener();
		}
		private function modifyAnnounHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var responseData:ModifyCorpsAnnounResponse = new ModifyCorpsAnnounResponse();
			responseData.readExternal(resByteArray);
			popUpShow.show(responseData.message);
		}
		private function closeWindowAndRemoveListener():void{
			WindowManager.closeWindow(ModifyCorpsAnnounComponent.NAME,false,false,null,popUpWindowLayer);
			this.eventMap.unmapListener(comp.modifyBtn,MouseEvent.CLICK,onModifyAnnoun);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCancelModify);
			this.eventMap.unmapListener(comp.clokeBtn,MouseEvent.CLICK,onCancelModify);
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
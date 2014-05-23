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
	
	import proto.corps.corps1312.ModifyBugleRequest;
	import proto.corps.corps1312.ModifyBugleResponse;
	
	import sceneModule.view.corps.view.ModifyCorpsBugleComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	/**
	 * 修改军号Mediator 
	 * @author Dream-Y
	 * 
	 */	
	public class ModifyCorpsBugleComponentMediator extends Mediator
	{
		[Inject]
		public var comp:ModifyCorpsBugleComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ModifyCorpsBugleComponentMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.eventMap.mapListener(comp.modifyBtn,MouseEvent.CLICK,onModifyBugle);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
		/**
		 * 修改军号 
		 */		
		private function onModifyBugle(evt:MouseEvent):void{
			var modifyBugleReq:ModifyBugleRequest = new ModifyBugleRequest();
			modifyBugleReq.id = SystemDataModel.roleId;
			modifyBugleReq.bugleTxt = comp.bugleName.text;
			var byteArray:ByteArray = new ByteArray();
			modifyBugleReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(modifyBugleHandler,faultHandler),URLConst.CORPS_MODIFYBUGLE_COMMANDID,byteArray);
			
			onCloseWindowAndRemoveListener();
		}
		private function modifyBugleHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var responseData:ModifyBugleResponse = new ModifyBugleResponse();
			responseData.readExternal(resByteArray);
			popUpShow.show(responseData.message);
		}
		/**
		 * 取消
		 */
		private function onCancel(evt:MouseEvent):void{
			onCloseWindowAndRemoveListener();
		}
		/**
		 * 关闭窗口移除监听
		 */
		private function onCloseWindowAndRemoveListener():void{
			this.eventMap.unmapListener(comp.modifyBtn,MouseEvent.CLICK,onModifyBugle);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			WindowManager.closeWindow(ModifyCorpsBugleComponent.NAME,false,false,null,popUpWindowLayer);
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
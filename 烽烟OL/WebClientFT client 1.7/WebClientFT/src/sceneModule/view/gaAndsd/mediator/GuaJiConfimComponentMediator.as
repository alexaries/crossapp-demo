package sceneModule.view.gaAndsd.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guaji.guaji3202.CancelGuajiRequest;
	import proto.guaji.guaji3202.CancelGuajiResponse;
	
	import sceneModule.view.gaAndsd.event.GuaJiCancelEvent;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.jingji.command.JingJiMessage;
	
	import service.ISocketServer;

	public class GuaJiConfimComponentMediator extends Mediator
	{
		[Inject]
		public var comp:GuaJiConfimComponent;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function GuaJiConfimComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.rBtn,MouseEvent.CLICK,onSubmit);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
		
		private function onSubmit(evt:MouseEvent):void{
			var cancelGuaJiReq:CancelGuajiRequest = new CancelGuajiRequest();
			cancelGuaJiReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			cancelGuaJiReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(cancelHandler,faultHandler),URLConst.GUAJI_CANCEL_COMMANDID,byteArray);
			
			onCancel();
		}
		
		private function cancelHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:CancelGuajiResponse = new CancelGuajiResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				JingJiMessage.getInstance().dispatchEvent(new GuaJiCancelEvent(GuaJiCancelEvent.GUAJICANCELEVENT));
				SystemDataModel.isGuaJiFlag = false;
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onCancel(evt:MouseEvent=null):void{
			WindowManager.closeWindow(GuaJiConfimComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
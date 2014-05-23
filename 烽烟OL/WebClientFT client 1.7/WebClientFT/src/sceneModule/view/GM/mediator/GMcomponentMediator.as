package sceneModule.view.GM.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.gm.gm4000.GMInfoRequest;
	
	import sceneModule.view.GM.view.GMcomponent;
	
	import service.ISocketServer;

	public class GMcomponentMediator extends Mediator
	{
		[Inject]
		public var comp:GMcomponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socket:ISocketServer;
		public function GMcomponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,mouseClickHandler);
			
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onSubmitClickHandler);
			
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancelClickHandler);
		}
		
		private function mouseClickHandler(event:MouseEvent=null):void{
			WindowManager.closeWindow(GMcomponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function onSubmitClickHandler(event:MouseEvent):void{
			var gmReq:GMInfoRequest = new GMInfoRequest();
			gmReq.gmMsg = comp.iTextArea.text;
			gmReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			gmReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(gmHandler,faultHandler),URLConst.GM_COMMANDID,byteArray);
			mouseClickHandler();
		}
		
		private function gmHandler(data:Object):void{
			
		}
		
		private function onCancelClickHandler(event:MouseEvent):void{
			mouseClickHandler();
		}
		
		private function faultHandler(event:FaultEvent):void{
			
		}
	}
}
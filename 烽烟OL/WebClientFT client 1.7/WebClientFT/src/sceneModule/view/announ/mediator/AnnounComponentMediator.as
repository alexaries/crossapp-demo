package sceneModule.view.announ.mediator
{
	import flash.utils.ByteArray;
	
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.system.system2700.SystemToInfoResponse;
	
	import sceneModule.view.announ.AddWindowEvent;
	import sceneModule.view.announ.AddWindowEventDispatcher;
	import sceneModule.view.announ.view.AnnounComponent;
	
	import service.IChatSocketServer;
	import service.ISocketServer;

	public class AnnounComponentMediator extends Mediator
	{
		[Inject]
		public var comp:AnnounComponent;
		
		[Inject]
		public var socketService:IChatSocketServer;
		public function AnnounComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			socketService.send(new mx.rpc.Responder(systemInfoHandler,faultHandler),URLConst.SYSTEM_INFO_COMMANDID,null,false);
			AddWindowEventDispatcher.getInstance().addEventListener(AddWindowEvent.ADDWINDOWEVENT,onAddWindowHandler);
			AddWindowEventDispatcher.getInstance().addEventListener(AddWindowEvent.PREADDWINDOWEVENT,preAddWindowHandler);
		}
		
		private function onAddWindowHandler(evt:AddWindowEvent):void{
			comp.startTimeToMove();
		}
		
		private function preAddWindowHandler(evt:AddWindowEvent):void{
			comp.stopTimeToStop();
		}
		
		private function systemInfoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:SystemToInfoResponse = new SystemToInfoResponse();
			responseData.readExternal(byteArray);
			comp.info_arr.push(responseData.sInfo);
			comp.setMarqueeTxt();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
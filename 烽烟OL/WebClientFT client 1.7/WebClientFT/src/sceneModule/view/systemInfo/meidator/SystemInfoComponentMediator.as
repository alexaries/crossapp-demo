package sceneModule.view.systemInfo.meidator
{
	import flash.utils.ByteArray;
	
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.prompted.prompted2200.PromptedMessage;
	
	import sceneModule.view.systemInfo.view.SystemInfoComponent;
	
	import service.ISocketServer;

	/**
	 * 系统消息Mediator 
	 * @author Dream-Y
	 * 
	 */	
	public class SystemInfoComponentMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var comp:SystemInfoComponent;
		public function SystemInfoComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			socketService.send(new mx.rpc.Responder(SystemInfoHandler,faultHandler),URLConst.SYSTEMINFO_COMMANDID,null,false);
		}
		//系统消息
		private function SystemInfoHandler(data:Object):void{
//			trace("收到系统消息");
			var byteArray:ByteArray = data as ByteArray;
			var responseData:PromptedMessage = new PromptedMessage();
			responseData.readExternal(byteArray);
			comp.onInsertSystemInfo(responseData.prompted);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
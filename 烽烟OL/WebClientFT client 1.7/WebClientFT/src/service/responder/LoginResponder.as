package service.responder
{
	import event.ChangeModuleEvent;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * login请求反馈 
	 * @author Linus
	 * 
	 */	
	public class LoginResponder extends Actor implements IResponder
	{
		/**
		 * constructor 
		 * 
		 */		
		public function LoginResponder()
		{
		}
		
		/**
		 * 成功 
		 * @param data
		 * 
		 */		
		public function result(data:Object):void
		{
			trace(data.toString());
			trace(ResultEvent(data).result);
		}
		
		/**
		 * 失败 
		 * @param info
		 * 
		 */		
		public function fault(info:Object):void
		{
			trace(FaultEvent(info).fault);
		}
	}
}
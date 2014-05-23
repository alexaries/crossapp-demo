package service.responder
{
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * Logout请求反馈 
	 * @author Linus
	 * 
	 */	
	public class LogoutResponder extends Actor implements IResponder
	{
		/**
		 * constructor 
		 * 
		 */		
		public function LogoutResponder()
		{
			super();
		}
		
		/**
		 * 成功 
		 * @param data
		 * 
		 */		
		public function result(data:Object):void
		{
		}
		
		/**
		 * 失败
		 * @param info
		 * 
		 */		
		public function fault(info:Object):void
		{
		}
	}
}
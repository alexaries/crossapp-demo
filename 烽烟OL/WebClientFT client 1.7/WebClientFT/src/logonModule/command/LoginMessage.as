package logonModule.command 
{
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author ...
	 */
	public class LoginMessage extends EventDispatcher 
	{
		private static var _instance:LoginMessage;
		public static function getInstance():LoginMessage {
			if (null == _instance) {
				_instance = new LoginMessage();
			}
			return _instance;
		}
		public function LoginMessage() 
		{
			
		}
		
	}

}
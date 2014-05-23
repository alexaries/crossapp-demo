package logonModule.event
{
	import flash.events.Event;
	/**
	 * 登录页面事件类 
	 * @author mutou
	 * 
	 */	
	public class LoginPageEvent extends Event
	{
		/**
		 * 用户点击 进入游戏发送enterGame事件 
		 */		
		public static const ENTER_GAME:String = "enterGame";
		
		public function LoginPageEvent(type:String)
		{
			super(type);
		}
		
	}
}
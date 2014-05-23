package sceneModule.event
{
	/**
	 * 窗口状态改变 
	 */	
	import flash.events.Event;

	public class ChangeWindowStateEvent extends Event
	{
		public static const CHANGEWINDOWSTATE:String = "changeWindowState";
		public static const MAINMENU:String = "mainMenu";
		public static const INVITEFRIENDS:String = "inviteFriends";
		public static const MAINSHOP:String = "mainShop";
		public var _winType:String;//窗口类型 
		public function ChangeWindowStateEvent(typeEvent:String,winType:String)
		{
			_winType = winType;
			super(typeEvent);
		}
	}
}
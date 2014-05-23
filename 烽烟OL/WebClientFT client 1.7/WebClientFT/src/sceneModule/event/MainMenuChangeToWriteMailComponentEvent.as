package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 切换主菜单到写邮件界面 
	 * @author Yaolx
	 * 
	 */	
	public class MainMenuChangeToWriteMailComponentEvent extends Event
	{
		public static const MAINMENUCHANGETOWRITEMAIL:String = "mainMenuChangeToWriteMail";
		public var obj:Object;
		public function MainMenuChangeToWriteMailComponentEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
package sceneModule.view.mail.event
{
	/**
	 * 邮件操作成功信息提示Event
	 * @author Yaolx 
	 */	
	import flash.events.Event;

	public class MainMenuMailSaveOrDeleteSuccessMessageEvent extends Event
	{
		public static const MAINMENUMAILSAVEORDELETEMESSAGE:String = "mainMenuMailMessage";
		public var confimMessage:String
		public function MainMenuMailSaveOrDeleteSuccessMessageEvent(type:String,message:String)
		{
			super(type);
			confimMessage = message;
		}
	}
}
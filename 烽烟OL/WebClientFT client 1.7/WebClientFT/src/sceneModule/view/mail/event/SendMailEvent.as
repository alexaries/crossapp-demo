package sceneModule.view.mail.event
{
	import flash.events.Event;

	/**
	 * 写邮件Event 
	 * @author Yaolx
	 * 
	 */	
	public class SendMailEvent extends Event
	{
		public static const SENDMAIL:String = "SENDMAIL";
		public function SendMailEvent(type:String)
		{
			super(type);
		}
		override public function clone():Event{
		    return new SendMailEvent(type);
		}
	}
}
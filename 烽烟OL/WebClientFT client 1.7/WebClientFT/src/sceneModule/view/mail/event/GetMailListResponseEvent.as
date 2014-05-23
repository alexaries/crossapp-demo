package sceneModule.view.mail.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;

	/**
	 * 获取邮件列表Response Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetMailListResponseEvent extends Event
	{
		public static const GETMAILLISTRESPONSE:String = "getMailListResponse";
		public var result:Object;
		public function GetMailListResponseEvent(type:String,value:Object)
		{
			result = value;
			super(type);
		}
	}
}
package sceneModule.view.chat.event
{
	import flash.events.Event;

	/**
	 * 服务器推送的最近私聊对象列表 
	 * @author Dream-Y
	 * 
	 */	
	public class ChatToObjectListEvent extends Event
	{
		public static const CHATTOOBJECTLISTEVENT:String = "chatToObjectListEvent";
		public function ChatToObjectListEvent(type:String)
		{
			super(type);
		}
	}
}
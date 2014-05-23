package sceneModule.view.chat.event
{
	/**
	 * 打开私聊聊天窗 
	 */	
	import flash.events.Event;

	public class MainOpenWhisperWindowEvent extends Event
	{
		public static const MAINOPENWHISPERWINDOWEVENT:String = "mainOpenWhisperWindowEvent";
		public var chatID:int;//私聊对象id
		public var name:String;//私聊对象名称
		public function MainOpenWhisperWindowEvent(type:String,id:int,value:String)
		{
			chatID = id;
			name = value;
			super(type);
		}
	}
}
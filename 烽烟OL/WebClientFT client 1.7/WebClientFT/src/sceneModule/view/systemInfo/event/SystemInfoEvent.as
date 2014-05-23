package sceneModule.view.systemInfo.event
{
	import flash.events.Event;

	/**
	 * 系统消息事件 
	 * @author Dream-Y
	 * 
	 */	
	public class SystemInfoEvent extends Event
	{
		public static const SYSTEMINFOEVENT:String = "systemInfoEvent";
		public var _message:String;
		public function SystemInfoEvent(type:String,message:String)
		{
			_message = message;
			super(type);
		}
	}
}
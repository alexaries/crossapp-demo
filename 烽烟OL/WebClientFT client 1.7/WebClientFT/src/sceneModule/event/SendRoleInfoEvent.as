package sceneModule.event
{
	import flash.events.Event;

	public class SendRoleInfoEvent extends Event
	{
		public static const SENDROLEINFO:String="sendRoleInfo";
		public function SendRoleInfoEvent(type:String)
		{
			super(type);
		}
		override public function clone():Event{
		    return new SendRoleInfoEvent(type);
		}
	}
}
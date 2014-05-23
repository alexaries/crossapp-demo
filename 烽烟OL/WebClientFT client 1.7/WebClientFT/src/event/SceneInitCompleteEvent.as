package event
{
	import flash.events.Event;

	public class SceneInitCompleteEvent extends Event
	{
		public static var SCENEINITCOMPLETE:String = "sceneInitCompleteEvent";
		public function SceneInitCompleteEvent(type:String)
		{
			super(type);
		}
	}
}
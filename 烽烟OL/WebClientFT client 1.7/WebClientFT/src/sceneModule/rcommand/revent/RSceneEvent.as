package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	public class RSceneEvent extends Event
	{
		public function RSceneEvent(type:String)
		{
			super(type);
		}
		public static const SCENE_INIT_COMPLETED_EVENT:String = "sceneInitCompletedEvent";
	}
}
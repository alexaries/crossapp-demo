package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 切换场景Event 
	 * @author Yaolx
	 * 
	 */	
	public class ChangeSceneEvent extends Event
	{
		public static const CHANGE_SCENE_EVENT:String = "changeScene";
		public var targetSceneId:int;
		public function ChangeSceneEvent(type:String,sceneId:int)
		{
			super(type);
			targetSceneId = sceneId;
		}
	}
}
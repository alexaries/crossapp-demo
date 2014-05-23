package event
{
	import flash.events.Event;

	/**
	 * 加载场景进度事件 
	 * @author Yaolx
	 * 
	 */	
	public class ProgressLoadSwitchSceneEvent extends Event
	{
		public static var PROGRESSLOADSWITCHSCENE:String = "progressLoadSwitchScene";
		public var fileCount:int;
		public var curFileLoad:int;
		public function ProgressLoadSwitchSceneEvent(type:String,maxCount:int,curCount:int)
		{
			fileCount = maxCount;
			curFileLoad = curCount;
			super(type);
		}
	}
}
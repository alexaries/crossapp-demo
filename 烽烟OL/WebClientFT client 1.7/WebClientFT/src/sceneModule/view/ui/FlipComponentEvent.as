package sceneModule.view.ui
{
	import flash.events.Event;

	/**
	 * 翻页事件
	 */
	public class FlipComponentEvent extends Event
	{
		public static const FLIPCOMPONENTEVENT:String = "flipComponent";
		public var flipIndex:int;
		public function FlipComponentEvent(type:String,value:int)
		{
			flipIndex = value;
			super(type);
		}
	}
}
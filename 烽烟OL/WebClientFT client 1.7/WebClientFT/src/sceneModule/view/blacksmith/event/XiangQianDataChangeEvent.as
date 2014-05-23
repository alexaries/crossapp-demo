package sceneModule.view.blacksmith.event
{
	import flash.events.Event;

	public class XiangQianDataChangeEvent extends Event
	{
		public static var XIANGQIANDATACHANGE:String = 'xiangQianDataChangeEvent';
		public function XiangQianDataChangeEvent(type:String)
		{
			super(type);
		}
	}
}
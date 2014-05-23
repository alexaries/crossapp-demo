package sceneModule.view.vip
{
	import flash.events.Event;

	public class VIPdataChangeEvent extends Event
	{
		public static const VIPDATACHANGEEVENT:String = "vipDataChangeEvent";
		public function VIPdataChangeEvent(type:String)
		{
			super(type);
		}
	}
}
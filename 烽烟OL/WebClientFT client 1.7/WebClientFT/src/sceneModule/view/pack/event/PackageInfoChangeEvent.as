package sceneModule.view.pack.event
{
	import flash.events.Event;

	public class PackageInfoChangeEvent extends Event
	{
		public static const PACKAGEINFOCHANGEEVENT:String = "packageInfoChangeEvent";
		public static const CANGKUINFOCHANGEVENT:String = "cangkuInfoChangeEvent";
		public function PackageInfoChangeEvent(type:String)
		{
			super(type);
		}
	}
}
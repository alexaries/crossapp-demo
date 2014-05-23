package sceneModule.view.pray.event
{
	import flash.events.Event;

	public class PrayEvent extends Event
	{
		public static const Pray_EVENT:String = "Prayevent";
		
		public var _obj:Object;
		public function PrayEvent(type:String, view:Object)
		{
			
			super(type);
			this._obj = view;
		}
		
		
		
	}
}
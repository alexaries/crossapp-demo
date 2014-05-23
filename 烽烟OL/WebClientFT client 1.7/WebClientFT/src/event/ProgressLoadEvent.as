package event
{
	import flash.events.Event;
	
	import mx.events.ModuleEvent;

	public class ProgressLoadEvent extends Event
	{
		public static var PROGRESSLOAD:String = "";
		public var e:ModuleEvent;
		public function ProgressLoadEvent(type:String,evt:ModuleEvent)
		{
			super(type);
			e = evt;
		}
	}
}
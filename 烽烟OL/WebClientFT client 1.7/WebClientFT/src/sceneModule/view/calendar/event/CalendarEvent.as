package sceneModule.view.calendar.event
{
	import flash.events.Event;


	public class CalendarEvent extends Event
	{
		public static const CalendarEvent_INFO_CHANGE:String="CalendarEvent_INFO_CHANGE";

		public var _obj:Object;

		public function CalendarEvent(type:String, value:Object)
		{
			_obj=value;
			super(type);
		}

	}

}

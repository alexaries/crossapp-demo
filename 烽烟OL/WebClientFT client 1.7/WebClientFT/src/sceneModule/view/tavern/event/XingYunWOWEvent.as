package sceneModule.view.tavern.event
{
	import flash.events.Event;

	public class XingYunWOWEvent extends Event
	{
		public static const XINGYUNWOWINFO_EVENT:String="xingyunwowinfoevent";
		
		
		public var view:Object;

		public function XingYunWOWEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{

			super(type, bubbles, cancelable);
			this.view=view;
		}

		override public function clone():Event
		{
			return new XingYunWOWEvent(type, view, bubbles, cancelable);
		}
	}
}

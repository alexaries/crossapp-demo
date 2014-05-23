package sceneModule.view.tavern.event
{
	import flash.events.Event;

	public class WOWEvent extends Event
	{
		public static const WOW_EVENT:String="wowevent";
		
		public var view:Object;

		public function WOWEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.view=view;
		}

		override public function clone():Event
		{
			return new WOWEvent(type, view, bubbles, cancelable);
		}
	}
}

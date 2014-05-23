package sceneModule.view.tavern.event
{
	import flash.events.Event;

	public class WOWItemRenderEvent extends Event
	{
		public static const WOWINFOCOMP_EVENT:String="wowinfocompvent";
		public static const WOWINFOITEMRENDER_EVENT:String="wowinfoitemrenderevent";
		
		public var view:Object;

		public function WOWItemRenderEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{

			super(type, bubbles, cancelable);
			this.view=view;
		}

		override public function clone():Event
		{
			return new WOWItemRenderEvent(type, view, bubbles, cancelable);
		}
	}
}

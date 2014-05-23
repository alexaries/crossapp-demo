package sceneModule.view.tavern.event
{
	import flash.events.Event;

	public class XingYunWOWItemRenderEvent extends Event
	{
//		public static const XINGYUNWOWINFOCOMP_EVENT:String="xingyunwowinfocompvent";
		
		public static const XINGYUNWOWINFOITEMRENDER_EVENT:String="xingyunwowinfoitemrendervent";
		
		public var view:Object;

		public function XingYunWOWItemRenderEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{

			super(type, bubbles, cancelable);
			this.view=view;
		}

		override public function clone():Event
		{
			return new XingYunWOWItemRenderEvent(type, view, bubbles, cancelable);
		}
	}
}

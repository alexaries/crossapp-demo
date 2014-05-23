package sceneModule.view.guanjue.event
{
	import flash.events.Event;

	public class ShengWangItemRenderEvent extends Event
	{
		public static const SHNEGWANG_EVENT:String="shengwangevent";
		public static const SHNEGWANGITEMRENDER_EVENT:String="shengwangitemrenderevent";
		public var view:Object;

		public function ShengWangItemRenderEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{

			super(type, bubbles, cancelable);
			this.view=view;
		}

		override public function clone():Event
		{
			return new ShengWangItemRenderEvent(type, view, bubbles, cancelable);
		}
	}
}

package sceneModule.view.zhanxing.event
{
	import flash.events.Event;

	public class JiFengItemRenderEvent extends Event
	{
		public static const JIFENG_EVENT:String="jifengevent";
		public static const JIFENGITEMRENDER_EVENT:String="jifengitemrenderevent";
		public static const BODYORPACKXYITEMRENDEREVENT:String = "bodyOrPackXYItemRenderEvent";
		public var view:Object;

		public function JiFengItemRenderEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{

			super(type, bubbles, cancelable);
			this.view=view;
		}

		override public function clone():Event
		{
			return new JiFengItemRenderEvent(type, view, bubbles, cancelable);
		}
	}
}

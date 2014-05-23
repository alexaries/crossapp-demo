package sceneModule.view.zhanxing.event
{
	import flash.events.Event;

	public class JiFengEvent extends Event
	{
		public static const JIFENGINFOCOMP_EVENT:String="jifenginfoevent";
		public var view:Object;

		public function JiFengEvent(type:String, view:Object)
		{

			super(type);
			this.view=view;
		}

		override public function clone():Event
		{
			return new JiFengEvent(type, view);
		}
	}
}

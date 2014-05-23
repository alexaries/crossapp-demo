package sceneModule.view.guanjue.event
{
	import flash.events.Event;

	public class ShengWangEvent extends Event
	{
		public static const SHNEGWANGCOMPONMENT_EVENT:String="shengwangcomponmentevent";
		public var view:Object;

		public function ShengWangEvent(type:String, view:Object)
		{

			super(type);
			this.view=view;
		}

		override public function clone():Event
		{
			return new ShengWangEvent(type, view);
		}
	}
}

package sceneModule.view.task.event
{
	import flash.events.Event;

	public class MediatorRegisterTaskEvent extends Event
	{
		public static const MEDIATORREGISTERTASKEVENT:String = "mediatorRegisterTaskEvent";
		public var view:Object;
		public function MediatorRegisterTaskEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterTaskEvent(type, view, bubbles, cancelable);
		}
	}
}
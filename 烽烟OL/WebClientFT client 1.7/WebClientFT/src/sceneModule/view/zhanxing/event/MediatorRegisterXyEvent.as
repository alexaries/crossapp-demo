package sceneModule.view.zhanxing.event
{
	import flash.events.Event;

	public class MediatorRegisterXyEvent extends Event
	{
		public static const MEDIATORREGISTERXYEVENT:String = 'mediatorRegisterSGEvent';
		public var _view:Object;
		public function MediatorRegisterXyEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._view = view;
		}
		
		override public function clone():Event{
			return new MediatorRegisterXyEvent(type, _view, bubbles, cancelable);
		}
	}
}
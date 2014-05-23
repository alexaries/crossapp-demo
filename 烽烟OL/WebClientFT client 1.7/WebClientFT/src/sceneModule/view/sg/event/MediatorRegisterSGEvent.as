package sceneModule.view.sg.event
{
	import flash.events.Event;

	public class MediatorRegisterSGEvent extends Event
	{
		public static const MEDIATORREGISTERSGEVENT:String = 'mediatorRegisterSGEvent';
		public var _view:Object;
		public function MediatorRegisterSGEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._view = view;
		}
		
		override public function clone():Event{
			return new MediatorRegisterSGEvent(type, _view, bubbles, cancelable);
		}
	}
}
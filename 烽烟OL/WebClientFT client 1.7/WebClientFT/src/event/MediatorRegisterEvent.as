package event
{
	import flash.events.Event;

	public class MediatorRegisterEvent extends Event
	{
		public static const REGISTER:String = 'mediatorRegister';
		
		public var view:Object;
		public function MediatorRegisterEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterEvent(type, view, bubbles, cancelable);
		}
	}
}
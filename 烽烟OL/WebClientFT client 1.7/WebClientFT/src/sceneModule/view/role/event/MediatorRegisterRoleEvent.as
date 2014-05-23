package sceneModule.view.role.event
{
	import flash.events.Event;

	public class MediatorRegisterRoleEvent extends Event
	{
		public static const MEDIATORREGISTERROLE:String = "mediatorRegisterRoleEvent";
		public var view:Object;
		public function MediatorRegisterRoleEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterRoleEvent(type, view, bubbles, cancelable);
		}
	}
}
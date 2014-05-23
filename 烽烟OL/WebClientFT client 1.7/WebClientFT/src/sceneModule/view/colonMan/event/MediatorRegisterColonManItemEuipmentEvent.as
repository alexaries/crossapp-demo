package sceneModule.view.colonMan.event
{
	import flash.events.Event;

	public class MediatorRegisterColonManItemEuipmentEvent extends Event
	{
		public static const MEDIATORREGISTERCOLONMANITEMEUIPMENT:String = "mediatorRegisterColonManItemEuipmentEvent";
		public static const MEDIATORREGISTERCOLOPRIVILEGE:String = "mediatorRegisterColonPrivilege";
		public var view:Object;
		public function MediatorRegisterColonManItemEuipmentEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterColonManItemEuipmentEvent(type, view, bubbles, cancelable);
		}
	}
}
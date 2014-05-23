package sceneModule.event
{
	import flash.events.Event;

	public class MediatorRegisterItemEuipmentEvent extends Event
	{
		public static const MEDIATORREGISTERCOMMISSIONITEMEUIPMENT:String = "mediatorRegisterCommissionItemEquipment";
		public static const MEDIATORREGISTERXIANGQIAN:String = "mediatorRegisterXiangQia";
		public static const MEDIATORREGISTERHECHENG:String = "mediatorRegisterHeCheng";
		public var view:Object;
		public function MediatorRegisterItemEuipmentEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterItemEuipmentEvent(type, view, bubbles, cancelable);
		}
	}
}
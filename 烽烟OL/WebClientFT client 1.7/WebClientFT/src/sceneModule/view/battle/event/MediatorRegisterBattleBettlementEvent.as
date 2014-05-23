package sceneModule.view.battle.event
{
	import flash.events.Event;
	
	public class MediatorRegisterBattleBettlementEvent extends Event
	{
		public static const MEDIATORREGISTERBATTLEBETTLEMENT:String = "mediatorRegisterBattleBettlementEvent";
		public var view:Object;
		public function MediatorRegisterBattleBettlementEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterBattleBettlementEvent(type, view, bubbles, cancelable);
		}
	}
}
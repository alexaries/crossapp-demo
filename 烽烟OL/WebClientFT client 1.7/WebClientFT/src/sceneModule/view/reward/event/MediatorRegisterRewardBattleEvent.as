package sceneModule.view.reward.event
{
	import flash.events.Event;

	public class MediatorRegisterRewardBattleEvent extends Event
	{
		public static const MEDIATORREGISTERREWARDBATTLEEVENT:String='mediatorRegisterRewardBattleEvent';
		public var _view:Object;
		public function MediatorRegisterRewardBattleEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._view = view;
		}
		
		override public function clone():Event{
			return new MediatorRegisterRewardBattleEvent(type, _view, bubbles, cancelable);
		}
	}
}
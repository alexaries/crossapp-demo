package sceneModule.view.reward.event
{
	import flash.events.Event;

	public class MediatorRegisterRewardEvent extends Event
	{
		public static const MEDIATORREGISTERREWARDEVENT:String='mediatorRegisterRewardEvent';
		public static const MEDIATORREGISTERREWARDDAYORGUIDEEVENT:String='mediatorRegisterRewardDayOrGuideEvent';
		public var _view:Object;
		public function MediatorRegisterRewardEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._view = view;
		}
		
		override public function clone():Event{
			return new MediatorRegisterRewardEvent(type, _view, bubbles, cancelable);
		}
	}
}
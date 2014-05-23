package sceneModule.view.ranking.event
{
	import flash.events.Event;

	public class MediatorRegisterRankingEvent extends Event
	{
		public static const MEDIATORREGISTERRANKING:String = "mediatorRegisterRanking";
		public var view:Object;
		public function MediatorRegisterRankingEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterRankingEvent(type, view, bubbles, cancelable);
		}
	}
}
package sceneModule.view.pata.event
{
	import flash.events.Event;
	
	import proto.panpa.panpa4203.TowerBattleResponse;

	public class PaTaBattleAndMoveEvent extends Event
	{
		public static var PATABATTLEANDMOVEEVENT:String = 'paTaBattleAndMoveEvent';
		public function PaTaBattleAndMoveEvent(type:String)
		{
			super(type);
		}
	}
}
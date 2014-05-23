package sceneModule.view.territory.event
{
	import flash.events.Event;

	public class RefreshTerritoryListInfoEvent extends Event
	{
		public static var REFRESHTERRITORYLISTINFOEVENT:String = "refreshTerritoryListInfo";
		public function RefreshTerritoryListInfoEvent(type:String)
		{
			super(type);
		}
	}
}
package sceneModule.view.blacksmith.event
{
	import flash.events.Event;

	public class RemoveEquipmentFromStrengthenEvent extends Event
	{
		public static var REMOVEEQUIPMENTFROMSTRENGTHENEVENT:String = "removeEquipmentFromStrenghten";
		public function RemoveEquipmentFromStrengthenEvent(type:String)
		{
			super(type);
		}
	}
}
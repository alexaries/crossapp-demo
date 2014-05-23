package sceneModule.view.pack.event
{
	import flash.events.Event;

	public class EquipEquipmentEvent extends Event
	{
		//穿装备
		public static const EQUIPEQUIPMENT:String = "equipEquipmentEvent";
		//卸载装备
		public static const UNEQUIPEQUIPMENT:String = "unEquipEquipmentEvent";
		//移动装备
		public static const MOVEITEMEVENT:String = "moveItemEvent";
		//起始位置
		public var fromPos:int;
		//终点位置
		public var toPos:int;
		public function EquipEquipmentEvent(type:String,fPos:int,tPos:int)
		{
			fromPos = fPos;
			toPos = tPos;
			super(type);
		}
	}
}
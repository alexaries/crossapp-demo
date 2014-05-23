package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 获取仓库信息Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetWarehouseInfoEvent extends Event
	{
		public static const GETWAREHOUSEINFOEVENT:String = "getWarehouseInfoEvent";
		public function GetWarehouseInfoEvent(type:String)
		{
			super(type);
		}
	}
}
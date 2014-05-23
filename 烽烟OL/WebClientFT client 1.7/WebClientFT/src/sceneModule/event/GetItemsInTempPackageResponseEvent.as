package sceneModule.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;

	/**
	 * 获取玩家临时包裹栏中的物品 Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetItemsInTempPackageResponseEvent extends Event
	{
		public static const GETITEMSINTEMPPACKAGEEVENT:String="getItemsInTempPackageEvent";
		public var result:Object;
		public function GetItemsInTempPackageResponseEvent(type:String,result:Object)
		{
			this.result = result;
			super(type);
		}
	}
}
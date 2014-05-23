package sceneModule.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;

	/**
	 * 获取仓库信息返回Response Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetWarehouseInfoResponseEvent extends Event
	{
		public static const GETWAREHOUSEINFORESPONSE:String = "getWarehouseInfoResponseEvent";
		public var result:Array;
		public function GetWarehouseInfoResponseEvent(type:String,value:Array)
		{
			this.result = value;
			super(type);
		}
	}
}
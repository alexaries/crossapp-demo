package sceneModule.view.shop.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;
	
	import proto.shop.shop206.ShopInfo;

	/**
	 * 获取商店信息返回值Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetShopInfoResponseEvent extends Event
	{
		public static const GETSHOPINFORESPONSE:String="getShopInfoResponse";
		
		public static const GETSHOPINFO:String = "getShopInfo";
		public var result:ShopInfo;
		public var _eventType:String; 
		public function GetShopInfoResponseEvent(type:String,value:ShopInfo,eventType:String)
		{
			this.result = value;
			this._eventType = eventType;
			super(type);
		}
	
	}
}
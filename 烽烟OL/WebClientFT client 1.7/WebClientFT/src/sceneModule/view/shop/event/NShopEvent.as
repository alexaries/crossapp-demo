package sceneModule.view.shop.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NShopEvent extends Event 
	{
		public static const NShopEvent_ITEM_DOUBLE_CLICK:String = "NShopEvent_ITEM_DOUBLE_CLICK";
		public static const NShopEvent_ITEM_DROP:String = "NShopEvent_ITEM_DROP";
		
		
		private var _obj:Object;
		public function NShopEvent(type:String, obj:Object, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = obj;
			super(type, bubbles, cancelable);
		}
		
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}
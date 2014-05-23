package event
{
	import flash.events.Event;
	
	/**
	 * client resource related event 
	 * @author Linus
	 * 
	 */	
	public class ClientResourceEvent extends Event
	{
		/**
		 * 常用预加载资源加载完毕 
		 */		
		static public const PRELOAD_COMMON_RESOURCE_COMPLETE:String = "preloadCommonResourceComplete";
		
		/**
		 * constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function ClientResourceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
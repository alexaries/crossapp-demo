package Animation
{
	import flash.events.Event;

	public class ResourceLoadEvent extends Event
	{
		/**
		 * 资源路径
		 */
		public var url:String="";
		/**
		 *  资源类型 默认为movieclip
		 */
		public var resourceType:int=MOVIECLIP;
		
		public static const MOVIECLIP:int=1;
		public static const IMAGE:int=2;
		public static const RESOURCE_LOAD_COMPLETE:String="resourceLoadComplete";
		
		public function ResourceLoadEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
package event
{
	import flash.events.Event;
	
	/**
	 * Local Server Event 
	 * @author Linus
	 * 
	 */	
	public class LocalServerEvent extends Event
	{
		/**
		 * 本地配置文件加载完毕 
		 */		
		static public var CONFIG_LOADED:String = "localConfigFileLoaded";
		
		/**
		 * 数据存储 
		 */		
		public var xmlData:XML;
		
		/**
		 * construction 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function LocalServerEvent(type:String, data:XML, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			xmlData = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * 克隆方法
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new LocalServerEvent(type, xmlData, bubbles, cancelable);
		}
	}
}
package model
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * Read Server config file 
	 * @author Linus
	 * 
	 */	
	dynamic public class ServerConfig extends Proxy
	{
		/**
		 * data store 
		 */		
		private var _xml:XML;
		
		/**
		 * construction 
		 * 
		 */		
		public function ServerConfig()
		{
			super();
		}
		
		/**
		 * assign file data
		 * @param data : xml file data
		 * 
		 */		
		public function setData(data:XML):void
		{
			_xml = data;
		}
		
		/**
		 * 
		 * @param name
		 * @return 
		 * 
		 */		
		flash_proxy override function getProperty(name:*):*
		{
			return _xml[name].toString();
		}
	}
}
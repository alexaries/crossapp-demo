package model
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	/**
	 * Version file model 
	 * @author Linus
	 * 
	 */	
	dynamic public class VersionFile extends Proxy
	{
		/**
		 * data store 
		 */		
		private var _xml:XML;
		
		/**
		 * construction 
		 * 
		 */		
		public function VersionFile()
		{
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
		 * 动态获取属性
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
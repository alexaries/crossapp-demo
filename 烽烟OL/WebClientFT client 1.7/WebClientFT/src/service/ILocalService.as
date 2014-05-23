package service
{
	/**
	 * 本地服务 
	 * @author Linus
	 * 
	 */	
	public interface ILocalService
	{
		/**
		 * 加载本地配置文件 
		 * 
		 */		
		function loadConfigFile():void;
		
		/**
		 * 读取模块版本文件 
		 * @param url 版本文件路径
		 * 
		 */		
		function loadVersionFile(url:String):void;
	}
}
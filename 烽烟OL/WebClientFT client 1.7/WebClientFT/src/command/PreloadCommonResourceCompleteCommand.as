package command
{
	import org.robotlegs.mvcs.Command;
	
	import resource.ModuleList;
	import resource.ModulePool;
	
	/**
	 * 常用预加载资源加载完毕处理 
	 * @author Linus
	 * 
	 */	
	public class PreloadCommonResourceCompleteCommand extends Command
	{
		/**
		 * 模块池 
		 */		
		[Inject]
		public var modulePool:ModulePool;
		
		/**
		 * 模块列表 
		 */		
		[Inject]
		public var moduleList:ModuleList;
		
		/**
		 * constructor 
		 * 
		 */		
		public function PreloadCommonResourceCompleteCommand()
		{
			super();
		}
		
		/**
		 * 执行 
		 * 
		 */		
		override public function execute():void
		{
//			trace("resource complete");
//			modulePool.loadModule(moduleList.LOGON_MODULE, moduleList.getModuleUrl(moduleList.LOGON_MODULE));
		}
	}
}
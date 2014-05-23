package command
{
	import event.GetVersionFileEvent;
	
	import model.VersionFile;
	
	import org.robotlegs.mvcs.Command;
	
	import resource.CommonResourceManager;
	
	import service.ILocalService;
	
	/**
	 * handle version file 
	 * @author Linus
	 * 
	 */	
	public class GetVersionFileCommand extends Command
	{
		/**
		 * 响应事件 
		 */		
		[Inject]
		public var evt:GetVersionFileEvent;
		
		/**
		 * 资源加载管理 
		 */		
		[Inject]
		public var resMng:CommonResourceManager;
		
		/**
		 * 数据模型 
		 */		
		[Inject]
		public var versionFile:VersionFile;
		
		public function GetVersionFileCommand()
		{
			super();
		}
		
		/**
		 * 执行 配置版本文件信息
		 * 
		 */		
		override public function execute():void
		{
			versionFile.setData(evt.xmlData);
//			trace("===========Version File==============");
//			trace(evt.xmlData);
//			trace("GetVersionFileCommand.as中还没有处理版本信息！待部署时再处理！");
			
			resMng.loadPreloadCommonResource();
		}
	}
}
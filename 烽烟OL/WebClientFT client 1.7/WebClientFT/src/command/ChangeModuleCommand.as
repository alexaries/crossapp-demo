package command
{
	import event.ChangeModuleEvent;
	
	import model.ApplicationModel;
	
	import org.robotlegs.mvcs.Command;
	
	import resource.ModuleList;
	import resource.ModulePool;
	
	/**
	 * Change Module Handle 
	 * @author Linus
	 * 
	 */	
	public class ChangeModuleCommand extends Command
	{
		/**
		 * module pool 
		 */		
		[Inject]
		public var modulePool:ModulePool;
		
		/**
		 * module list 
		 */		
		[Inject]
		public var moduleList:ModuleList;
		
		/**
		 * change module event 
		 */		
		[Inject]
		public var evt:ChangeModuleEvent;
		
		/**
		 * construction 
		 * 
		 */		
		public function ChangeModuleCommand()
		{
			super();
		}
		
		override public function execute():void
		{
//			trace("ChangeModule ID:" + evt.newModuleId);
			modulePool.loadModule(evt.newModuleId, moduleList.getModuleUrl(evt.newModuleId));
		}
	}
}
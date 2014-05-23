package command
{
	import event.ClientModuleReadyEvent;
	
	import interfaces.ILogonModule;
	
	import model.ApplicationModel;
	
	import mx.core.IVisualElement;
	import mx.modules.Module;
	
	import org.robotlegs.mvcs.Command;
	
	import resource.ModulePool;
	
	/**
	 * 模块准备就绪处理 
	 * @author Linus
	 * 
	 */	
	public class ClientModuleReadyCommand extends Command
	{
		/**
		 * inject event 
		 */		
		[Inject]
		public var evt:ClientModuleReadyEvent;
		
		/**
		 * 应用框架模型 
		 */		
		[Inject]
		public var appModel:ApplicationModel;
		
		/**
		 * 
		 */		
		[Inject]
		public var modulePool:ModulePool;
		
		/**
		 * constructor 
		 * 
		 */		
		public function ClientModuleReadyCommand()
		{
			super();
		}
		
		/**
		 * 执行 
		 * 
		 */		
		override public function execute():void
		{
//			trace(evt.moduleId + " is ready!");
			appModel.setActiveModule(evt.moduleId, modulePool.getModule(evt.moduleId) as IVisualElement);
		}
	}
}
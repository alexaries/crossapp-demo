package model
{
	import event.ApplicationReplaceModuleEvent;
	
	import mx.core.IVisualElement;
	
	import org.robotlegs.mvcs.Actor;
	
	import resource.ModulePool;
	
	/**
	 * Model of Application 
	 * @author Linus
	 * 
	 */	
	public class ApplicationModel extends Actor
	{
		/**
		 * module pool 
		 */		
		[Inject]
		public var modulePool:ModulePool;
		
		/**
		 * 当前活动模块ID
		 */		
		private var _activeModuleId:String = '';
		
		/**
		 * 当前活动可视模块 
		 */		
		private var _activeModule:IVisualElement
		
		/**
		 * constructor 
		 * 
		 */		
		public function ApplicationModel()
		{
			super();
		}
		
		/**
		 * 设置当前活动模块 
		 * @param vis
		 * 
		 */		
		public function setActiveModule(id:String, vis:IVisualElement):void
		{
			if(_activeModule != null)
			{
				modulePool.unloadModule(_activeModuleId);
			}
			_activeModuleId = id;
			_activeModule = vis;
			this.dispatch(new ApplicationReplaceModuleEvent);
		}
		
		/**
		 * 返回活动模块 
		 * @return 
		 * 
		 */		
		public function getActiveModule():IVisualElement
		{
			return _activeModule;
		}
		/**
		 * 返回加载模块
		 */
		public function getLoadModule():String{
			return _activeModuleId;
		}
	}
}
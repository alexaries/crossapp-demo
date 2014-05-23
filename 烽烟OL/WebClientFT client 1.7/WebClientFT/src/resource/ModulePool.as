package resource
{
	import event.ClientModuleReadyEvent;
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	import event.ProgressLoadEvent;
	import event.SwitchMaskEvent;
	import flash.net.SharedObject;
	import model.GuideInfo;
	
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import mx.core.IFlexModuleFactory;
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleManager;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 模块池 ，全局管理应用模块
	 * @author Linus
	 * 
	 */	
	public class ModulePool extends Actor
	{
		[Inject]
		public var moduleFactory:IFlexModuleFactory;
		
		/**
		 * 模块信息映射
		 */		
		private var _pool:Dictionary;
		
		/**
		 * 反向映射模块ID 
		 */		
		private var _reverseDic:Dictionary;
		
		/**
		 * constructor 
		 * 
		 */			
		public function ModulePool()
		{
			_pool = new Dictionary;
			_reverseDic = new Dictionary;
			super();
		}
		
		/**
		 * 加载指定路径模块 
		 * @param url	路径
		 * 
		 */		
		public function loadModule(moduleId:String, url:String):void
		{
			var info:IModuleInfo = ModuleManager.getModule(url);
			info.addEventListener(ModuleEvent.READY, onReady);
			info.addEventListener(ModuleEvent.PROGRESS, onProgress);
			info.addEventListener(ModuleEvent.ERROR, onError);
			
			_pool[moduleId] = info;
			_reverseDic[info] = moduleId;
			
			//GuidEventCenter.getInstance().dispatchEvent(new SwitchMaskEvent(SwitchMaskEvent.SwitchMaskEvent_SHOW));
			
			GuidEventCenter.getInstance().dispatchEvent(
				new SwitchMaskEvent(
					SwitchMaskEvent.SwitchMaskEvent_SHOW, 
					info.load, 
					[ApplicationDomain.currentDomain, null, null, moduleFactory]
				)
			);
			
			//info.load(ApplicationDomain.currentDomain, null, null, moduleFactory);
		}
		
		/**
		 * 获取模块 
		 * @param moduleId 	模块ID
		 * @return 			模块实例
		 * 
		 */		
		public function getModule(moduleId:String):*
		{
			if(_pool.hasOwnProperty(moduleId))
			{
				var info:IModuleInfo = _pool[moduleId];
				if(info.ready)
				{
					return info.factory.create();	
				}
				else
				{
					info.load(null, null, null, moduleFactory);
				}
			}
			else
			{
				throw new Error("Module is not loaded!");
			}
		}
		
		/**
		 * 卸载模块 
		 * @param moduleId 模块ID
		 * 
		 */		
		public function unloadModule(moduleId:String):void
		{
			if(_pool.hasOwnProperty(moduleId))
			{
				var info:IModuleInfo = _pool[moduleId];
				if(info){
					info.addEventListener(ModuleEvent.UNLOAD, onUnload, false, 0, true);
					info.unload();
				}				
				_pool[moduleId] = null;
			}
		}
		
		/**
		 * 加载完毕
		 * @param evt
		 * 
		 */		
		private function onReady(evt:ModuleEvent):void
		{
//			trace("ModulePool:" + evt.module.url + " ready");
//			trace("ModuleID:" + _reverseDic[evt.module]);
			this.dispatch(new ClientModuleReadyEvent(_reverseDic[evt.module]));
			
			if (_reverseDic[evt.module] == "logonModule") {

			}
			else{
				GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CHANGE_MODEL));
			}
		}
		
		/**
		 * 加载进程
		 * @param evt
		 * 
		 */		
		private function onProgress(evt:ModuleEvent):void
		{
//			trace("ModulePool:" + evt.module.url + ":" + evt.bytesLoaded + "/" + evt.bytesTotal);
			this.dispatch(new ProgressLoadEvent(ProgressLoadEvent.PROGRESSLOAD,evt));
		}
		
		/**
		 * 加载错误
		 * @param evt
		 * 
		 */		
		private function onError(evt:ModuleEvent):void
		{
			trace("ModulePool Error:" + evt.errorText);
		}
		
		/**
		 * 卸载模块 
		 * @param evt
		 * 
		 */		
		private function onUnload(evt:ModuleEvent):void
		{
			trace("ModulePool Unload:" + evt.module.url);
		}
	}
}
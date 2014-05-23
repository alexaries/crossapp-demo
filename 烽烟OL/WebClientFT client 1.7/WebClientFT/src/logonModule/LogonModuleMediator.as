package logonModule
{
	import event.ChangeModuleEvent;
	
	import flash.events.Event;
	
	import interfaces.ILogonModule;
	
	import model.URLConst;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Mediator;
	
//	import registModule.event.RegPageEvent;
	
	
	
	/**
	 * Mediator of LogonModule, it's a module at the same time a view 
	 * @author Linus
	 * 
	 */	
	public class LogonModuleMediator extends Mediator
	{
		/**
		 * 注入模块接口 
		 */		
		[Inject]
		public var module:ILogonModule;
		
		/**
		 * context of module 
		 */		
		private var _moduleContext:IContext;
		
		/**
		 * construction 
		 * 
		 */		
		public function LogonModuleMediator()
		{
			super();
		}
		
		/**
		 * 注册消息 
		 * 
		 */		
		override public function onRegister():void
		{
			// 获取模块级context
			_moduleContext = module.getContext();
			
			
			// 模块内监听
			this.eventMap.mapListener(_moduleContext.eventDispatcher, ChangeModuleEvent.CHANGE_MODULE_EVENT, onChangeModule);
		}
		
		
		/**
		 * 向全局发送消息 
		 * @param event
		 * 
		 */		
		private function onChangeModule(evt:ChangeModuleEvent):void
		{
			this.dispatch(evt);
		}
		
	}
}
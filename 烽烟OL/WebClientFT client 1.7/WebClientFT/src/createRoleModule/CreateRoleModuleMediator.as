package createRoleModule
{
	/**
	 * 创建角色模块mediator
	 * @author Yaolx
	 * 
	 */
	
	import event.ChangeModuleEvent;
	
	import flash.events.Event;
	
	import interfaces.ICreateRoleModule;
	
	import org.robotlegs.core.IContext;
	
	import org.robotlegs.mvcs.Mediator;
	
//	import registModule.event.RegPageEvent;
	
	public class CreateRoleModuleMediator extends Mediator
	{
		/**
		 * 注入模块接口 
		 */		
		[Inject]
		public var module:ICreateRoleModule;
		
		/**
		 * context of module 
		 */		
		private var _moduleContext:IContext;
		public function CreateRoleModuleMediator()
		{
			super();
		}
		/**
		 *注册消息 
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
		 * 模块切换
		 * @param evt
		 * 
		 */		
		private function onChangeModule(evt:ChangeModuleEvent):void{
		   this.dispatch(evt);
		}
	}
}
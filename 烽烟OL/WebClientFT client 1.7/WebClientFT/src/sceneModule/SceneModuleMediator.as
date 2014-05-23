package sceneModule
{
	import interfaces.ISceneModule;
	
	import org.robotlegs.core.IContext;
	import org.robotlegs.mvcs.Mediator;

	public class SceneModuleMediator extends Mediator
	{
		/**
		 * 模块接口映射 
		 */		
		[Inject]
		public var module:ISceneModule;
		
		/**
		 * 模块Context
		 */		
		private var _moduleContext:IContext;
		public function SceneModuleMediator()
		{
			super();
		}
		/**
		 * 注册消息 
		 * 
		 */		
		override public function onRegister():void
		{
			_moduleContext = module.getContext();
			
		}
	}
}
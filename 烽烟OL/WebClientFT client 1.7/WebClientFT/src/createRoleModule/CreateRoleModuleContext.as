package createRoleModule
{
	import createRoleModule.mediator.CreateRoleFTViewMediator;
	import createRoleModule.mediator.CreateRoleViewMediator;
	import createRoleModule.mediator.RoleInfoComponentMediator;
	import createRoleModule.view.*;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	import resource.ModuleList;
	
	import sceneModule.command.GetRoleInfoResponseCommand;
	import sceneModule.event.GetRoleInfoResponseEvent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.*;

	/**
	 * 创建角色模块context
	 * @author Yaolx
	 * 
	 */
	public class CreateRoleModuleContext extends Context
	{
		public function CreateRoleModuleContext(contextView:DisplayObjectContainer=null,autoStartup:Boolean=true)
		{
			super(contextView,autoStartup);
		}
		/**
		 * 初始化模块结构
		 * 
		 */
		override public function startup():void
		{
			this.injector.mapSingleton(ModuleList);
		   //映射remoting server
			
			injector.mapValue(ISocketServer,((this.contextView) as CreateRoleModule).getSocketService());
			
			injector.mapValue(IPopUpShow,((this.contextView) as CreateRoleModule).getPopUpShow());
			//view
			mediatorMap.mapView(CreateRoleView,CreateRoleViewMediator);
			mediatorMap.mapView(CreateRoleFTView,CreateRoleFTViewMediator);
			mediatorMap.mapView(RoleInfoComponent,RoleInfoComponentMediator);
			
		}
	}
}
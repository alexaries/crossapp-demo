package logonModule
{
	import flash.display.DisplayObjectContainer;
	
	import logonModule.mediator.LoginPageMediator;
	import logonModule.view.LoginPageView;
	
	import model.ServerConfig;
	
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Context;
	
//	import registModule.command.GetRegValidateCodeCommand;
//	import registModule.event.GetRegValidateCodeEvent;
//	import registModule.event.RegPageEvent;
	
	import resource.ModuleList;
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.*;
	
	/**
	 * 登陆模块Context 
	 * @author Linus
	 * 
	 */	
	public class LogonModuleContext extends Context
	{
		/**
		 * construction 
		 * @param contextView 关联应用
		 * @param autoStartup 自动注册
		 * 
		 */	
		public function LogonModuleContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		/**
		 * 初始化模块结构 
		 * 
		 */		
		override public function startup():void
		{
			this.injector.mapSingleton(ModuleList);
			
			// 映射remoting server
			
			injector.mapValue(ISocketServer,(this.contextView as LogonModule).getSocketService());
			
			injector.mapValue(ServerConfig,(this.contextView as LogonModule).getServerConfig());
			
			injector.mapValue(IPopUpShow,(this.contextView as LogonModule).getPopUpShow());
			//view
			mediatorMap.mapView(LoginPageView,LoginPageMediator);
			
			injector.mapValue(PopUpWindowLayer,(this.contextView as LogonModule).getPopUpWindow());
			//service
			//injector.mapClass(HTTPService, HTTPService); 
			//command
			// commandMap.mapEvent(RegPageEvent.SWITCH_TO_LOGINGPAGEVIEW,RegNowCommand);
		}
	}
}
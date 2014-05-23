package
{
	import command.*;
	
	import createRoleModule.CreateRoleModuleMediator;
	import createRoleModule.mediator.*;
	import createRoleModule.view.*;
	
	import event.*;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.system.Security;
	
	import interfaces.*;
	
	import loader.ProgressBarControl;
	
	import logonModule.LogonModuleMediator;
	
	import managers.KeyBordManager;
	import managers.UILayerManager;
	
	import mediator.ApplicationMediator;
	import mediator.SwitchMaskMediator;
	import mediator.TaskGuideMediator;
	
	import model.*;
	
	import mx.core.IFlexModuleFactory;
	import mx.core.UIComponent;
	import mx.modules.ModuleLoader;
	
	import org.robotlegs.mvcs.Context;
	
	import resource.*;
	
	import sceneModule.SceneModuleMediator;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.popupWin.PopUpShow;
	
	import service.*;
	import service.ISocketServer;
	import service.SocketService;
	
	import util.IPopUpTaskShow;
	import util.PopUpTaskShow;

	
	/**
	 * 应用程序总context 
	 * @author Linus
	 * 
	 */	
	public class ApplicationContext extends Context
	{
		/**
		 * constructor 
		 * @param contextView 关联界面
		 * @param autoStartup 自动开始
		 * 
		 */		
		public function ApplicationContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		/**
		 * 初始化模块结构 
		 * 
		 */		
		override public function startup():void
		{	
			// mapping singleton
			this.injector.mapSingleton(ServerConfig);
			this.injector.mapSingleton(VersionFile);
			this.injector.mapSingleton(CommonResourceManager);
			this.injector.mapSingleton(ResourceList);
			this.injector.mapSingleton(ModulePool);
			this.injector.mapSingleton(ModuleList);
			this.injector.mapSingleton(ApplicationModel);
//			this.injector.mapSingleton(FeedbackBox);
			
			// mapping singleton interface
			this.injector.mapSingletonOf(ILocalService, LocalServer);
			this.injector.mapSingletonOf(IWebService, WebServer);
//			this.injector.mapSingletonOf(IRemoteService, RemoteServer);
			this.injector.mapSingletonOf(ISocketServer,SocketService);
			this.injector.mapSingletonOf(IPopUpShow,PopUpShow);
			this.injector.mapSingletonOf(IPopUpTaskShow,PopUpTaskShow);
			injector.mapValue(PopUpWindowLayer,getPopUpWindow());
			
			var app:WebClient = this.contextView as WebClient;
			this.injector.mapValue(IFlexModuleFactory, app.moduleFactory);
			
			//添加键盘监听
			KeyBordManager.getInstance().init(app.stage);
			
			
			
			
			// mapping modules, using String for dynamic mapping
			mediatorMap.mapView('logonModule::LogonModule', LogonModuleMediator, ILogonModule);
//			mediatorMap.mapView('registModule::RegistModule', RegistModuleMediator, IRegistModule);
			mediatorMap.mapView('createRoleModule::CreateRoleModule', CreateRoleModuleMediator, ICreateRoleModule);
			mediatorMap.mapView('sceneModule::SceneModule', SceneModuleMediator, ISceneModule);
			mediatorMap.mapView(GuidLayer,TaskGuideMediator);
			mediatorMap.mapView(SwitchMaskLayer,SwitchMaskMediator);
			
			mediatorMap.mapView(WebClient, ApplicationMediator);
			
			// mapping command
			commandMap.mapEvent(LocalServerEvent.CONFIG_LOADED, LocalConfigFileLoadedCommand);
			commandMap.mapEvent(GetVersionFileEvent.VERSION_FILE_LOADED, GetVersionFileCommand);
			commandMap.mapEvent(ClientResourceEvent.PRELOAD_COMMON_RESOURCE_COMPLETE, PreloadCommonResourceCompleteCommand);
			commandMap.mapEvent(ClientModuleReadyEvent.CLIENT_MODULE_READY, ClientModuleReadyCommand);
			commandMap.mapEvent(ChangeModuleEvent.CHANGE_MODULE_EVENT, ChangeModuleCommand);
			
			
			//注册UI弹出层
			UILayerManager.getInstance().alert_layer = app.ui_alert;
			
			// setup security policy
//			securityPolicy();
			
			// load config file
			loadConfigFile();
			
			super.startup();
				
		}
		
		/**
		 * 设置网络访问安全协议 
		 * 
		 */		
		private function securityPolicy():void
		{
			Security.loadPolicyFile('');
		}
		
		/**
		 * 读取配置文件 
		 * 
		 */		
		private function loadConfigFile():void
		{
//			var local:ILocalService = this.injector.getInstance(ILocalService);
//			local.loadConfigFile();
			var rsm:CommonResourceManager = this.injector.getInstance(CommonResourceManager);
			rsm.loadPreloadCommonResource();
		}
		/**
		 * 获取ISocketServer
		 *  
		 */	
		public function getISocketServer():ISocketServer{
		   var socketServer:ISocketServer = this.injector.getInstance(ISocketServer);
		   return socketServer;
		}
		/**
		 * 获取ServerConfig 
		 */		
		public function getServerConfig():ServerConfig{
		   var serverConfig:ServerConfig = this.injector.getInstance(ServerConfig);
		   return serverConfig;
		}
		/**
		 * 获取popupShow
		 */
		public function getPopUpShow():IPopUpShow{
			var popUpShow:IPopUpShow = this.injector.getInstance(IPopUpShow);
			return popUpShow;
		}
		/**
		 * 获取popUpTaskShow
		 */
		public function getPopUpTaskShow():util.IPopUpTaskShow{
			var popUpTaskShow:IPopUpTaskShow = this.injector.getInstance(IPopUpTaskShow);
			return popUpTaskShow;
		}
		/**
		 * 获取tooltip
		 */
		public function getTooltip():MainMenuEquipmentTooltip{
			return (this.contextView as WebClient).toolTipComp;
		}
		/**
		 * 获取弹出窗口实例
		 */
		public function getPopUpWindow():PopUpWindowLayer{
			return (this.contextView as WebClient).popUpWindowLayer;
		}
		/**
		 * 
		 */
		public function getApplicationScene():Sprite{
			return (this.contextView as WebClient).scene;
		}
		/**
		 * 获取加载条实例
		 */
		public function getProgressLoadInstance():ProgressBarControl{
			return (this.contextView as WebClient).proBar;
		}
	}
}
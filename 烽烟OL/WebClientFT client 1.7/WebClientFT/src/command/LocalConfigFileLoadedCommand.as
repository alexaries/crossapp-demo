package command
{
	import event.LocalServerEvent;
	import util.xtrace;
	
	import model.ServerConfig;
	
	import org.robotlegs.mvcs.Command;
	
	import service.ILocalService;
	import service.ISocketServer;
	import service.IWebService;
	
	/**
	 * 处理本地配置文件加载完毕事件 
	 * @author Linus
	 * 
	 */	
	public class LocalConfigFileLoadedCommand extends Command
	{
		[Inject]
		public var evt:LocalServerEvent;
		
		[Inject]
		public var serverConfig:ServerConfig;
		
		[Inject]
		public var localServer:ILocalService;
		
		[Inject]
		public var webServer:IWebService;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		/**
		 * constructor 
		 * 
		 */		
		public function LocalConfigFileLoadedCommand()
		{
			super();
		}
		
		/**
		 * 处理 
		 * 
		 */		
		override public function execute():void
		{
			serverConfig.setData(evt.xmlData);
			
			//设置webServer
			webServer.setUrl(String(serverConfig.httpServerIP), String(serverConfig.httpServerPort));
			
//			trace("LocalConfigFileLoadedCommand.as，在此配置socket服务器信息以及验证码服务器信息");
			//配置socket服务器信息，与服务器建立连接
			socketServer.host = String(serverConfig.socketServerIp);
			socketServer.port = serverConfig.socketServerPort;
			xtrace("设置服务器连接信息 ", socketServer.host, ":", socketServer.port);
			
			//点击按钮的时候连接服务器
			socketServer.connect(function():void{
				
			});
			
			// 读取版本文件
			localServer.loadVersionFile("config/Version.xml");
		}
	}
}
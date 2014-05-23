package resource
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	import wordscene.config.SConfigCenter;
	import wordscene.helper.MapPathFinder;
	import wordscene.loader.SAssetManager;
	
	
	import event.ClientResourceEvent;
	import event.GuidEventCenter;
	import event.GuideConfigLoadedEvent;
	import event.NGuidEvent;
	import event.PreLoadResProgressEvent;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.IDataInput;
	
	import mediator.TaskGuideMediator;
	
	import model.ServerConfig;
	import model.SystemDataModel;
	
	import mx.controls.Alert;
	
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	import org.robotlegs.mvcs.Actor;
	
	import sceneModule.view.levelup.command.CrotaIILevelUpConfig;
	import sceneModule.view.territory.model.TerritoryConfig;
	import sceneModule.view.wordmap.model.MapConfig;
	
	import service.ISocketServer;
	import service.IWebService;
	
	/**
	 * Common Resource Class 
	 * @author Linus
	 * 
	 */	
	public class CommonResourceManager extends Actor
	{
		[Inject]
		public var resourceList:ResourceList;
		
		[Inject]
		public var serverConfig:ServerConfig;
		
		[Inject]
		public var webServer:IWebService;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		/**
		 * resource loader 
		 */		
		private var _resourceLoader:BulkLoader;
		
		/**
		 * constructor 
		 * 
		 */		
		public function CommonResourceManager()
		{
			super();
		}
		
		/**
		 * 加载预加载资源 
		 * 
		 */		
		public function loadPreloadCommonResource():void
		{
			_resourceLoader = new BulkLoader('preloadCommonResource');
			_resourceLoader.allowsAutoIDFromFileName = true;
			
			for each(var item:Object in resourceList.preloadCommonResource)
			{
//				trace(item.id + ":" + item.url);
				_resourceLoader.add(item.url, item).id;
			}
			_resourceLoader.addEventListener(BulkProgressEvent.PROGRESS, onPreloadCommonResourceProgress, false, 0, true);
			_resourceLoader.addEventListener(BulkProgressEvent.COMPLETE, onPreloadCommonResourceComplete, false, 0, true);
			if(_resourceLoader.itemsTotal == 0)
			{
				onPreloadCommonResourceComplete();
			}
			else
			{
				_resourceLoader.start();
			}
		}
		
		/**
		 * 获取已加载的资源 
		 * @param key
		 * @return 
		 * 
		 */		
		public function getPreloadCommonResourceById(key:String):*
		{
			BulkLoader.getLoader('preloadCommonResource').getContent(key,false);
		}
		
		/**
		 * 预加载资源中
		 * @param event
		 * 
		 */		
		private function onPreloadCommonResourceProgress(evt:BulkProgressEvent):void
		{
//			trace("Loaded" , evt.bytesLoaded," of ",  evt.weightPercent);
			this.dispatch(new PreLoadResProgressEvent(PreLoadResProgressEvent.PROLOADRESPROGRESS,evt.weightPercent));
		}
		
		/**
		 * 预加载资源结束
		 * @param event
		 * 
		 */		
		private function onPreloadCommonResourceComplete(e:BulkProgressEvent=null):void
		{
			
			serverConfig.setData(_resourceLoader.getXML("server_config"));
			
			MapConfig.getInstance().map_info_xml = _resourceLoader.getXML("map_config");
			MapConfig.getInstance().fb_config_xml = _resourceLoader.getXML("fb_config");
			AssetCenter.getInstance().init_xml(_resourceLoader.getXML("asset_config"));
			SAssetManager.getInstance().setAssetXML(_resourceLoader.getXML("res_config"));
			SConfigCenter.getInstance().entitysXML = _resourceLoader.getXML("entitys_config")
			AssetCenter.getInstance().rewardDes_xml = _resourceLoader.getXML("rewardDes_config");
			TerritoryConfig.getInstance().territory_xml = _resourceLoader.getXML("territory_config");
			CrotaIILevelUpConfig.getInstance().levUpXML = _resourceLoader.getXML("levupEff_config");
			MapPathFinder.getInstance().init(_resourceLoader.getXML("trip_config"));
			SConfigCenter.getInstance().zhanyinXML = _resourceLoader.getXML("zhanyi_config");
			
			//初始化新手指引数据
			MapConfig.getInstance().guide_xml = _resourceLoader.getXML("guide_config");
			
			//加载zip
			startLoadItemFile();
		}
		
		private function initSocketInfoAndConnect():void{
			//设置webServer
			webServer.setUrl(String(serverConfig.httpServerIP), String(serverConfig.httpServerPort));
			
//			trace("LocalConfigFileLoadedCommand.as，在此配置socket服务器信息以及验证码服务器信息");
			//配置socket服务器信息，与服务器建立连接
			socketServer.host = String(serverConfig.socketServerIp);
			socketServer.port = serverConfig.socketServerPort;
			
			//连接服务器
			socketServer.connect(function():void{
				
			});
		}
		
		private function ui_pre_load_ok():void {
			this.dispatch(new ClientResourceEvent(ClientResourceEvent.PRELOAD_COMMON_RESOURCE_COMPLETE));
		}
		
		//加载器
		public var urlLoader:URLLoader = new URLLoader;
		private function startLoadItemFile():void
		{
			//加载zip文件
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			urlLoader.addEventListener(Event.COMPLETE,complete);
			urlLoader.addEventListener(ProgressEvent.PROGRESS,onProgressLoad);
			urlLoader.load(new URLRequest('config/item.zip'));
		}
		private function complete(evt:Event):void{
			var zip:ZipFile = new ZipFile(evt.target.data);
			var entry:ZipEntry = zip.entries[0];
			var s:String = String(zip.getInput(entry));//使用字节数组作为参数，传到String构造函数中生成字符串。
			var xml:XML = new XML(s);
			CrotaItemConfig.getInstance()._itemXML = xml;
//			//加载预加载ui资源
//			AssetCenter.getInstance().pre_load(ui_pre_load_ok);
			//加载文本资源文件
			startLoadResFile();
		}
		private function onProgressLoad(evt:ProgressEvent):void{
			this.dispatch(new PreLoadResProgressEvent(PreLoadResProgressEvent.PRELOADZIPRESPROGRESS,evt.bytesLoaded/evt.bytesTotal));
		}
		
		//加载文本资源配置文件
		private var resLoader:URLLoader = new URLLoader();
		private function startLoadResFile():void{
			//加载zip文件
			resLoader.dataFormat = URLLoaderDataFormat.BINARY;
			resLoader.addEventListener(Event.COMPLETE,onResComplete);
			resLoader.addEventListener(ProgressEvent.PROGRESS,onProgressLoad);
			resLoader.load(new URLRequest('config/local/'+String(serverConfig.languageVersion)+'/message.zip'));
		}
		private function onResComplete(evt:Event):void{
			var zip:ZipFile = new ZipFile(evt.target.data);
			var entry:ZipEntry = zip.entries[0];
			var s:String = String(zip.getInput(entry));//使用字节数组作为参数，传到String构造函数中生成字符串。
			var xml:XML = new XML(s);
			CrotaResourceConfig.getInstance().resXML = xml;
			//加载预加载ui资源
			AssetCenter.getInstance().pre_load(ui_pre_load_ok);
			//配置socket信息,创建连接
			initSocketInfoAndConnect();
		}
	}
}
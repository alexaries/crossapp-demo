package Animation
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;

	public class ResourceLoadManager extends EventDispatcher
	{
		
		private static var compClassName:String="ComponentClass";
		private static var _instance:ResourceLoadManager;
		/**
		 *  存储所有已经加载的元件方式的影片剪辑资源 key表示资源路径，value表示资源相关的数据
		 */
		private var compMovieDic:Dictionary=new Dictionary();
		/**
		 *	所有预加载的movieclipxml数组
		 */
		private var preLoadMcArray:Array=new Array();
		/**
		 * 每次同时加载影片剪辑的个数
		 */
		public static const MCONCELOAD_COUNT:int=5;
		
		private var preloadCount:int;
		
		/**
		 * 位图数据字典 key表示资源url,value 表示位图数据
		 */
		private var bitmapDataDic:Dictionary=new Dictionary();
		
		public static function get instance():ResourceLoadManager
		{
			if (_instance == null)
			{
				_instance=new ResourceLoadManager();
			}
			return _instance;
		}
		
		/**
		 * 通过元件的方式获得影片剪辑
		 * @url 资源路径
		 * @name 元件名字(必须是元件属性中那个名称)
		 */
		public function getMoviClipByComponent(url:String):MovieClip
		{
			
			//如果键值未定义或者键值为空
			if (compMovieDic[url] == undefined || compMovieDic[url] == null)
			{
				loadSwfByComponent(url);
				return null;
			}
			else if (compMovieDic[url] is LoaderInfo)
			{
				var loaderInfo:LoaderInfo=compMovieDic[url] as LoaderInfo;
				var mc:MovieClip;
				try
				{
//					var Component:Class=loaderInfo.applicationDomain.getDefinition(compClassName) as Class;
//					mc=new Component();
					mc = loaderInfo.content as MovieClip;
				}
				catch (e:Error)
				{
					trace("无法在域中找到资源 " + loaderInfo.url);
				}
				return mc;
			}
			return null;
		}
		
		/**
		 * 加载一个只包含元件的swf
		 */
		private function loadSwfByComponent(url:String):void
		{
			var loader:Loader=new Loader();
			var request:URLRequest=new URLRequest(url);
			loader.contentLoaderInfo.addEventListener(Event.OPEN, onSwfLoadOpenByComponent);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onSwfLoadProgressByComponent);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onSwfLoadCompleteByComponent);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadResFailed);
			loader.load(request);
			compMovieDic[url]=loader.contentLoaderInfo;
		}
		
		/**
		 * 加载资源失败
		 */
		private function onLoadResFailed(event:IOErrorEvent):void
		{
			var loaderInfo:LoaderInfo=event.currentTarget as LoaderInfo
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadResFailed);
			mx.controls.Alert.show(event.text);
		}
		
		/**
		 * 加载包含元件的swf文件完成
		 */
		private function onSwfLoadCompleteByComponent(event:Event):void
		{
			var loaderInfo:LoaderInfo=event.currentTarget as LoaderInfo;
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onSwfLoadProgressByComponent);
			loaderInfo.removeEventListener(Event.COMPLETE, onSwfLoadCompleteByComponent);
			var value:Object;
			
			for (var prop:String in compMovieDic) //此处需要优化
			{
				value=compMovieDic[prop];
				if (value && value == loaderInfo)
				{
					var resLoadEvent:ResourceLoadEvent=new ResourceLoadEvent(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE);
					resLoadEvent.url=prop;
					resLoadEvent.resourceType=ResourceLoadEvent.MOVIECLIP;
					this.dispatchEvent(resLoadEvent);
					break;
				}
				
			}
		}
		
		/**
		 * 加载资源开始 
		 * @param evt 事件
		 * 
		 */		
		private function onSwfLoadOpenByComponent(evt:Event):void
		{
			var loaderInfo:LoaderInfo=evt.currentTarget as LoaderInfo;
			loaderInfo.removeEventListener(Event.OPEN, onSwfLoadOpenByComponent);
			// Event.OPEN
			this.dispatchEvent(evt);
		}
		
		/**
		 * 加载资源进程 
		 * @param evt 事件
		 * 
		 */		
		private function onSwfLoadProgressByComponent(evt:ProgressEvent):void
		{
			// ProgressEvent
			this.dispatchEvent(evt);
		}
		
		public function ResourceLoadManager()
		{
		}
		
	}
}
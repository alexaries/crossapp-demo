package service
{
	import event.GetVersionFileEvent;
	import event.LocalServerEvent;
	import event.PreLoadResProgressEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * Local file and resource 
	 * @author Linus
	 * 
	 */	
	public class LocalServer extends Actor implements ILocalService
	{
		/**
		 * 加载器 
		 */		
		private var _loader:URLLoader;
		
		/**
		 * constructor 
		 * 
		 */		
		public function LocalServer()
		{
			_loader = new URLLoader;
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, true);
			
			super();
		}
		
		/**
		 * local config file 
		 * 
		 */		
		public function loadConfigFile():void
		{
			var req:URLRequest = new URLRequest("config/ServerConfig.xml");
			_loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			_loader.addEventListener(ProgressEvent.PROGRESS,onServerConfigLoadProgress);
			_loader.load(req);
		}
		
		private function onServerConfigLoadProgress(evt:ProgressEvent):void{
			this.dispatch(new PreLoadResProgressEvent(PreLoadResProgressEvent.PROLOADRESPROGRESS,evt.bytesLoaded/evt.bytesTotal));
		}
		
		/**
		 * local version file 
		 * @param url
		 * 
		 */		
		public function loadVersionFile(url:String):void
		{
			var req:URLRequest = new URLRequest(url);
			_loader.addEventListener(Event.COMPLETE, onLoadVersionFile, false, 0, true);
			_loader.addEventListener(ProgressEvent.PROGRESS,onLoadVersionProgress);
			_loader.load(req);
		}
		
		private function onLoadVersionProgress(evt:ProgressEvent):void{
			this.dispatch(new PreLoadResProgressEvent(PreLoadResProgressEvent.PROLOADRESPROGRESS,evt.bytesLoaded/evt.bytesTotal));
		}
		
		/**
		 * 加载完毕 
		 * @param event
		 * 
		 */		
		private function onComplete(evt:Event):void
		{
			_loader.removeEventListener(Event.COMPLETE, onComplete);
			var data:XML = XML(evt.target.data);
			this.dispatch(new LocalServerEvent(LocalServerEvent.CONFIG_LOADED, data));
		}
		
		/**
		 * I/O错误 
		 * @param event
		 * 
		 */		
		private function onError(evt:IOErrorEvent):void
		{
			trace("I/O Error:" + evt.text);
		}
		
		/**
		 * 安全错误 
		 * @param event
		 * 
		 */		
		private function onSecurityError(evt:SecurityErrorEvent):void
		{
			trace("Security Error:" + evt.text);
		}
		
		/**
		 * 读取版本文件成功 
		 * @param event
		 * 
		 */		
		private function onLoadVersionFile(evt:Event):void
		{
			_loader.removeEventListener(Event.COMPLETE, onLoadVersionFile);
			var xml:XML = XML(evt.target.data);
			var e:GetVersionFileEvent = new GetVersionFileEvent(xml);
			this.dispatch(e);
		}
	}
}
package Animation
{
	import createRoleModule.view.progressBarComponentLoad;
	
	import de.polygonal.ds.NullIterator;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.controls.ProgressBar;
	import mx.controls.ProgressBarMode;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.supportClasses.GroupBase;

	/**
	 * 动画控制类 
	 * @author Yaolx
	 * 
	 */	
	public class Animation extends UIComponent
	{
		
		private var _url:String;
		//出场阶段的起始帧
		private var startFrame:int;
		//出场阶段的结束帧
		private var endFrame:int;
		//消失阶段的起始帧
		private var preStartFrame:int;
		//消失阶段的结束帧
		private var preEndFrame:int;
		
		/**
		 * 加载进度条 
		 */		
		//private var _progressBar:ProgressBar;
		private var _progressBar:progressBarComponentLoad
		
		public function Animation(url:String)
		{
			this._url = url;
			initProgressBar();
		}
		
		/**
		 * 初始化加载进度条 
		 * 
		 */		
		private function initProgressBar():void
		{
			_progressBar = new progressBarComponentLoad;
			//_progressBar.mode = ProgressBarMode.MANUAL;
		}
		
		/**
		 * 添加动画到父类
		 * @p父类
		 */
		public function addToParent(p:Group):void{
		    p.addElement(this);
		}
		/**
		 * 动画在屏幕中的位置
		 */
		public function setPosition(x:int,y:int):void{
		    this.x = x;
			this.y = y;
		}
		
		/**
		 * 设置加载进度条位置 
		 * @param x
		 * @param y
		 * 
		 */		
		public function setProgressBarPosAndSize(x:Number, y:Number, w:Number = 460, h:Number =30):void
		{
			_progressBar.x = x;
			_progressBar.y = y;
			_progressBar.width = w;
			_progressBar.height = h;
		}
		
		/**
		 * 加载并播放动画
		 * 出场动画阶段控制
		 */
		public function play(beginFrame:int, _endFrame:int):void{			
			startFrame = beginFrame;
			endFrame = _endFrame;
			var mc:MovieClip=ResourceLoadManager.instance.getMoviClipByComponent(_url);
			if (mc == null)
			{
				ResourceLoadManager.instance.addEventListener(Event.OPEN, onResourceLoadOpen);
				ResourceLoadManager.instance.addEventListener(ProgressEvent.PROGRESS, onResourceLoadProgress);
				ResourceLoadManager.instance.addEventListener(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE, onMovieClipLoaded);
			}
			else
			{
				addChild(mc);
				mc.gotoAndPlay(startFrame);
				mc.addEventListener(Event.ENTER_FRAME, stopMovie);
			}
		}
		/**
		 * 出场阶段动画加载完毕
		 */
		private function onMovieClipLoaded(event:ResourceLoadEvent):void
		{
			ResourceLoadManager.instance.removeEventListener(Event.OPEN, onResourceLoadOpen);
			ResourceLoadManager.instance.removeEventListener(ProgressEvent.PROGRESS, onResourceLoadProgress);
			ResourceLoadManager.instance.removeEventListener(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE, onMovieClipLoaded);
			if(null != _progressBar.parent)
			{
				_progressBar.parent.removeChild(_progressBar);
			}
			if (event.resourceType == ResourceLoadEvent.MOVIECLIP)
			{
				var url:String=event.url as String;
				var mc:MovieClip=ResourceLoadManager.instance.getMoviClipByComponent(url);
				if(mc == null)return;
				addChild(mc);
				mc.gotoAndPlay(startFrame);
				mc.addEventListener(Event.ENTER_FRAME, stopMovie);
			}
		}
			/**
			 * 在指定帧停止播放动画
			 * Stop playing at the end frame.
			 */
			private function stopMovie(event:Event):void
			{
				var mc:MovieClip=event.currentTarget as MovieClip;
				if (mc.currentFrame == endFrame)
				{	
					mc.stop();
					mc.removeEventListener(Event.ENTER_FRAME, stopMovie);
				}

			}
		/**
		 * 消失阶段动画控制
		 * @resultHandler 回调函数
		 */
		private var resultHandler:Function;
		public function nextPlay(beginFrame:int, _endFrame:int,functionHandler:Function):void{
			preStartFrame = beginFrame;
			preEndFrame = _endFrame;
			resultHandler = functionHandler;
			var mc:MovieClip=ResourceLoadManager.instance.getMoviClipByComponent(_url);
			if (mc == null)
			{
				ResourceLoadManager.instance.addEventListener(Event.OPEN, onResourceLoadOpen);
				ResourceLoadManager.instance.addEventListener(ProgressEvent.PROGRESS, onResourceLoadProgress);
				ResourceLoadManager.instance.addEventListener(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE, onMovieClipLoadedNext);
			}
			else
			{
				mc.gotoAndPlay(preStartFrame);
				mc.addEventListener(Event.ENTER_FRAME, nextStopMovie);
			}
		}	
		/**
		 * 退出动画加载完毕
		 */
		private function onMovieClipLoadedNext(event:ResourceLoadEvent):void
		{
			ResourceLoadManager.instance.removeEventListener(Event.OPEN, onResourceLoadOpen);
			ResourceLoadManager.instance.removeEventListener(ProgressEvent.PROGRESS, onResourceLoadProgress);
			ResourceLoadManager.instance.removeEventListener(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE, onMovieClipLoadedNext);
			if(null != _progressBar.parent)
			{
				/*trace("_progress bar removed");*/
				_progressBar.parent.removeChild(_progressBar);
			}
			if (event.resourceType == ResourceLoadEvent.MOVIECLIP)
			{
				var url:String=event.url as String;
				var mc:MovieClip=ResourceLoadManager.instance.getMoviClipByComponent(url);
				if(mc == null)return;
				addChild(mc);
				mc.gotoAndPlay(preStartFrame);
				mc.addEventListener(Event.ENTER_FRAME, nextStopMovie);
			}
			
		}
		/**
		 * 在指定帧停止播放动画
		 * Stop playing at the end frame.
		 */
		private function nextStopMovie(event:Event):void
		{
			var mc:MovieClip=event.currentTarget as MovieClip;
			if (mc.currentFrame == preEndFrame)
			{
				mc.stop();
				mc.removeEventListener(Event.ENTER_FRAME, nextStopMovie);
				resultHandler();
			}
		}
		/**
		 * Resource load start 
		 * @param evt
		 * 
		 */		
		private function onResourceLoadOpen(evt:Event):void
		{
			if(_progressBar.parent == null)
			{
				this.addChild(_progressBar);
			}
			/*trace("progress bar x:" + _progressBar.x);
			trace("progress bar y:" + _progressBar.y);*/
			_progressBar.isPopUp = true;
			_progressBar.setActualSize(100, 30);
		}
		
		/**
		 * Resource load progress 
		 * @param evt
		 * 
		 */		
		private function onResourceLoadProgress(evt:ProgressEvent):void
		{
			//_progressBar.setProgress(evt.bytesLoaded, evt.bytesTotal);
		}
		
		/**
		 * 移除动画
		 */
		public function removeFromParent(p:Group):void{
		    p.removeElement(this);
		}
	}
}
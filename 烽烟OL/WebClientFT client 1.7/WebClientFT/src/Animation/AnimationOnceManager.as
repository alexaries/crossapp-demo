package Animation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;

	/**
	 * 控制游戏中只需播放一次，播放完就移除的动画 
	 * @author Yaolx
	 * 
	 */	
	public class AnimationOnceManager extends UIComponent
	{
		private var _url:String;

		public function AnimationOnceManager(url:String)
		{
			this._url = url;
		}
		/**
		 * 添加动画到父类
		 * @p父类
		 */
		public function addToParent():void{
			FlexGlobals.topLevelApplication.addElement(this);
		}
		/**
		 * 动画在屏幕中的位置
		 */
		public function setPosition(x:int,y:int):void{
			this.x = x;
			this.y = y;
		}
		/**
		 * 加载并播放动画
		 * 出场动画阶段控制
		 */
		public function play():void{			
			var mc:MovieClip=ResourceLoadManager.instance.getMoviClipByComponent(_url);
			if (mc == null)
			{
				ResourceLoadManager.instance.addEventListener(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE, onMovieClipLoaded);
			}
			else
			{
				addChild(mc);
				mc.gotoAndPlay(1);
				mc.addEventListener(Event.ENTER_FRAME, stopMovie);
			}
		}
		/**
		 * 出场阶段动画加载完毕
		 */
		private function onMovieClipLoaded(event:ResourceLoadEvent):void
		{
			ResourceLoadManager.instance.removeEventListener(ResourceLoadEvent.RESOURCE_LOAD_COMPLETE, onMovieClipLoaded);
			if (event.resourceType == ResourceLoadEvent.MOVIECLIP)
			{
				var url:String=event.url as String;
				var mc:MovieClip=ResourceLoadManager.instance.getMoviClipByComponent(url);
				if(mc == null)return;
				addChild(mc);
				mc.gotoAndPlay(1);
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
			if (mc.currentFrame == mc.totalFrames)
			{	
				mc.stop();
				mc.removeEventListener(Event.ENTER_FRAME, stopMovie);
				
			    if(this.contains(mc)){
					this.removeChild(mc);
					mc = null;
				}
				removeFromParent();
			}
			
		}
		/**
		 * 移除动画
		 */
		public function removeFromParent():void{
			FlexGlobals.topLevelApplication.removeElement(this);
		}
	}
}
package Animation
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import resource.AssetCenter;

	/**
	 * 控制游戏中只需播放一次，播放完就移除的动画 
	 * @author Yaolx
	 * 
	 */	
	public class AnimationManager extends UIComponent
	{
		private var pack_url:String;
		private var swf_url:String;

		public function AnimationManager(p_url:String,s_url:String)
		{
			this.pack_url = p_url;
			this.swf_url = s_url;
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
			AssetCenter.getInstance().get_mc_form_pacakge(pack_url,swf_url,onCompleteMC);
		}
		private function onCompleteMC(mc:MovieClip):void{
			addChild(mc);
			mc.gotoAndPlay(1);
			mc.addEventListener(Event.ENTER_FRAME, stopMovie);
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
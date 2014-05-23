package sceneModule.rcommon
{
	import com.pblabs.engine.PBE;
	
	import flash.display.MovieClip;
	
	import sceneModule.rcommon.RMovieClipRenderer;
	
	/**
	 * 战斗中显示的非BOSS血条组件
	 * @author mutou
	 * 
	 */	
	public class RHpMcRender extends RMovieClipRenderer
	{
		
		public function RHpMcRender()
		{
			super();
		}
		
		public var targetFrame:int;
		
		override public function onFrame(elapsed:Number):void{
			if (!owner)
				return;
			
			if (!clip)
				clip = getClipInstance();
			
			if (!clip)
				return;
			
			if(_clipDirty)
			{
				_clipFrame = 0;
				_clipLastUpdate = 0;
				_maxFrames = findMaxFrames(clip, clip.totalFrames);
				_clipDirty = false;
			}
			
			
			if(targetFrame==clip.currentFrame){
				clip.stop();//血条停止
			}else if(targetFrame>clip.currentFrame){
				clip.play();//
			}
			// Update to next frame when appropriate.
			if(PBE.processManager.virtualTime - _clipLastUpdate > 1000/frameRate)
			{
				// If we're on the last frame, loop or self-destruct.
				if(++_clipFrame > _maxFrames)
				{
					if (loop) 
					{
						_clipFrame = 1;
					}
					else 
					{
						//Logger.(this, "Finished playback, destroying self.");
						if(destroyOnEnd)
							owner.destroy();
						else
							super.onFrame(elapsed);
						
						return;
					}
				}
				
				/*if(clip.totalFrames >= _clipFrame)
				clip.gotoAndStop(_clipFrame);*/
				
				// Update child clips as well.
				updateChildClips(clip, _clipFrame);
				
				_clipLastUpdate = PBE.processManager.virtualTime;
			}
			
			
			super.onFrame(elapsed);
		}
		
	}
}
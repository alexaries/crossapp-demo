package sceneModule.rcommon
{
	import com.pblabs.engine.PBE;
	
	import flash.display.MovieClip;
	
	/**
	 * 鼠标移到怪物上出现的小剑
	 * @author mutou
	 * 
	 */	
	public class RSwordMcRender extends RMovieClipRenderer
	{
		
		public function RSwordMcRender()
		{
			super();
		}
		
		override public function onFrame(elapsed:Number) : void
		{
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
			
			// Update to next frame when appropriate.
			if(PBE.processManager.virtualTime - _clipLastUpdate > 1000/frameRate)
			{
				// If we're on the last frame, loop or self-destruct.
				if(++_clipFrame > _maxFrames)
				{
					if (loop) 
					{
						_clipFrame = 10;
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

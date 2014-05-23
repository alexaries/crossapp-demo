package sceneModule.rcommon
{
	import com.pblabs.engine.PBE;
	
	import flash.display.MovieClip;
	
	/**
	 * 准备战斗组件
	 * @author mutou
	 * 
	 */	
	public class RBattleStartMcRender extends RMovieClipRenderer
	{
		/**
		 * 要显示的准备战斗MC
		 */		
		private var battleStartMc:MovieClip;
		
		public function RBattleStartMcRender()
		{
			super();
			addBattleStart();
		}
		
		/**
		 * 添加准备战斗MC
		 */		
		private function addBattleStart():void{
			battleStartMc = new BattleStart();
			clip = battleStartMc;
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
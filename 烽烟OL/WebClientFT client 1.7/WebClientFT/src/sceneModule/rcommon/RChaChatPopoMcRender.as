package sceneModule.rcommon
{
	import com.pblabs.engine.PBE;
	
	import flash.display.MovieClip;
	import flash.utils.setTimeout;
	
	/**
	 * 聊天泡泡组件
	 * @author mutou
	 * 
	 */	
	public class RChaChatPopoMcRender extends RMovieClipRenderer
	{
		/**
		 * 要设置的聊天内容
		 */		
		private var _chatStr:String;
		/**
		 * 要设置内容的聊天泡泡MC 
		 */		
		private var chaChatPopoMc:MovieClip;
		
		public function RChaChatPopoMcRender()
		{
			super();
			addChatPopo();
		}
		
		public function set chatStr(value:String):void{
			_chatStr = value;
			chaChatPopoHandler();
		}
		public function get chatStr():String{
			return _chatStr;
		}
		/**
		 * 添加聊天泡泡 
		 */		
		private function addChatPopo():void{
			chaChatPopoMc = new ChatPopo();
			clip = chaChatPopoMc;
		}
		/**
		 * 设置聊天泡泡的内容
		 */		
		private function chaChatPopoHandler():void{
			chaChatPopoMc.setChatContent(_chatStr);
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
		
		/*protected override function onAdd():void {
		clip.stop();
		}*/
		protected override function onRemove():void {
			super.onRemove();
		}
		
		
	}
}
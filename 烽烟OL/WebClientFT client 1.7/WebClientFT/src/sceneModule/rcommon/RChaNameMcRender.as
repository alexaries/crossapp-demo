package sceneModule.rcommon
{
	import com.pblabs.engine.PBE;
	
	import flash.display.MovieClip;
	
	/**
	 * 角色名字组件，角色，怪物，BOSS，都用此组件 
	 * @author mutou
	 * 
	 */	
	public class RChaNameMcRender extends RMovieClipRenderer
	{
		/**
		 * 要设置的角色名字数组，其中包含两项
		 * chaNameArr[0]：角色名称
		 * chaNameArr[1]：字体颜色 
		 * chaNameArr[2]：是否是VIP
		 */		
		private var _chaNameArr:Array;
		/**
		 * 要设置的角色军团名字数组，其中包含两项
		 * chaUnionArr[0]：角色名称
		 * chaUnionArr[1]：字体颜色 
		 */		
		private var _chaUnionArr:Array=["","0xFFFFFF"];
		
		public function RChaNameMcRender()
		{
			super();
		}
		
		public function set chaNameArr(value:Array):void{
			_chaNameArr = value;
			chaNameHandler();
		}
		public function get chaNameArr():Array{
			return _chaNameArr;
		}
		
		public function set chaUnionArr(value:Array):void{
			_chaUnionArr = value;
			chaUnionHandler();
		}
		public function get chaUnionArr():Array{
			return _chaUnionArr;
		}
		/**
		 * 处理要显示的样式
		 * 设置文字和颜色 
		 */		
		private function chaNameHandler():void{
			var chaName:String = _chaNameArr[0] as String;
			var chaNameColor:String = _chaNameArr[1] as String;
			var isVip:Boolean = _chaNameArr[2] as Boolean;
			if(!chaNameMc){
				chaNameMc = new ChaName();
			}
			if(chaName != null){
				chaNameMc.setChaName(chaName,chaNameColor,isVip);
				clip = chaNameMc;
			}
		}
		private var chaNameMc:MovieClip;
		/**
		 * 处理要显示的样式
		 * 设置文字和颜色 
		 */		
		private function chaUnionHandler():void{
			var chaUnionName:String = _chaUnionArr[0] as String;
			var chaUnionNameColor:String = _chaUnionArr[1] as String;
			if(!chaNameMc){
				chaNameMc = new ChaName();
			}
			if(chaUnionName != null){
				chaNameMc.setChaUnionName(chaUnionName,chaUnionNameColor);
			}
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
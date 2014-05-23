package wordscene.fight.ui 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import com.greensock.easing.RoughEase;
	import util.DelayExcuter;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class JumpNumberSprite extends Sprite 
	{
		private var _contain:Sprite;
		public function JumpNumberSprite() 
		{
			_contain = new Sprite();
			this.addChild(_contain);
			
			//test();
		}
		
		private function test():void {
			this.graphics.beginFill(0xFFFF00);
			this.graphics.drawRect( -10, -10, 20, 20);
		}
		
		public function show(num:String):void {
			var len:int = num.length;
			var imgs:Vector.<BitmapData> = SAssetManager.getInstance().getImgs('default', 'fightnumber');
			//var timeline:TimelineLite = new TimelineLite();
			var index:int = -1;
			for (var i:int = 0; i < len; i++) 
			{
				var curstr:String = num.charAt(i);
				if ('-' == curstr) {
					index = 11;
				}
				else if ('+' == curstr) {
					index = 10;
				}
				else {
					index = parseInt(curstr);
				}
				var bmd:BitmapData = imgs[index];
				var bm:Bitmap = new Bitmap(bmd);
				bm.x = bmd.width * i;
				_contain.addChild(bm);
				//var t:TweenLite = new TweenLite(ball, 1, { y:0, ease:RoughEase.create(3, 7, false, Back.easeOut, "in", false) } );
				//timeline.append(t);
			}
			_contain.x = -_contain.width / 2;
			_contain.y = -_contain.height - 150;
			TweenLite.to(_contain, 0.5, { y:-_contain.height, ease:RoughEase.create(3, 7, false, Back.easeOut, "in", false), onComplete:showOver } );
			//timeline.play();
		}
		
		private function showOver():void {
			new DelayExcuter(1000, clear, null);
		}
		
		public function clear():void {
			while (_contain.numChildren > 0) {
				_contain.removeChildAt(0);
			}
		}
	}

}
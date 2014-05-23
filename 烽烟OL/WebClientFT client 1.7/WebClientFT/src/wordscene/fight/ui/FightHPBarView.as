package wordscene.fight.ui 
{
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import util.Logging;
	
	import wordscene.loader.SAssetManager;
	
	/**
	 * 战斗中的角色血条
	 * @author hao
	 */
	public class FightHPBarView extends Sprite
	{
		public static const Boold_Time:Number = 0.4;
		
		
		private var _bar_x:Number = 1;
		private var _bar_y:Number = 1;
		
		//血条背景
		private var _container:Bitmap;
		//血条
		private var _bar:Bitmap;
		public function FightHPBarView() 
		{
			initView();
			initAsset();
		}
		private function initView():void {
			_container = new Bitmap();
			this.addChild(_container);
			_bar = new Bitmap();
			_bar.x = _bar_x;
			_bar.y = _bar_y;
			this.addChild(_bar);
		}
		private function initAsset():void {
			_container.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'bpbarbg');
			_bar.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'bpbar');
			//test();
		}
		
		private function test():void {
			this.graphics.beginFill(0xFFFF00);
			this.graphics.drawRect( -10, -10, 20, 20);
			this.graphics.endFill();
		}
		
		/**
		 * 设置血条显示比例
		 * @param	curValue
		 * @param	maxValue
		 */
		public function setValue(curValue:Number, maxValue:Number, isTween:Boolean = false):void {
			if (isTween) {
				if (null == _bar) {
					Logging.log("血条显示错误");
					throw new Error("血条显示错误");
				}
				TweenLite.to(_bar, Boold_Time, {scaleX:curValue / maxValue} );
			}
			else {
				_bar.scaleX = curValue / maxValue;
			}
		}
		
		public function clear():void {
			TweenLite.killTweensOf(_bar);
			_container.bitmapData = null;
			_bar.bitmapData = null;
		}
		
	}

}
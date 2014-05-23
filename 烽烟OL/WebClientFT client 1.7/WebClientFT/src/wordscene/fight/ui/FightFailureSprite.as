package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import wordscene.loader.SAssetManager;
	import wordscene.WordSceneSprite;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightFailureSprite extends Sprite 
	{
		private var _bgImg:Bitmap;
		private var _btn:FightBitmapButton;
		public function FightFailureSprite() 
		{
			_bgImg = new Bitmap();
			this.addChild(_bgImg);
		}
		
		public function refresh():void {
			if (null == _bgImg.bitmapData) {
				_bgImg.bitmapData = SAssetManager.getInstance().getBitmapData('fight', 'battleFailImg');
			}
			if (null == _btn) {
				_btn = new FightBitmapButton('fight', 'okbtn_nomal', 'okbtn_down', 'okbtn_over');
				_btn.x = (_bgImg.width - _btn.width) / 2;
				_btn.y = _bgImg.height - _btn.height - 13;
				_btn.addEventListener(MouseEvent.CLICK, onClick);
				this.addChild(_btn);
			}
		}
		
		private function onClick(e:MouseEvent):void {
			this.parent.removeChild(this);
			WordSceneSprite.getInstance().fightSceneSp.showResOver();
		}
		
	}

}
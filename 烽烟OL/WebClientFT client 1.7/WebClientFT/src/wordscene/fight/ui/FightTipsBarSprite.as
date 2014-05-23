package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import util.DisplayUtils;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightTipsBarSprite extends Sprite 
	{
		public static const TYPE_HP:int = 1;
		public static const TYPE_POWER:int = 2;
		
		private var _bgimg:Bitmap;
		private var _barimg:Bitmap;
		private var _mask:Sprite;
		private var _txtImg:Bitmap;
		
		private var _txt:TextField;
		
		private var _type:int;
		public function FightTipsBarSprite(type:int) 
		{
			_type = type;
			
			_bgimg = new Bitmap();
			this.addChild(_bgimg);
			
			_barimg = new Bitmap();
			_barimg.x = 1;
			_barimg.y = 1;
			this.addChild(_barimg);
			
			_mask = new Sprite();
			_mask.x = _barimg.x;
			_mask.y = _barimg.y;
			this.addChild(_mask);
			
			_barimg.mask = _mask;
			
			_txtImg = new Bitmap();
			this.addChild(_txtImg);
			
			_txt = DisplayUtils.createLabel(12, 0xFFFFFF);
		}
		
		public function setPorgress(cur:int, max:int):void {
			if (null == _bgimg.bitmapData) {
				_bgimg.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'bar_bg');
				if (TYPE_HP == _type) {
					_bgimg.visible = false;
					//_barimg.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'hp');
				}
				else {
					_barimg.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'jingli');
				}
				_mask.graphics.beginFill(0xFFFF00);
				_mask.graphics.drawRect(0, 0, _bgimg.width, _bgimg.height);
				_mask.graphics.endFill();
			}
			if (_txt.text != cur + "/" + max) {
				if (_txtImg.bitmapData) {
					_txtImg.bitmapData.dispose();
				}
				_txt.text = cur + "/" + max;
				_txtImg.bitmapData = DisplayUtils.createBitmapTxt(_txt);
				_txtImg.x = _bgimg.x + (_bgimg.width - _txtImg.width) / 2;
				_txtImg.y = (_bgimg.height - _txtImg.height) / 2;
			}
			_mask.scaleX = 1.0 * cur / max;
		}
		
	}

}
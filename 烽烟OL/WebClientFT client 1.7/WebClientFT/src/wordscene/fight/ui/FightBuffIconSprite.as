package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import proto.battle.battle703.BuffInfo;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightBuffIconSprite extends Sprite 
	{
		private var _vo:BuffInfo;
		private var _bg:Bitmap;
		public function FightBuffIconSprite() 
		{
			_bg = new Bitmap();
			this.addChild(_bg);
		}
		
		public function refresh(vo:BuffInfo):void {
			_vo = vo;
			_bg.bitmapData = SAssetManager.getInstance().getBitmapData('bufficon', _vo.buffIconId + '');
			if (null == _bg.bitmapData) {
				var bmd:BitmapData = new BitmapData(22, 22);
				_bg.bitmapData = bmd;
			}
		}
		
		public function get vo():BuffInfo 
		{
			return _vo;
		}
		
	}

}
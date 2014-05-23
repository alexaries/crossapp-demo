package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import proto.battle.battle703.BuffInfo;
	import util.DisplayUtils;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightBuffTipsSprite extends Sprite 
	{
		private var _v:FightBuffIconSprite;
		
		private var _bgImg:Bitmap;
		private var _nameImg:Bitmap;
		private var _iconImg:Bitmap;
		private var _desImg:Bitmap;
		
		private var _nameTxt:TextField;
		private var _desTxt:TextField;
		
		public function FightBuffTipsSprite() 
		{
			_nameTxt = DisplayUtils.createLabel(16, 0xFFFF00, true);
			_desTxt = DisplayUtils.createLabel(12, 0xFFFFFF, true);
			
			_bgImg = new Bitmap();
			this.addChild(_bgImg);
			
			_nameImg = new Bitmap();
			this.addChild(_nameImg);
			
			_iconImg = new Bitmap();
			this.addChild(_iconImg);
			
			_desImg = new Bitmap();
			this.addChild(_desImg);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			//test();
		}
		
		private function test():void {
			this.graphics.lineStyle(1, 0x796040);
			this.graphics.beginFill(0x111111, 0.9);
			this.graphics.drawRoundRect(0, 0, 170, 100, 5);
			this.graphics.endFill();
		}
		
		public function refresh(v:FightBuffIconSprite):void {
			if (null == _bgImg.bitmapData) {
				_bgImg.bitmapData = SAssetManager.getInstance().getBitmapData('fight', 'tips');
			}
			
			var d:BuffInfo = v.vo;
			if (d.buffName != _nameTxt.text) {
				if (null != _nameImg.bitmapData) {
					_nameImg.bitmapData.dispose();
				}
				_nameTxt.text = d.buffName;
				_nameImg.bitmapData = DisplayUtils.createBitmapTxt(_nameTxt);
				_iconImg.x = _nameImg.x + _nameImg.width + 50;
			}
			_iconImg.bitmapData = SAssetManager.getInstance().getBitmapData('bufficon', d.buffIconId + '');
			if (null == d.bufDes) {
				d.bufDes = "buf描述";
			}
			DisplayUtils.refreshImgText(d.bufDes, _desImg, _desTxt);
			_desImg.y = _nameImg.y + _nameImg.height;
			_v = v;
		}
		
		public function get v():FightBuffIconSprite 
		{
			return _v;
		}
		
	}

}
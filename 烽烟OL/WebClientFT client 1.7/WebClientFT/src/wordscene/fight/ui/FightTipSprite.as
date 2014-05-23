package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import util.DisplayUtils;
	import wordscene.entity.FightEntitySprite;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightTipSprite extends Sprite 
	{
		private var _nameTxt:TextField;
		private var _levelTxt:TextField;
		private var _hplabelTxt:TextField;
		private var _powerlabelTxt:TextField;
		
		private var _bgImg:Bitmap;
		private var _nameImg:Bitmap;
		private var _levelImg:Bitmap;
		private var _hplabelImg:Bitmap;
		private var _powerlabelImg:Bitmap;
		private var _hpbar:FightTipsBarSprite;
		private var _powerbar:FightTipsBarSprite;
		
		private var _id:int;
		
		public function FightTipSprite() 
		{
			_nameTxt = DisplayUtils.createLabel(14, 0x29ae15, true);
			_nameTxt.filters = [DisplayUtils.TextBorderFilte];
			_levelTxt = DisplayUtils.createLabel(14, 0xFFFFFF, true);
			_levelTxt.filters = [DisplayUtils.TextBorderFilte];
			_hplabelTxt = DisplayUtils.createLabel(14, 0xFFFFFF);
			_hplabelTxt.filters = [DisplayUtils.TextBorderFilte];
			_hplabelTxt.text = "兵力:";
			_powerlabelTxt = DisplayUtils.createLabel(14, 0xFFFFFF);
			_powerlabelTxt.filters = [DisplayUtils.TextBorderFilte];
			_powerlabelTxt.text = "聚气:";
			
			_bgImg = new Bitmap();
			this.addChild(_bgImg);
			
			_nameImg = new Bitmap();
			_nameImg.x = 12;
			_nameImg.y = 16;
			this.addChild(_nameImg);
			
			_levelImg = new Bitmap();
			_levelImg.x = 115;
			_levelImg.y = _nameImg.y;
			this.addChild(_levelImg);
			
			_hplabelImg = new Bitmap();
			_hplabelImg.bitmapData = DisplayUtils.createBitmapTxt(_hplabelTxt);
			_hplabelImg.x = _nameImg.x;
			_hplabelImg.y = 42;
			this.addChild(_hplabelImg);
			
			_hpbar = new FightTipsBarSprite(FightTipsBarSprite.TYPE_HP);
			_hpbar.x = 56;
			_hpbar.y = _hplabelImg.y + 5;
			this.addChild(_hpbar);
			
			_powerlabelImg = new Bitmap();
			_powerlabelImg.bitmapData = DisplayUtils.createBitmapTxt(_powerlabelTxt);
			_powerlabelImg.x = _nameImg.x;
			_powerlabelImg.y = 64;
			this.addChild(_powerlabelImg);
			
			_powerbar = new FightTipsBarSprite(FightTipsBarSprite.TYPE_POWER);
			_powerbar.x = _hpbar.x;
			_powerbar.y = _powerlabelImg.y + 5;
			this.addChild(_powerbar);
			
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
		
		public function refresh(v:FightEntitySprite):void {
			_id = v.vo.chaBattleId;
			
			if (null == _bgImg.bitmapData) {
				_bgImg.bitmapData = SAssetManager.getInstance().getBitmapData('fight', 'tips');
			}
			
			
			if (_nameTxt.text != v.vo.chaName) {
				if (_nameImg.bitmapData) {
					_nameImg.bitmapData.dispose();
				}
				_nameTxt.text = v.vo.chaName;
				_nameImg.bitmapData = DisplayUtils.createBitmapTxt(_nameTxt);
			}
			if (_levelTxt.text != v.vo.chaLevel + "级") {
				if (_levelImg.bitmapData) {
					_levelImg.bitmapData.dispose();
				}
				_levelTxt.text = v.vo.chaLevel + "级";
				_levelImg.bitmapData = DisplayUtils.createBitmapTxt(_levelTxt);
			}
			_hpbar.setPorgress(v.curhp, v.vo.chaTotalHp);
			_powerbar.setPorgress(v.curpower, v.maxpower);
		}
		
		public function get id():int 
		{
			return _id;
		}
	}

}
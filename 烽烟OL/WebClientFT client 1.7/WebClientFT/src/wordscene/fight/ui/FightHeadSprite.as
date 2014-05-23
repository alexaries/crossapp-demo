package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import proto.battle.battle703.BuffInfo;
	import proto.battle.battle703.InitBattleData;
	import util.DisplayUtils;
	import util.HashMap;
	import wordscene.loader.SAssetManager;
	import wordscene.WordSceneSprite;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightHeadSprite extends Sprite 
	{
		private var _faceimg:Bitmap;
		private var _nameImg:Bitmap;
		private var _levelImg:Bitmap;
		private var _bufcontain:Sprite;
		
		private var _nameTxt:TextField;
		private var _levelTxt:TextField;
		
		public function FightHeadSprite() 
		{
			_faceimg = new Bitmap();
			this.addChild(_faceimg);
			_nameImg = new Bitmap();
			this.addChild(_nameImg);
			_levelImg = new Bitmap();
			_levelImg.x = 9;
			_levelImg.y = -6;
			this.addChild(_levelImg);
			_bufcontain = new Sprite();
			this.addChild(_bufcontain);
			
			_bufcontain.graphics.beginFill(0xFFFF00, 0);
			_bufcontain.graphics.drawRect(0, 0, 20, 20);
			_bufcontain.graphics.endFill();
			
			_nameTxt = DisplayUtils.createLabel(14, 0x02b3ff);
			_nameTxt.filters = [DisplayUtils.TextBorderFilte];
			_levelTxt = DisplayUtils.createLabel(14, 0xFFFFFF);
			_levelTxt.filters = [DisplayUtils.TextBorderFilte];
		}
		
		public function refresh(d:InitBattleData):void {
			var chaIcon:int = d.chaIcon;
			//chaIcon = Math.random() * 2 + 1
			_faceimg.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'face' + chaIcon);
			if (_nameTxt.text != d.chaName) {
				if (_nameImg.bitmapData) {
					_nameImg.bitmapData.dispose();
				}
				var tf:TextFormat = _nameTxt.defaultTextFormat;
				if (1 == d.chaDirection) {
					//向右
					tf.color = WordSceneSprite.HEARO_SELF_COLOR;
				}
				else {
					tf.color = WordSceneSprite.FIGHT_MONSTER_NAME;
				}
				_nameTxt.defaultTextFormat = tf;
				_nameTxt.text = d.chaName;
				_nameImg.bitmapData = DisplayUtils.createBitmapTxt(_nameTxt);
				_nameImg.y = 66;
				_nameImg.x = (66 - _nameImg.width) / 2;
			}
			if (_levelTxt.text != d.chaLevel + "") {
				if (_levelImg.bitmapData) {
					_levelImg.bitmapData.dispose();
				}
				_levelTxt.text = d.chaLevel + "";
				_levelImg.bitmapData = DisplayUtils.createBitmapTxt(_levelTxt);
			}
			_bufcontain.y = _nameImg.y + _nameImg.height;
		}
		
		public function refreshBuf(arr:Array):void {
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++) 
			{
				var d:BuffInfo = arr[i] as BuffInfo;
				var v:FightBuffIconSprite;
				if (i >= _bufcontain.numChildren) {
					v = new FightBuffIconSprite();
					_bufcontain.addChild(v);
				}
				else {
					v = _bufcontain.getChildAt(i) as FightBuffIconSprite;
				}
				v.refresh(d);
				v.x = v.width * i;
				v.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
				v.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
				
			}
			while (_bufcontain.numChildren > len) {
				var rv:FightBuffIconSprite = _bufcontain.removeChildAt(_bufcontain.numChildren - 1) as FightBuffIconSprite;
				WordSceneSprite.getInstance().fightSceneSp.uisprite.hideBufTips(rv);
				rv.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
				rv.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			}
		}
		
		public function clear():void {
			while (_bufcontain.numChildren > 0) {
				var rv:FightBuffIconSprite = _bufcontain.removeChildAt(_bufcontain.numChildren - 1) as FightBuffIconSprite;
				WordSceneSprite.getInstance().fightSceneSp.uisprite.hideBufTips(rv);
				rv.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
				rv.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			}
		}
		
		private function mouseOver(e:MouseEvent):void {
			var v:FightBuffIconSprite = e.currentTarget as FightBuffIconSprite;
			WordSceneSprite.getInstance().fightSceneSp.uisprite.showBufTips(v);
		}
		
		private function mouseOut(e:MouseEvent):void {
			var v:FightBuffIconSprite = e.currentTarget as FightBuffIconSprite;
			WordSceneSprite.getInstance().fightSceneSp.uisprite.hideBufTips(v);
		}
		
	}

}
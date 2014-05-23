package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import model.ProConst;
	import proto.battle.battle703.SettlementData;
	import resource.CrotaItemConfig;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.copyScene.view.SpBitmapButton;
	import util.DelayExcuter;
	import util.DisplayUtils;
	import wordscene.loader.SAssetManager;
	import wordscene.WordSceneSprite;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightWinSprite extends Sprite 
	{
		private var _bgImg:Bitmap;
		private var _headImg:Bitmap;
		private var _nameImg:Bitmap;
		private var _priceImg:Bitmap;
		private var _itemSp:Sprite;
		private var _itemImg:Bitmap;
		private var _btn:FightBitmapButton;
		
		private var _nameTxt:TextField;
		private var _priceTxt:TextField;
		
		private var _curItem:PackageItem;
		
		public function FightWinSprite() 
		{
			_bgImg = new Bitmap();
			this.addChild(_bgImg);
			
			_headImg = new Bitmap();
			_headImg.x = 35;
			_headImg.y = 70;
			this.addChild(_headImg);
			
			_nameImg = new Bitmap();
			_nameImg.x = 110;
			_nameImg.y = 80;
			this.addChild(_nameImg);
			
			_priceImg = new Bitmap();
			_priceImg.x = _nameImg.x;
			_priceImg.y = 105;
			this.addChild(_priceImg);
			
			_itemSp = new Sprite();
			_itemSp.x = 270;
			_itemSp.y = _headImg.y + 11;
			_itemImg = new Bitmap();
			_itemSp.addChild(_itemImg);
			this.addChild(_itemSp);
			_itemSp.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			_itemSp.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			
			_nameTxt = DisplayUtils.createLabel(14, 0xFFFFFF);
			_nameTxt.filters = [DisplayUtils.TextBorderFilte];
			_priceTxt = DisplayUtils.createLabel(14, 0xFFFFFF);
			_priceTxt.filters = [DisplayUtils.TextBorderFilte];
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			_itemSp.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			WordSceneSprite.getInstance().itemtips.visible = false;
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			WordSceneSprite.getInstance().itemtips.curDataInfo = _curItem;
			WordSceneSprite.getInstance().itemtips.visible = true;
			onMove();
			_itemSp.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		
		private function onMove(e:MouseEvent = null):void {
			WordSceneSprite.getInstance().itemtips.x = this.stage.mouseX;
			WordSceneSprite.getInstance().itemtips.y = this.stage.mouseY;
		}
		
		public function refresh(info:SettlementData):void {
			if (null == _bgImg.bitmapData) {
				_bgImg.bitmapData = SAssetManager.getInstance().getBitmapData('fight', 'battleBettlementBg');
			}
			if (null == _btn) {
				_btn = new FightBitmapButton('fight', 'okbtn_nomal', 'okbtn_down', 'okbtn_over');
				_btn.x = 240;
				_btn.y = 160;
				_btn.addEventListener(MouseEvent.CLICK, onClick);
				this.addChild(_btn);
			}
			_headImg.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'face1');
			
			if (null != info.itemsBonus) {
				var item:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(info.itemsBonus.itemId);
				_curItem = item;
				DisplayUtils.refreshImgText(item.name + " x" + info.itemsBonus.stack, _priceImg, _priceTxt);
			
				var url:String = ProConst.getImageResUrl(item.type) + item.icon + ".png";
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(
					Event.COMPLETE,
					function(e:Event):void {
						_itemImg.bitmapData = (loader.content as Bitmap).bitmapData;
					}
				);
				loader.load(new URLRequest(url));
			}
			
			
			DisplayUtils.refreshImgText(info.name, _nameImg, _nameTxt);
			
		}
		
		private function onClick(e:MouseEvent):void {
			this.parent.removeChild(this);
			WordSceneSprite.getInstance().fightSceneSp.showResOver();
		}
	}

}
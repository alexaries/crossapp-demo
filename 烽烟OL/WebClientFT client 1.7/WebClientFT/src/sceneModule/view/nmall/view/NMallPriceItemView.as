package sceneModule.view.nmall.view 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import managers.ToolTipManager;
	
	import mx.events.FlexEvent;
	
	import proto.shop.shop208.ItemIifo;
	import proto.shop.shop208.MallItemType;
	
	import resource.AssetCenter;
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.copyScene.view.BitmapButton;
	import sceneModule.view.copyScene.view.SpBitmapButton;
	import sceneModule.view.nmall.model.MallInfoVo;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	
	import util.CommonTools;
	import util.xtrace;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NMallPriceItemView extends Sprite 
	{
		private var _bg_bitmap:Bitmap;
		private var _icon:Loader;
		private var _count:TextField;
		private var _mark:Bitmap;
		private var _name:TextField;
		private var pre_price:TextField;
		private var now_price:TextField;
		private var _zuan_icon:Bitmap;
		private var _zuan_icon2:Bitmap;
		private var _money:TextField;
		private var _nowMoney:TextField;
		private var _buy_btn:SpBitmapButton;
		
		
		private var _is_selected:Boolean;
		private var _is_over:Boolean;
		
		private var _item:MallInfoVo = new MallInfoVo();
		
		private var _tips:MainMenuEquipmentTooltip;
		
		public function NMallPriceItemView() 
		{
			_is_over = false;
			init_view();
			init_event();
		}
		
		private function init_view():void {
			_bg_bitmap = new Bitmap();
			this.addChild(_bg_bitmap);
			
			_bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'zp_bg');
			
			_icon = new Loader();
			_icon.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, on_error);
			_icon.x = 10;
			_icon.y = 15;
			this.addChild(_icon);
			
			_count = CommonTools.createFTF();
			this.addChild(_count);
			
			_mark = new Bitmap();
			_mark.x = 10;
			_mark.y = 15;
			this.addChild(_mark);
			
			_name = CommonTools.createBlackTF();
			_name.x = 55;
			_name.y = 6;
			this.addChild(_name);
			
			pre_price = CommonTools.createBlackTF();
			pre_price.x = 55;
			pre_price.y = 26;
			this.addChild(pre_price);
			
			now_price = CommonTools.createBlackTF();
			now_price.x = 55;
			now_price.y = 46;
			this.addChild(now_price);
			
			_zuan_icon = new Bitmap();
			_zuan_icon.x = 85;
			_zuan_icon.y = 26;
			this.addChild(_zuan_icon);
			
			_zuan_icon2 = new Bitmap();
			_zuan_icon2.x = 85;
			_zuan_icon2.y = 46;
			this.addChild(_zuan_icon2);
			
			_money = CommonTools.createHuangseTF();
			_money.x = 110;
			_money.y = 26;
			this.addChild(_money);
			
			_nowMoney = CommonTools.createBlackTF();
			_nowMoney.x = 110;
			_nowMoney.y = 46;
			this.addChild(_nowMoney);
			
			_buy_btn = new SpBitmapButton('ui_mall', 'btn_common_up', 'btn_common_over', 'btn_common_down', 'btn_next_disable', CrotaResourceConfig.getInstance().getTextByModuleAndId('nmall','nmIV_gm'));
			_buy_btn.x = 138;
			_buy_btn.y = 23;
			this.addChild(_buy_btn);
		}
		
		private function on_error(e:Event):void 
		{
			xtrace("no icon " + e.toString());
		}
		
		private function init_event():void {
			_icon.addEventListener(MouseEvent.ROLL_OVER, mouse_over);
			_icon.addEventListener(MouseEvent.ROLL_OUT, mouse_out);
			_icon.addEventListener(MouseEvent.MOUSE_MOVE, mouse_move);
			this.addEventListener(Event.REMOVED_FROM_STAGE, mouse_out);
			_buy_btn.addEventListener(MouseEvent.CLICK, buy);
		}
		
		private function mouse_out(e:Event):void 
		{
			if (null != _tips) {
				if (MallMessage.getInstance().popUpWindowLayer.contains(_tips)) {
					MallMessage.getInstance().popUpWindowLayer.removeElement(_tips);
				}
				_tips = null;
			}
		}
		
		private function mouse_over(e:MouseEvent):void 
		{
			if (null == _tips )
				_tips = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
			var packgeItem:PackageItem = _item.itemInfo;
			_tips.curDataInfo = packgeItem;
			//设置ToolTip位置
			var base_x:int = MallMessage.getInstance().popUpWindowLayer.mouseX;
			var base_y:int = MallMessage.getInstance().popUpWindowLayer.mouseY;
			_tips.x = base_x;
			_tips.y = base_y - _tips.height;
			_tips.addEventListener(
				FlexEvent.CREATION_COMPLETE,
				function (e:Event):void {
					if (null != _tips) {
						_tips.y = base_y;
					}
				}
			);
			MallMessage.getInstance().popUpWindowLayer.addElement(_tips);
		}
		
		private function mouse_move(e:MouseEvent):void {
			if (_tips) {
				var base_x:int = MallMessage.getInstance().popUpWindowLayer.mouseX;
				var base_y:int = MallMessage.getInstance().popUpWindowLayer.mouseY;
				_tips.x = base_x;
				_tips.y = base_y;
			}
		}
		
		private function buy(e:MouseEvent):void {
			MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('sg','asgCC_sfxh') + _item.price + CrotaResourceConfig.getInstance().getTextByModuleAndId('nmall','nmIV_zgm') + _item.itemInfo.name + "？", null, null, null, null, MallMessage.getInstance().request_buy, null, [_item.itemID]);
		}
		
		
		
		private function refresh_bg():void {
			if (_is_over) {
				_bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'item_bg_up');
			}
			else {
				_bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'item_bg_over');
			}
		}
		
		
		public function refresh_d(item:ItemIifo):void {
			_item.itemInfo = CrotaItemConfig.getItemInfoByTempleteId(item.templateId);
			_item.count = item.count;
			_item.itemID = item.itemID;
			_item.price = item.price;
			_item.type = item.type;
			
			_icon.unloadAndStop();
			var url:String = CommonTools.setEquipmentUrl(_item.itemInfo.icon, _item.itemInfo.type)
			_icon.load(new URLRequest(url));
			
			switch(item.type) {
				case MallItemType.NOMAL:
					_mark.bitmapData = null;
					break;
				case MallItemType.NEW:
					_mark.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'ico_hot');
					break;
				case MallItemType.HOT:
					_mark.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'ico_hot');
					break;
				case MallItemType.SALL:
					_mark.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'ico_hot');
					break;
			}
			
			_count.text = item.count.toString();
			_count.x = _icon.x + 42 - _count.width;
			_count.y = _icon.y + 42 - _count.height;
			
			_name.text = _item.itemInfo.name;
			now_price.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('text_mail','tm_xj');
			pre_price.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('text_mail','tm_yj');
			
			_zuan_icon.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('common_res', 'cry_img');
			_zuan_icon2.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('common_res', 'cry_img');
			
			_money.text = item.price.toString();
			_nowMoney.text = item.priceNow.toString();
		}
	}
}
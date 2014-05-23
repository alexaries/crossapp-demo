package sceneModule.view.nmall.mediater
{
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import mx.core.UIComponent;
	import mx.events.ItemClickEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.shop.shop208.ItemIifo;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.copyScene.view.BitmapButton;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.nmall.view.NMallItemView;
	import sceneModule.view.nmall.view.NMallPriceItemView;
	import sceneModule.view.nmall.view.NMallView;
	import sceneModule.view.nmall.view.PageButtonView;
	
	import util.CommonTools;
	
	//商城视图管理器
	public class NMallMediator extends Mediator
	{
		public static const SIZE:int = 3;
		
		private var _base_item_x:int = 86;
		private var _base_item_y:int = 84;
		
		private var _bg_bitmap:Bitmap;
		private var _money_tf:TextField;
		private var _putmoney_btn:BitmapButton;
		
		private var _pre_btn:BitmapButton;
		private var _next_btn:BitmapButton;
		private var _close_btn:BitmapButton;
		private var _page_num_tf:TextField;
		
		private var _v_items:Array;
		private var _s_items:Array;
		
		public function NMallMediator()
		{
			super();
		}
		
		override public function onRegister():void {
			_v_items = [];
			_s_items = [];
			
			_bg_bitmap = new Bitmap();
			bg.addChild(_bg_bitmap);
			
			_money_tf = CommonTools.createMoneyTF();
			_money_tf.x = 522;
			_money_tf.y = 371;
			_money_tf.text = "123";
			contain.addChild(_money_tf);
			
			_putmoney_btn = new BitmapButton('ui_mall', 'btn_put_money_up', 'btn_put_money_down', 'btn_put_money_over', 'btn_put_money_disable');
			_putmoney_btn.x = 592;
			_putmoney_btn.y = 364;
			contain.addChild(_putmoney_btn);
			
			
			_pre_btn = new BitmapButton('ui_mall', 'btn_pre_nomal', 'btn_pre_nomal', 'btn_pre_nomal', 'btn_pre_disable');
			
			_pre_btn.x = 386;
			_pre_btn.y = 343;
			
			_page_num_tf = CommonTools.createFTF();
			_page_num_tf.y = _pre_btn.y;
			_page_num_tf.text = "1/1";
			_next_btn = new BitmapButton('ui_mall', 'btn_next_nomal', 'btn_next_nomal', 'btn_next_nomal', 'btn_next_disable');
			_next_btn.x = _pre_btn.x + 55;
			_next_btn.y = _pre_btn.y;
			_page_num_tf.x = _pre_btn.x + (_next_btn.x - _pre_btn.x + _next_btn.get_bg_w() - _page_num_tf.width) / 2;
			_pre_btn.set_disable(true);
			_next_btn.set_disable(true);
			contain.addChild(_page_num_tf);
			contain.addChild(_pre_btn);
			contain.addChild(_next_btn);
			
			_bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_mall', 'mall_bg');
			
			
			_close_btn = new BitmapButton('ui_mall', 'btn_close_up', 'btn_close_over', 'btn_close_down');
			_close_btn.x = 912;
			_close_btn.y = 21;
			contain.addChild(_close_btn);
			
			MallMessage.getInstance().request_items(1,1);
			refresh_money();
			
			MallMessage.getInstance().addEventListener(MallMessage.MallMessage_REFRESH_ITEMS, refresh_item);
			MallMessage.getInstance().addEventListener(MallMessage.MallMessage_REFRESH_MONEY, refresh_money);
			_pre_btn.addEventListener(MouseEvent.CLICK, pre_page);
			_next_btn.addEventListener(MouseEvent.CLICK, next_page);
			(this.viewComponent as NMallView).cardtype.addEventListener(ItemClickEvent.ITEM_CLICK,onCardTypeChange);
			_close_btn.addEventListener(MouseEvent.CLICK, on_close);
			_putmoney_btn.addEventListener(MouseEvent.CLICK,onPutMoney);
		}
		
		private function onCardTypeChange(evt:ItemClickEvent):void{
			switch((this.viewComponent as NMallView).cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('text_mail','tm_hot'):
					MallMessage.getInstance().request_items(1,1);
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('text_mail','tm_sy'):
					MallMessage.getInstance().request_items(1,2);
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('text_mail','tm_qh'):
					MallMessage.getInstance().request_items(1,3);
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('text_mail','tm_cw'):
					MallMessage.getInstance().request_items(1,4);
					break;
			}
		}
		
		private function onPutMoney(evt:MouseEvent):void{
			CommonTools.onOpenNavigate();
		}
		
		private function pre_page(e:MouseEvent):void {
			if (_pre_btn.is_disable) {
				return;
			}
			if (MallMessage.getInstance().cur_page > 1) {
				MallMessage.getInstance().request_items(MallMessage.getInstance().cur_page - 1,MallMessage.getInstance().categories);
			}
		}
		
		private function next_page(e:MouseEvent):void {
			if (_next_btn.is_disable) {
				return;
			}
			if (MallMessage.getInstance().cur_page < MallMessage.getInstance().max_page) {
				MallMessage.getInstance().request_items(MallMessage.getInstance().cur_page + 1,MallMessage.getInstance().categories);
			}
		}
		
		private function on_close(e:MouseEvent):void {
			WindowManager.closeWindow(NMallView.NAME);
		}
		
		private function remove_from_stage(e:Event):void {
			
		}
		
		override public function preRemove():void {
		}
		
		private function refresh_money(e:Event = null):void {
			_money_tf.text = SystemDataModel.roleInfo.gold.toString();
		}
		
		private function refresh_page():void {
			_page_num_tf.text = MallMessage.getInstance().cur_page + "/" + MallMessage.getInstance().max_page;
			_page_num_tf.x = _pre_btn.x + (_next_btn.x - _pre_btn.x + _next_btn.get_bg_w() - _page_num_tf.width) / 2;
			
			var curpage:int = MallMessage.getInstance().cur_page
			if (curpage <= 1) {
				_pre_btn.set_disable(true);
			}
			else {
				_pre_btn.set_disable(false);
			}
			if (curpage >= MallMessage.getInstance().max_page) {
				_next_btn.set_disable(true);
			}
			else {
				_next_btn.set_disable(false);
			}
		}
		
		private function refresh_item(e:Event):void {
			var d_items:Array = MallMessage.getInstance().shop_items;
			var d_len:int = d_items.length;
			var v_len:int = _v_items.length;
			var i:int = 0;
			var d:ItemIifo = null;
			for (; i < d_len; i++) 
			{
				d = d_items[i] as ItemIifo;
				var v_item:NMallItemView = null;
				if (i >= v_len) {
					//创建新的item
					v_item = new NMallItemView();
					v_item.x = _base_item_x + (i % SIZE) * (v_item.width + 4);
					v_item.y = _base_item_y + int(i / SIZE) * (v_item.height + 6);
					contain.addChild(v_item);
					_v_items.push(v_item);
				}
				else {
					//刷新
					v_item = _v_items[i] as NMallItemView;
				}
				v_item.refresh_d(d);
			}
			var s_items:Array = MallMessage.getInstance().price_items;
			var s_len:int = s_items.length;
			var p_len:int = _s_items.length;
			var p:ItemIifo = null;
			for(var ii:int=0;ii<s_len;ii++){
				p = s_items[ii] as ItemIifo;
				var p_item:NMallPriceItemView = null;
				if(ii >= p_len){
					//创建
					p_item = new NMallPriceItemView();
					p_item.x = 713;
					p_item.y = 120 + ii*96;
					contain.addChild(p_item);
					_s_items.push(p_item);
				}else{
					//刷新
					p_item = _s_items[ii] as NMallPriceItemView;
				}
				p_item.refresh_d(p);
			}
			remove_item(i,s_len);
			refresh_page();
		}
		
		private function remove_item(i:int,l:int):void {
			while (_v_items.length > i) {
				var v:NMallItemView = _v_items.pop();
				v.parent && v.parent.removeChild(v);
			}
			while(_s_items.length > l){
				var p:NMallPriceItemView = _s_items.pop();
				p.parent && p.parent.removeChild(p);
			}
		}
		
		public function get view():NMallView {
			return viewComponent as NMallView;
		}
		public function get bg():UIComponent {
			return view.bg;
		}
		public function get contain():UIComponent {
			return view.contain;
		}
		
		
	}
}
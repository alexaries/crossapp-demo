package sceneModule.view.shop.mediator
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Image;
	import mx.core.BitmapAsset;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.events.ItemClickEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	import mx.styles.StyleManager;
	
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.mvcs.Mediator;
	
	import proto.scene.scene204.getItemsInPackageRequest;
	import proto.shop.shop206.getNpcShopInfoRequest;
	import proto.shop.shop206.getNpcShopInfoResponse;
	import proto.shop.shop219.npcShopBuyItemRequest;
	import proto.shop.shop219.npcShopBuyItemResponse;
	import proto.shop.shop220.npcShopSellItemRequest;
	import proto.shop.shop220.npcShopSellItemResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.view.pack.view.MainMenuEquipmentComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.GetBuyMoneyEffectEvent;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	import sceneModule.view.shop.event.NShopEvent;
	import sceneModule.view.shop.event.NpcPackDoubleClickEvent;
	import sceneModule.view.shop.view.NpcShopItemComponent;
	import sceneModule.view.shop.view.NpcShopSellItemComponent;
	
	import service.ISocketServer;
	
	import util.ObjectToString;
	import util.xtrace;

	public class NpcShopItemComponentMediator extends Mediator
	{
		[Inject]
		public var comp:NpcShopItemComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		
		
		public function NpcShopItemComponentMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			
			comp.cardtype.addEventListener(ItemClickEvent.ITEM_CLICK,onItemClick);
			comp.addEventListener(NShopEvent.NShopEvent_ITEM_DOUBLE_CLICK, on_dooclick);
			comp.addEventListener(NShopEvent.NShopEvent_ITEM_DROP, on_drog);
			comp.shopList.addEventListener(DragEvent.DRAG_ENTER, on_drag_enter);
			comp.shopList.addEventListener(DragEvent.DRAG_DROP,onDragDrop);
			this.eventDispatcher.addEventListener(NpcPackDoubleClickEvent.NPCPACKDOUBLECLICKEVENT,onPackDoubleClick);
			
			init_view();
			
			this.eventMap.mapListener(comp.preBtn,MouseEvent.CLICK,onPrePageShop);
			this.eventMap.mapListener(comp.nextBtn,MouseEvent.CLICK,onNextPageShop);
		}
		
		private function onPrePageShop(evt:MouseEvent):void{
			SceneModuleCommonMessage.getInstance().getNpcShopInfo(SystemDataModel.shopInfoVo.itemType,SystemDataModel.shopInfoVo.curPage - 1);
		}
		private function onNextPageShop(evt:MouseEvent):void{
			SceneModuleCommonMessage.getInstance().getNpcShopInfo(SystemDataModel.shopInfoVo.itemType,SystemDataModel.shopInfoVo.curPage + 1);
		}
		
		private function onPackDoubleClick(evt:NpcPackDoubleClickEvent):void{
			comp.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_hg');
			getNpcShopInfo();
		}
		
		override public function preRemove():void {
			comp.cardtype.removeEventListener(ItemClickEvent.ITEM_CLICK,onItemClick);
			comp.removeEventListener(NShopEvent.NShopEvent_ITEM_DOUBLE_CLICK, on_dooclick);
			comp.removeEventListener(NShopEvent.NShopEvent_ITEM_DROP, on_drog);
			comp.shopList.removeEventListener(DragEvent.DRAG_ENTER, on_drag_enter);
			comp.shopList.removeEventListener(DragEvent.DRAG_DROP,onDragDrop);
			this.eventDispatcher.removeEventListener(NpcPackDoubleClickEvent.NPCPACKDOUBLECLICKEVENT,onPackDoubleClick);
		}
		
		
		private function init_view():void {
			comp.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_gm');
			getNpcShopInfo();
		}
		
		
		private function on_drog(e:NShopEvent):void {
			var format:String;
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_gm'):
					format = "goumai";
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_hg'):
					format = "huigou"
					break;
			}
			if (null != format) {
				// { view:this,img_view:imgItemIcon,mouse_event:e }
				var ds:DragSource = new DragSource();
				ds.addData(e.obj.view, format);
				var img:Image = e.obj.img_view;
				var bd:BitmapData = new BitmapData(img.width, img.height);
				bd.draw(img);
				var asset:BitmapAsset = new BitmapAsset(bd);
				DragManager.doDrag(e.obj.img_view,ds,e.obj.mouse_event,asset,- e.obj.mouse_event.localX + 30,- e.obj.mouse_event.localY + 30);
				
				//去除拖拽的x号按钮
				var mgr:IStyleManager2  = FlexGlobals.topLevelApplication.styleManager;
				var selector:String = "mx.managers.DragManager";
				var decl:CSSStyleDeclaration = mgr.getStyleDeclaration(selector);
				if (!decl)
					decl = new CSSStyleDeclaration(selector);
				decl.setStyle("rejectCursor", Sprite);
				mgr.setStyleDeclaration(selector, decl, false);
			}
		}
		
		private function on_dooclick(e:NShopEvent):void {
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_gm'):
					request_buy_item(e.obj.id, e.obj.stack);
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_hg'):
					request_sell_item(e.obj.id);
					break;
			}
		}
		
		
		private function on_drag_enter(e:DragEvent):void {
			if (e.dragSource.hasFormat(MainMenuEquipmentItemRender.FROMPACKAGE)) {
				DragManager.acceptDragDrop(IUIComponent(e.target));
				if (CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_gm') == comp.cardtype.selectedValue) {
					comp.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_hg');
					getNpcShopInfo();
				}
			}
		}
		
		private function onDragDrop(e:DragEvent):void {
			var sellObj:Object = e.dragSource.dataForFormat(MainMenuEquipmentItemRender.FROMPACKAGE);
			if(sellObj){
				if(sellObj.stack > 1){
					WindowManager.createWindow(NpcShopSellItemComponent.NAME,sellObj,null,false,false,false,null,mediatorMap,popUpWindowLayer,true)
				}else{
					request_to_jimai(sellObj.id, sellObj.position,SystemDataModel.packageinfoVo.curPage);
				}
				
			}
		}
		
		/**
		 * 商店种类选择
		 */
		private function onItemClick(evt:ItemClickEvent = null):void {
			comp.currentPage = 1;
			getNpcShopInfo();
		}
		
		//申请购买物品
		//type 操作类型 0购买1购回
		private function request_buy_item(itemid:int, num:int):void{
			var msg:npcShopBuyItemRequest = new npcShopBuyItemRequest();
			msg.id = SystemDataModel.roleId;
			msg.itemId = itemid;
			msg.npcId = SystemDataModel.tempId;
			msg.opeType = 0;
			msg.buyNum = num;
			xtrace("购买物品",msg);
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			socketService.send(new mx.rpc.Responder(response_buy_item,faultHandler),URLConst.NPCSHOP_BUYORBACKBUY_COMMANDID,bytes);
		}
		private function response_buy_item(data:ByteArray):void{
			var msg:npcShopBuyItemResponse = new npcShopBuyItemResponse();
			msg.readExternal(data);
			xtrace("购买回回购回复",msg.result,msg.message);
			if(msg.result){
				//获取商店信息
				getNpcShopInfo();
				//获取背包信息TODO
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage,SystemDataModel.packageType);
				dispatch(new GetBuyMoneyEffectEvent(GetBuyMoneyEffectEvent.GETBUYCHANGEMONEYFLASHEFFECT));
			}else {
				//xtrace("popUpShow",popUpShow);
				popUpShow.show(msg.message);
			}
		}
		//回购
		private function request_sell_item(itemid:int):void{
			var msg:npcShopBuyItemRequest = new npcShopBuyItemRequest();
			msg.id = SystemDataModel.roleId;
			msg.itemId = itemid;
			msg.npcId = SystemDataModel.tempId;
			msg.opeType = 1;
			xtrace("出售寄卖物品",msg);
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			socketService.send(new mx.rpc.Responder(response_sell_item,faultHandler),URLConst.NPCSHOP_BUYORBACKBUY_COMMANDID,bytes);
		}
		private function response_sell_item(data:ByteArray):void{
			var msg:npcShopBuyItemResponse = new npcShopBuyItemResponse();
			msg.readExternal(data);
			xtrace("出售寄卖物品回复",msg);
			if(msg.result){
				//获取商店信息
				getNpcShopInfo();
				//获取背包信息TODO
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage,SystemDataModel.packageType);
			}else{
				popUpShow.show(msg.message);
			}
		}
		
		/**
		 * 出售物品
		 * @param itemId 物品id
		 * @param itemPos 物品所在背包栏的位置
		 */		
		private function request_to_jimai(itemId:int,itemPos:int,page:int=1,count:int=1):void{
			var msg:npcShopSellItemRequest = new npcShopSellItemRequest();
			msg.id = SystemDataModel.roleId;
			msg.itemPos = itemPos;
			msg.curpage = page;
			msg.sellCount = count;
			msg.packageType = SystemDataModel.packageType;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("出售物品",msg);
			socketService.send(new mx.rpc.Responder(response_to_jimai,faultHandler),URLConst.NPCSHOP_SELL_COMMANDID,bytes);
		}
		/**
		 * 出售物品返回处理
		 */
		private function response_to_jimai(data:Object):void{
			var sellItemResByte:ByteArray = data as ByteArray;
			var msg:npcShopSellItemResponse = new npcShopSellItemResponse();
			msg.readExternal(sellItemResByte);
			if(msg.result){
				//获取商店相应信息
				getNpcShopInfo();
				//获取角色物品信息
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage,SystemDataModel.packageType);
				
			}else{
//				popUpShow.show(msg.message);
			}
		}
		
		/**
		 * 获取商店信息
		 */
		private function getNpcShopInfo():void{
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_gm'):
					SystemDataModel.shopInfoVo.itemType = ProConst.NPCSHOP_BUY_SHOP;
					comp.l_tip.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_sjgm');
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_hg'):
					SystemDataModel.shopInfoVo.itemType=ProConst.NPCSHOP_SELL_SHOP;
					comp.l_tip.text =CrotaResourceConfig.getInstance().getTextByModuleAndId('shop','nsIC_sjhg');
					break;
			}
			SceneModuleCommonMessage.getInstance().getNpcShopInfo(SystemDataModel.shopInfoVo.itemType,1);
			
			//获取角色物品信息
			ShopMessage.getInstance().requese_package_info(1,SystemDataModel.packageType);
		}
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
package sceneModule.view.pack.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Menu;
	import mx.core.FlexGlobals;
	import mx.core.mx_internal;
	import mx.events.DragEvent;
	import mx.events.MenuEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.chat.chat1003.itemLinkData;
	import proto.pack.pack215.splitItemsInPackRequest;
	import proto.pack.pack215.splitItemsInPackResponse;
	import proto.pack.pack216.dropItemsInPackRequest;
	import proto.pack.pack216.dropItemsInPackResponse;
	import proto.scene.scene203.getItemsInEquipSlotRequest;
	import proto.scene.scene204.getItemsInPackageRequest;
	import proto.scene.scene210.equipEquipmentRequest;
	import proto.scene.scene210.equipEquipmentResponse;
	import proto.scene.scene211.unloadedEquipmentRequest;
	import proto.scene.scene211.unloadedEquipmentResponse;
	import proto.scene.scene212.moveItemRequest;
	import proto.scene.scene212.moveItemResponse;
	
	import sceneModule.event.ChatEquipmentEvent;
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.event.GetRoleItemResponseEvent;
	import sceneModule.view.chat.view.ChatWindow;
	import sceneModule.view.chat.vo.ChatEquipmentVo;
	import sceneModule.view.pack.event.EquipEquipmentEvent;
	import sceneModule.view.pack.view.MainMenuEquipmentComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentSplitComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	use namespace mx_internal;
	
	import service.ISocketServer;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltipItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.model.vo.itemsVo.PackgeInfoVo;
	import proto.shop.shop220.npcShopSellItemRequest;
	import proto.shop.shop220.npcShopSellItemResponse;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	import proto.shop.shop206.getNpcShopInfoRequest;
	import proto.shop.shop206.getNpcShopInfoResponse;
	import managers.WindowManager;
	import util.PackageIitemInfoSettingUtil;
	import spark.filters.GlowFilter;
	import proto.pack.pack223.PackageExpansionRequest;
	import proto.pack.pack223.PackageExpansionResponse;
	import sceneModule.view.shop.view.NpcShopItemView;
	import proto.shop.shop219.npcShopBuyItemRequest;
	import proto.shop.shop219.npcShopBuyItemResponse;
	import sceneModule.view.shop.event.NpcPackDoubleClickEvent;
	import sceneModule.view.shop.view.NpcShopSellItemComponent;
	import sceneModule.view.blacksmith.view.MainEquipmentComponent;
	import sceneModule.view.blacksmith.event.RemoveEquipmentFromStrengthenEvent;
	import managers.ToolTipManager;
	import mx.managers.SystemManager;
	import sceneModule.view.pack.view.MainMenuEquipmentGroup;
	import resource.CrotaResourceConfig;

	public class MainMenuEquipmentComponentMediator extends Mediator
	{
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
//		[Inject]
//		public var chatWindow:ChatWindow;
		
		[Inject]
		public var comp:MainMenuEquipmentComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var intervalID:Number = 0 ;
		private var timeOffset:Number = 300 ;
		
		public var tooltip:MainMenuEquipmentTooltip;
		public var mainMenu:MainMenuEquipmentGroup;
		public function MainMenuEquipmentComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			comp.doubleClickEnabled = true;
			comp.mouseChildren = false;
			eventMap.mapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
			eventMap.mapListener(comp,MouseEvent.CLICK,onDoClick);
			eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			eventMap.mapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onRemoveMapListener():void{
			eventMap.unmapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
			eventMap.unmapListener(comp,MouseEvent.CLICK,onDoClick);
			eventMap.unmapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			eventMap.unmapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			
			eventMap.unmapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.unmapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.unmapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		//鼠标事件类型
		private var mouseClickStrFlag:String;
		private var evtClick:MouseEvent;
		//MouseDown
		private function onMouseDown(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
			evtClick = evt;
			clearInterval(intervalID);
			
			intervalID = setInterval(doClick,timeOffset);
		}
		//MouseClick
		private function onDoClick(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
			
		}
		//MouseDoubleClick
		private function onDoubleClick(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
		}
		
		private function doClick():void{

			clearInterval(intervalID);
			if(mouseClickStrFlag == "doubleClick"){
				//执行鼠标双击事件
				onMouseDoubleClick();
			}else if(mouseClickStrFlag =="click"){
				//鼠标单击事件 如果有物品数据则显示Menu菜单，如果个子为开放则弹出开启个子提示框
				if(comp.data && comp.data.id !=0){
					showMenu();
				}else if(comp.curTileIsClock && comp.rolePos == 0){
					popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','cmeIRM_sfff') + onSetOpenPackDomand(comp.data.position) + CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_ktbb'), null, null, null, null, submitOpenPackHandler, close_qianghua_alert, null);
					//新手指引,打开扩展背包确认解密
					GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ALERT_OPEN_PACKAGE));
				}
				
			}else if(mouseClickStrFlag == "mouseDown"){
				//鼠标按下，执行拖拽操作
				comp.onClick(evtClick);
			}
		}
		
		
		//关闭强化确认框
		private function close_qianghua_alert(e:Event):void {
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ALERT_CLOSE_PACKAGE));
		}
		
		/**
		 * 计算开背包所花费的魔钻数
		 */
		private function onSetOpenPackDomand(pos:int):int{
			//所开背包格子数
			var count:int = (SystemDataModel.packageinfoVo.curPage - 1)*30 + (pos+1) - SystemDataModel.packageinfoVo.curOpenMaxCount;
			//本次所开背包第一个格子魔钻
			var startMoney:int = (SystemDataModel.packageinfoVo.curOpenMaxCount - 23)*2;
			//本次所开背包所需所有的魔钻数
			var maxMoney:int;
			var curMoney:int;
			for(var i:int=0;i<count;i++){
				curMoney = startMoney + i*2;
				maxMoney +=curMoney;
			}
			return maxMoney;
		}
		//确定开放背包个子
		private function submitOpenPackHandler(evt:MouseEvent):void{
			var packageExpansionReq:PackageExpansionRequest = new PackageExpansionRequest();
			packageExpansionReq.characterId = SystemDataModel.roleId;
			packageExpansionReq.packageType = SystemDataModel.packageType;
			packageExpansionReq.curpage = SystemDataModel.packageinfoVo.curPage;
			packageExpansionReq.position = comp.data.position;
			var byteArray:ByteArray = new ByteArray();
			packageExpansionReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(expansionHandler,faultHandler),URLConst.EXPANSION_PACK_COMMANDID,byteArray);
		}
		private function expansionHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:PackageExpansionResponse = new PackageExpansionResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
			}
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_BIG_PACKAGE_OK));
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private function onMouseOver(evt:MouseEvent):void{

//			comp.filters=[new GlowFilter(0xff0000,1,6,6,2,1,true)];
			//鼠标经过显示发光边框
			
			comp.borderOverEffectImg.visible = true;
			if(comp.data && comp.data.id !=0){
				if(!tooltip){
					tooltip = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
				}
				var packgeItem:PackageItem = comp.data as PackageItem;
				tooltip.curDataInfo = packgeItem;
		        popUpWindowLayer.addElement(tooltip);
				//设置ToolTip位置
				setTooltipPosition();
			}			
		}
		//鼠标移动 设置ToolTip位置
		private function onMouseMove(evt:MouseEvent):void{
			if(tooltip){
				setTooltipPosition();
			}
		}
		/**
		 * 当鼠标移出，设置Tooltip为不可见
		 */
		private function onMouseOut(evt:MouseEvent):void{
			if(tooltip)popUpWindowLayer.removeElement(tooltip);
//			comp.filters=[];
			comp.borderOverEffectImg.visible = false;
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			tooltip.y = FlexGlobals.topLevelApplication.mouseY;
			if(1000 - FlexGlobals.topLevelApplication.mouseX - insetPosX < tooltip.width){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX - tooltip.width - 10;
			}else{
				tooltip.x = FlexGlobals.topLevelApplication.mouseX + insetPosX;
			}
		}
		private function onDragDrop(evt:DragEvent):void{				
//			comp.filters = [];
			comp.borderOverEffectImg.visible = false;
			//把当前拖拽对象的身体部位置为-1
			SystemDataModel.bodyPos = -1
			if(comp.dragType == comp.FROMPACKAGETOROLE){
				var skillComp:MainMenuEquipmentComponent = evt.dragSource.dataForFormat(comp.FROMPACKAGE) as MainMenuEquipmentComponent;
				if(skillComp != null && skillComp.data && comp.rolePos != -1 && skillComp.data.bodyType !=-1){
					//穿装备
					onEquipEquipment(skillComp.data.position,comp.rolePos);
				}
			}else if(comp.dragType == comp.FROMROLETOPACKAGE){
				var unEquipComp:MainMenuEquipmentComponent = evt.dragSource.dataForFormat(comp.FROMROLE) as MainMenuEquipmentComponent;
				if(unEquipComp != null && unEquipComp.data && (SystemDataModel.packageType == ProConst.COMMON_ITEM)){
					//卸载装备
					unEquipEquipment(unEquipComp.data.position,comp.data.position,SystemDataModel.packageinfoVo.curPage);
			}
			}else if(comp.dragType == comp.MOVEITEM){
				var moveComp:MainMenuEquipmentComponent = evt.dragSource.dataForFormat(comp.FROMPACKAGE) as MainMenuEquipmentComponent;
				if(moveComp != null && moveComp.data && SystemDataModel.packageType == ProConst.COMMON_ITEM){
					//移动
					onMoveItem(moveComp.data.position,comp.data.position);
				}
			}else if(comp.dragType == comp.SPLITITEM){
				var splitComponent:MainMenuEquipmentComponent = evt.dragSource.dataForFormat(comp.SPLITITEM) as MainMenuEquipmentComponent;
				if(splitComponent != null && splitComponent.data && comp.rolePos == 0 && comp.data){
					//拆分
					onSplitItemSendCommand(splitComponent.data.position,comp.data.position,splitComponent.splitNum,3);
				}
			}else if(comp.dragType == comp.HUIGOU){
				var buyItemRender:NpcShopItemView = evt.dragSource.dataForFormat(comp.HUIGOU) as NpcShopItemView;
				//回购
				request_sell_item(buyItemRender.data.id);
			}else if(comp.dragType == comp.GOUMAI){
				var huigouItemRender:NpcShopItemView = evt.dragSource.dataForFormat(comp.GOUMAI) as NpcShopItemView;
				//购买
				request_buy_item(huigouItemRender.data.id, huigouItemRender.data.stack);
			}else if(comp.dragType == MainEquipmentComponent.fromStrengthen){
				this.dispatch(new RemoveEquipmentFromStrengthenEvent(RemoveEquipmentFromStrengthenEvent.REMOVEEQUIPMENTFROMSTRENGTHENEVENT));
				//获取背包信息TODO
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
			}
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
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			socketServer.send(new mx.rpc.Responder(response_buy_item,faultHandler),URLConst.NPCSHOP_BUYORBACKBUY_COMMANDID,bytes);
		}
		private function response_buy_item(data:ByteArray):void{
			var msg:npcShopBuyItemResponse = new npcShopBuyItemResponse();
			msg.readExternal(data);
			if(msg.result){
				//获取商店信息
				getNpcShopInfo(ProConst.NPCSHOP_BUY_SHOP);
				//获取背包信息TODO
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
			}else {
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
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			socketServer.send(new mx.rpc.Responder(response_sell_item,faultHandler),URLConst.NPCSHOP_BUYORBACKBUY_COMMANDID,bytes);
		}
		private function response_sell_item(data:ByteArray):void{
			var msg:npcShopBuyItemResponse = new npcShopBuyItemResponse();
			msg.readExternal(data);
			if(msg.result){
				//获取商店信息
				getNpcShopInfo(ProConst.NPCSHOP_SELL_SHOP);
				//获取背包信息TODO
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
			}else{
//				popUpShow.show(msg.message);
			}
		}
		/**
		 * 弹出Menu菜单
		 */
		private function onMouseDoubleClick():void{
//			trace("使用");
			clearInterval(intervalID);
			if(SystemDataModel.shopInfoVo.itemType != -1){
				if(comp.data && comp.data.id != 0){
					//发送出售该物品指令
					if(comp.data.stack > 1){
						WindowManager.createWindow(NpcShopSellItemComponent.NAME,comp.data,null,false,true,false,null,mediatorMap,popUpWindowLayer,true)
					}else{
						npcShopSellItem(comp.data.id,comp.data.position,SystemDataModel.packageinfoVo.curPage);
					}
					this.dispatch(new NpcPackDoubleClickEvent(NpcPackDoubleClickEvent.NPCPACKDOUBLECLICKEVENT));
				}
			}else{
//				trace("else:");
				if(comp.data && comp.data.id !=0 && comp.rolePos ==0){
					//发送穿装备指令

					onEquipEquipment(comp.data.position,comp.data.bodyType);
				}else if(comp.data && comp.data.templateId == 249){
					//此时没有喊话物品  暂时处理方法 小喇叭
//					onHornFunction(comp.data);
				}
			}
						
		}
		/**
		 * 出售物品
		 * @param itemId 物品id
		 * @param itemPos 物品所在背包栏的位置
		 */		
		private function npcShopSellItem(itemId:int,itemPos:int,page:int=1,count:int=1):void{
			var npcShopSellItemReq:npcShopSellItemRequest = new npcShopSellItemRequest();
			npcShopSellItemReq.id = SystemDataModel.roleId;
			npcShopSellItemReq.itemPos = itemPos;
			npcShopSellItemReq.curpage = page;
			npcShopSellItemReq.sellCount = count;
			npcShopSellItemReq.packageType = SystemDataModel.packageType;
			var npcShopSellItemByte:ByteArray = new ByteArray();
			npcShopSellItemReq.writeExternal(npcShopSellItemByte);
			socketServer.send(new mx.rpc.Responder(sellItemHandler,faultHandler),URLConst.NPCSHOP_SELL_COMMANDID,npcShopSellItemByte);
		}
		/**
		 * 出售物品返回处理
		 */
		private function sellItemHandler(data:Object):void{
			var sellItemResByte:ByteArray = data as ByteArray;
			var sellItemRes:npcShopSellItemResponse = new npcShopSellItemResponse();
			sellItemRes.readExternal(sellItemResByte);
			if(sellItemRes.result){
				SystemDataModel.shopInfoVo.itemType = 1;
				//获取商店相应信息
				getNpcShopInfo(ProConst.NPCSHOP_BUY_SHOP);
				//获取背包信息
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
			}else{
//				popUpShow.show(sellItemRes.message);
			}
		}
		private var myMenu:Menu;
		private function showMenu():void {
//			var arr:Array = new Array(['丢弃'],['使用'],['出售'],['展示'],['装备'],['复制'],['拆分']);
			var arr:Array = new Array([CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_sy')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_dq')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_zs')]);
			var arrRw:Array=new Array([CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_dq')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_zs')]);
			var tempArr:Array=SystemDataModel.packageType==2?arrRw:arr;	
			myMenu = Menu.createMenu(null,getItemMenuData(tempArr), false);
			myMenu.labelField = 'label';
//			myMenu.width = 32;
			myMenu.addEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
			if(tooltip.visible){
				tooltip.visible = false;
			}
			myMenu.show(FlexGlobals.topLevelApplication.mouseX + 5, FlexGlobals.topLevelApplication.mouseY + 5);
		}
		private function onMenuItemClick(evt:MenuEvent):void  {
//			trace("function onMenuItemClick");
			switch(evt.label){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_dq'):
					//丢弃
					var dropStr:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_qddq');
					popUpShow.show(dropStr,null,null,null,null,submitDropHandler);
					
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_sy'):
//					//使用
					onMouseDoubleClick();
					break;
//				case ProConst.MENU_SELL:
//					//出售
//					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_zs'):
					//展示
					var itemlinkdata:itemLinkData = new itemLinkData();
					itemlinkdata.chatEquipType = ProConst.CHATLINK_EQUIP;
					itemlinkdata.id = comp.data.id;
					//此处需要获取角色名称
					itemlinkdata.name = comp.data.name;
					this.dispatch(new ChatEquipmentEvent(ChatEquipmentEvent.CHATEQUIPMENTEVENT,itemlinkdata));
					break;
//				case ProConst.MENU_EQUIP:
//					//装备
//					break;
//				case ProConst.MENU_COPY:
//					//复制
//					break;
//				case ProConst.MENU_SPLIT:
//					//拆分 
//					onSplitItem();
//					
//					break;
			}
			myMenu.removeEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
		}
		/**
		 * 穿装备
		 */
		private function sendAddItemCommand():void{
			//TODO
		}
		/**
		 * 确定丢弃物品
		 */
		private function submitDropHandler(evt:MouseEvent):void{
			onDropItem(SystemDataModel.packageType,comp.data.position);
		}
		private function getItemMenuData(itemArr:Array):Array {
			var l:int = itemArr.length;
			var itemMenuData:Array = new Array();
			for(var i:int=0;i<l;i++){
				var menuItem:Object = new Object();
				menuItem.label = itemArr[i];
				itemMenuData.push(menuItem);
			}
			return itemMenuData;
		}
		/**
		 * 丢弃物品
		 */
		private function onDropItem(pType:int,pos:int):void{
			var dropRequest:dropItemsInPackRequest = new dropItemsInPackRequest();
			dropRequest.id = SystemDataModel.roleId;
			dropRequest.packageType = pType;
			dropRequest.position = pos;
			dropRequest.curPage = SystemDataModel.packageinfoVo.curPage;
			var dropByteArray:ByteArray = new ByteArray();
			dropRequest.writeExternal(dropByteArray);
			socketServer.send(new mx.rpc.Responder(dropItemHandler,faultHandler),URLConst.DROP_ITEM_COMMANDID,dropByteArray);
		}
		/**
		 * 丢弃物品返回处理
		 */
		private function dropItemHandler(data:Object):void{
			var dropByte:ByteArray = data as ByteArray;
			var dropResponse:dropItemsInPackResponse = new dropItemsInPackResponse();
			dropResponse.readExternal(dropByte);
			if(dropResponse.result){
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				getEquipmentInSlotInfo();
			}else{
				popUpShow.show(dropResponse.message);
			}
		}
		/**
		 * 拆分物品
		 */
		private var splitComp:MainMenuEquipmentSplitComponent;
		private function onSplitItem():void{
			splitComp = new MainMenuEquipmentSplitComponent();
			this.contextView.addChild(splitComp);
			splitComp._maxNum =comp.data.stack;
			splitComp.x = FlexGlobals.topLevelApplication.width/2 - splitComp.width/2;
			splitComp.y = FlexGlobals.topLevelApplication.height/2 - splitComp.height/2;
			splitComp.ensureBtn.addEventListener(MouseEvent.CLICK,onEnsureSplitItem);
			splitComp.cancelBtn.addEventListener(MouseEvent.CLICK,onCancelSplit);
		}
		/**
		 * 确定拆分物品
		 */
		private function onEnsureSplitItem(evt:MouseEvent):void{
			splitComp.ensureBtn.removeEventListener(MouseEvent.CLICK,onEnsureSplitItem);
			onCloseWindow(evt);
			//发送拆分信息
			comp.splitNum = splitComp.numSpinner.value;
//			comp.onClick(evtClick,comp.SPLITITEM);
		}
		/**
		 * 取消拆分物品
		 */
		private function onCancelSplit(evt:MouseEvent):void{
			splitComp.cancelBtn.removeEventListener(MouseEvent.CLICK,onCancelSplit);
			onCloseWindow(evt);
		}
		/**
		 * 关闭窗口
		 */
		private function onCloseWindow(evt:MouseEvent):void{
			this.contextView.removeChild(splitComp);
		}
		/**
		 * 拆分装备
		 */
		private function onSplitItemSendCommand(fromPos:int,toPos:int,num:int,pType:int):void{
			var splitRequest:splitItemsInPackRequest = new splitItemsInPackRequest();
			splitRequest.id = SystemDataModel.roleId;
			splitRequest.fromposition = fromPos;
			splitRequest.toposition = toPos;
			splitRequest.splitnum = num;
			splitRequest.packageType = pType;
			var splitByteArray:ByteArray = new ByteArray();
			splitRequest.writeExternal(splitByteArray);
			socketServer.send(new mx.rpc.Responder(splitHandler,faultHandler),URLConst.SPLIT_ITEM_COMMANDID,splitByteArray);
		}
		/**
		 * 拆分装备返回处理
		 */
		private function splitHandler(data:Object):void{
			var splitResponseByte:ByteArray = data as ByteArray;
			var responseData:splitItemsInPackResponse = new splitItemsInPackResponse();
			responseData.readExternal(splitResponseByte);
			if(responseData.result){
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				getEquipmentInSlotInfo();
			}
		}
		/**
		 * 移动装备
		 */
		private function onMoveItem(fromPos:int,toPos:int):void{
			var moveRequest:moveItemRequest = new moveItemRequest();
			moveRequest.fromPosition = fromPos;
			moveRequest.toPosition = toPos;
			moveRequest.id = SystemDataModel.roleId;
			moveRequest.packageType = ProConst.COMMON_ITEM;
			moveRequest.curpage = SystemDataModel.packageinfoVo.curPage;
			var moveByteArray:ByteArray = new ByteArray();
			moveRequest.writeExternal(moveByteArray);
			socketServer.send(new mx.rpc.Responder(moveItemHandler,faultHandler),URLConst.MOVE_ITEM_COMMANDID,moveByteArray);
		}
		/**
		 * 移动物品结果返回处理
		 */
		private function moveItemHandler(data:Object):void{
			var moveResultByteArray:ByteArray = data as ByteArray;
			var moveResponseData:moveItemResponse = new moveItemResponse();
			moveResponseData.readExternal(moveResultByteArray);
			if(moveResponseData.result){
				if(moveResponseData.data.packageType == ProConst.COMMON_ITEM){
					getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				}
				 
			}else{
				//popUpShow.show(moveResponseData.message);
				if(moveResponseData.message!=""){
//					popUpShow.show(moveResponseData.message);
				}
			}
		}
		/**
		 * 穿装备
		 */
		private function onEquipEquipment(fromPos:int,toPos:int):void{
			var equipRequest:equipEquipmentRequest = new equipEquipmentRequest();
			equipRequest.id = SystemDataModel.roleId;
			equipRequest.fromPosition = fromPos;
			equipRequest.toPosition = toPos;
			equipRequest.fromPackCategory = SystemDataModel.packageType;
			equipRequest.curpage = SystemDataModel.packageinfoVo.curPage;
			var byteArray:ByteArray = new ByteArray();
			equipRequest.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(resultHandler,faultHandler),URLConst.EQUIP_ROLE_COMMANDID,byteArray);
		}
		/**
		 * equip role resultHandler
		 */
		private function resultHandler(data:Object):void{
			var responseByte:ByteArray = data as ByteArray;
			var equipResponse:equipEquipmentResponse = new equipEquipmentResponse();
			equipResponse.readExternal(responseByte);
			if(equipResponse.result){
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				getEquipmentInSlotInfo();
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ADD_EQUIP));
			}
		}
		/**
		 * 获取商店信息
		 */
		private function getNpcShopInfo(shopCategory:int):void{
			var requestGetShopInfo:getNpcShopInfoRequest = new getNpcShopInfoRequest();
			requestGetShopInfo.id = SystemDataModel.roleId;
			requestGetShopInfo.npcId = SystemDataModel.tempId;
			requestGetShopInfo.shopCategory = shopCategory;
			var getShopInfoByteArray:ByteArray = new ByteArray();
			requestGetShopInfo.writeExternal(getShopInfoByteArray);
			socketServer.send(new mx.rpc.Responder(resultNpcShopHandler,faultHandler),URLConst.GET_SHOPINFO_COMMANDID,getShopInfoByteArray);
		}
		/**
		 * 获取商店信息返回处理
		 */
		private function resultNpcShopHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:getNpcShopInfoResponse = new getNpcShopInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				dispatch(new GetShopInfoResponseEvent(GetShopInfoResponseEvent.GETSHOPINFORESPONSE,responseData.data,GetShopInfoResponseEvent.GETSHOPINFO));
			}else{
//				popUpShow.show(responseData.message);
			}
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
		/**
		 *获取装备信息 
		 */		
		private function getEquipmentInfo(page:int=1):void{
			//获取角色物品信息
			ShopMessage.getInstance().requese_package_info(page, SystemDataModel.packageType);
			//var requestGetItemInPackage:proto.scene.scene204.getItemsInPackageRequest = new getItemsInPackageRequest();
			//requestGetItemInPackage.id = SystemDataModel.roleId;
			//requestGetItemInPackage.packCategory = SystemDataModel.packageType;
			//requestGetItemInPackage.curpage = page;
			//var itemInPackageByteArray:ByteArray = new ByteArray();
			//requestGetItemInPackage.writeExternal(itemInPackageByteArray);
			//socketServer.send(new mx.rpc.Responder(itemInPackageResultHandler,faultHandler),URLConst.GET_ITEMINPACKAGE_COMMANDID,itemInPackageByteArray);
		}
		/**
		 *itemInPackageResultHandler 
		 */	
		private function itemInPackageResultHandler(data:Object):void{
			dispatch(new GetRoleItemInPackageResponseEvent(GetRoleItemInPackageResponseEvent.GETROLEITEMINPACKAGEVENT,data));
		}
		/**
		 * 获取角色装备信息
		 */
		private function getEquipmentInSlotInfo():void{
			//获取角色装备信息
			var requestGetItem:getItemsInEquipSlotRequest = new getItemsInEquipSlotRequest();
			requestGetItem.id = SystemDataModel.roleId;
			var itemInfoByteArray:ByteArray = new ByteArray();
			requestGetItem.writeExternal(itemInfoByteArray);
			socketServer.send(new mx.rpc.Responder(itemResultHandler,faultHandler),URLConst.GET_ROLEITEM_COMMANDID,itemInfoByteArray);
			
		}
		/**
		 * itemResultHandler 
		 */		
		private function itemResultHandler(data:Object):void{
			dispatch(new GetRoleItemResponseEvent(GetRoleItemResponseEvent.GET_ROLEITEM_EVENT,data));
		}
		/**卸载装备
		 * 
		 */
		private function unEquipEquipment(fromPos:int,toPos:int,page:int=1):void{
			var unLoadEquipRequest:unloadedEquipmentRequest = new unloadedEquipmentRequest();
			unLoadEquipRequest.id = SystemDataModel.roleId;
			unLoadEquipRequest.fromPosition = fromPos;
			unLoadEquipRequest.toPosition = toPos;
			unLoadEquipRequest.curpage = page;
			var unLoadByteArray:ByteArray = new ByteArray();
			unLoadEquipRequest.writeExternal(unLoadByteArray);
			socketServer.send(new mx.rpc.Responder(unLoadEquipment,faultHandler),URLConst.UNLOAD_EQUIPMENT_COMMANDID,unLoadByteArray);
		}
		/**
		 * 卸载装备返回处理
		 */
		private function unLoadEquipment(data:Object):void{
			var unLoadByteArray:ByteArray = data as ByteArray;
			var unLoadResponse:unloadedEquipmentResponse = new unloadedEquipmentResponse();
			unLoadResponse.readExternal(unLoadByteArray);
			if(unLoadResponse.result){
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				getEquipmentInSlotInfo();
			}else{
//				trace("卸载装备unLoadResponse.message***" + unLoadResponse.message);
//				popUpShow.show(unLoadResponse.message);
			}
		}
	}
}
package sceneModule.view.pack.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Menu;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.events.MenuEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.chat.chat1003.itemLinkData;
	import proto.pack.pack223.PackageExpansionRequest;
	import proto.pack.pack223.PackageExpansionResponse;
	import proto.pet.pet2300.GetPetListInfoRequest;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChatEquipmentEvent;
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.blacksmith.event.RemoveEquipmentFromStrengthenEvent;
	import sceneModule.view.blacksmith.view.MainEquipmentComponent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentSplitComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.role.view.MainMenuRoleComponent;
	import sceneModule.view.role.view.MainRoleEquipmentItemRender;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.NpcPackDoubleClickEvent;
	import sceneModule.view.shop.view.NpcShopComponent;
	import sceneModule.view.shop.view.NpcShopItemView;
	import sceneModule.view.shop.view.NpcShopSellItemComponent;
	
	import service.ISocketServer;

	public class MainMenuEquipmentItemRenderMediator extends Mediator
	{
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var comp:MainMenuEquipmentItemRender;
		
		public var tooltip:MainMenuEquipmentTooltip;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var intervalID:Number = 0 ;
		private var timeOffset:Number = 300 ;
		public function MainMenuEquipmentItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			comp.doubleClickEnabled = true;
			comp.mouseChildren = false;
			eventMap.mapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
			eventMap.mapListener(comp,MouseEvent.CLICK,onDoClick);
			eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			eventMap.mapListener(comp,DragEvent.DRAG_ENTER,onDragEnter);
			eventMap.mapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			eventMap.mapListener(comp,DragEvent.DRAG_OVER,onDragOver);
			eventMap.mapListener(comp,DragEvent.DRAG_EXIT,onDragExit);
			eventMap.mapListener(comp,DragEvent.DRAG_COMPLETE,onDragComplete);
			
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onDragComplete(evt:DragEvent):void{
			if(SystemDataModel.bodyPos !=-1){
				SystemDataModel.bodyPos = -1;
			}
		}
		
		private function onDragOver(evt:DragEvent):void{
			if(!comp.borderOverEffectImg.visible)comp.borderOverEffectImg.visible=true;
		}
		private function onDragExit(evt:DragEvent):void{
			if(comp.borderOverEffectImg.visible)comp.borderOverEffectImg.visible=false;
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
				}else if(!comp.curTileIsClock){
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
			comp.borderOverEffectImg.visible = true;
			if(comp.data && comp.data.id !=0){
				if(!tooltip){
					tooltip = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
				}
				var packgeItem:PackageItem = comp.data as PackageItem;
				tooltip.curDataInfo = packgeItem;
				//设置ToolTip位置
				setTooltipPosition();
				popUpWindowLayer.addElement(tooltip);
				
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
			comp.borderOverEffectImg.visible = false;
			if(tooltip && popUpWindowLayer.contains(tooltip))popUpWindowLayer.removeElement(tooltip);
			
			//			comp.filters=[];
//			comp.borderOverEffectImg.visible = false;
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
		
		/**
		 * onDragEnter
		 */
		private function onDragEnter(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(MainRoleEquipmentItemRender.FROMROLEPACK)){
				comp.dragType = MainRoleEquipmentItemRender.FROMROLEPACK;
			}else if(evt.dragSource.hasFormat(MainMenuEquipmentItemRender.FROMPACKAGE)){
				comp.dragType = MainMenuEquipmentItemRender.FROMPACKAGE;
			}else if(evt.dragSource.hasFormat(comp.HUIGOU)){
				comp.dragType = comp.HUIGOU;
			}else if(evt.dragSource.hasFormat(comp.GOUMAI)){
				comp.dragType = comp.GOUMAI;
			}else if(evt.dragSource.hasFormat(MainEquipmentComponent.fromStrengthen)){
				comp.dragType = MainEquipmentComponent.fromStrengthen;
			}
			DragManager.acceptDragDrop(IUIComponent(evt.target));
		}
		private function onDragDrop(evt:DragEvent):void{				
//			comp.borderOverEffectImg.visible = false;
			//把当前拖拽对象的身体部位置为-1
			SystemDataModel.bodyPos = -1
			if(comp.dragType == MainRoleEquipmentItemRender.FROMROLEPACK){
				var roleEquObj:Object = evt.dragSource.dataForFormat(MainRoleEquipmentItemRender.FROMROLEPACK);
				if(roleEquObj && (SystemDataModel.packageType == ProConst.COMMON_ITEM)){
					//卸载装备
					SceneModuleCommonMessage.getInstance().unEquipEquipment(roleEquObj.bodyType,comp.data.position,SystemDataModel.packageinfoVo.curPage);
				}
			}else if(comp.dragType == MainMenuEquipmentItemRender.FROMPACKAGE){
				var moveObj:Object = evt.dragSource.dataForFormat(MainMenuEquipmentItemRender.FROMPACKAGE);
				if(moveObj && SystemDataModel.packageType == ProConst.COMMON_ITEM){
					//移动
					//强化界面暂时不能移动
//					if(SystemDataModel.packType != MainStrengthenComponent.NAME){
						SceneModuleCommonMessage.getInstance().onMoveItem(moveObj.position,comp.data.position);
//					}
					
				}
			}else if(comp.dragType == comp.SPLITITEM){
//				var splitComponent:MainMenuEquipmentComponent = evt.dragSource.dataForFormat(comp.SPLITITEM) as MainMenuEquipmentComponent;
//				if(splitComponent != null && splitComponent.data && comp.rolePos == 0 && comp.data){
//					//拆分
//					onSplitItemSendCommand(splitComponent.data.position,comp.data.position,splitComponent.splitNum,3);
//				}
			}else if(comp.dragType == comp.HUIGOU){
				var buyItemRender:NpcShopItemView = evt.dragSource.dataForFormat(comp.HUIGOU) as NpcShopItemView;
				//回购
				SceneModuleCommonMessage.getInstance().request_sell_item(buyItemRender.data.id);
			}else if(comp.dragType == comp.GOUMAI){
				var huigouItemRender:NpcShopItemView = evt.dragSource.dataForFormat(comp.GOUMAI) as NpcShopItemView;
				//购买
				SceneModuleCommonMessage.getInstance().request_buy_item(huigouItemRender.data.id, huigouItemRender.data.stack);
			}else if(comp.dragType == MainEquipmentComponent.fromStrengthen){
				this.dispatch(new RemoveEquipmentFromStrengthenEvent(RemoveEquipmentFromStrengthenEvent.REMOVEEQUIPMENTFROMSTRENGTHENEVENT));
				var strObj:Object  = evt.dragSource.dataForFormat(MainEquipmentComponent.fromStrengthen);
				//移动
				SceneModuleCommonMessage.getInstance().onMoveItem(strObj.position,comp.data.position);
				//获取背包信息TODO
//				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
			}
		}
		
		/**
		 * 弹出Menu菜单
		 */
		private function onMouseDoubleClick():void{
			clearInterval(intervalID);
			switch(SystemDataModel.packType){
				case NpcShopComponent.NAME:
					if(comp.data && comp.data.id != 0){
						//发送出售该物品指令
						if(comp.data.stack > 1){
							WindowManager.createWindow(NpcShopSellItemComponent.NAME,comp.data,null,false,true,false,null,mediatorMap,popUpWindowLayer,true)
						}else{
							SceneModuleCommonMessage.getInstance().npcShopSellItem(comp.data.id,comp.data.position,SystemDataModel.packageinfoVo.curPage);
						}
//						this.dispatch(new NpcPackDoubleClickEvent(NpcPackDoubleClickEvent.NPCPACKDOUBLECLICKEVENT));
					}
					break;
				case MainMenuRoleComponent.NAME:
					if(comp.data && comp.data.id !=0){
						//发送穿装备指令
						SceneModuleCommonMessage.getInstance().onEquipEquipment(comp.data.position,comp.data.bodyType);
					}
					break;
			}
		}
		private function getPetInfo():void{
			var getPetListReq:GetPetListInfoRequest = new GetPetListInfoRequest();
			getPetListReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getPetListReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(getPetListHandler,faultHandler),URLConst.PET_GETLISTINFO_COMMANDID,byteArray);
		}
		private function getPetListHandler(data:Object):void{
			this.dispatch(new GetPetListInfoResponseEvent(GetPetListInfoResponseEvent.GETPETLISTINFO,data));
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
//			if(tooltip.visible){
//				tooltip.visible = false;
//			}
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
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_dq'):
					//展示
					var itemlinkdata:itemLinkDataa = new itemLinkData();
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
			SceneModuleCommonMessage.getInstance().onDropItem(SystemDataModel.packageType,comp.data.position);
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
	}
}
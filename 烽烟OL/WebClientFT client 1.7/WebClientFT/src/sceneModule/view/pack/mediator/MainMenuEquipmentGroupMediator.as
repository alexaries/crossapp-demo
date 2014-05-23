package sceneModule.view.pack.mediator
{
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import managers.ToolTipManager;
	
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.events.ItemClickEvent;
	import mx.managers.CursorManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pack.pack217.packageArrangeRequest;
	import proto.pack.pack217.packageArrangeResponse;
	import proto.scene.scene204.getItemsInPackageRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.event.MediatorRegisterItemEuipmentEvent;
	import sceneModule.view.pack.event.PackageInfoChangeEvent;
	import sceneModule.view.pack.view.MainMenuEquipmentGroup;
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.GetBuyMoneyEffectEvent;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.FilterTool;

	public class MainMenuEquipmentGroupMediator extends Mediator
	{
		[Inject]
		public var comp:MainMenuEquipmentGroup;
		
		[Inject]
		public var socektServer:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		public var iSmallDesToolTip:MainSmallDesTooltip;
		private var index:int;
		public function MainMenuEquipmentGroupMediator()
		{
			super();
		}
		override public function onRegister():void{
			//整理背包
			eventMap.mapListener(comp.iBtn,MouseEvent.CLICK,onBtnClick);
			//背包类型改变
			eventMap.mapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onItemClick);
			//上一页
			eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePage);
			//下一页
			eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPage);
			//鼠标移过魔钻
			eventMap.mapListener(comp.crystal,MouseEvent.MOUSE_OVER,onDtextMouseOver);
			//鼠标移出魔钻
			eventMap.mapListener(comp.crystal,MouseEvent.MOUSE_OUT,onDtextMouseOut);
			//鼠标在魔钻上移动
			eventMap.mapListener(comp.crystal,MouseEvent.MOUSE_MOVE,onMouseMove);
			//鼠标移过金币
			eventMap.mapListener(comp.coin,MouseEvent.MOUSE_OVER,onCtextMouseOver);
			//鼠标移出金币
			eventMap.mapListener(comp.coin,MouseEvent.MOUSE_OUT,onCtextMouseOut);
			//鼠标在金币上移动
			eventMap.mapListener(comp.coin,MouseEvent.MOUSE_MOVE,onMouseMove);
			//背包信息改动事件
			this._eventDispatcher.addEventListener(PackageInfoChangeEvent.PACKAGEINFOCHANGEEVENT,onPackageInfoChange);
			this._eventDispatcher.addEventListener(GetBuyMoneyEffectEvent.GETBUYCHANGEMONEYFLASHEFFECT,onGetChangeMoneyFlashEffect);
			
			init_view();
			
			comp.addEventListener(MediatorRegisterItemEuipmentEvent.MEDIATORREGISTERCOMMISSIONITEMEUIPMENT,onRegisterMediatorItem);
		}
		
		private function onRegisterMediatorItem(evt:MediatorRegisterItemEuipmentEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function init_view():void{
			comp.bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_package", "pack_bg");
			comp.coin_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("common_res", "coin_img");
			comp.cys_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("common_res", "cry_img");
		}
		
		//移除事件监听
		private function onRemoveEventListener():void{
			//整理背包
			eventMap.unmapListener(comp.iBtn,MouseEvent.CLICK,onBtnClick);
			//背包类型改变
			eventMap.unmapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onItemClick);
			//上一页
			eventMap.unmapListener(comp.pre_btn,MouseEvent.CLICK,onPrePage);
			//下一页
			eventMap.unmapListener(comp.next_btn,MouseEvent.CLICK,onNextPage);
			//鼠标移过魔钻
			eventMap.unmapListener(comp.crystal,MouseEvent.MOUSE_OVER,onDtextMouseOver);
			//鼠标移出魔钻
			eventMap.unmapListener(comp.crystal,MouseEvent.MOUSE_OUT,onDtextMouseOut);
			//鼠标在魔钻上移动
			eventMap.unmapListener(comp.crystal,MouseEvent.MOUSE_MOVE,onMouseMove);
			//鼠标移过金币
			eventMap.unmapListener(comp.coin,MouseEvent.MOUSE_OVER,onCtextMouseOver);
			//鼠标移出金币
			eventMap.unmapListener(comp.coin,MouseEvent.MOUSE_OUT,onCtextMouseOut);
			//鼠标在金币上移动
			eventMap.unmapListener(comp.coin,MouseEvent.MOUSE_MOVE,onMouseMove);
			//背包信息改动事件
			this._eventDispatcher.removeEventListener(PackageInfoChangeEvent.PACKAGEINFOCHANGEEVENT,onPackageInfoChange);
		}
		//购买成功后让金币闪动
		private function onGetChangeMoneyFlashEffect(e:GetBuyMoneyEffectEvent):void{
			
//			trace("money..flash");
//			var co:ColorTransform = FilterTool.colorTransform();
//			comp.cText.transform.colorTransform = co;
			//ROLEINFOTEXTFORMAT
			comp.cText.styleName = "SHOPBUYITEM";
			changeCssStyle();
		}
		
		private function changeCssStyle():void{
		
			index = 0;
			var _interval:uint = setInterval(changeS,200);
			
			function changeS():void{				
				index++;
				if(index >= 4){
					index = 0
					clearInterval(_interval);
				}
				if(index%2 == 0){
					comp.cText.styleName = "ROLEINFOTEXTFORMAT";
				}else{
					comp.cText.styleName = "MONEYFLASH2";
				}
			}			
		}	
		
		private function onPackageInfoChange(evt:PackageInfoChangeEvent):void{
			//重新设置背包信息
			comp.setEquipInfo();
		}
		private function onMouseMove(evt:MouseEvent):void{
			//设置简短描述ToolTip位置
			setSmallDesPos();
		}
		//鼠标在魔钻上移动事件处理
		private function onDtextMouseOver(evt:MouseEvent):void{
			if(!iSmallDesToolTip){
				iSmallDesToolTip = ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			//设置简短描述信息
			iSmallDesToolTip.curDes = CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan')+"："+SystemDataModel.roleInfo.gold;
			comp.addElement(iSmallDesToolTip);
			//设置简短描述ToolTip位置
			setSmallDesPos();
		}
		//鼠标移出魔钻隐藏简短描述ToolTip
		private function onDtextMouseOut(evt:MouseEvent):void{
			if(iSmallDesToolTip){
				comp.removeElement(iSmallDesToolTip);
			}
		}
		//鼠标在金币上移动事件处理
		private function onCtextMouseOver(evt:MouseEvent):void{
			if(!iSmallDesToolTip){
				iSmallDesToolTip = ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			//设置简短描述信息
			iSmallDesToolTip.curDes = CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjW_jb')+"："+CommonTools.setMoneyCurrencyFormatter(SystemDataModel.roleInfo.coin);
			comp.addElement(iSmallDesToolTip);
			//设置简短描述ToolTip位置
			setSmallDesPos();
		}
		//鼠标移出金币隐藏简短描述ToolTip
		private function onCtextMouseOut(evt:MouseEvent):void{
			if(iSmallDesToolTip){
				comp.removeElement(iSmallDesToolTip);
			}
		}
		//设置简短描述ToolTip位置
		private function setSmallDesPos():void{
			if(iSmallDesToolTip){
				iSmallDesToolTip.x = comp.mouseX + 10;
				iSmallDesToolTip.y = comp.mouseY + 10;
			}
		}
		/**
		 * 上一页
		 */
		private function onPrePage(evt:MouseEvent):void{
			getEquipmentInfo(SystemDataModel.packageinfoVo.curPage - 1);
		}
		/**
		 * 下一页
		 */
		private function onNextPage(evt:MouseEvent):void{
			getEquipmentInfo(SystemDataModel.packageinfoVo.curPage + 1);
		}
		private function onItemClick(evt:ItemClickEvent):void{
			var cardValue:Object = comp.cardtype.selection.id;
			switch(cardValue){
				case "daoju":
					SystemDataModel.packageType = ProConst.COMMON_ITEM;
					break;
				case "renwu":
					SystemDataModel.packageType = ProConst.TASK_ITEM;
					break;
			}
			getEquipmentInfo();
		}
		/**
		 * 整理背包
		 */
		private function onBtnClick(evt:MouseEvent):void{
			var packArrQuest:packageArrangeRequest = new packageArrangeRequest();
			packArrQuest.id = SystemDataModel.roleId;
			packArrQuest.packageType = SystemDataModel.packageType;
			var arrByte:ByteArray = new ByteArray();
			packArrQuest.writeExternal(arrByte);
			socektServer.send(new mx.rpc.Responder(arrangeHandler,faultHandler),URLConst.ARRANGE_PACK_COMMANDID,arrByte);
		}
		/**
		 * 背包整理返回处理
		 */
		private function arrangeHandler(data:Object):void{
			var arrangeByte:ByteArray = data as ByteArray;
			var responseData:packageArrangeResponse = new packageArrangeResponse();
			responseData.readExternal(arrangeByte);
			if(responseData.result){
				getEquipmentInfo();
			}else{
				popUpShow.show(responseData.message);
			}
		}
		/**
		 *获取装备信息 
		 * @param page 获取page页的装备数据 默认是第一页
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
			//socektServer.send(new mx.rpc.Responder(itemInPackageResultHandler,faultHandler),URLConst.GET_ITEMINPACKAGE_COMMANDID,itemInPackageByteArray);
		}
		/**
		 *itemInPackageResultHandler 
		 */	
		private function itemInPackageResultHandler(data:Object):void{
			dispatch(new GetRoleItemInPackageResponseEvent(GetRoleItemInPackageResponseEvent.GETROLEITEMINPACKAGEVENT,data));
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
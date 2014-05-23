package sceneModule.view.shop.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.scene.scene204.getItemsInPackageRequest;
	import proto.shop.shop206.getNpcShopInfoRequest;
	import proto.shop.shop206.getNpcShopInfoResponse;
	import proto.shop.shop220.npcShopSellItemRequest;
	import proto.shop.shop220.npcShopSellItemResponse;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	import sceneModule.view.shop.view.NpcShopSellItemComponent;
	
	import service.ISocketServer;

	public class NpcShopSellItemComponentMediator extends Mediator
	{
		
		[Inject]
		public var comp:NpcShopSellItemComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function NpcShopSellItemComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.canBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.mapListener(comp.subBtn,MouseEvent.CLICK,onSubmit);
		}
		private function onSubmit(evt:MouseEvent):void{
			onCloseWindowAndRemoveListener();
			request_to_jimai(comp.data.position,SystemDataModel.packageinfoVo.curPage,comp.sellCount);
		}
		/**
		 * 出售物品
		 * @param itemId 物品id
		 * @param itemPos 物品所在背包栏的位置
		 */		
		private function request_to_jimai(itemPos:int,page:int=1,count:int=1):void{
			var msg:npcShopSellItemRequest = new npcShopSellItemRequest();
			msg.id = SystemDataModel.roleId;
			msg.itemPos = itemPos;
			msg.curpage = page;
			msg.sellCount = count;
			msg.packageType = SystemDataModel.packageType;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
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
				SceneModuleCommonMessage.getInstance().getNpcShopInfo(SystemDataModel.shopInfoVo.itemType,SystemDataModel.shopInfoVo.curPage);
				//获取背包信息
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				
			}else{
				popUpShow.show(msg.message);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
		/**
		 *获取装备信息 
		 */		
		private function getEquipmentInfo(page:int=1):void{
			//获取角色物品信息
			ShopMessage.getInstance().requese_package_info(page, SystemDataModel.packageType);
		}
		/**
		 *itemInPackageResultHandler 
		 */	
		private function itemInPackageResultHandler(data:Object):void{
			dispatch(new GetRoleItemInPackageResponseEvent(GetRoleItemInPackageResponseEvent.GETROLEITEMINPACKAGEVENT,data));
		}
		private function onCancel(evt:MouseEvent):void{
			onCloseWindowAndRemoveListener();
		}
		
		private function onCloseWindowAndRemoveListener():void{
			this.eventMap.unmapListener(comp.canBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.unmapListener(comp.subBtn,MouseEvent.CLICK,onSubmit);
			WindowManager.closeWindow(NpcShopSellItemComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer);
		}
	}
}
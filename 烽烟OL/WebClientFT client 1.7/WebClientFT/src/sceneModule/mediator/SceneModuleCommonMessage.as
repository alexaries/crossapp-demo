package sceneModule.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pack.pack215.splitItemsInPackRequest;
	import proto.pack.pack215.splitItemsInPackResponse;
	import proto.pack.pack216.dropItemsInPackRequest;
	import proto.pack.pack216.dropItemsInPackResponse;
	import proto.scene.scene203.getItemsInEquipSlotRequest;
	import proto.scene.scene210.equipEquipmentRequest;
	import proto.scene.scene210.equipEquipmentResponse;
	import proto.scene.scene211.unloadedEquipmentRequest;
	import proto.scene.scene211.unloadedEquipmentResponse;
	import proto.scene.scene212.moveItemRequest;
	import proto.scene.scene212.moveItemResponse;
	import proto.shop.shop206.getNpcShopInfoRequest;
	import proto.shop.shop206.getNpcShopInfoResponse;
	import proto.shop.shop219.npcShopBuyItemRequest;
	import proto.shop.shop219.npcShopBuyItemResponse;
	import proto.shop.shop220.npcShopSellItemRequest;
	import proto.shop.shop220.npcShopSellItemResponse;
	
	import sceneModule.event.GetRoleItemResponseEvent;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	
	import service.ISocketServer;

	public class SceneModuleCommonMessage extends Mediator
	{
		[Inject]
		public var socketServer:ISocketServer;
		
		private static var _instance:SceneModuleCommonMessage;
		
		public static function getInstance():SceneModuleCommonMessage{
			if(null == _instance){
				_instance = new SceneModuleCommonMessage();
			}
			return _instance;
		}
		public function SceneModuleCommonMessage()
		{
			super();
		}
		
		/**
		 * 穿装备
		 */
		public function onEquipEquipment(fromPos:int,toPos:int,page:int = 0):void{
			var equipRequest:equipEquipmentRequest = new equipEquipmentRequest();
			equipRequest.id = SystemDataModel.roleId;
			equipRequest.fromPosition = fromPos;
			equipRequest.toPosition = toPos;
			equipRequest.fromPackCategory = SystemDataModel.packageType;
			if(page == 0){
				equipRequest.curpage = SystemDataModel.packageinfoVo.curPage;
			}else{
				equipRequest.curpage = page;
			}
			
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
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
				getEquipmentInSlotInfo();
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ADD_EQUIP));
				if (1 == equipResponse.usetype) {
					//使用宠物蛋结果
					GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE,GuideInfo.ACTION_GET_PET));
				}
			}
		}
		/**
		 * 获取角色装备信息
		 */
		public function getEquipmentInSlotInfo():void{
			//获取角色装备信息
			var requestGetItem:getItemsInEquipSlotRequest = new getItemsInEquipSlotRequest();
			requestGetItem.id = SystemDataModel.roleId;
			var itemInfoByteArray:ByteArray = new ByteArray();
			requestGetItem.writeExternal(itemInfoByteArray);
			socketServer.send(new mx.rpc.Responder(itemResultHandler,faultHandler),URLConst.GET_ROLEITEM_COMMANDID,itemInfoByteArray);
			
		}
		
		/**卸载装备
		 * 
		 */
		public function unEquipEquipment(fromPos:int,toPos:int,page:int=1):void{
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
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
				getEquipmentInSlotInfo();
			}
		}
		/**
		 * 移动装备
		 */
		public function onMoveItem(fromPos:int,toPos:int):void{
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
					ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
				}
				
			}
		}
		/**
		 * 拆分装备
		 */
		public function onSplitItemSendCommand(fromPos:int,toPos:int,num:int,pType:int):void{
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
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
				getEquipmentInSlotInfo();
			}
		}
		
		/**
		 * itemResultHandler 
		 */		
		private function itemResultHandler(data:Object):void{
			this.dispatch(new GetRoleItemResponseEvent(GetRoleItemResponseEvent.GET_ROLEITEM_EVENT,data));
		}
		/**
		 * 获取商店信息
		 */
		public function getNpcShopInfo(shopCategory:int,page:int):void{
			var requestGetShopInfo:getNpcShopInfoRequest = new getNpcShopInfoRequest();
			requestGetShopInfo.id = SystemDataModel.roleId;
			requestGetShopInfo.npcId = SystemDataModel.tempId;
			requestGetShopInfo.shopCategory = shopCategory;
			requestGetShopInfo.curPage = page;
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
				this.dispatch(new GetShopInfoResponseEvent(GetShopInfoResponseEvent.GETSHOPINFORESPONSE,responseData.data,GetShopInfoResponseEvent.GETSHOPINFO));
			}
		}
		/**
		 * 丢弃物品
		 */
		public function onDropItem(pType:int,pos:int):void{
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
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
				getEquipmentInSlotInfo();
			}
		}
		
		/**
		 * 出售物品
		 * @param itemId 物品id
		 * @param itemPos 物品所在背包栏的位置
		 */		
		public function npcShopSellItem(itemId:int,itemPos:int,page:int=1,count:int=1):void{
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
				getNpcShopInfo(ProConst.NPCSHOP_SELL_SHOP,SystemDataModel.shopInfoVo.curPage);
				//获取背包信息
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
			}
		}
		//回购
		public function request_sell_item(itemid:int):void{
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
				getNpcShopInfo(ProConst.NPCSHOP_SELL_SHOP,SystemDataModel.shopInfoVo.curPage);
				//获取背包信息TODO
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
			}
		}
		//申请购买物品
		//type 操作类型 0购买1购回
		public function request_buy_item(itemid:int, num:int):void{
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
				getNpcShopInfo(ProConst.NPCSHOP_BUY_SHOP,SystemDataModel.shopInfoVo.curPage);
				//获取背包信息TODO
				ShopMessage.getInstance().requese_package_info(SystemDataModel.packageinfoVo.curPage, SystemDataModel.packageType);
			}
		}
		
		
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
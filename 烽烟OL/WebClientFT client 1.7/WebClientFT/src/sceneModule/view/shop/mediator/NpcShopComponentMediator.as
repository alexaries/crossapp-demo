package sceneModule.view.shop.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pack.pack216.dropItemsInPackRequest;
	import proto.pack.pack216.dropItemsInPackResponse;
	import proto.scene.scene203.getItemsInEquipSlotRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChangeWindowStateEvent;
	import sceneModule.event.MediatorRegisterItemEuipmentEvent;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.RegisterMediatorShopItemEvent;
	import sceneModule.view.shop.view.NpcShopComponent;
	import sceneModule.view.task.event.NTaskEvent;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;
	import util.xtrace;

	public class NpcShopComponentMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var npcShopComponent:NpcShopComponent;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function NpcShopComponentMediator()
		{
			super();
		}
		override public function preRegister():void{
			this.eventMap.mapListener(npcShopComponent,RegisterMediatorShopItemEvent.MEDIATORREGISTERSHOPITEM,onCreateMediator);
			
			this.eventMap.mapListener(npcShopComponent.closeWinBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(npcShopComponent.openStrBtn, MouseEvent.CLICK, onOpenStr);
			mediatorMap.createMediator(npcShopComponent.shopComp);
			mediatorMap.createMediator(npcShopComponent.equipGroup);
			mediatorMap.createMediator(npcShopComponent.taskComp);
			//			mediatorMap.createMediator(npcShopComponent.npc_task_view);
			
			npcShopComponent.addEventListener(MediatorRegisterItemEuipmentEvent.MEDIATORREGISTERCOMMISSIONITEMEUIPMENT, onRegisterMediatorItem);
			
			refresh_name();
			
			this.eventMap.mapListener(npcShopComponent,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(npcShopComponent,DragEvent.DRAG_DROP,onDragDrop);
		}
		
		private function onCreateMediator(evt:RegisterMediatorShopItemEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		//拖拽源来自Package
		private function onDragEnter(evt:DragEvent):void{
			if (evt.dragSource.hasFormat(MainMenuEquipmentItemRender.FROMPACKAGE)) //如果标号为format则接受拖来的物体
			{
				DragManager.acceptDragDrop(IUIComponent(evt.target)); // 接受被拖进来的物体       
			}
		}
		private var tempPos:int;
		private function onDragDrop(evt:DragEvent):void{
			var dropObj:Object = evt.dragSource.dataForFormat(MainMenuEquipmentItemRender.FROMPACKAGE);
			if(dropObj){
				var dropStr:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeCM_qddq');
				popUpShow.show(dropStr,null,null,null,null,submitDropHandler);
				tempPos = dropObj.position;
			}
		}
		private function submitDropHandler(evt:MouseEvent):void{
			onDropItem(SystemDataModel.packageType,tempPos);
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
			socketService.send(new mx.rpc.Responder(dropItemHandler,faultHandler),URLConst.DROP_ITEM_COMMANDID,dropByteArray);
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
			}else{
				popUpShow.show(dropResponse.message);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function refresh_name(e:Event = null):void {
			var func_type:int = SystemDataModel.opening_npc_type;
			var ico_id:String = null;
			var word_id:String = null;
			if (ProConst.DAOJUDIAN == func_type) {
				//道具店
				ico_id = "npc_ico_daoju";
				word_id = "npc_word_daoju";
			}
			else if (ProConst.FANGJUDIAN == func_type) {
				//防具店
				ico_id = "npc_ico_zhuangbei";
				word_id = "npc_word_zhuangbei";
			}
			else if (ProConst.WUQIDIAN == func_type) {
				//武器
				ico_id = "npc_ico_wuqi";
				word_id = "npc_word_wuqi";
			}
			
			if (null != ico_id && null != word_id) {
				CommonTools.make_bitmap(npcShopComponent.img_shop_ico).bitmapData = 
					AssetCenter.getInstance().get_img_form_pacakge('ui_npcshop', ico_id);
				CommonTools.make_bitmap(npcShopComponent.img_shop_title_word).bitmapData = 
					AssetCenter.getInstance().get_img_form_pacakge('ui_npcshop', word_id);
			}
			else {
				CommonTools.make_bitmap(npcShopComponent.img_shop_ico).bitmapData = null;
				CommonTools.make_bitmap(npcShopComponent.img_shop_title_word).bitmapData = null;
			}
			
		}
		
		private function onRegisterMediatorItem(evt:MediatorRegisterItemEuipmentEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		private function onOpenStr(evt:MouseEvent):void{
//			onCloseWindowFunc();
//			SystemDataModel.packType = MainStrengthenComponent.NAME;
//			AssetCenter.getInstance().load_package("ui_strengthen",to_strengthen,null,true,null,null,null,['ui_package','ui_npc_task']);
		}
		private function to_strengthen():void{
//			WindowManager.createWindow(MainStrengthenComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
//			this.dispatch(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK));
			
//			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QIANGHUA)]);
			//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QIANGHUA));
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			onCloseWindowFunc();
		}
		
		private function onCloseWindowFunc():void{
			WindowManager.closeWindow(NpcShopComponent.NAME,false,false,null,popUpWindowLayer);
		}
		
	}
}
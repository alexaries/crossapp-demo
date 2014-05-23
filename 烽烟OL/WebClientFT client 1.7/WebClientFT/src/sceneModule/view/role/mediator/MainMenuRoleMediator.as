package sceneModule.view.role.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
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
	import sceneModule.event.GetRoleItemResponseEvent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.role.event.NRoleEvent;
	import sceneModule.view.role.view.MainMenuRoleComponent;
	import sceneModule.view.shop.command.ShopMessage;
	
	import service.ISocketServer;
	
	public class MainMenuRoleMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var mainMenuRoleComp:MainMenuRoleComponent;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function MainMenuRoleMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.addContextListener(NRoleEvent.NRoleEvent_INFO_CHANGE, on_info_change, NRoleEvent);
			this.addContextListener(NRoleEvent.NRoleEvent_EQUIP_CHANGE, on_equip_change, NRoleEvent);
			
			this.eventMap.mapListener(mainMenuRoleComp,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(mainMenuRoleComp,DragEvent.DRAG_DROP,onDragDrop);
			
			this.eventMap.mapListener(mainMenuRoleComp.closeBtn,MouseEvent.CLICK,onCloseWin);
			
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo);
			mediatorMap.createMediator(mainMenuRoleComp.mainMenuEquipment);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_0);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_1);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_2);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_3);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_4);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_5);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_6);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_7);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_8);
			mediatorMap.createMediator(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_9);
			
		}
		
		override public function onRemove():void{
			this.eventMap.unmapListener(mainMenuRoleComp,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.unmapListener(mainMenuRoleComp,DragEvent.DRAG_DROP,onDragDrop);
			
			this.eventMap.unmapListener(mainMenuRoleComp.closeBtn,MouseEvent.CLICK,onCloseWin);
			
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.mainMenuEquipment);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_0);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_1);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_2);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_3);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_4);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_5);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_6);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_7);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_8);
			mediatorMap.removeMediatorByView(mainMenuRoleComp.comp_roleinfo.comp_role_style.comp_pos_9);
		}
		
		private function onCloseWin(evt:MouseEvent):void{
			WindowManager.closeWindow(MainMenuRoleComponent.NAME,false,false,null,popUpWindowLayer);
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
		
		private function on_info_change(e:NRoleEvent):void {
			mainMenuRoleComp.comp_roleinfo.data = SystemDataModel.roleInfo;
		}
		private function on_equip_change(e:NRoleEvent):void {
			mainMenuRoleComp.comp_roleinfo.equip_obj = SystemDataModel.peopleItemInfo;
		}
	}
}
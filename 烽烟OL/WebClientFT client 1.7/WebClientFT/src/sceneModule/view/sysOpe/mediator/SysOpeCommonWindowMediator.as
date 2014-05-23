package sceneModule.view.sysOpe.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pet.pet2300.GetPetListInfoRequest;
	
	import resource.AssetCenter;
	
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.view.announ.AddWindowEvent;
	import sceneModule.view.announ.AddWindowEventDispatcher;
	import sceneModule.view.blacksmith.view.MainStrFunctionComponent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.nmall.view.NMallView;
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.view.PetComponent;
	import sceneModule.view.role.view.MainMenuRoleComponent;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.sysOpe.view.SysOpeCommonWindow;
	import sceneModule.view.task.event.NTaskEvent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class SysOpeCommonWindowMediator extends Mediator
	{
		[Inject]
		public var comp:SysOpeCommonWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		public function SysOpeCommonWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.anBtn,MouseEvent.CLICK,onFunction);
		}
		
		private function onFunction(evt:MouseEvent):void{
			switch(comp._curObj.type){
				case 2:
					//强化
					onOpenBlacksmithWindow();
					break;
				case 3:
					//技能
					onOpenSkill();
					break;
				case 4:
					//技能
					onOpenSkill();
					break;
				case 5:
					//商城
					AssetCenter.getInstance().load_package('ui_mall', real_open_mall, null, true);
					break;
				case 6:
					//阵法
					getPetInfo();
					break;
				case 7:
					//背包
					SystemDataModel.packType = MainMenuRoleComponent.NAME;
					AssetCenter.getInstance().load_package('ui_mainMenu', real_open_role, null, true);
					break;
			}

			onCloseWindow();
		}
		private function real_open_role():void{
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			ShopMessage.getInstance().requese_package_info(1, SystemDataModel.packageType);
			SceneModuleCommonMessage.getInstance().getEquipmentInSlotInfo();
			WindowManager.createWindow(MainMenuRoleComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
		}
		private function getPetInfo():void{
			var getPetListReq:GetPetListInfoRequest = new GetPetListInfoRequest();
			getPetListReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getPetListReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(getPetListHandler,faultHandler),URLConst.PET_GETLISTINFO_COMMANDID,byteArray);
		}
		private function getPetListHandler(data:Object):void{
			AssetCenter.getInstance().load_package("ui_pet",to_pet,null,true);
			this.dispatch(new GetPetListInfoResponseEvent(GetPetListInfoResponseEvent.GETPETLISTINFO,data));
		}
		
		private function to_pet():void{
			WindowManager.createWindow(PetComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function real_open_mall():void {
			WindowManager.createWindow(NMallView.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onOpenSkill():void{
			var obj:Object = new Object();
			obj.type = 'newSkill';
			WindowManager.createWindow(MainMenuComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		/**
		 *打开铁匠铺 
		 */		
		private function onOpenBlacksmithWindow():void{
			AssetCenter.getInstance().load_package("ui_strengthen",to_blacksmith,null,true);
//			SystemDataModel.packType = MainStrengthenComponent.NAME;
//			AssetCenter.getInstance().load_package("ui_strengthen",to_strengthen,null,true,null,null,null,['ui_package','ui_npc_task']);
			
		}
		private function to_blacksmith():void{
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			SystemDataModel.curOpenWindowName = MainStrFunctionComponent.NAME
			WindowManager.createWindow(MainStrFunctionComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QIANGHUA)]);
			
//			WindowManager.createWindow(MainStrengthenComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			delete SystemDataModel.sysOpeDictionary[comp._curObj.type];
			comp.parent.removeChild(comp);
		}
		
		private function faultHandler(evt:MouseEvent):void{
			
		}
	}
}
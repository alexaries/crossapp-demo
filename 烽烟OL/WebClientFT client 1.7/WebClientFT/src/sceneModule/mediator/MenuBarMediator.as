package sceneModule.mediator {
	import wordscene.event.PlusEvent;
	import wordscene.WordSceneSprite;
	
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.BaseWindow;
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guaji.guaji3200.StartUpGuaJiRequest;
	import proto.guaji.guaji3200.StartUpGuaJiResponse;
	import proto.skill.skill801.GetSkillInfoRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChangeWindowStateEvent;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.announ.AddWindowEvent;
	import sceneModule.view.announ.AddWindowEventDispatcher;
	import sceneModule.view.battle.command.BattleAndCopySceneMessage;
	import sceneModule.view.blacksmith.view.MainStrFunctionComponent;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.NCropsRootView;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.friend.view.MainMenuFriendView;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.groupBattle.view.GroupBattleInfoComponent;
	import sceneModule.view.groupBattle.view.GroupCityComponent;
	import sceneModule.view.guanjue.view.GuanjueWindow;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.nmall.view.NMallView;
	import sceneModule.view.pet.view.PetComponent;
	import sceneModule.view.role.view.MainMenuRoleComponent;
	import sceneModule.view.sg.view.ShenDiWindow;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.view.MainMenuSkillComponent;
	import sceneModule.view.territory.view.AramWindow;
	import sceneModule.view.territory.view.LianjinWindow;
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.ui.MenuBar;
	import sceneModule.view.vip.view.VipWindow;
	import sceneModule.view.zhanxing.view.ZhanXingWindow;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;
	
	/**
	 * MenuBar Mediator
	 * @author Yaolx
	 *
	 */
	public class MenuBarMediator extends Mediator {
		[Inject]
		public var menuBar:MenuBar;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function MenuBarMediator() {
			super();
		}
		
		override public function onRegister():void {
			//退出副本
			this.eventMap.mapListener(menuBar.escSceneBtn, MouseEvent.CLICK, onEscScene);
			
			this.eventMap.mapListener(menuBar.zhanyiBtn, MouseEvent.CLICK, onZhanyiClick);
			this.eventMap.mapListener(menuBar.shopButtn, MouseEvent.CLICK, onMainShopClick);
			this.eventMap.mapListener(menuBar.personBtn, MouseEvent.CLICK, onPersonClick);
			this.eventMap.mapListener(menuBar.qianghuaBtn, MouseEvent.CLICK, onQianghuaClick);
			this.eventMap.mapListener(menuBar.petBtn, MouseEvent.CLICK, onOpenPet);
			this.eventMap.mapListener(menuBar.skillBtn, MouseEvent.CLICK, onSkillClick);
			this.eventMap.mapListener(menuBar.juntuanBtn, MouseEvent.CLICK, onJuntuanClick);
			this.eventMap.mapListener(menuBar.friendBtn, MouseEvent.CLICK, onfriendClick);
			//eventMap.mapListener(menuBar.vipBtn,MouseEvent.CLICK,onOpenVIP);
			eventMap.mapListener(menuBar.guajiBtn, MouseEvent.CLICK, setGuaJiFun);
			eventMap.mapListener(menuBar.territoryBtn, MouseEvent.CLICK, onInviteFriendsClick);
			this.eventMap.mapListener(menuBar.escBattleBtn, MouseEvent.CLICK, onEscBattle);
			socketService.send(new mx.rpc.Responder(vipHandler, faultHandler), URLConst.VIP_AUTO_OPEN_COMMANDID, null, false);
		}
		
		private function onZhanyiClick(e:MouseEvent):void {
			WordSceneSprite.getInstance().dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_OPEN_ZHANYI));
		}
		
		private function onEscBattle(evt:MouseEvent):void {
			menuBar.escBattleBtn.visible = false;
			WordSceneSprite.getInstance().fightSceneSp.forceOver();
		}
		
		/**
		 * 打开邀请好友界面
		 */
		private function onInviteFriendsClick(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(GuaJiConfimComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				if (SystemDataModel.curOpenWindowName == TerritoryWindow.NAME || SystemDataModel.curWindowParentName == TerritoryWindow.NAME) {
					//WindowManager.closeWindow(MainMenuInviteFriendsComponent.NAME,false,false,null,popUpWindowLayer);
					//WindowManager.closeWindow(TerritoryWindow.NAME,false,false,null,popUpWindowLayer);
					WindowManager.closeAllWindows();
				} else {
					SystemDataModel.curOpenWindowName = TerritoryWindow.NAME
					AssetCenter.getInstance().load_package("ui_territory", to_territory, null, true, null, null, null);
					//WindowManager.createWindow(MainMenuInviteFriendsComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
				}
			}
		}
		
		private function to_territory():void {
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(TerritoryWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
		}
		
		/**
		 * 挂机功能
		 */
		private function setGuaJiFun(evt:MouseEvent):void {
			var startGuaJiReq:StartUpGuaJiRequest = new StartUpGuaJiRequest();
			startGuaJiReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			startGuaJiReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(guajiHandler, faultHandler), URLConst.GUAJI_START_COMMANDID, byteArray);
		}
		
		private function guajiHandler(data:Object):void {
			var byteArray:ByteArray = data as ByteArray;
			var responseData:StartUpGuaJiResponse = new StartUpGuaJiResponse();
			responseData.readExternal(byteArray);
			if (responseData.result) {
				SystemDataModel.isGuaJiFlag = true;
			}
		}
		
		private function vipHandler(data:Object):void {
			onOpenVIP();
		}
		
		private function onOpenVIP(evt:MouseEvent = null):void {
			AssetCenter.getInstance().load_package("ui_vip", to_vip, null, true, null, null, null);
		}
		
		private function to_vip():void {
			WindowManager.createWindow(VipWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		private function onfriendClick(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(MainMenuFriendView.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				AssetCenter.getInstance().load_package("ui_friend", to_friend, null, true);
			}
		}
		
		private function to_friend():void {
			this.dispatch(new NFriendEvent(NFriendEvent.NFriendEvent_OPEN));
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(MainMenuFriendView.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		private function onJuntuanClick(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(NCropsRootView.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				AssetCenter.getInstance().load_package("ui_union", to_crop, null, true);
			}
		}
		
		private function to_crop():void {
			this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH));
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(NCropsRootView.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_JUNTUAN)]);
		
		}
		
		private function onSkillClick(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(MainMenuSkillComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				AssetCenter.getInstance().load_package("ui_skill", to_skill, null, true);
			}
		}
		
		private function to_skill():void {
			onGetSkillData();
			onGetRoleSkillData();
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(MainMenuSkillComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_SKILL)]);
		}
		
		/**
		 * 获取技能数据
		 */
		private function onGetSkillData():void {
			var skillRequest:GetSkillInfoRequest = new GetSkillInfoRequest();
			skillRequest.id = SystemDataModel.roleId;
			var skillByteArray:ByteArray = new ByteArray();
			skillRequest.writeExternal(skillByteArray);
			socketService.send(new mx.rpc.Responder(skillInfoHandler, faultHandler), URLConst.SKILL_GETINFO_COMMANDID, skillByteArray);
		}
		
		private function skillInfoHandler(data:Object):void {
			dispatch(new GetSkillInfoResponseEvent(GetSkillInfoResponseEvent.GETSKILLINFORESPONSE, data));
		}
		
		/**
		 * 获取技能数据
		 */
		private function onGetRoleSkillData():void {
			var skillRequest:GetSkillInfoRequest = new GetSkillInfoRequest();
			skillRequest.id = SystemDataModel.roleId;
			var skillByteArray:ByteArray = new ByteArray();
			skillRequest.writeExternal(skillByteArray);
			socketService.send(new mx.rpc.Responder(RoleSkillInfoHandler, faultHandler), URLConst.SKILL_ROLESELF_COMMANDID, skillByteArray);
		}
		
		private function RoleSkillInfoHandler(data:Object):void {
			dispatch(new GetBattleSkillInfoResponseEvent(GetBattleSkillInfoResponseEvent.GETBATTLESKILLINFORESPONSE, data));
		}
		
		private function onOpenPet(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(GuaJiConfimComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				AssetCenter.getInstance().load_package("ui_pet", to_pet, null, true);
			}
		}
		
		private function to_pet():void {
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(PetComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_PET)]);
		}
		
		private function onQianghuaClick(evt:MouseEvent):void {
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(GuaJiConfimComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				if (!CommonTools.delayClick())
					return;
				if (SystemDataModel.roleInfo.level < 2) {
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith', 'msfCM_djbz2'));
					return;
				}
				AssetCenter.getInstance().load_package("ui_strengthen", to_blacksmith, null, true);
			}
		}
		
		private function to_blacksmith():void {
			if (SystemDataModel.curOpenWindowName == MainStrFunctionComponent.NAME) {
				WindowManager.closeWindow(MainStrFunctionComponent.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer);
			} else {
				AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
				SystemDataModel.curOpenWindowName = MainStrFunctionComponent.NAME
				WindowManager.createWindow(MainStrFunctionComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QIANGHUA)]);
			}
		}
		
		private function onMainShopClick(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				WindowManager.createWindow(GuaJiConfimComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				if (SystemDataModel.curOpenWindowName == NMallView.NAME) {
					WindowManager.closeWindow(NMallView.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer);
				} else {
					AssetCenter.getInstance().load_package('ui_mall', real_open_mall, null, true);
				}
			}
		}
		
		private function onPersonClick(evt:MouseEvent):void {
			SystemDataModel.packType = MainMenuRoleComponent.NAME;
			if (!CommonTools.delayClick())
				return;
			if (SystemDataModel.isGuaJiFlag) {
				//获取角色物品信息
				ShopMessage.getInstance().requese_package_info(1, ProConst.COMMON_ITEM);
				SceneModuleCommonMessage.getInstance().getEquipmentInSlotInfo();
				WindowManager.createWindow(MainMenuRoleComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else {
				if (SystemDataModel.curOpenWindowName == MainMenuRoleComponent.NAME) {
					WindowManager.closeWindow(MainMenuRoleComponent.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer);
				} else {
					AssetCenter.getInstance().load_package('ui_mainMenu', real_open_role, null, true);
				}
			}
		}
		
		private function real_open_role():void {
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			ShopMessage.getInstance().requese_package_info(1, SystemDataModel.packageType);
			SceneModuleCommonMessage.getInstance().getEquipmentInSlotInfo();
			WindowManager.createWindow(MainMenuRoleComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
		}
		
		private function real_open_mall():void {
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(NMallView.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		public function faultHandler(evt:FaultEvent):void {
		
		}
		
		/**
		 * 退出副本
		 */
		private function onEscScene(evt:MouseEvent):void {
			BattleAndCopySceneMessage.getInstance().onEscCopyScene();
		}
	}
}
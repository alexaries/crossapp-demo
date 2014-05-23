 package sceneModule.mediator
{
	import Animation.AnimationOnceManager;
	import proto.battle.battle720.FightPkRequest;
	import proto.battle.battle720.FightPkResponse;
	import proto.zhanyi.GetNowZhanYiInfo4500.GetNowZhanYiInfoRequest;
	import proto.zhanyi.GetNowZhanYiInfo4500.GetNowZhanYiInfoResponse;
	import sceneModule.view.zhanyi.model.ZhanyiModel;
	import sceneModule.view.zhanyi.view.ZhanyiView;
	import util.AppVersion;
	import util.Logging;
	import wordscene.event.PlusEvent;
	import wordscene.loader.SAssetManager;
	import wordscene.WordSceneSprite;
	
	
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	import event.KeyFuncEvent;
	import event.SceneInitCompleteEvent;
	import event.SceneInitCompleteManager;
	import event.SwitchMaskEvent;
	import event.UILoadEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import loader.ProgressBarControl;
	import loader.UILoaderProgressBarView;
	
	import logonModule.command.LoginMessage;
	import logonModule.event.NLoginEvent;
	
	import managers.KeyBordManager;
	import managers.SoundConst;
	import managers.SoundManager;
	import managers.ToolTipManager;
	import managers.UILayerManager;
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SceneData;
	import model.ServerConfig;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.events.ResizeEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle703.FightRequest;
	import proto.battle.battle703.FightResponse;
	import proto.battle.battle704.quitFightRequest;
	import proto.battle.battle704.quitFightResponse;
	import proto.battle.battle705.getAllCardInfoRequest;
	import proto.battle.battle713.EscColonizationBattleRequest;
	import proto.chat.chat1003.itemLinkData;
	import proto.chat.chat1010.ChatToObjectListResponse;
	import proto.copyScene.copyScene1501.enterInstanceRequest;
	import proto.copyScene.copyScene1501.enterInstanceResponse;
	import proto.copyScene.copyScene1502.escInstanceRequest;
	import proto.copyScene.copyScene1502.escInstanceResponse;
	import proto.copyScene.copyScene1503.instanceTeamResponse;
	import proto.copyScene.copyScene1504.teamInstanceRequest;
	import proto.copyScene.copyScene1504.teamInstanceResponse;
	import proto.copyScene.copyScene1506.instanceActivateRequest;
	import proto.copyScene.copyScene1506.instanceActivateResponse;
	import proto.copyScene.copyScene1506.item;
	import proto.copyScene.copyScene1507.GetCopySceneInfoRequest;
	import proto.copyScene.copyScene1507.GetCopySceneInfoResponse;
	import proto.friends.friends302.getPlayerFrindsRequest;
	import proto.friends.friends302.getPlayerFrindsResponse;
	import proto.group.group901.pushInvitedGroupRequest;
	import proto.group.group903.agreeGroupRequest;
	import proto.group.group903.agreeGroupResponse;
	import proto.group.group904.rejectGroupRequest;
	import proto.groupHall.groupHall1806.GetRoleOfRoomInfoResponse;
	import proto.groupHall.groupHall1806.RoleOfRoomInfo;
	import proto.groupHall.groupHall1810.InviteJoinGroupMsg;
	import proto.groupHall.groupHall1811.InviteJoinGroupAcceptRequest;
	import proto.groupHall.groupHall1811.InviteJoinGroupAcceptResponse;
	import proto.groupHall.groupHall1812.InviteJoinGroupRefuseRequest;
	import proto.guaji.guaji3200.StartUpGuaJiRequest;
	import proto.guaji.guaji3200.StartUpGuaJiResponse;
	import proto.mail.mail504.mailArrived;
	import proto.pack.pack216.dropItemsInPackRequest;
	import proto.pack.pack216.dropItemsInPackResponse;
	import proto.pet.pet2300.GetPetListInfoRequest;
	import proto.resur.resur1705.pushAskForRevive;
	import proto.resur.resur1706.ReviveTeamMemberRequest;
	import proto.resur.resur1706.ReviveTeamMemberResponse;
	import proto.role.role218.pushCharacterLevelMessage;
	import proto.scene.getPlayerInfo.getPlayerInfoRequest;
	import proto.scene.scene203.getItemsInEquipSlotRequest;
	import proto.scene.scene222.GetBuffListInfoResponse;
	import proto.scene.scene2600.SceneLoadCompleteRequest;
	import proto.scene.scene602.characterPosition;
	import proto.scene.scene602.pushSceneMessage;
	import proto.scene.scene603.moveInSceneRequest;
	import proto.scene.scene604.removePlayerInMap;
	import proto.scene.scene605.EnterSceneMessage;
	import proto.shop.shop206.ShopInfo;
	import proto.shop.shop206.getNpcShopInfoResponse;
	import proto.skill.skill801.GetSkillInfoRequest;
	import proto.task.task1401.Quest;
	import proto.task.task1401.getQuestListOnNpcRequest;
	import proto.task.task1401.getQuestListOnNpcResponse;
	import proto.task.task1403.commitQuestRequest;
	import proto.task.task1403.commitQuestResponse;
	import proto.task.task1407.Quest;
	import proto.task.task1407.getCanReceivedquestListResponse;
	import proto.task.task1408.getScenceNpcQuestStatusRequest;
	import proto.task.task1408.getScenceNpcQuestStatusResponse;
	
	import resource.AssetCenter;
	import resource.AssetItemInfo;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChatEquipmentEvent;
	import sceneModule.event.EnterBattlePlaceResponseEvent;
	import sceneModule.event.GetRoleInfoResponseEvent;
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.event.GetRoleItemResponseEvent;
	import sceneModule.event.MainMenuChangeToWriteMailComponentEvent;
	import sceneModule.event.NSceneEvent;
	import sceneModule.event.SceneLoadedAndShowSceneNameEvent;
	import sceneModule.event.TeamMemberInfoResponseEvent;
	import sceneModule.model.SceneMessage;
	import sceneModule.model.rvo.RNpcVo;
	import sceneModule.model.rvo.RSwitchVo;
	import sceneModule.model.vo.buffVO.BuffInfoVO;
	import sceneModule.model.vo.groupVo.RoomRoleListRoleInfoVo;
	import sceneModule.model.vo.taskVO.TaskInfoVo;
	import sceneModule.rcommand.revent.RBattleRoundEvent;
	import sceneModule.rcommand.revent.RCharacterEvent;
	import sceneModule.rcommand.revent.RLoadEvent;
	import sceneModule.rcommand.revent.RMonsterEvent;
	import sceneModule.rcommand.revent.RMousePosEvent;
	import sceneModule.rcommand.revent.RNpcEvent;
	import sceneModule.rcommand.revent.RSceneEvent;
	import sceneModule.rcommand.revent.RSwitchBattleEvent;
	import sceneModule.rcommand.revent.RSwitchEvent;
	import sceneModule.rresource.RCharacterConst;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.GM.view.GMcomponent;
	import sceneModule.view.ScenePageView;
	import sceneModule.view.announ.AddWindowEvent;
	import sceneModule.view.announ.AddWindowEventDispatcher;
	import sceneModule.view.battle.command.BattleAndCopySceneMessage;
	import sceneModule.view.battle.event.BattleFlipEvent;
	import sceneModule.view.battle.event.BattleOverGetItemInfoResponseEvent;
	import sceneModule.view.battle.view.BattleColonizationFailWindow;
	import sceneModule.view.battle.view.BattleColonizationWindow;
	import sceneModule.view.battle.view.BattleFailSettlementWindow;
	import sceneModule.view.battle.view.BattleFlipComponent;
	import sceneModule.view.battle.view.BattleSuccessSettlementWindow;
	import sceneModule.view.blacksmith.view.MainStrFunctionComponent;
	import sceneModule.view.calendar.view.CalendarInfoComponent;
	import sceneModule.view.chat.event.ChatToObjectListEvent;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.chat.view.MainOneToOneChatWindow;
	import sceneModule.view.chat.vo.WhisperChatObjectInfoVO;
	import sceneModule.view.colonMan.command.ColonManMessage;
	import sceneModule.view.colonMan.view.MainColoPrivilegeWindow;
	import sceneModule.view.copyScene.mediator.NCopySceneChoseMediator;
	import sceneModule.view.copyScene.model.FuBenItemVo;
	import sceneModule.view.copyScene.model.FubenChoseItemVo;
	import sceneModule.view.copyScene.view.NCopySceneChoseView;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.CorpsInfoComponent;
	import sceneModule.view.corps.view.NCropsRootView;
	import sceneModule.view.friend.command.FriendMessage;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.friend.model.vo.FriendInfoVo;
	import sceneModule.view.friend.view.MainMenuFriendView;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.groupBattle.view.GroupCityComponent;
	import sceneModule.view.jingji.command.JingJiMessage;
	import sceneModule.view.jingji.event.JingJiBattleEvent;
	import sceneModule.view.jingji.view.JingJiBattleJieSuanWindow;
	import sceneModule.view.mail.event.MainMenuMailComponentCreateCompleteEvent;
	import sceneModule.view.mail.event.MediatorRegisterMainEvent;
	import sceneModule.view.mail.event.NMailEvent;
	import sceneModule.view.mail.view.MainMenuMailComponent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.nmall.view.NMallView;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.pata.view.PanPaWindow;
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.view.MainPetViewInfoComponent;
	import sceneModule.view.pet.view.PetComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.pray.view.PrayWindow;
	import sceneModule.view.ranking.event.MediatorRegisterRankingEvent;
	import sceneModule.view.ranking.view.MainMenuRankingComponent;
	import sceneModule.view.reward.view.RewardNewGuideWindow;
	import sceneModule.view.role.view.MainMenuRoleComponent;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.view.NpcShopComponent;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.view.MainMenuSkillComponent;
	import sceneModule.view.target.view.TargetTaskWindow;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.TaskTrackingEvent;
	import sceneModule.view.task.view.MainTaskComponent;
	import sceneModule.view.task.view.TaskListComponent;
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.ui.GuideWindowLayer;
	import sceneModule.view.ui.event.NMainUIEvent;
	import sceneModule.view.ui.event.PopUpGuideLayerEvent;
	import sceneModule.view.vip.view.VipWindow;
	import sceneModule.view.wordmap.model.MapConfig;
	import sceneModule.view.wordmap.view.SceneMapView;
	
	import service.IChatSocketServer;
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;
	import util.ObjectToString;
	import util.xtrace;




	/**
	 * ScenePageMediator
	 * @author Yaolx
	 * 
	 */    
	public class ScenePageMediator extends Mediator
	{
		[Inject]
		public var applicationScene:Sprite;				
		
		[Inject]		
		public var scenePageView:ScenePageView;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var chatService:IChatSocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var chatSocketService:IChatSocketServer;
		
		[Inject]
		public var serverConfig:ServerConfig;
		
		[Inject]
		public var progressBar:ProgressBarControl;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		//定时向服务器发送玩家坐标的Timer
		private var timer:Timer;
		//向服务器发送玩家坐标的时间间隔
		private static const PERTIME:Number = 200;
		
		private const ROLEIDRANGE:int = 1000000;
		
		//npc商店
		private var npcShopComp:NpcShopComponent;
		
		
		public function ScenePageMediator()
		{
			super();
		}
		override public function onRegister():void {
			Logging.stor("ui", this);
			
			//告诉服务器场景模块加载完毕，可以开始进行消息的推送
			sendS_MtoServer();
			
			//监听鼠标点击场景事件
			//todo wordscene
			//eventMap.mapListener(scenePageView.sceneLayer,MouseEvent.CLICK,onSceneMouseClick);
			eventMap.mapListener(scenePageView.chatWin.iTextArea,MouseEvent.CLICK,onSceneMouseClick);
			//todo wordscene
			//eventMap.mapListener(scenePageView.sceneLayer,MouseEvent.MOUSE_MOVE,onMouseMoveInSceneLayer);
			
			//监听切换场景事件
			WordSceneSprite.getInstance().addEventListener(RSwitchEvent.SWITCH_EVENT,onSwitchScene);			
			//监听战斗开始事件
			WordSceneSprite.getInstance().addEventListener(RMonsterEvent.NORMAL_MONSTER_EVENT,onMonsterBattle);			
			//添加鼠标点击NPC事件
			WordSceneSprite.getInstance().addEventListener(RMousePosEvent.MOUSE_SELECTED_EVENT,onMouseClickNpc);			
			WordSceneSprite.getInstance().addEventListener(RCharacterEvent.CHAT_WITH_NPC_EVENT, onChatWithNpcAndAddWindow);
			//隐藏其他玩家信息
			WordSceneSprite.getInstance().addEventListener(PlusEvent.PlusEvent_HIDE_PLAYER_INFO, clearPlayerInfo);
			//监听战斗结束事件
			WordSceneSprite.getInstance().addEventListener(RBattleRoundEvent.ALL_ROUND_OVER_EVENT,onBattleOver);
			//监听场景内资源加载进度事件
			SAssetManager.getInstance().addEventListener(RLoadEvent.PERCENT_LOADED_EVENT,rLoadEventHandler);
			//监听战斗资源加载进度事件
			eventMap.mapListener(applicationScene,RLoadEvent.PERCENT_BATTLE_LOADED_EVENT,rLoadEventHandler);
			//监听战斗资源加载完成事件
			eventMap.mapListener(applicationScene,RLoadEvent.BATTLE_LOADED_EVENT,onBattleResLoaded);
			//场景初始化完成
			WordSceneSprite.getInstance().addEventListener(RSceneEvent.SCENE_INIT_COMPLETED_EVENT, onSceneComplete);
			//请求退出战斗
			WordSceneSprite.getInstance().addEventListener(PlusEvent.PlusEvent_EXIT_FIGHT, sendQuitBattle);
			//请求pk
			WordSceneSprite.getInstance().addEventListener(PlusEvent.PlusEvent_SCENE_PK, onPkOther);
			
			
			//监听战斗资源加载完毕事件
			eventMap.mapListener(applicationScene,RSwitchBattleEvent.SWITCH_BATTLE_EVENT,onSwitchBattle);			
			//战斗监听
//			eventMap.mapListener(scenePageView.scene,MonsterEvent.NORMAL_MONSTER_EVENT,monsterHandler);
			//监听战斗血量变化事件
			//eventMap.mapListener(applicationScene,BattleChangeHpEvent.BATTLE_CHANGE_HP_MP_EVENT,onBattleChangeHp);
			//监听主菜单状态切换
			this.addContextListener(MainMenuChangeToWriteMailComponentEvent.MAINMENUCHANGETOWRITEMAIL,onChangeMainMenu);
			//同步场景信息 1.自己信息同步给服务器2.场景信息同步
			syncSceneInfo();
			//添加服务器返回的队伍信息
			addGroupInfo();
			//添加邀请组队事件监听
			addEventInvitedGroup();
			//添加角色信息改变事件
			addRoleInfoChange();
			//添加有新邮件通知监听
			addHaveNewMail();
			//添加任务追踪信息监听
			addTaskEventListener();
			//添加其他队员死亡索取复活
			addOtherRoleRequestResur();
			//添加服务器切换场景指令 被动切换
			addChangeSceneEventListener();
			//监听升级指令
			addLevelUpInfo();
			//监听进入战斗指令
			addEventListenerEnterBattle();
			//监听进入副本指令
			addEventListererEnterCopyScene();
			//监听NPC状态变化
			addEventListenerNPCState();
			//获取角色信息
			getPlayerInfo();
			//队伍房间信息
			addRoomRoleListListener();
			//监听邀请加入房间请求
			addInviteJoinRoomListener();
			//监听可接任务列表信息
			addEventListenerCanAcceptTaskList();
			//监听服务器推送的Buff特效
			addEventListenerBuffListInfo();
			
			//添加打开地图监听
			KeyBordManager.getInstance().addEventListener(KeyFuncEvent.KeyFuncEvent_MAP_CHANGE, change_map);
			
			//监听打开私聊窗口事件
			addEventlistenerOpenWhisperWindow();
			
			//添加服务器推送过的最近联系人列表信息
			addNearChatList();
			//新邮件通知
			addNewMailShow();
			
			//拖拽监听
			addDragEnterOtherListener();
			//添加场景玩家移除事件
			addRemovePlayerFromPlace();
			//获取黑名单
			getBlackName();
			
			WordSceneSprite.getInstance().addEventListener(BattleFlipEvent.BATTLEFLIPEVENT,onBattleFlipHandler);
			
			
			//显示UI进度条
			AssetCenter.getInstance().addEventListener(UILoadEvent.UILoadEvent_SHOW, show_ui_load);
			//隐藏UI进度条
			AssetCenter.getInstance().addEventListener(UILoadEvent.UILoadEvent_HIDE, hide_ui_load);
			
			//npc创建完成
			WordSceneSprite.getInstance().addEventListener(RNpcEvent.ALL_NPC_CREATED_EVENT, getNpcStatuInfo);
			
			//注册场景实体信息刷新广播
			socketService.send(new Responder(resultHandler,faultHandler),URLConst.MOVE_INSCENE_COMMANDID, null, false);
			//主控角色移动
			SceneMessage.getInstance().addEventListener(NSceneEvent.NSceneEvent_HEARO_MOVE, on_hero_move);
			
			//注册云层视图
			//UILayerManager.getInstance().sky_layer = viewComponent.skyUIComp;
			
			WordSceneSprite.getInstance().addEventListener(PlusEvent.PlusEvent_OPEN_PATA, onPanPa);
			
			this.scenePageView.addEventListener(ResizeEvent.RESIZE,onResize);
			
			LoginMessage.getInstance().addEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER, close_con2server_alert);
			
			this.eventMap.mapListener(scenePageView.newMailBtn,MouseEvent.CLICK,onNewMail);
			
			this.eventMap.mapListener(scenePageView.openColoBtn,MouseEvent.CLICK,onOpenColo);
			this.eventMap.mapListener(scenePageView.openTargetBtn,MouseEvent.CLICK,onTarget);
			this.eventMap.mapListener(scenePageView.newRewardBtn,MouseEvent.CLICK,onNewReward);
			this.eventMap.mapListener(scenePageView.calendarBtn,MouseEvent.CLICK,onOpenCalendar);
			
			this.eventMap.mapListener(scenePageView.gmBtn,MouseEvent.CLICK,onOpenGMHandler);
			
			this.eventMap.mapListener(scenePageView.qidaoBtn,MouseEvent.CLICK,onQiDaoHandler);
			
			setWebTitle();
			
			addJingJi();
			
			TaskMessage.getInstance().addEventListener(PopUpGuideLayerEvent.POPUPGUIDELAYEREVENT,onOpenGuideLayer);
			
			this.eventMap.mapListener(scenePageView.openPanPaBtn,MouseEvent.CLICK,onPanPa);
			this.eventMap.mapListener(scenePageView.qidaoBtn,MouseEvent.CLICK,onQiDaoHandler);
			
			this.eventMap.mapListener(scenePageView.paihangBtn,MouseEvent.CLICK,onPaihangClick);
			this.eventMap.mapListener(scenePageView.youjianBtn,MouseEvent.CLICK,onyoujianClick);
			
			this.eventMap.mapListener(scenePageView.paihangBtn,MouseEvent.MOUSE_OVER,onPaihangMouseOver);
			this.eventMap.mapListener(scenePageView.paihangBtn,MouseEvent.MOUSE_OUT,onPaihangMouseOut);
			
			this.eventMap.mapListener(scenePageView.youjianBtn,MouseEvent.MOUSE_OVER,onyoujianMouseOver);
			this.eventMap.mapListener(scenePageView.youjianBtn,MouseEvent.MOUSE_OUT,onyoujianMouseOut);
			
			eventMap.mapListener(scenePageView.ldBtn, MouseEvent.CLICK, onOpenLingDi);
			
			WordSceneSprite.getInstance().addEventListener(PlusEvent.PlusEvent_OPEN_ZHANYI, showZhanyi);
		}
		
		private function onOpenLingDi(evt:MouseEvent):void{
			AssetCenter.getInstance().load_package("ui_lingdi",to_lingdi,null,true,null,null,null);
		}
		
		private function to_lingdi():void{
			WindowManager.createWindow(GroupCityComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private var tips:MainSmallDesTooltip;
		private function onPaihangMouseOver(evt:MouseEvent):void{
			if (!tips)
			{
				tips=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
				tips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui_main_game','umg_ph');
			
			scenePageView.addElement(tips);
			tips.x = scenePageView.mouseX - tips.width - 5;
			tips.y = scenePageView.mouseY;
		}
		
		private function onPaihangMouseOut(evt:MouseEvent):void{
			if (tips)
			{
				scenePageView.removeElement(tips);
			}
		}
		
		
		private function onyoujianMouseOver(evt:MouseEvent):void{
			if (!tips)
			{
				tips=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			tips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui_main_game','umg_yj');
			
			scenePageView.addElement(tips);
			tips.x = scenePageView.mouseX - tips.width - 5;
			tips.y = scenePageView.mouseY;
		}
		
		private function onyoujianMouseOut(evt:MouseEvent):void{
			if (tips)
			{
				scenePageView.removeElement(tips);
			}
		}
		
		private function onyoujianClick(evt:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(MainMenuMailComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				AssetCenter.getInstance().load_package("ui_mail", to_mail, null, true);
			}
		}
		
		private function to_mail():void{
//			this.dispatch(new MediatorRegisterRankingEvent(MediatorRegisterRankingEvent.MEDIATORREGISTERRANKING,this,true));
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.ADDWINDOWEVENT));
			
			this.dispatch(new MediatorRegisterMainEvent(MediatorRegisterMainEvent.MR_MAIL_COMP,this,true));
			
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(MainMenuMailComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onPaihangClick(evt:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(MainMenuRankingComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				AssetCenter.getInstance().load_package("ui_ranking", to_rank, null, true);
			}
		}
		
		private function to_rank():void{
			this.dispatch(new MediatorRegisterRankingEvent(MediatorRegisterRankingEvent.MEDIATORREGISTERRANKING,this,true));
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(MainMenuRankingComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onPanPa(evt:Event = null):void{
//			this.dispatch(new SceneLoadedAndShowSceneNameEvent(SceneLoadedAndShowSceneNameEvent.SCENELOADEDANDSHOWSCENENAME,SystemDataModel.placeResId));
//			return;
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				if(!CommonTools.delayClick())return;
				if(SystemDataModel.roleInfo.level<30){
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz30'));
					return;
				}
				var t_arr:Array = [];
				
				var std_swf:AssetItemInfo = new AssetItemInfo();
				std_swf.package_id = 'word_map';
				std_swf.id = 'word_map_std';
				std_swf.type = AssetItemInfo.AssetItemInfo_TYPE_SWF;
				std_swf.path = getJobImg(SystemDataModel.roleInfo.profession) + "_stand.swf";
				
				var move_swf:AssetItemInfo = new AssetItemInfo();
				move_swf.package_id = 'word_map';
				move_swf.id = 'word_map_move';
				move_swf.type = AssetItemInfo.AssetItemInfo_TYPE_SWF;
				move_swf.path = getJobImg(SystemDataModel.roleInfo.profession) + ".swf";
				
				var movel_swf:AssetItemInfo = new AssetItemInfo();
				movel_swf.package_id = 'word_map';
				movel_swf.id = 'word_map_move_l';
				movel_swf.type = AssetItemInfo.AssetItemInfo_TYPE_SWF;
				movel_swf.path = getJobImg(SystemDataModel.roleInfo.profession) + "_walk_L.swf";
				
				t_arr.push(std_swf);
				t_arr.push(move_swf);
				t_arr.push(movel_swf);
				AssetCenter.getInstance().load_package("ui_pata",to_keluota, null, true,null,null,t_arr);
			}
			
		}
		public function getJobImg(profession:int):String{
			var r:String = null;
			switch (profession) 
			{
				case 1:
					r = "assets/word_map/ZS";
					break;
				case 2:
					r = "assets/word_map/FS";
					break;
				case 3:
					r = "assets/word_map/YX";
					break;
				case 4:
					r = "assets/word_map/ZSO";
					break;
				case 5:
					r = "assets/word_map/FSO";
					break;
				case 6:
					r = "assets/word_map/YXO";
					break;
				
				default:
					r = null;
			}
			return r;
		}
		
		private function to_keluota():void{
			WindowManager.createWindow(PanPaWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private var tempTaskId:int;
		private function onOpenGuideLayer(evt:PopUpGuideLayerEvent):void{
			tempTaskId = evt.taskId;
			AssetCenter.getInstance().load_package(("ui_yd_"+evt.taskId),to_yd_ui,null,true,null,null,null);
		}
		
		private function to_yd_ui():void{
			var obj:Object = new Object();
			obj.tempTaskId = tempTaskId;
			WindowManager.createWindow(GuideWindowLayer.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function addJingJi():void{
			JingJiMessage.getInstance().getCDTime();
			JingJiMessage.getInstance().event_dispatcher.addEventListener(JingJiBattleEvent.JINGJIBATTLE,onBattleJingJi);
		}
		private var tempRoleId:int;
		private function onBattleJingJi(evt:JingJiBattleEvent):void{
			tempRoleId = evt.obj;
			if(SystemDataModel.mainJingJiInfoVo.CDTime > 0){
				var zuan:int = SystemDataModel.mainJingJiInfoVo.CDTime/60;
				if(SystemDataModel.mainJingJiInfoVo.CDTime%60>0){
					zuan += 1;
				}
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('jingji','jjp_sfsy')+zuan+CrotaResourceConfig.getInstance().getTextByModuleAndId('jingji','jjp_zxh'), null, null, null, null, cleanCDhandler,null,null);
			}else{
				JingJiMessage.getInstance().jingjiBattle(evt.obj);
			}
		}
		
		private function cleanCDhandler(evt:MouseEvent):void{
			JingJiMessage.getInstance().cleanCD(tempRoleId);
		}
		
		private function onOpenGMHandler(event:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			WindowManager.createWindow(GMcomponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onQiDaoHandler(event:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				AssetCenter.getInstance().load_package("ui_pray",openPray,null,true);
			}
		}
		
		private function openPray():void
		{
			WindowManager.createWindow(PrayWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		//重新设置浏览器标题
		private function setWebTitle():void{
			return;
			if(ExternalInterface.available){
				try {
					ExternalInterface.call("setWebTitle");
				} catch(e:Error) {
					trace(e)
				}
			}
		}
		
		private function onNewReward(evt:MouseEvent):void{
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				if(!CommonTools.delayClick())return;
				AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
				WindowManager.createWindow(RewardNewGuideWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}
		}
		
		private function onOpenCalendar(evt:MouseEvent):void{
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				if(!CommonTools.delayClick())return;
				if(SystemDataModel.roleInfo.level<14){
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz14'));
					return;
				}
				AssetCenter.getInstance().load_package("ui_calendar",to_calendar,null,true);
			}
			
		}
		
		private function to_calendar():void{
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(CalendarInfoComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onOpenColo(evt:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				ColonManMessage.getInstance().getColoPrivilegeData(1,getDataFun);
			}
		}
		
		private function onTarget(evt:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				AssetCenter.getInstance().load_package("ui_targetTask",to_targetTask,null,true);
			}
		}
		
		private function getDataFun():void{
			AssetCenter.getInstance().load_package("ui_coloMan_TeQuan",to_coloMan,null,true);
		}
		
		private function to_targetTask():void{
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(TargetTaskWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function to_coloMan():void{
			AddWindowEventDispatcher.getInstance().dispatchEvent(new AddWindowEvent(AddWindowEvent.PREADDWINDOWEVENT));
			WindowManager.createWindow(MainColoPrivilegeWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
		}
		
		private function onNewMail(evt:MouseEvent):void{
			if(!CommonTools.delayClick())return;
			SystemDataModel.newMailFlag = false;
			var obj:Object = new Object();
			obj.type = 'newMail';
			this.dispatch(new Event("open_mail"));
			WindowManager.createWindow(MainMenuComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function sendS_MtoServer():void{
			var sceneLoadReq:SceneLoadCompleteRequest = new SceneLoadCompleteRequest();
			sceneLoadReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			sceneLoadReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(serverLoadHandler,faultHandler),URLConst.SCENEMODULE_LOADED_TO_SERVER,byteArray);
		}
		private function serverLoadHandler(data:Object):void{
			
		}
		
		private function close_con2server_alert(evt:NLoginEvent):void{
		}
		/**
		 * 写邮件时的窗口跳转控制
		 * @evt 
		 */		
		private var tempRoleName:String;
		private function onChangeMainMenu(evt:MainMenuChangeToWriteMailComponentEvent):void{
//			if(!mainMenuFlag){
//				onOpenMainMenuComp();
//			}
//			tempRoleName = evt.obj.roleName;
//			scenePageView.mainMenuComponent.cardtype.selectedValue = "mailBtn";
//			scenePageView.mainMenuComponent.viewStack.selectedIndex = 4;
//			if(scenePageView.mainMenuComponent.mainMailComp){
//				setWriteMailContent();
//			}else{
//				this.addContextListener(MainMenuMailComponentCreateCompleteEvent.MAINMENUMAILCOMPONENTCREATECOMPLETE,onMailCreationComplete);
//			}
			
		}
		
		//初始化完成
		private function onMailCreationComplete(evt:MainMenuMailComponentCreateCompleteEvent):void{
			setWriteMailContent();
		}
		//设置写邮件的相应内容
		private function setWriteMailContent():void{
//			scenePageView.mainMenuComponent.mainMailComp.currentState = "writeMailState";
//			scenePageView.mainMenuComponent.mainMailComp.userName.text = tempRoleName;
		}
		
		/**
		 * 切换场景
		 * 需要处理，现在只有四个场景，所以场景id 只有1,2,3,4. 
		 * @param e
		 * isCanSwitchScene 是否可以发送切换场景指令，为解决切换场景多次发送指令的Bug
		 */		
		private var isCanSwitchScene:Boolean=true;
		private function onSwitchScene(e:RSwitchEvent):void{
			if(isCanSwitchScene){	
				//获取副本数据弹出副本选择界面
				getCopyInfoData(e.switchId);
			}
			
		}
		private function enterSceneHandler(data:Object):void{
			
		}
		
		/**
		 * 战斗资源加载完成，为了实现战斗场景切换特性功能
		 */
		private function onSwitchBattle(evt:RSwitchBattleEvent):void{
			//添加战斗场景切换动画
			//addSwitchBattleAnimation();
			progressBar.visible = false;
		}
		/**
		 * 加载相应的场景
		 * @param sceneResId 场景资源id
		 */
		private function loadScene(sceneResId:int):void {
			//把场景ID赋给本地缓存
			SystemDataModel.placeResId = sceneResId;
			
			//todo wordscene
			//显示加载条
			progressBar.visible = true;
			WordSceneSprite.getInstance().enterScene(sceneResId);
			
			return;
			
			//移除角色
			characterOp.removeCurrentSceneCharacter();
			//移除传送门
			iRSwitchOp.removeAllSwitch();
			//移除Npc
			npcOp.removeAllNpc();
			//移出场景
			rPbeLevel.destroyPbeLevel(-1);
			//显示加载条
			progressBar.visible = true;
			
			
			//加载场景
			rPbeLevel.generatePbeLevel(sceneResId);
		}
//		/**
//		 * 添加切换场景特效
//		 */
//		private function addSwitchSceneEffect():void{
//			//移除效果层上所有的子节点
//			scenePageView.effectLayer.visible = true;
//			var startBitmapData:BitmapData = getBitmapData(this.contextView);
//			var endBitmapData:BitmapData = new BitmapData(1000,570);
//			XTran.instance.addBitmapData(startBitmapData);
//			XTran.instance.addBitmapData(endBitmapData);
//			XTran.instance.addTransition(new BlurTransition);
//			XTran.instance.setView(scenePageView.effectLayer);
//			XTran.instance.go();
//			XTran.instance.addEventListener(XTranEvent.ALL_TRANSITIONS_PLAY_COMPLETE,onAllTransitionsPlayComplete);
//		}
//		
//		private function onAllTransitionsPlayComplete(evt:XTranEvent):void{
//			XTran.instance.removeEventListener(XTranEvent.ALL_TRANSITIONS_PLAY_COMPLETE,onAllTransitionsPlayComplete);
//			//移除效果层上所有的子节点
//			scenePageView.effectLayer.visible = false;
//		}
		
//		private function getBitmapData(target:DisplayObject):BitmapData  //截图功能函数   
//		{ 
//			var bd:BitmapData=new BitmapData(target.width,target.height); 
//		    var m:Matrix = new Matrix(); 
//		    bd.draw(target,m); 
//		    return bd; 
//	    } 
		
		//资源加载进度
		private var firstLoadFlag:Boolean;
		private function rLoadEventHandler(e:RLoadEvent):void{
			if(firstLoadFlag){
				progressBar.setLoadProgressInfo(e.percentLoaded,firstLoadFlag,"%",e.countRate);
			}else{
				progressBar.setLoadProgressInfo(e.percentLoaded,firstLoadFlag,'%2/2');
			}
			
		}
		/**
		 * 战斗资源加载完成事件
		 */
		private function onBattleResLoaded(evt:RLoadEvent):void{
			progressBar.visible = false;
		}
		
		private function onResize(evt:ResizeEvent = null):void{
			//todo wordscene
			return;
			RPBELevel.setBgFrame(false);
			if(SceneHelper.getInstance().myScene){
				if(SceneHelper.getInstance().myScene.sceneView.width%2==0){
					SceneHelper.getInstance().myScene.sceneView.width = scenePageView.width;
				}else{
					SceneHelper.getInstance().myScene.sceneView.width = scenePageView.width+1;
				}
				SceneHelper.getInstance().myScene.sceneView.height = scenePageView.height
				sky.updateScrollEffect(SystemDataModel.placeResId,scenePageView.skyUIComp,true);
			}
		}
		
		private function getCopySceneInfoFun():void{
			var getCYRe:GetCopySceneInfoRequest = new GetCopySceneInfoRequest();
			getCYRe.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getCYRe.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(CYhandler,faultHandler),URLConst.COPYSCENE_INFO_COMMANDID,byteArray);
		}
		private function CYhandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetCopySceneInfoResponse = new GetCopySceneInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.sceneCorpsName = responseData.corpsName;
				SystemDataModel.sceneCorpsId = responseData.corpsId;
				SystemDataModel.rewardCorpsId = responseData.rewardId;
				SystemDataModel.rewardCorpsName = responseData.rewardName;
				SystemDataModel.monsterNum = responseData.monsterNum;
			}
		}
		
		/**
		 * 场景初始化完成
		 */
		private function onSceneComplete(evt:RSceneEvent):void{
			if(ProConst.MAX_CITY_ID >= SystemDataModel.placeId){
				SoundManager.getInstance().stop(SoundConst.FUBEN_SOUND);
				SoundManager.getInstance().play(SoundConst.CITY_SOUND,0,-1);
			}else{
				SoundManager.getInstance().stop(SoundConst.CITY_SOUND);
				SoundManager.getInstance().play(SoundConst.FUBEN_SOUND,0,-1);
			}
			if(!firstLoadFlag){
				firstLoadFlag = true;
				SceneInitCompleteManager.getInstance().dispatchEvent(new SceneInitCompleteEvent(SceneInitCompleteEvent.SCENEINITCOMPLETE));
			}
			//todo wordscene
			//场景初始化完成后隐藏加载条
			progressBar.visible = false;
			progressBar.setDefaultVisible();
			
			getCopySceneInfoFun();
			SystemDataModel.sceneIsLoaded = true;
			GuidEventCenter.getInstance().dispatchEvent(new SwitchMaskEvent(SwitchMaskEvent.SwitchMaskEvent_HIDE));
			request_hero_move( -1, -1);
			return;
			
			onResize();
			
			//场景初始化完成后隐藏加载条
			progressBar.visible = false;
			progressBar.setDefaultVisible();
			
			getCopySceneInfoFun();
			
			
			if(SystemDataModel.jingjiBattleFlag || SystemDataModel.panPaBattleFlag || SystemDataModel.groupBattleFlag){
				characterOp.removeCurrentSceneCharacter();
				iRSwitchOp.removeAllSwitch();
				npcOp.removeAllNpc();
				
				WindowManager.closeAllWindows();
				
				ibattleShow.rBattleInit(SystemDataModel.battleInfoVo._initBattleVo,SystemDataModel.battleInfoVo._battleAllRoundVo,true);	
				
				SystemDataModel.isBattleStatusFlag = true;
				
				SystemDataModel.battleInfoVo._battleAllRoundVo = null;
				SystemDataModel.battleInfoVo._initBattleVo = null;
			}else if(!SystemDataModel.isColonizationFlag){
				
				//标志位置为true
				SystemDataModel.sceneIsLoaded = true;
				//更新场景雾气信息
				sky.updateScrollEffect(SystemDataModel.placeResId,scenePageView.skyUIComp);
				//更新NPC信息
				var l:int = SystemDataModel.npcInfoArr.length;
				var arr:Array = new Array();
				for(var i:int=0;i<l;i++){
					arr.push(SystemDataModel.npcInfoArr[i]);
				}
				npcOp.updateFixedNpc(arr);
				//更新传送门信息
				switchOp.updateFixedSwitch(SystemDataModel.switchInfoArr);
				//派发进入场景接收到可接任务事件
				//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_SHOW_UI, GuideInfo.TYPE_UI_ENTER_CITY));
				PlayerLogic.getBounds();
				
				//场景名称
				this.dispatch(new SceneLoadedAndShowSceneNameEvent(SceneLoadedAndShowSceneNameEvent.SCENELOADEDANDSHOWSCENENAME,SystemDataModel.placeResId));
				
				//hao 切换场景
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_CHANGE_SCENE));
				//TaskMessage.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_Enter_City));
				
				//判断副本和主程,控制是否显示任务追踪
				//
				/*if (SystemDataModel.placeId >= ProConst.MIN_CITY_ID && SystemDataModel.placeId <= ProConst.MAX_CITY_ID) {
				scenePageView.taskComponent.visible = true;
				}
				else {
				scenePageView.taskComponent.visible = false;
				}*/
				if(SystemDataModel.openPanPaUI){
					SystemDataModel.openPanPaUI = false;
					AssetCenter.getInstance().load_package("ui_pata",to_keluota,null,true);
				}
				GuidEventCenter.getInstance().dispatchEvent(new SwitchMaskEvent(SwitchMaskEvent.SwitchMaskEvent_HIDE));
			}else if(SystemDataModel.battleInfoVo._initBattleVo && SystemDataModel.battleInfoVo._battleAllRoundVo){
				
				characterOp.removeCurrentSceneCharacter();
				iRSwitchOp.removeAllSwitch();
				npcOp.removeAllNpc();
				
				WindowManager.closeAllWindows();
				
				
				GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.INTER_ZHIMIN_BAT));
				
				SystemDataModel.isColonizationFlag = true;
				
				ibattleShow.rBattleInit(SystemDataModel.battleInfoVo._initBattleVo,SystemDataModel.battleInfoVo._battleAllRoundVo,true);	
				
				SystemDataModel.isBattleStatusFlag = true;
				
				SystemDataModel.battleInfoVo._battleAllRoundVo = null;
				SystemDataModel.battleInfoVo._initBattleVo = null;
			}
			//请求初始化场景实体
			//请求所有场景实体
			//xtrace("请求所有场景实体");
			request_hero_move( -1, -1);
		}
		/**
		 * 获取可接任务列表
		 */
		private function addEventListenerCanAcceptTaskList():void{
			socketService.send(new mx.rpc.Responder(receivedTaskHandler,faultHandler),URLConst.GETTASK_CANRECEIVED_COMMANDID,null,false);
		}
		/**
		 * receivedTaskHandler
		 */
		private function receivedTaskHandler(data:Object):void{
			var receivedByte:ByteArray = data as ByteArray;
			var responseData:getCanReceivedquestListResponse = new getCanReceivedquestListResponse();
			responseData.readExternal(receivedByte);
			if(responseData.data && responseData.data.canReceivedquestList){
				var taskArr:ArrayCollection = new ArrayCollection();
				//主线任务
				var mainTaskInfo:Object = new Object();
				mainTaskInfo.taskname = "主线任务";
				mainTaskInfo.children = new ArrayCollection();
				//支线任务
				var oneTaskInfo:Object = new Object();
				oneTaskInfo.taskname = "支线任务";
				oneTaskInfo.children = new ArrayCollection();
				//行会任务
				var familyTaskInfo:Object = new Object();
				familyTaskInfo.taskname = "行会任务";
				familyTaskInfo.children = new ArrayCollection();
				//环任务
				var cirTaskInfo:Object = new Object();
				cirTaskInfo.taskname = "环任务";
				cirTaskInfo.children = new ArrayCollection();
				
				var l:int = responseData.data.canReceivedquestList.length;
				for(var i:int = 0;i<l;i++){
					var taskInfo:proto.task.task1407.Quest = responseData.data.canReceivedquestList[i];
					var taskInfoVo:TaskInfoVo = new TaskInfoVo();
					taskInfoVo.taskId = taskInfo.taskId;
					taskInfoVo.taskname = taskInfo.taskname;
					var taskType:int = SystemDataModel.taskInfoXML.row.(@id == taskInfo.taskId).task_type;
					taskInfoVo.taskType = taskType;
					switch(taskType){
						case ProConst.MAINTASKLINE:
							mainTaskInfo.children.addItem(taskInfoVo);
							break;
						case ProConst.ONETASKLINE:
							oneTaskInfo.children.addItem(taskInfoVo);
							break;
						case ProConst.CIRCLETASKLINE:
							familyTaskInfo.children.addItem(taskInfoVo);
							break;
						case ProConst.FAMILYTASKLINE:
							cirTaskInfo.children.addItem(taskInfoVo);
							break;
					}
				}
				
				
				taskArr.addItem(mainTaskInfo);
				taskArr.addItem(oneTaskInfo);
				taskArr.addItem(familyTaskInfo);
				taskArr.addItem(cirTaskInfo);
				
				SystemDataModel.mainTaskInfoList.source = taskArr.toArray();
			}
		}
		/**
		 * 战斗场景切换动画
		 */
		private function addSwitchBattleAnimation():void{
			//var animation:AnimationOnceManager = new AnimationOnceManager(URLConst.SWITCH_BATTLEANIMATION_URL);
			//animation.addToParent();
			//animation.setPosition(0,0);
			//animation.play();
		}
		
		/**
		 * 同步场景信息 分两部分 1：把自己的信息定时同步给服务器 2： 服务器同步当前场景的信息 
		 * @param e
		 * 
		 */		
		private function syncSceneInfo():void{
			//监听服务器同步的场景信息
			socketService.send(new Responder(resultHandler,faultHandler),URLConst.PLAYER_LOCATION_COMMANDID,null,false);			
			//把自己信息同步给服务器
			syncPointWithServer();	
			return;
			//处理当浏览器最小化时Player继续正常运行
			if (ExternalInterface.available) {
				try {
					ExternalInterface.addCallback("keepFrameRate", keepFrameRate);				
					ExternalInterface.call("startKeepFrameRate");
				}catch(error:SecurityError) {
					trace("A SecurityError occurred: " + error.message + "\n");
				}catch(error:Error) {
					trace("An Error occurred: " + error.message + "\n");
				}
			} else {
				trace("External interface is not available for this container.");
			}
			
		}
		
		/**
		 * keep frame rate for out focus fp10.1 
		 * 
		 */		
		private function keepFrameRate():void
		{
			return;
			//trace("keep frame rate:" + scenePageView.stage.frameRate);
		}
		
		//定时器，定时向服务器发送玩家坐标信息，即和服务器同步坐标
		private function syncPointWithServer():void{
			//timer = new Timer(PERTIME);
			//timer.addEventListener(TimerEvent.TIMER,onTimer);
			//timer.start();
		}
		
		private function on_hero_move(e:NSceneEvent):void {
			var x:int = e.obj.x;
			var y:int = e.obj.y;
//			xtrace("主控角色移动", x, y);
			request_hero_move(x, y);
		}
		
		private function request_hero_move(x:int, y:int):void{
			if(SystemDataModel.sceneIsLoaded){
				var request:moveInSceneRequest = new moveInSceneRequest();
				request.id = SystemDataModel.roleId;
				request.x = x;
				request.y = y;
				request.sceneId = SystemDataModel.placeId;
				var byteArray:ByteArray = new ByteArray();
				request.writeExternal(byteArray);
				//xtrace("发送主控角色坐标", request);
				//同步坐标 这个指令只负责把自己的坐标发给服务器，服务器并不返回数据
				socketService.send(new Responder(resultHandler,faultHandler),URLConst.MOVE_INSCENE_COMMANDID,byteArray);
			}
		}
		
		/*private function onTimer(evt:TimerEvent):void{
			if(SystemDataModel.sceneIsLoaded){
				var request:moveInSceneRequest = new moveInSceneRequest();
				request.id = SystemDataModel.roleId;
				var directionVo:RDirectionVo = characterOp.getCharacterPos(SystemDataModel.roleId);
				if(directionVo == null || directionVo.chaPos == null)return;
				request.x = directionVo.chaPos.x;
				request.y = directionVo.chaPos.y;
				request.sceneId = SystemDataModel.placeId;
				var byteArray:ByteArray = new ByteArray();
				request.writeExternal(byteArray);
				//xtrace("发送主控角色坐标", request);
				//同步坐标 这个指令只负责把自己的坐标发给服务器，服务器并不返回数据
				socketService.send(new Responder(resultHandler,faultHandler),URLConst.MOVE_INSCENE_COMMANDID,byteArray);
			}		

		}*/
		//同步坐标返回处理
		private function resultHandler(data:Object):void{
		   var byteArray:ByteArray = data as ByteArray;
		   var responseData:pushSceneMessage = new pushSceneMessage();
		   responseData.readExternal(byteArray);
		   if (SystemDataModel.placeId != responseData.sceneId) {
			   xtrace("同步坐标出错,现有场景id", SystemDataModel.placeId, " 同步场景id ", responseData.sceneId);
			   return;
		   }
		   if (!SystemDataModel.sceneIsLoaded) {
			   return;
		   }
		   
		   
		   var scene_data:SceneData = WordSceneSprite.getInstance().entityData;
		    //玩家信息 场景人物军团
		   if(responseData.PlayerPosition){
			   var l:int = responseData.PlayerPosition.length;
			   for(var i:int = 0;i<l;i++){
				   var location:characterPosition = responseData.PlayerPosition[i];
				   scene_data.add_entity(location, SceneData.ENTITY_TYPE_CHAR);
			   }
		   }
		   //怪物信息
		   if(responseData.MonsterPosition){
			   var ml:int = responseData.MonsterPosition.length;
			   for(var mi:int = 0;mi<ml;mi++){
				   var monLocation:characterPosition = responseData.MonsterPosition[mi];
				   scene_data.add_entity(monLocation, SceneData.ENTITY_TYPE_MONSTER);
			   }
		   }
		   //宠物信息
		   if(responseData.petInfo){
			   var pl:int = responseData.petInfo.length;
			   for(var pi:int=0;pi<pl;pi++){
				   var petLocation:characterPosition = responseData.petInfo[pi];
				   scene_data.add_entity(petLocation,SceneData.ENTITY_TYPE_PET);
			   }
		   }
		   WordSceneSprite.getInstance().upDataEntityProperty();
		   //characterOp.updateScene(scene_data.entitys); 
		}
		
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		/**
		 * 鼠标在场景移动事件
		 */
		private function onMouseMoveInSceneLayer(evt:MouseEvent):void{
			//todo wordscene
			
			return;
			characterOp.moveEventHandler();
		}
		/**
		 *鼠标点击场景 角色移动
		 * @point 鼠标点击的坐标 角色向该点移动
		 */	
		private function onSceneMouseClick(e:MouseEvent):void{
			if(scenePageView.chatWin.mouseEnabled){
				scenePageView.chatWin.mouseEnabled = false;
				return;
			}
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
				return;
			}
			//如果显示其他角色信息，当点击场景是隐藏其他角色信息
			if(SystemDataModel.otherInfo.isShow){
				SystemDataModel.otherInfo.isShow = false;
			}
			//todo wordscene
			WordSceneSprite.getInstance().moveHearo();
			TaskMessage.getInstance().clear_find_path();
			return;
		}
		
		/**
		 * 邀请组队
		 */
		private function addEventInvitedGroup():void{
			socketService.send(new Responder(resultPushInvitedGroupSkillHandler,faultHandler),URLConst.PUSHINVITED_GROUP_COMMANDID,null,false);
		}
		/**
		 * 被邀请组队请求
		 * @inviteId 邀请者id
		 */
		private var inviteId:int;
		private function resultPushInvitedGroupSkillHandler(data:Object):void{
			var pushInvitedByteArray:ByteArray = data as ByteArray;
			var pushInvitedResponse:pushInvitedGroupRequest = new pushInvitedGroupRequest();
			pushInvitedResponse.readExternal(pushInvitedByteArray);
			if(pushInvitedResponse.msg){
//				var myAlert:Alert;
//				var flags:uint = Alert.YES|Alert.CANCEL;
//				Alert.yesLabel = "确定";
//				Alert.cancelLabel = "取消";
//				flags |= Alert.NONMODAL;
//				myAlert=Alert.show(pushInvitedResponse.msg,"信息提示",flags,null,clickHandler);
//				myAlert.width = 638;
//				myAlert.height = 353;
				inviteId = pushInvitedResponse.inviterId;
				
				popUpShow.show(pushInvitedResponse.msg,"信息提示",null,"确定","取消",submitHandler,cancelHandler);
			}
		}
		/**
		 * 同意接受组队邀请
		 */
		private function submitHandler(evt:MouseEvent):void{
				var agreeRequest:agreeGroupRequest = new agreeGroupRequest();
				agreeRequest.id = SystemDataModel.roleId;
				agreeRequest.tid = inviteId;
				var agreeByteArray:ByteArray = new ByteArray();
				agreeRequest.writeExternal(agreeByteArray);
				socketService.send(new Responder(resultAgreeInviteGroupHandler,faultHandler),URLConst.AGREE_INVITEGROUP_COMMANDID,agreeByteArray);
		}
		/**
		 * 拒绝接受组队邀请
		 */
		private function cancelHandler(evt:MouseEvent):void{
				var rejuectRequest:rejectGroupRequest = new rejectGroupRequest();
				rejuectRequest.id = SystemDataModel.roleId;
				rejuectRequest.toid = inviteId;
				var rejectByteArray:ByteArray = new ByteArray();
				rejuectRequest.writeExternal(rejectByteArray);
				socketService.send(new Responder(resultRejectGroupHandler,faultHandler),URLConst.REJECT_INVITEGROUP_COMMANDID,rejectByteArray);
		}
		/**
		 * 拒绝组队邀请
		 */
		private function resultRejectGroupHandler(data:Object):void{
			var rejectResponse:ByteArray = data as ByteArray;
//			trace("拒绝组队邀请");
		}
		/**
		 * resultAgreeInviteGroupHandler
		 */
		private function resultAgreeInviteGroupHandler(data:Object):void{
			var agreeResponseByteArray:ByteArray = data as ByteArray;
			var agreeResponseData:agreeGroupResponse = new agreeGroupResponse();
			agreeResponseData.readExternal(agreeResponseByteArray);
			if(agreeResponseData.result){
//				popUpShow.show(agreeResponseData.message);
			}
		}
		/**
		 * 
		 */
		private function onMonsterBattle(evt:RMonsterEvent):void{
			request_enter_battle(evt.monsterId);
		}
		
		private function request_enter_battle(monsterId:int):void {
			var fightRequest:FightRequest = new FightRequest();			 
			fightRequest.id = SystemDataModel.roleId;			
			fightRequest.tid = monsterId;			
			fightRequest.type = 1;			
			var fightByteArray:ByteArray = new ByteArray();			
			fightRequest.writeExternal(fightByteArray);			
			socketService.send(new mx.rpc.Responder(fightResultHandler, faultHandler), URLConst.BATTLE_MONSTER_COMMANDID, fightByteArray);
			Logging.log("请求进入战斗");
		}
		
		/**
		 * 战场信息Handler
		 */	
		private function fightResultHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var fightResponse:proto.battle.battle703.FightResponse = new FightResponse();
			fightResponse.readExternal(byteArray);
			Logging.log("进入战斗", fightResponse, Logging.o2s(fightResponse));
			if (fightResponse.result) {
				//战斗开始，加载战斗资源显示加载进度
				GuidEventCenter.getInstance().dispatchEvent(
					new SwitchMaskEvent(
						SwitchMaskEvent.SwitchMaskEvent_SHOW,
						intoFight,
						[fightResponse]
					)
				);
			}
			else {
				//重置战斗怪物id
				WordSceneSprite.getInstance().playerCoutainSp.resetFightMonsterID();
			}
		}
		
		private function intoFight(fightResponse:FightResponse):void {
			WordSceneSprite.getInstance().enterFight(fightResponse);
			SoundManager.getInstance().stop(SoundConst.FUBEN_SOUND);
			SoundManager.getInstance().stop(SoundConst.CITY_SOUND);
			SoundManager.getInstance().play(SoundConst.BATTLE_SOUND);
		}
		
		private function onPkOther(e:PlusEvent):void {
			sendScenePkReq(e.obj.id);
		}
		
		private function sendScenePkReq(id:int):void {
			var req:FightPkRequest = new FightPkRequest();
			req.id = SystemDataModel.roleId;
			req.tid = id;
			Logging.log("发送场景pk", Logging.o2s(req));
			var bytes:ByteArray = new ByteArray();
			req.writeExternal(bytes);
			socketService.send(new mx.rpc.Responder(scenePkRes, faultHandler), URLConst.BATTLE_SCENE_PK_COMMANDID, bytes);
		}
		
		//场景pk
		private function scenePkRes(data:Object):void {
			var byteArray:ByteArray = data as ByteArray;
			var response:FightPkResponse = new FightPkResponse();
			response.readExternal(byteArray);
			
			Logging.log("场景pk结果");
		}
		
		/**
		 * 
		 * 战斗结算翻牌
		 */
		
		private function addBattleFlip():void{
			WindowManager.createWindow(BattleFlipComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer, false);
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_FIGHT_FANPAIZI));
		}
		/**
		 * 退出副本
		 */
		private function onEscCopySceneHandler(evt:MouseEvent):void{
			//发送退出战斗请求
			sendQuitBattle();
			//退出副本
			BattleAndCopySceneMessage.getInstance().onEscCopyScene();
		}
		/**
		 * 再次征战副本
		 */
		private function submitEnterBattle(data:Object):void{
			//发送退出战斗请求
			sendQuitBattle();
			//重新征战副本请求
			var enterInstanceR:escInstanceRequest = new escInstanceRequest();
			enterInstanceR.id = SystemDataModel.roleId;
			var enterInstanceB:ByteArray = new ByteArray();
			enterInstanceR.writeExternal(enterInstanceB);
			socketService.send(new mx.rpc.Responder(enterInstanceHandler,faultHandler),URLConst.SUBMITENTER_COPYSCENE_COMMANDID,enterInstanceB);
		}
		/**
		 * 确定再次征战副本返回处理
		 */
		private function enterInstanceHandler(data:Object):void{
			var enterInstanceByte:ByteArray = data as ByteArray;
			var enterInstanceResponseData:escInstanceResponse = new escInstanceResponse();
			enterInstanceResponseData.readExternal(enterInstanceByte);
			if(enterInstanceResponseData.result){
				SystemDataModel.sceneIsLoaded = true;
			}else{
				popUpShow.show(enterInstanceResponseData.message);
			}
		}
		/**
		 * 退出副本
		 */
		private function cancelCopyScene(data:Object):void{
			
		}
		/**
		 * onBattleOver 战斗结束 
		 */
		private function onBattleOver(evt:RBattleRoundEvent):void{
			if(SystemDataModel.jingjiBattleFlag || SystemDataModel.panPaBattleFlag || SystemDataModel.groupBattleFlag){
				//竞技战斗结束
				WindowManager.createWindow(JingJiBattleJieSuanWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else if(SystemDataModel.isColonizationFlag){
				//殖民战TODO
				//				onEscColonizationBattle();
				if(SystemDataModel.battleInfoVo.battleResult == 1){
					WindowManager.createWindow(BattleColonizationWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer, false);
					new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QINGLUE_JIEGUO_CHENGGONG)]);
				}else{
					WindowManager.createWindow(BattleColonizationFailWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer, false);
					new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QINGLUE_JIEGUO_SHIBAI)]);
				}
			}else{
				//添加战斗结算界面			
				addBattleSettlement();
			}		
		}
		/**
		 * 退出殖民战
		 */
		private function onEscColonizationBattle():void{
			SystemDataModel.isColonizationFlag = false;
			var escColReq:EscColonizationBattleRequest = new EscColonizationBattleRequest();
			escColReq.id = SystemDataModel.roleId;
			if(SystemDataModel.battleInfoVo.battleResult == 1){
				escColReq.battleResult = true;
			}else{
				escColReq.battleResult = false;
			}
			escColReq.sceneId = SystemDataModel.colCopyId;
			var byteArray:ByteArray = new ByteArray();
			escColReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(escColHandler,faultHandler),URLConst.BATTLE_ESCCOL_COMMANDID,byteArray);
		}
		private function escColHandler(data:Object):void{
			//销毁战斗场景中的所有实体
			//rBattleShow.destroyRBattleEntities();
		}
	    /**
		 * 战斗结算界面
		 * 显示结算界面5秒后自动进入翻牌子界面
		 */
		private var uiComp:UIComponent;
		private function addBattleSettlement():void{
			//battleResult 4翻牌子
			if(SystemDataModel.battleInfoVo.battleResult == 1){
				//胜利
				AssetCenter.getInstance().load_package("ui_battle_suc", to_battle_suc, null, true);
				
			}else{
				//失败
				WindowManager.createWindow(BattleFailSettlementWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}
		}
		private function to_battle_suc():void{
			getCopySceneInfoFun();
			WindowManager.createWindow(BattleSuccessSettlementWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_FIGHT_JIESUAN));
		}
		
		/**
		 * 添加监听显示翻牌子界面
		 */
		private function addShowFlipCompInfo():void{
			socketService.send(new mx.rpc.Responder(ShowFlipCompResultHandler,faultHandler),URLConst.SHOW_BATTLECOMP_COMMANDID,null,false);
		}
		/**
		 * 显示翻牌子界面
		 */
		private function ShowFlipCompResultHandler(data:Object):void {
			AssetCenter.getInstance().load_package("ui_battle_suc", addBattleFlip, null, true);
			//addBattleFlip();
		}
		
		/**
		 * 退出战斗请求
		 */
		private function sendQuitBattle(e:PlusEvent = null):void{
			var quitFightQuest:quitFightRequest = new quitFightRequest();
			quitFightQuest.id = SystemDataModel.roleId;
			var byteArrayQuit:ByteArray = new ByteArray();
			quitFightQuest.writeExternal(byteArrayQuit);
			socketService.send(new mx.rpc.Responder(QuitFightResultHandler,faultHandler),URLConst.QUIT_BATTLE_COMMANDID,byteArrayQuit);
		}
		
		/**
		 * QuitFightResultHandler
		 */
		private function QuitFightResultHandler(data:Object):void{
			var responseByteArray:ByteArray = data as ByteArray;
			var quitResponse:quitFightResponse = new quitFightResponse();
			quitResponse.readExternal(responseByteArray);
			SystemDataModel.isBattleStatusFlag = false;
			SoundManager.getInstance().stop(SoundConst.BATTLE_SOUND);
			if(ProConst.MAX_CITY_ID >= SystemDataModel.placeId){
				SoundManager.getInstance().stop(SoundConst.FUBEN_SOUND);
				SoundManager.getInstance().play(SoundConst.CITY_SOUND,0,-1);
			}else{
				SoundManager.getInstance().stop(SoundConst.CITY_SOUND);
				SoundManager.getInstance().play(SoundConst.FUBEN_SOUND,0,-1);
			}
			return;
		}

		/**
		 *获取装备信息 
		 */		
		private function getEquipmentInfo(page:int=1):void{
			ShopMessage.getInstance().requese_package_info(page, SystemDataModel.packageType);
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
			socketService.send(new mx.rpc.Responder(itemResultHandler,faultHandler),URLConst.GET_ROLEITEM_COMMANDID,itemInfoByteArray);

		}
		/**
		 * itemResultHandler 
		 */		
		private function itemResultHandler(data:Object):void{
			dispatch(new GetRoleItemResponseEvent(GetRoleItemResponseEvent.GET_ROLEITEM_EVENT,data));
		}
		
		/**
		 * 商店
		 */
		private function onShopClick(npcId:int,funType:int):void{
			AssetCenter.getInstance().load_package('ui_npc_task', npc_task, [npcId,funType], true, null, null, null);
			
//			var requestGetShopInfo:getNpcShopInfoRequest = new getNpcShopInfoRequest();
//			requestGetShopInfo.id = SystemDataModel.roleId;
//			requestGetShopInfo.npcId = npcId;
//			requestGetShopInfo.shopCategory = ProConst.NPCSHOP_BUY_SHOP;
//			requestGetShopInfo.curPage = SystemDataModel.shopInfoVo.curPage;
//			var getShopInfoByteArray:ByteArray = new ByteArray();
//			requestGetShopInfo.writeExternal(getShopInfoByteArray);
//			socketService.send(new mx.rpc.Responder(resultNpcShopHandler,faultHandler),URLConst.GET_SHOPINFO_COMMANDID,getShopInfoByteArray);

		}
		private function npc_task(npcId:int,funType:int):void{
			var obj:Object = new Object();
			obj.npcId = npcId;
			obj.funType = funType;
			WindowManager.createWindow(MainTaskComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		/**
		 * 获取商店信息返回处理
		 */
		private function resultNpcShopHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:getNpcShopInfoResponse = new getNpcShopInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				AssetCenter.getInstance().load_package('ui_npcshop', show_npc_shop, [responseData.data], true, null, null, null, ['ui_package','ui_npc_task']);
			}else{
				popUpShow.show(responseData.message);
			}
		}
		
		//private function load_package(obj:proto.shop.shop206.ShopInfo):void {
			//AssetCenter.getInstance().load_package('ui_package', show_npc_shop, [obj]);
		//}
		
		private function show_npc_shop(obj:proto.shop.shop206.ShopInfo):void {
//			if (null == npcShopComp) {
//				npcShopComp = new NpcShopComponent();
//			}
			
			//申请背包信息
			
//			this.contextView.addChild(npcShopComp);
			SceneModuleCommonMessage.getInstance().getNpcShopInfo(SystemDataModel.shopInfoVo.itemType,1);
			WindowManager.createWindow(NpcShopComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			dispatch(new Event("hello"));
		}
		
		/**
		 * npc点击事件
		 * 角色id大于1000000
		 */
		private function onMouseClickNpc(evt:RMousePosEvent):void{
			if(evt.chaType == RCharacterConst.CHA_TYPE_3){
				//PetMessage.getInstance().getOnePetInfo(evt.chaId,evt.masterId);
				//WindowManager.createWindow(MainPetViewInfoComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else if(evt.chaType == RCharacterConst.CHA_TYPE_1){
				SystemDataModel.otherInfo.isShow = true;
				SystemDataModel.otherInfo.id = evt.chaId;
				SystemDataModel.otherInfo.nickname = evt.chaName;
				SystemDataModel.otherInfo.profession = evt.chaProfessionType;
				SystemDataModel.otherInfo.level = evt.chaLevel;
				SystemDataModel.otherInfo.roletype = evt.vipLevel;
				SystemDataModel.otherInfo.campid = evt.campid;
				WordSceneSprite.getInstance().dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_ResetPKAble));
			}
			
			SystemDataModel.tempId = evt.chaId;
			tempName = evt.chaName;
			
			//进入副本
//			openCopySelectedComp();
		}
		
		private function clearPlayerInfo(e:PlusEvent):void {
			SystemDataModel.otherInfo.isShow = false;
		}
		
		private var tempName:String;
		private function onWithNpcChat(evt:RCharacterEvent):void{
			//if(SystemDataModel.tempId > CharacterConst.NPC_TYPE && SystemDataModel.tempId < GuideConst.GUIDE_NPC_TYPE){
				//getTaskListInfo(SystemDataModel.tempId);
			//}else if(SystemDataModel.tempId > ROLEIDRANGE){
				onOpenNpcChatWindow(SystemDataModel.tempId,tempName);
			//}
		}
		/**
		 * 打开NPC相应的弹出窗
		 */
		private function onOpenNpcChatWindow(npcId:int,npcName:String = null):void{
			if(npcId >= ROLEIDRANGE){
				SystemDataModel.otherInfo.isShow = true;
				SystemDataModel.otherInfo.id = npcId;
				SystemDataModel.otherInfo.nickname = npcName;
				//判断此时是否同时按住了shift键
				if(SystemDataModel.shiftKeyDown){
					var itemlinkdata:itemLinkData = new itemLinkData();
					itemlinkdata.chatEquipType = ProConst.CHATLINK_ROLE;
					itemlinkdata.id = npcId;
					//此处需要获取角色名称
					itemlinkdata.name = npcName;
					this.dispatch(new ChatEquipmentEvent(ChatEquipmentEvent.CHATEQUIPMENTEVENT,itemlinkdata));
				}
			}else if(npcId == ProConst.NPC_DAOJU || npcId == ProConst.NPC_FANGJU){
				//商店NPC
//				onShopClick();
//				getEquipmentInfo();
//				getTaskListInfo(npcId);
			}else if(npcId == ProConst.NPC_TRAINING){
//				openCopySelectedComp();
				
			}else if(npcId == ProConst.NPC_UNITING){
				//挂机修炼NPC
//				WindowManager.createWindow(MainHotelComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else if(npcId == ProConst.NPC_LODGEHOUSE){
				//铁匠铺
//				onOpenBlacksmithWindow();
			}else if(npcId == ProConst.NPC_BLACKSMITH){
			   //铁匠铺
//				onOpenBlacksmithWindow();
			}else{
				//怪物
				var itemlink:itemLinkData = new itemLinkData();
				itemlink.chatEquipType = ProConst.CHATLINK_BOSS;
				itemlink.id = npcId;
				//此处需要获取角色名称
				itemlink.name = npcName;
				this.dispatch(new ChatEquipmentEvent(ChatEquipmentEvent.CHATEQUIPMENTEVENT,itemlink));
			}
			
			//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_SHOW_UI, GuideInfo.TYPE_UI_TASK, npcId));
		}
		/**
		 * 和NPC对话弹出相应的界面
		 */
		private function onChatWithNpcAndAddWindow(evt:RCharacterEvent):void {
			SystemDataModel.tempId = evt.npcId;
			SystemDataModel.opening_npc_type = evt.npcFunctionType;
			SystemDataModel.shopInfoVo.itemType = 0;
			onShopClick(evt.npcId,evt.npcFunctionType);
			switch(evt.npcFunctionType){
				case ProConst.MEIRIRENWU:
					//每日任务NPC  TODO
					break;
				case ProConst.DAOJUDIAN:
					//道具店NPC 
					SystemDataModel.packType = NpcShopComponent.NAME;
					break;
				case ProConst.FANGJUDIAN:
					//防具店NPC
					SystemDataModel.packType = NpcShopComponent.NAME;
					break;
				case ProConst.WUQIDIAN:
					//武器店NPC
//					SystemDataModel.packType = MainStrengthenComponent.NAME;
//					onOpenBlacksmithWindow();
					break;
				case ProConst.JIUDIAN:
					//酒店NPC TODO
					break;
				case ProConst.CANGKUGUANLIYUAN:
					//仓库管理员 TODO
					break;
				case ProConst.RENWUNPC:
					//任务NPC TODO
					break;
				case ProConst.JUNTUANGUANLIYUAN:
					//军团管理员 TODO
					break;
				case ProConst.JIAOYISUONPC:
					//交易所NPC TODO
					break;
				case ProConst.JINENGNPC:
					//技能NPC TODO
					break;
				case ProConst.SHENMISHANGREN:
					//神秘商人 TODO
					break;
				case ProConst.ZHANPUSHI:
					//占卜师 TODO
					break;
			}
			
		}
		
		
		//打开或关闭世界地图
		private function change_map(e:KeyFuncEvent):void {
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				if (WindowManager.isPopedUp(SceneMapView.NAME)) {
					//已经弹出
					//移动过程中不能关闭地图
					if (MapConfig.getInstance().move_ing) {
						
					}
					else{
						WindowManager.closeWindow(SceneMapView.NAME, false, false, null, null, mediatorMap);
					}
				}
				else {
					//副本中不能打开世界地图
					var placeid:int = SystemDataModel.placeId;
					
					if (placeid >= ProConst.MIN_CITY_ID && placeid < ProConst.MAX_CITY_ID) {
						//如果世界地图打开了关闭世界地图
						if (WindowManager.isPopedUp(NCopySceneChoseView.NAME)) {
							SystemDataModel.open_trip_id = 0;
							WindowManager.closeWindow(NCopySceneChoseView.NAME);
						}
						AssetCenter.getInstance().load_package(
							"map_scene_" + 0, 
							WindowManager.createWindow, 
							[SceneMapView.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer], 
							true, null, null, null,
							['map_scene_base']
						);
					}
				}
			}
			
		}
		
	    /**
		 * 监听从场景移除玩家事件
		 */
		private function addRemovePlayerFromPlace():void{
			socketService.send(new mx.rpc.Responder(resultRemovePlayerShopHandler,faultHandler),URLConst.REMOVE_PLAYERFROMPLACE_COMMANDID,null,false);
		}
		
		/**
		 * resultRemovePlayerShopHandler
		 */
		private function resultRemovePlayerShopHandler(data:Object):void {
			var removePlayerByteArray:ByteArray = data as ByteArray;
			var removePlayerResponse:removePlayerInMap = new removePlayerInMap();
			removePlayerResponse.readExternal(removePlayerByteArray);
			Logging.log("remove player", Logging.o2s(removePlayerResponse));
			if (removePlayerResponse.id) {
				//todo wordscene
				WordSceneSprite.getInstance().removeChar(removePlayerResponse.id);
				//characterOp.removeCharacterById(removePlayerResponse.id);
				//SystemDataModel.scene_data.rm_entity(removePlayerResponse.id);
			}
		}
		
		/**
		 * 获取战后结束翻牌子物品信息
		 */
		private function getBattleOverFlipItemInfo():void{
			var getBattleOverItemInfo:getAllCardInfoRequest = new getAllCardInfoRequest();
			getBattleOverItemInfo.id = SystemDataModel.roleId;
			var requestBattleByteArray:ByteArray = new ByteArray();
			getBattleOverItemInfo.writeExternal(requestBattleByteArray);
			socketService.send(new mx.rpc.Responder(resultBattleOverItemHandler,faultHandler),URLConst.GET_BATTLE0VER_ITEMINFO_COMMANDID,requestBattleByteArray);
		}
		
		/**
		 * 获取战后结算物品信息
		 */
		private function resultBattleOverItemHandler(data:Object):void{
			var battleItemByteArray:ByteArray = data as ByteArray;
			dispatch(new BattleOverGetItemInfoResponseEvent(BattleOverGetItemInfoResponseEvent.BATTLEOVERITEMRESPONSE,battleItemByteArray));
			
			addBattleFlip();
		}
		/**
		 * 监听服务器返回的队伍信息
		 */
		private function addGroupInfo():void{
			socketService.send(new mx.rpc.Responder(resultGroupInfoHandler,faultHandler),URLConst.TEAM_GROUPINFO_COMMANDID,null,false);
		}
		/**
		 * 服务器返回的信息处理
		 */
		private function resultGroupInfoHandler(data:Object):void{
			dispatch(new TeamMemberInfoResponseEvent(TeamMemberInfoResponseEvent.TEAMMEMBERINFOEVENT,data));
		}
		/**
		 * 角色信息改变事件
		 */
		private function addRoleInfoChange():void{
			socketService.send(new mx.rpc.Responder(RoleInfoChange,faultHandler),URLConst.ROLE_CHANGE_COMMANDID,null,false);
		}
		/**
		 * 角色信息改变重新获取角色信息
		 */
		private function RoleInfoChange(data:Object):void{
			getPlayerInfo();
		}
		/**
		 * 获取角色信息
		 */
		private function getPlayerInfo():void{
			var request:getPlayerInfoRequest = new getPlayerInfoRequest();
			var byteArrayPlayerInfo:ByteArray = new ByteArray();
			request.id = SystemDataModel.roleId;
			request.writeExternal(byteArrayPlayerInfo);
			//获取角色基本信息
			socketService.send(new mx.rpc.Responder(resultPlyerInfoHandler,faultHandler),URLConst.GET_ROLEINFO_COMMANDID,byteArrayPlayerInfo);
		}
		/**
		 * resultPlyerInfoHandler 
		 */		
		private function resultPlyerInfoHandler(data:Object):void{
			dispatch(new GetRoleInfoResponseEvent(GetRoleInfoResponseEvent.GET_ROLEINFO_SUCCESS_EVENT,data)); 
		}
		/**
		 * 添加监听，监听有新邮件事件
		 */
		private function addHaveNewMail():void{
			socketService.send(new mx.rpc.Responder(resultNewMailHandler,faultHandler),URLConst.MAIL_ARRIVED_COMMANDID,null,false);
		}
		/**
		 * 有新邮件
		 */
		private function resultNewMailHandler(data:Object):void{
			var mailByteArray:ByteArray = data as ByteArray;
			var responseMail:mailArrived = new mailArrived();
			responseMail.readExternal(mailByteArray);
			xtrace("有新邮件",new ObjectToString(responseMail).getString());
			if (responseMail.signal) {
				this.dispatch(new NMailEvent(NMailEvent.NMailEvent_NEW_MAIL));
			}
		}
		
		/**
		/*
		 * 获取任务列表
		 */
		private function getTaskListInfo(npcId:int):void{
			var taskRequest:getQuestListOnNpcRequest = new getQuestListOnNpcRequest();
			taskRequest.id = SystemDataModel.roleId;
			taskRequest.npcId = npcId;
			var taskByteArray:ByteArray = new ByteArray();
			taskRequest.writeExternal(taskByteArray);
			socketService.send(new mx.rpc.Responder(taskResultHandler,faultHandler),URLConst.GETTASK_INFO_COMMANDID,taskByteArray);
		}
		/**
		 * 返回任务列表信息
		 */
		private var taskListComp:TaskListComponent;
		private function taskResultHandler(data:Object):void{
			var taskResponseByte:ByteArray = data as ByteArray;
			var taskResponse:getQuestListOnNpcResponse = new getQuestListOnNpcResponse();
			taskResponse.readExternal(taskResponseByte);
			if(taskResponse.result && taskResponse.data){
				var taskArr:ArrayCollection = new ArrayCollection();
				//可接受的任务	
				var tl:int = taskResponse.data.canReceivedquestList.length;
					for(var ti:int=0;ti<tl;ti++){
						var quest:proto.task.task1401.Quest = taskResponse.data.canReceivedquestList[ti];
						var taskInfoVo:TaskInfoVo = new TaskInfoVo();
						taskInfoVo.taskId = quest.taskId;
						taskInfoVo.taskname = quest.taskname;
						taskInfoVo.taskType = ProConst.ACCESSTASK;
						taskArr.addItem(taskInfoVo);
					}
				//进行中的任务
				var pl:int = taskResponse.data.progressingquestList.length;
				for(var pi:int=0;pi<pl;pi++){
					var questPro:proto.task.task1401.Quest = taskResponse.data.progressingquestList[pi];
					var taskInfoVoPro:TaskInfoVo = new TaskInfoVo();
					taskInfoVoPro.taskId = questPro.taskId;
					taskInfoVoPro.taskname = questPro.taskname+"--正在进行";
					taskInfoVoPro.taskType = ProConst.PROGRESSTASK;
					taskArr.addItem(taskInfoVoPro);
				}
				//完成的任务
				var cl:int = taskResponse.data.cancommitquestList.length;
				for(var ci:int=0;ci<cl;ci++){
					var questCommit:proto.task.task1401.Quest = taskResponse.data.cancommitquestList[ci];
					var taskInfoVoCom:TaskInfoVo = new TaskInfoVo();
					taskInfoVoCom.taskId = questCommit.taskId;
					taskInfoVoCom.taskname = questCommit.taskname+"--已完成";
					taskInfoVoCom.taskType = ProConst.CANSUBMITTASK;
					taskArr.addItem(taskInfoVoCom);
				}
				//失败任务
				var fl:int = taskResponse.data.failedquestList.length;
				for(var fi:int=0;fi<fl;fi++){
					var questFail:proto.task.task1401.Quest = taskResponse.data.failedquestList[fi];
					var taskInfoVoFail:TaskInfoVo = new TaskInfoVo();
					taskInfoVoFail.taskId = questFail.taskId;
					taskInfoVoFail.taskname = questFail.taskname+"--失败";
					taskInfoVoFail.taskType = ProConst.FAILTASK;
					taskArr.addItem(taskInfoVoFail);
				}
				//打开相应的窗口
				onOpenNpcChatWindow(taskResponse.data.npcId);
				SystemDataModel.taskListNpc.source = taskArr.toArray();
			}
		}
		/**
		 * 提交任务
		 */
		private function onSubmitTask(taskId:int):void{
			var commitTaskRequest:commitQuestRequest = new commitQuestRequest();
			commitTaskRequest.id = SystemDataModel.roleId;
			commitTaskRequest.taskId = taskId;
			var commitTaskByte:ByteArray = new ByteArray();
			commitTaskRequest.writeExternal(commitTaskByte);
			socketService.send(new mx.rpc.Responder(commitTaskHandler,faultHandler),URLConst.COMMIT_TASK_COMMANDID,commitTaskByte);
		}
		/**
		 * 提交任务返回处理
		 */
		private function commitTaskHandler(data:Object):void{
			var commitByte:ByteArray = data as ByteArray;
			var taskResponseCom:commitQuestResponse = new commitQuestResponse();
			taskResponseCom.readExternal(commitByte);
			if(taskResponseCom.result){
				var animation:AnimationOnceManager = new AnimationOnceManager(URLConst.TASK_COMPLETE_URL);
				animation.addToParent();
				animation.setPosition(400,200);
				animation.play();
			}
			popUpShow.show(taskResponseCom.message);
		}
		/**
		 * 获取副本数据
		 */
		private function getCopyInfoData(cId:int):void{
			var getCopyDataRequest:instanceActivateRequest = new instanceActivateRequest();
			getCopyDataRequest.id = SystemDataModel.roleId;
			getCopyDataRequest.csz = cId;
			var copyByteArray:ByteArray = new ByteArray();
			getCopyDataRequest.writeExternal(copyByteArray);
			xtrace("申请副本数据",getCopyDataRequest);
			socketService.send(new mx.rpc.Responder(copySceneDataHandler,faultHandler),URLConst.GETCOPYSCENE_DATA_COMMANDID,copyByteArray);
		}
		/**
		 * 得到的副本数据
		 */
		private function copySceneDataHandler(data:Object):void{
			var resCopyScene:ByteArray = data as ByteArray;
			var copySceneResponse:instanceActivateResponse = new instanceActivateResponse();
			copySceneResponse.readExternal(resCopyScene);
			if(copySceneResponse.result){
				xtrace("获得副本信息",new ObjectToString(copySceneResponse).getString());
				var fb_info:FuBenItemVo = MapConfig.getInstance().get_fb_by_id(copySceneResponse.data.csz);
				fb_info.id = copySceneResponse.data.csz;
				fb_info.level_stage = copySceneResponse.data.levelState;
				var chose:Array = copySceneResponse.data.info;
				var t_arr:Array = [];
				for each (var x:item in chose) 
				{
					var t:FubenChoseItemVo = MapConfig.getInstance().get_fb_item_by_id(x.id);
					//-1 没激活 1 激活 2 通关
					t.id0 = x.instanceList[0];
					t.id1 = x.instanceList[1];
					t.id2 = x.instanceList[2];
					t.state0 = x.stateList[0];
					t.state1 = x.stateList[1];
					t.state2 = x.stateList[2];
					t.monst_infos = x.monsterinfos;
					t._fuben_state = x.state;
					t.unin_state = fb_info.level_stage;
					t.is_enable = ( -1 != x.state);
					t.union_id = x.unionId;
					t.union_name = x.unionName;
					t.leader_id = x.leaderId;
					t.leader_name = x.leaderName;
					t.fu_camp = x.camp;
					t_arr.push(t);
				}
				fb_info.chose_items = t_arr;
				
				openCopySelectedComp(fb_info);
			}else{
//				popUpShow.show(copySceneResponse.message);
			}
		}
		/**
		 * 打开副本选择界面
		 */
		private function openCopySelectedComp(obj:Object):void{
			//如果打开世界地图的时候关闭世界地图
			if (WindowManager.isPopedUp(SceneMapView.NAME)) {
				WindowManager.closeWindow(SceneMapView.NAME, false, false, null, null, mediatorMap);
			}
			
			
			var _fb_info:FuBenItemVo = obj as FuBenItemVo;
			xtrace("初始化副本选择", _fb_info);
			//获取素材信息
			var img_infos:Array = [];
			var bg_asset_item:AssetItemInfo = new AssetItemInfo();
			bg_asset_item.id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE + "_BG_" + _fb_info.id;
			
			if (AssetCenter.getInstance().is_img_in_package(NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE,bg_asset_item.id)) {
				//已经存在这张地图资源
				show_copy_chose(obj);
			}
			else if (AssetCenter.getInstance().is_package_here(NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE)) {
				//存在副本数据,但是不存在改传送门数据
				bg_asset_item.package_id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE;
				bg_asset_item.path = _fb_info.bg_img_path;
				img_infos.push(bg_asset_item);
				for each (var item:FubenChoseItemVo in _fb_info.chose_items) {
					img_infos.push(make_chose_asset_info(item,"nomal_bg_path"));
					img_infos.push(make_chose_asset_info(item,"down_bg_path"));
					img_infos.push(make_chose_asset_info(item,"selected_bg_path"));
					img_infos.push(make_chose_asset_info(item,"disable_bg_path"));
				}
				AssetCenter.getInstance().add_and_load_package(NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE, img_infos, show_copy_chose,[obj]);
			}
			else{
				//不存在副本数据,也不存在该传送门数据
				bg_asset_item.package_id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE;
				bg_asset_item.path = _fb_info.bg_img_path;
				img_infos.push(bg_asset_item);
				for each (var item2:FubenChoseItemVo in _fb_info.chose_items) {
					img_infos.push(make_chose_asset_info(item2,"nomal_bg_path"));
					img_infos.push(make_chose_asset_info(item2,"down_bg_path"));
					img_infos.push(make_chose_asset_info(item2,"selected_bg_path"));
					img_infos.push(make_chose_asset_info(item2,"disable_bg_path"));
				}
				
				//添加边框素材
				img_infos.push(make_border_asset_info("TOPLEFT","assets/nfuben/fb_item_bg_top_left.png")); 
				img_infos.push(make_border_asset_info("TOPRIGHT","assets/nfuben/fb_item_bg_top_right.png")); 
				img_infos.push(make_border_asset_info("BOTTOMLEFT","assets/nfuben/fb_item_bg_bottom_left.png")); 
				img_infos.push(make_border_asset_info("BOTTOMRIGHT", "assets/nfuben/fb_item_bg_bottom_right.png")); 
				//添加星号标记
				img_infos.push(make_border_asset_info("STAR", "assets/nfuben/fb_icon_star.png")); 
				
				//添加讨伐标记
				img_infos.push(make_border_asset_info("TAOFA_BG", "assets/nfuben/fb_taofa_bg.png")); 
				img_infos.push(make_border_asset_info("TAOFA_DO_ICO_LIGHT", "assets/nfuben/fb_do_taofa_light.png")); 
				img_infos.push(make_border_asset_info("TAOFA_DO_ICO_NOMAL", "assets/nfuben/fb_do_taofa_nomal.png")); 
				img_infos.push(make_border_asset_info("TAOFA_JUNQI_ICO", "assets/nfuben/fb_junqi_ico.png")); 
				//添加tips背景
				img_infos.push(make_border_asset_info("Fb_MONSTER_BG", "assets/nfuben/fb_monster_tip.png")); 
				
				
				AssetCenter.getInstance().add_and_load_package(NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE,img_infos, show_copy_chose, [obj]);
			}
		}
		
		private function make_border_asset_info(id:String, path:String):AssetItemInfo {
			var item_img:AssetItemInfo = new AssetItemInfo();
			item_img.id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE + "_BORDER_" + id;
			item_img.package_id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE;
			item_img.path = path;
			return item_img;
		}
		
		private function make_chose_asset_info(item:FubenChoseItemVo, type:String):AssetItemInfo {
			var item_img:AssetItemInfo = new AssetItemInfo();
			item_img.id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE + "_CHOSE_" + type + "_" + item.id;
			item_img.package_id = NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE;
			item_img.path = item[type];
			return item_img;
		}
		
		private function show_copy_chose(obj:Object):void {
			if (WindowManager.isPopedUp(NCopySceneChoseView.NAME)) {
				return;
			}
			WindowManager.createWindow(NCopySceneChoseView.NAME, obj, null, false, false, false, null, mediatorMap, this.popUpWindowLayer);
			SystemDataModel.open_trip_id = (obj as FuBenItemVo).id;
			//清理新手指引
			//GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CHANGE_MODEL));
			//进入选择副本界面
			//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_SHOW_UI, GuideInfo.TYPE_UI_COPY_SCENE_CHOSE));
		}
		
		
//		/**
//		 * 点击进入队伍按钮，关闭副本选择界面
//		 */
//		private function onJoinGroupClick(evt:MouseEvent):void{
//			copySceneComp.groupHallBtn.removeEventListener(MouseEvent.CLICK,onJoinGroupClick);
//			onCloseCopySceneWindow();
//		}
//		/**
//		 * 关闭副本选择界面
//		 */
//		private function onCancelCopySceneComp(evt:MouseEvent):void{
//			copySceneComp.cancelBtn.removeEventListener(MouseEvent.CLICK,onCancelCopySceneComp);
//			onCloseCopySceneWindow();
//		}
//		private function onCloseCopySceneWindow():void{
//		    this.contextView.removeChild(copySceneComp);	
//		}
		/**
		 * 进入副本
		 */
		private function onEnterCopyScene(evt:MouseEvent):void{
			//关闭副本选择界面
//			onCloseCopySceneWindow();
//			copySceneComp.enterCopySceneBtn.removeEventListener(MouseEvent.CLICK,onEnterCopyScene);
			var enterCopySceneR:enterInstanceRequest = new enterInstanceRequest();
			enterCopySceneR.id = SystemDataModel.roleId;
//			enterCopySceneR.InstanceId=copySceneComp.curCopySceneId;
			var enterCopyByte:ByteArray = new ByteArray();
			enterCopySceneR.writeExternal(enterCopyByte);
			socketService.send(new mx.rpc.Responder(enterCopySceneHandler,faultHandler),URLConst.ENTER_COPYSCENE_COMMANDID,enterCopyByte);
			isCanSwitchScene = false;
		}
		/**
		 * 进入副本返回处理
		 */
		private function enterCopySceneHandler(data:Object):void{
			var enterCopySceneB:ByteArray = data as ByteArray;
			var copySceneResponse:enterInstanceResponse = new enterInstanceResponse();
			copySceneResponse.readExternal(enterCopySceneB);
			isCanSwitchScene = true;
		    if(copySceneResponse.result && copySceneResponse.data){
//				loadScene(copySceneResponse.data.placeId);
//				//要加载场景的类型
//				changeSceneType = COPYSCENE;
			}else{
				popUpShow.show(copySceneResponse.message);
			}
		}

		
		/**
		 * 添加任务信息追踪监听
		 */
		private function addTaskEventListener():void{
			socketService.send(new mx.rpc.Responder(taskHandler,faultHandler),URLConst.TASK_RUDE_COMMANDID,null,false);
		}
		/**
		 *任务追踪信息返回处理 
		 */
		private function taskHandler(data:Object):void{
			dispatch(new TaskTrackingEvent(TaskTrackingEvent.TASKTRACKINGEVENT,data));
		}
		
		/**
		 * 监听同盟其他玩家的复活请求
		 */
		private function addOtherRoleRequestResur():void{
			socketService.send(new mx.rpc.Responder(otherResurHandler,faultHandler),URLConst.OTHERROLE_RESUR_COMMANDID,null,false);
		}
		/**
		 * 收到服务器发送来的其他玩家复活请求
		 */
		private var victimerId:int;
	　　private function otherResurHandler(data:Object):void{
		    var requestResurByte:ByteArray = data as ByteArray;
		    var reqeustResResponseData:pushAskForRevive = new pushAskForRevive();
		    reqeustResResponseData.readExternal(requestResurByte);
			victimerId = reqeustResResponseData.victimerId;
		    var resurStr:String = "您的队友"+reqeustResResponseData.victimerName+"在战斗中阵亡，他的英灵尚未消散，您愿意将他复活吗？";   
		    popUpShow.show(resurStr,null,null,null,null,submitResurHandler);
	    }
	   /**
	   * 确定复活队友
	   */
	    private function submitResurHandler(evt:MouseEvent):void{
			sendResurCommand(ProConst.RESUR_ITEM_COMMANDID);
		}
	    private function sendResurCommand(t:int):void{
			var sendResurQuest:ReviveTeamMemberRequest = new ReviveTeamMemberRequest();
			sendResurQuest.id = SystemDataModel.roleId;
			sendResurQuest.victimerId = victimerId;
			sendResurQuest.paytype = t;
			var sendResurByte:ByteArray = new ByteArray();
			sendResurQuest.writeExternal(sendResurByte);
			socketService.send(new mx.rpc.Responder(sendResureHandler,faultHandler),URLConst.RESUR_OTHER_COMMANDID,sendResurByte);
		}
		/**
		 * 复活队友返回处理
		 */
		private function sendResureHandler(data:ByteArray):void{
			var sendResurByte:ByteArray = data as ByteArray;
			var resurResponse:ReviveTeamMemberResponse = new ReviveTeamMemberResponse();
			resurResponse.readExternal(sendResurByte);
			if(resurResponse.result){
				
			}else{
				if(resurResponse.data.faildtype == ProConst.RESUR_NOTITEM){
					var reStr:String = "您的背包中没有复活道具，您是否需要花费"+resurResponse.data.goldprice+"金币直接在商城中购买并使用!";
					popUpShow.show(reStr,null,null,null,null,submitUseGoldResurHandler);
				}else if(resurResponse.data.faildtype == ProConst.RESUR_GOLD_COMMANDID){
					var payStr:String = "金币不足，请充值！";
					popUpShow.show(payStr);
				}else{
					popUpShow.show(resurResponse.message);
				}
				
			}
		}
		/**
		 * 
		 */
		private function submitUseGoldResurHandler(evt:MouseEvent):void{
			sendResurCommand(ProConst.RESUR_GOLD_COMMANDID);
		}
		/**
		 * //添加服务器切换场景指令 被动切换
		 */
		private function addChangeSceneEventListener():void{
			socketService.send(new mx.rpc.Responder(resultSwitchSceneHandler,faultHandler),URLConst.ADDEVENTLISTER_CHANGESCENE_COMMANDID,null,false);
		}
		private function resultSwitchSceneHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:EnterSceneMessage = new EnterSceneMessage();
			responseData.readExternal(byteArray);
			
			Logging.log('进入场景', Logging.o2s(responseData));
			//场景id
			SystemDataModel.placeId = responseData.sceneId;
			SystemDataModel.sceneCorpsName = responseData.corpsName;
			SystemDataModel.rewardCorpsName = responseData.rewardCorpsName;
			SystemDataModel.sceneName = responseData.scenename;
			
			//把标志位设为不可传入 此时以后不更新玩家信息，直到新场景加载完毕
			SystemDataModel.sceneIsLoaded = false;
			//通过场景的资源id加载相应场景
			//loadScene(responseData.resourceId);
			GuidEventCenter.getInstance().dispatchEvent(
				new SwitchMaskEvent(
					SwitchMaskEvent.SwitchMaskEvent_SHOW,
					loadScene,
					[responseData.resourceId]
				)
			);
					
			
			// npcInfo
			var npc_len:int = responseData.npclist.length;
			var npcArr:Array = [];
			for(var i:int=0;i<npc_len;i++){
				var rNpcVo:RNpcVo = new RNpcVo();
				rNpcVo.id = responseData.npclist[i].npcId;
				rNpcVo.name = responseData.npclist[i].npcName;
				rNpcVo.professionType = responseData.npclist[i].resourceId;
				rNpcVo.functionType = responseData.npclist[i].funcType;
				rNpcVo.position = new Point(responseData.npclist[i].positionX,responseData.npclist[i].positionY);
				npcArr.push(rNpcVo);
			}
			SystemDataModel.npcInfoArr = npcArr;
			WordSceneSprite.getInstance().npcData = npcArr;
			
			//传送门信息
			var sw_len:int=responseData.portals.length;
			var swArr:Array = [];
			for(var si:int=0;si<sw_len;si++){
				var vo:RSwitchVo = new RSwitchVo();
				vo.id = responseData.portals[si].portalId;
				vo.name = responseData.portals[si].portalName;
				vo.professionType = responseData.portals[si].resourceId;
				vo.position = new Point(responseData.portals[si].positionX,responseData.portals[si].positionY);
				swArr.push(vo);
			}
			SystemDataModel.switchInfoArr = swArr;
			WordSceneSprite.getInstance().switchData = swArr;
			
			
			this.dispatch(new NMainUIEvent(NMainUIEvent.NMainUIEvent_REFRESH_TRIPS_INFO));
		}
		private function testHandler(data:Object):void{
//			trace("成功复活");
		}
		/**
		 * 升级信息监听
		 */
		private function addLevelUpInfo():void{
			socketService.send(new mx.rpc.Responder(levelUpHandler,faultHandler),URLConst.ROLE_LEVELUP_COMMANDID,null,false);
		}
		/**
		 * 收到升级信息
		 */
		private function levelUpHandler(data:Object):void{
			var levelUpByte:ByteArray = data as ByteArray;
			var levelResponseData:pushCharacterLevelMessage = new pushCharacterLevelMessage();
			levelResponseData.readExternal(levelUpByte);
			//characterOp.playLevelUp(SystemDataModel.roleId);
			var animation:AnimationOnceManager = new AnimationOnceManager(URLConst.LEVEL_UP_URL);
			animation.addToParent();
			if(FlexGlobals.topLevelApplication.height > 650){
				animation.setPosition(FlexGlobals.topLevelApplication.width/2-100,240);
			}else{
				animation.setPosition(FlexGlobals.topLevelApplication.width/2-100,FlexGlobals.topLevelApplication.height/2-85);
			}
			
			animation.play();
			this.dispatch(new SceneLoadedAndShowSceneNameEvent(SceneLoadedAndShowSceneNameEvent.LEVELUPEFFECT,SystemDataModel.placeResId));
		}
		
		/**
		 * 监听进入战斗
		 */
		private function addEventListenerEnterBattle():void{
			socketService.send(new mx.rpc.Responder(fightResultHandler, faultHandler), URLConst.ENTERBATTLE_SERVER_COMMANDID, null, false);
		}
		/**
		 * addEventListererEnterCopyScene
		 */
		private function addEventListererEnterCopyScene():void{
			socketService.send(new mx.rpc.Responder(enterCopySceneCommandHandler,faultHandler),URLConst.ENTERSERVER_COPYSCENE_COMMANDID,null,false);
		}
		/**
		 * 服务器推送的消息
		 */
		private var leaderid:int;
		private function enterCopySceneCommandHandler(data:Object):void{
			var teamResponseByte:ByteArray = data as ByteArray;
			var teamResponseData:instanceTeamResponse = new instanceTeamResponse();
			teamResponseData.readExternal(teamResponseByte);
			leaderid = teamResponseData.leaderid;
			popUpShow.show("确定进入副本？",null,null,null,null,submitEnterCopyScene);
		}
		/**
		 * 确定进入队长所选的副本
		 */
		private function submitEnterCopyScene(evt:MouseEvent):void{
			var submitEnterCopySceneR:teamInstanceRequest = new teamInstanceRequest();
			submitEnterCopySceneR.id = SystemDataModel.roleId;
			submitEnterCopySceneR.leaderid = leaderid;
			var submitByteArray:ByteArray = new ByteArray();
			submitEnterCopySceneR.writeExternal(submitByteArray);
			socketService.send(new mx.rpc.Responder(submitEnterCopySceneHandler,faultHandler),URLConst.SUBMIT_ENTERCOPYSCENE_COMMANDID,submitByteArray);
		}
		/**
		 * 进入队长指定副本返回处理
		 */
		private function submitEnterCopySceneHandler(data:Object):void{
			var enterCopySceneByteArray:ByteArray = data as ByteArray;
			var enterCopyResponse:teamInstanceResponse = new teamInstanceResponse();
			enterCopyResponse.readExternal(enterCopySceneByteArray);
			if(!enterCopyResponse.result){
				popUpShow.show(enterCopyResponse.message);
			}
		}
		/**
		 * 获取NPC状态信息
		 */
		private function getNpcStatuInfo(e:Event = null):void{
			var npcStatusRequest:getScenceNpcQuestStatusRequest = new getScenceNpcQuestStatusRequest();
			npcStatusRequest.id = SystemDataModel.roleId;
			var npcStatusByte:ByteArray = new ByteArray();
			npcStatusRequest.writeExternal(npcStatusByte);
			socketService.send(new mx.rpc.Responder(npcStatusHandler,faultHandler),URLConst.NPC_STATUS_COMMANDID,npcStatusByte);
		}
		/**
		 * NPC状态改变
		 */
		private function addEventListenerNPCState():void{
			socketService.send(new mx.rpc.Responder(npcStatusHandler,faultHandler),URLConst.NPC_STATUS_COMMANDID,null,false);
		}
		/**
		 * 服务器返回NPC状态更改
		 */
		private function npcStatusHandler(data:Object):void{
			var npcStatusByteArray:ByteArray = data as ByteArray;
			var npcStatusResponse:getScenceNpcQuestStatusResponse = new getScenceNpcQuestStatusResponse();
			npcStatusResponse.readExternal(npcStatusByteArray);
			//todo wordscene
			Logging.log("更新npc", Logging.o2s(npcStatusResponse));
			WordSceneSprite.getInstance().updataNPCState(npcStatusResponse.NPCQuestStatusList);
			return;
		}
		/**
		 * 战斗血量变化
		 */
		/*private function onBattleChangeHp(evt:BattleChangeHpEvent):void{
			if(SystemDataModel.roleId == evt.id){
				SystemDataModel.roleInfo.hp = evt.resultHp;
				SystemDataModel.roleInfo.mp = evt.resultMp;
			}			
		}*/
		/**
		 * 监听服务推送的房间角色信息
		 */
		private function addRoomRoleListListener():void{
			socketService.send(new mx.rpc.Responder(roleOfRoomHandler,faultHandler),URLConst.GROUPHALL_ROOMROLEINFO_COMMANDID,null,false);
		}
		
		private function roleOfRoomHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetRoleOfRoomInfoResponse = new GetRoleOfRoomInfoResponse();
			responseData.readExternal(byteArray);
			var l:int = responseData.roleOfRoomInfo.length;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int = 0;i<l;i++){
				var roleOfRoomInfo:RoleOfRoomInfo = responseData.roleOfRoomInfo[i];
				var roomRoleListRoleInfo:RoomRoleListRoleInfoVo = new RoomRoleListRoleInfoVo();
				roomRoleListRoleInfo.isReady = roleOfRoomInfo.isReady;
				roomRoleListRoleInfo.isRoomOwner = roleOfRoomInfo.isRoomOwner;
				if(roleOfRoomInfo.isRoomOwner){
					if(SystemDataModel.roleId == roleOfRoomInfo.roleId){
						SystemDataModel.curRoleIsOwnerFlag = true;
					}else{
						SystemDataModel.curRoleIsOwnerFlag = false;
					}
				}
				roomRoleListRoleInfo.roleId = roleOfRoomInfo.roleId;
				roomRoleListRoleInfo.roleLevel = roleOfRoomInfo.roleLevel;
				roomRoleListRoleInfo.roleName = roleOfRoomInfo.roleName;
				roomRoleListRoleInfo.roleWork = roleOfRoomInfo.roleWork;
				arr.addItem(roomRoleListRoleInfo);
			}
			SystemDataModel.roomRoleInfoList.source = arr.toArray();
		}
		/**
		 * 
		 * 监听邀请加入房间请求
		 */
		private function addInviteJoinRoomListener():void{
			socketService.send(new mx.rpc.Responder(inviteJoinRoomHandler,faultHandler),URLConst.GROUPHALL_INVITEJOINROOM_COMMANDID,null,false);
		}
		/**
		 * 邀请进入房间请求
		 */
		private var tempInviteId:int;
		private var tempAreaId:int;
		private var tempRoomId:int;
		private function inviteJoinRoomHandler(data:Object):void{
			var joinRoomByte:ByteArray = data as ByteArray;
			var joinRoomResponse:InviteJoinGroupMsg = new InviteJoinGroupMsg();
			joinRoomResponse.readExternal(joinRoomByte);
			tempInviteId = joinRoomResponse.inviteID;
			tempAreaId = joinRoomResponse.areaID;
			tempRoomId = joinRoomResponse.roomId;
			popUpShow.show(joinRoomResponse.message,null,null,'接受','拒绝',acceptHandler,refuseHandler);
		}
		/**
		 * 接受加入房间邀请
		 */
		private function acceptHandler(evt:MouseEvent):void{
			var acceptJoinReq:InviteJoinGroupAcceptRequest = new InviteJoinGroupAcceptRequest();
			acceptJoinReq.id = SystemDataModel.roleId;
			acceptJoinReq.areaId = tempAreaId;
			acceptJoinReq.inviteId = tempInviteId;
			acceptJoinReq.roomId = tempRoomId;
			var acceptByte:ByteArray = new ByteArray();
			acceptJoinReq.writeExternal(acceptByte);
			socketService.send(new mx.rpc.Responder(acceptJoinHandler,faultHandler),URLConst.GROUPHALL_ACCEPTINVITE_COMMANDID,acceptByte);
		}
		private function acceptJoinHandler(data:Object):void{
			var acceptJoinByte:ByteArray = data as ByteArray;
			var acceptRes:InviteJoinGroupAcceptResponse = new InviteJoinGroupAcceptResponse();
			acceptRes.readExternal(acceptJoinByte);
			if(acceptRes.result){
//				WindowManager.createWindow(MainRoomComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}
		}
		/**
		 * 拒绝加入房间邀请
		 */
		private function refuseHandler(evt:MouseEvent):void{
			var refuseJoinReq:InviteJoinGroupRefuseRequest = new InviteJoinGroupRefuseRequest();
			refuseJoinReq.id = SystemDataModel.roleId;
			refuseJoinReq.inviteId = tempInviteId;
			var refuseByte:ByteArray = new ByteArray();
			refuseJoinReq.writeExternal(refuseByte);
			socketService.send(new mx.rpc.Responder(refuseJoinHandler,faultHandler),URLConst.GROUPHALL_REFUSEINVITE_COMMANDID,refuseByte);
		}
		private function refuseJoinHandler(data:Object):void{
			
		}
		/**
		 * 监听服务器推送的Buff信息
		 */
		private function addEventListenerBuffListInfo():void{
			socketService.send(new mx.rpc.Responder(buffListResponseHandler,faultHandler),URLConst.BUFFLIST_INFO_COMMANDID,null,false);
		}
		/**
		 * buffListResponseHandler
		 */
		private function buffListResponseHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetBuffListInfoResponse = new GetBuffListInfoResponse();
			responseData.readExternal(byteArray);
			var l:int = responseData.buffInfo.length;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var buffInfoVo:BuffInfoVO = new BuffInfoVO();
				buffInfoVo.buffDes = responseData.buffInfo[i].buffDes;
				buffInfoVo.buffId = responseData.buffInfo[i].buffId;
				buffInfoVo.buffName = responseData.buffInfo[i].buffName;
				buffInfoVo.icon = responseData.buffInfo[i].icon;
				buffInfoVo.timeAndCountFlag = responseData.buffInfo[i].timeAndCountFlag;
				buffInfoVo.timeOrCount = responseData.buffInfo[i].timeOrCount;
				buffInfoVo.type = responseData.buffInfo[i].type;
				arr.addItem(buffInfoVo);
			}
			scenePageView.buffComp.onDataChange(arr);
//			SystemDataModel.buffListArr.source = arr.toArray();
		}
		/**
		 * 打开私聊窗口事件 
		 */		
		private function addEventlistenerOpenWhisperWindow():void{
			JingJiMessage.getInstance().event_dispatcher.addEventListener(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,onOpenWhisperWindow);
			this._eventDispatcher.addEventListener(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,onOpenWhisperWindow);
		}
		//临时私聊对象信息
		private var tempobj:Object;
		private function onOpenWhisperWindow(evt:MainOpenWhisperWindowEvent):void{
			FriendMessage.getInstance().requese_friend_list();
			tempobj = new Object();
			tempobj.chatObjectId = evt.chatID;
			tempobj.name = evt.name;
			AssetCenter.getInstance().load_package("ui_whisper", to_whisper, null, true);
		}
		private function to_whisper():void{
			WindowManager.closeWindow(CorpsInfoComponent.NAME);
			WindowManager.createWindow(MainOneToOneChatWindow.NAME,tempobj,null,false,true,false,null,mediatorMap,popUpWindowLayer,true);
			
			this.dispatch(new NFriendEvent(NFriendEvent.NFriendEvent_OPEN));
		}
		/**
		 * 推送最近联系人列表
		 */
		private function addNearChatList():void{
			chatService.send(new mx.rpc.Responder(nearChatListHandler,faultHandler),URLConst.CHAT_OBJECTLIST_COMMANDID,null,false);
		}
		private function nearChatListHandler(data:Object):void{
			SystemDataModel.whisperObjList.removeAll();
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ChatToObjectListResponse = new ChatToObjectListResponse();
			responseData.readExternal(byteArray);
			var l:int = responseData.chatObjectInfo.length;
			//var arr:ArrayCollection = new ArrayCollection();
//			for(var i:int=0;i<l;i++){
			for(l-1;l>0;l--){
				var whisperChatInfoVo:WhisperChatObjectInfoVO = new WhisperChatObjectInfoVO();
				whisperChatInfoVo.chatObjectId = responseData.chatObjectInfo[l-1].chatObjectId;
				whisperChatInfoVo.chatObjectPos = responseData.chatObjectInfo[l-1].chatObjectPos;
				whisperChatInfoVo.level = responseData.chatObjectInfo[l-1].level;
				whisperChatInfoVo.name = responseData.chatObjectInfo[l-1].name;
				whisperChatInfoVo.perfession = responseData.chatObjectInfo[l-1].perfession;
				whisperChatInfoVo.readFlag = responseData.chatObjectInfo[l-1].readFlag;
				SystemDataModel.whisperObjList.addItem(whisperChatInfoVo);
			}
			//SystemDataModel.whisperObjList.source = arr.toArray();
			this.dispatch(new ChatToObjectListEvent(ChatToObjectListEvent.CHATTOOBJECTLISTEVENT));
		}
		private function addNewMailShow():void{
			socketService.send(new mx.rpc.Responder(newMailHandler,faultHandler),URLConst.MAIL_NEW_COMMANDID,null,false);
		}
		private function newMailHandler(data:Object):void{
			SystemDataModel.newMailFlag = true;
		}
		//获取黑名单
		public function getBlackName():void
		{
			var requestGetFriendsInfo:proto.friends.friends302.getPlayerFrindsRequest = new getPlayerFrindsRequest();
			requestGetFriendsInfo.id = SystemDataModel.roleId;
//			requestGetFriendsInfo.type = 2;
			var playerInfoByteArray:ByteArray = new ByteArray();
			requestGetFriendsInfo.writeExternal(playerInfoByteArray);
			socketService.send(new mx.rpc.Responder(getBlackListHandler,faultHandler),URLConst.GET_BLACKPLAYER_COMMANDID,playerInfoByteArray,true);
		}
		
		public function getBlackListHandler(data:Object):void
		{
			SystemDataModel.blackPlayerList.removeAll();
			var responseData:proto.friends.friends302.getPlayerFrindsResponse = new getPlayerFrindsResponse();
			var byteArray:ByteArray = data as ByteArray;
			responseData.readExternal(byteArray);
			var l:int = responseData.data.friends.length;
			for(var i:int=0;i<l;i++){
				var blackListVo:FriendInfoVo=new FriendInfoVo();
				blackListVo.roleId=responseData.data.friends[i].roleId;
				blackListVo.roleName=responseData.data.friends[i].roleName;
				blackListVo.roleProfession=responseData.data.friends[i].roleProfession
				SystemDataModel.blackPlayerList.addItem(blackListVo);
			}
		}
		private function addDragEnterOtherListener():void{
			this.eventMap.mapListener(scenePageView,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(scenePageView,DragEvent.DRAG_DROP,onDragDrop);
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
				var dropStr:String = "你确定丢弃该物品！！！";
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
				getEquipmentInfo(SystemDataModel.packageinfoVo.curPage);
				getEquipmentInSlotInfo();
			}else{
				popUpShow.show(dropResponse.message);
			}
		}
		
		//翻牌子
		private function onBattleFlipHandler(evt:BattleFlipEvent):void{
			//添加监听显示翻牌子界面
			addShowFlipCompInfo();
			//获取战斗结束后翻牌子所需要的物品信息
			getBattleOverFlipItemInfo();
			//把本次翻动牌子的次数重置为0
			SystemDataModel.flipCount = 0;
		}
		
		//显示ui进度条
		private function show_ui_load(e:UILoadEvent):void {
			WindowManager.createWindow(UILoaderProgressBarView.NAME,null,null,false,true,false,null,mediatorMap,popUpWindowLayer,true);
		}
		//隐藏ui进度条
		private function hide_ui_load(e:UILoadEvent):void {
			WindowManager.closeWindow(UILoaderProgressBarView.NAME);
		}
		
		//显示战役
		public function showZhanyi(e:Event = null):void {
			var req:GetNowZhanYiInfoRequest = new GetNowZhanYiInfoRequest();
			req.id = SystemDataModel.roleId;
			req.index = -1;
			var bytes:ByteArray = new ByteArray();
			req.writeExternal(bytes);
			socketService.send(new mx.rpc.Responder(getZhanyiRes, faultHandler), URLConst.ZHANYI_REQUEST_LIST, bytes);
			Logging.log("请求战役数据");
		}
		
		//返回战役数据
		public function getZhanyiRes(data:Object):void {
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetNowZhanYiInfoResponse = new GetNowZhanYiInfoResponse();
			responseData.readExternal(byteArray);
			Logging.log("战役数据返回", Logging.o2s(responseData));
			if (responseData.result) {
				ZhanyiModel.getInstance().sdata = responseData.data;
				AssetCenter.getInstance().load_package('zhanyi', zhanyiLoaded, [], true);
			}
		}
		
		//测试打开战役
		public function teseOpenZhanyi():void {
			AssetCenter.getInstance().load_package('zhanyi', zhanyiLoaded, [], true);
		}
		
		//加载占已完成
		public function zhanyiLoaded():void {
			WindowManager.createWindow(ZhanyiView.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		//隐藏战役
		public function hideZhanyi():void {
			WindowManager.closeWindow(ZhanyiView.NAME);
		}
	}
	
}
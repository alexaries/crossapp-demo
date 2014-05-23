package sceneModule
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import sceneModule.view.zhanyi.mediator.ZhanyiViewMediator;
	import sceneModule.view.zhanyi.view.ZhanyiView;
	import wordscene.WordSceneSprite;
	
	import loader.ProgressBarControl;
	import loader.UILoaderProgressBarView;
	
	import managers.KeyBordManager;
	
	import model.ServerConfig;
	
	import org.robotlegs.mvcs.Context;
	
	import sceneModule.command.ColonizationBattleResponseCommand;
	import sceneModule.command.EnterBattlePlaceResponseCommand;
	import sceneModule.command.GetItemsInTempPackageResponseCommand;
	import sceneModule.command.GetRoleInfoResponseCommand;
	import sceneModule.command.GetRoleItemInPackageResponseCommand;
	import sceneModule.command.GetRoleItemResponseCommand;
	import sceneModule.command.GetWarehouseInfoResponseCommand;
	import sceneModule.command.TeamMemberInfoResponseCommand;
	import sceneModule.event.ColonizationBattleResponseEvent;
	import sceneModule.event.EnterBattlePlaceResponseEvent;
	import sceneModule.event.GetItemsInTempPackageResponseEvent;
	import sceneModule.event.GetRoleInfoResponseEvent;
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.event.GetRoleItemResponseEvent;
	import sceneModule.event.GetWarehouseInfoResponseEvent;
	import sceneModule.event.TeamMemberInfoResponseEvent;
	import sceneModule.mediator.MenuBarMediator;
	import sceneModule.mediator.SceneEffectLayerMediator;
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.mediator.ScenePageMediator;
	import sceneModule.model.SceneMessage;
	import sceneModule.view.GM.mediator.GMcomponentMediator;
	import sceneModule.view.GM.view.GMcomponent;
	import sceneModule.view.GameTopUI.mediator.GameTopUIItemRenderMediator;
	import sceneModule.view.GameTopUI.mediator.GameTopUImediator;
	import sceneModule.view.GameTopUI.view.GameTopUI;
	import sceneModule.view.GameTopUI.view.GameTopUIItemRender;
	import sceneModule.view.SceneEffectLayer;
	import sceneModule.view.ScenePageView;
	import sceneModule.view.announ.mediator.AnnounComponentMediator;
	import sceneModule.view.announ.view.AnnounComponent;
	import sceneModule.view.battle.command.BattleAndCopySceneMessage;
	import sceneModule.view.battle.command.BattleOverGetItemInfoResponseCommand;
	import sceneModule.view.battle.event.BattleOverGetItemInfoResponseEvent;
	import sceneModule.view.battle.mediator.BattleColonizationFailWindowMediator;
	import sceneModule.view.battle.mediator.BattleColonizationWindowMediator;
	import sceneModule.view.battle.mediator.BattleFailSettlementComponentMediator;
	import sceneModule.view.battle.mediator.BattleFlipItemRenderMediator;
	import sceneModule.view.battle.mediator.BattleFlipMediator;
	import sceneModule.view.battle.mediator.BattleSuccessSettlementComponentMediator;
	import sceneModule.view.battle.mediator.BattleSuccessSettlementItemRenderMediator;
	import sceneModule.view.battle.view.BattleColonizationFailWindow;
	import sceneModule.view.battle.view.BattleColonizationWindow;
	import sceneModule.view.battle.view.BattleFailSettlementWindow;
	import sceneModule.view.battle.view.BattleFlipComponent;
	import sceneModule.view.battle.view.BattleFlipItemRender;
	import sceneModule.view.battle.view.BattleSuccessSettlementItemRender;
	import sceneModule.view.battle.view.BattleSuccessSettlementWindow;
	import sceneModule.view.blacksmith.command.BlacksmithMessage;
	import sceneModule.view.blacksmith.mediator.HeChengComponentMediator;
	import sceneModule.view.blacksmith.mediator.MainEquipmentComponentMediator;
	import sceneModule.view.blacksmith.mediator.MainEquipmentZhuanYiComponentMediator;
	import sceneModule.view.blacksmith.mediator.MainStrEquipmentItemRenderMediator;
	import sceneModule.view.blacksmith.mediator.MainStrFunctionComponentMediator;
	import sceneModule.view.blacksmith.mediator.StrengthenButtonMediator;
	import sceneModule.view.blacksmith.mediator.StrengthenComponentMediator;
	import sceneModule.view.blacksmith.mediator.XiangQianAndUnloadConfimComponentMediator;
	import sceneModule.view.blacksmith.mediator.XiangQianComponentMediator;
	import sceneModule.view.blacksmith.mediator.XiangQianItemRenderMediator;
	import sceneModule.view.blacksmith.mediator.ZhuanYiComponentMediator;
	import sceneModule.view.blacksmith.mediator.ZhuanYiItemRenderMediator;
	import sceneModule.view.blacksmith.view.HeChengComponent;
	import sceneModule.view.blacksmith.view.MainEquipmentComponent;
	import sceneModule.view.blacksmith.view.MainEquipmentZhuanYiComponent;
	import sceneModule.view.blacksmith.view.MainStrEquipmentItemRender;
	import sceneModule.view.blacksmith.view.MainStrFunctionComponent;
	import sceneModule.view.blacksmith.view.StrengthenButton;
	import sceneModule.view.blacksmith.view.StrengthenComponent;
	import sceneModule.view.blacksmith.view.XiangQianAndUnloadConfimComponent;
	import sceneModule.view.blacksmith.view.XiangQianComponent;
	import sceneModule.view.blacksmith.view.XiangQianItemRender;
	import sceneModule.view.blacksmith.view.ZhuanYiComponent;
	import sceneModule.view.blacksmith.view.ZhuanYiItemRender;
	import sceneModule.view.buff.mediator.BuffComponentItemRenderMeidator;
	import sceneModule.view.buff.view.BuffComponentItemRender;
	import sceneModule.view.calendar.command.GetCalendarInfoResponseCommand;
	import sceneModule.view.calendar.event.CalendarEvent;
	import sceneModule.view.calendar.mediator.CalendarInfoMediator;
	import sceneModule.view.calendar.view.CalendarInfoComponent;
	import sceneModule.view.chat.mediator.AddToBlackWarningComponentMediator;
	import sceneModule.view.chat.mediator.ChatWindowMediator;
	import sceneModule.view.chat.mediator.MainOneToOneChatWindowMediator;
	import sceneModule.view.chat.view.AddToBlackWarningComponent;
	import sceneModule.view.chat.view.ChatWindow;
	import sceneModule.view.chat.view.MainOneToOneChatWindow;
	import sceneModule.view.colonMan.command.ColonManMessage;
	import sceneModule.view.colonMan.mediator.ColonManEquipmentItemRenderMediator;
	import sceneModule.view.colonMan.mediator.MainColoManagerWindowMediator;
	import sceneModule.view.colonMan.mediator.MainColoPrivilegeFuBenColoInfoWindowMediator;
	import sceneModule.view.colonMan.mediator.MainColoPrivilegeFuBenItemRenderMediator;
	import sceneModule.view.colonMan.mediator.MainColoPrivilegeWindowMediator;
	import sceneModule.view.colonMan.view.ColonManEquipmentItemRender;
	import sceneModule.view.colonMan.view.MainColoManagerWindow;
	import sceneModule.view.colonMan.view.MainColoPrivilegeFuBenColoInfoWindow;
	import sceneModule.view.colonMan.view.MainColoPrivilegeFuBenItemRender;
	import sceneModule.view.colonMan.view.MainColoPrivilegeWindow;
	import sceneModule.view.copyScene.mediator.ColonizationBattleByCopySceneComponentMediator;
	import sceneModule.view.copyScene.mediator.NCopySceneChoseMediator;
	import sceneModule.view.copyScene.view.ColonizationBattleByCopySceneComponent;
	import sceneModule.view.copyScene.view.NCopySceneChoseView;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.corps.mediator.NCorpsEmblemMediator;
	import sceneModule.view.corps.mediator.NCorpsInMediator;
	import sceneModule.view.corps.mediator.NCorpsKejiMediator;
	import sceneModule.view.corps.mediator.NCorpsMemberMediator;
	import sceneModule.view.corps.mediator.NCorpsOutMediator;
	import sceneModule.view.corps.mediator.NCorpsRequestMediator;
	import sceneModule.view.corps.mediator.NCorpsRootMediator;
	import sceneModule.view.corps.view.NCropEmblemView;
	import sceneModule.view.corps.view.NCropKejiView;
	import sceneModule.view.corps.view.NCropMemberView;
	import sceneModule.view.corps.view.NCropRequestView;
	import sceneModule.view.corps.view.NCropsInView;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.corps.view.NCropsRootView;
	import sceneModule.view.friend.command.FriendMessage;
	import sceneModule.view.friend.command.GetPlayerFrindsResponseCommand;
	import sceneModule.view.friend.event.GetPlayerFrindsResponseEvent;
	import sceneModule.view.friend.mediator.MainMenuFriendMediator;
	import sceneModule.view.friend.view.MainMenuFriendView;
	import sceneModule.view.gaAndsd.mediator.GuaJiConfimComponentMediator;
	import sceneModule.view.gaAndsd.mediator.GuaJiToolTipMediator;
	import sceneModule.view.gaAndsd.mediator.SaoDangWindowMediator;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.gaAndsd.view.GuaJiToolTip;
	import sceneModule.view.gaAndsd.view.SaoDangWindow;
	import sceneModule.view.group.command.GroupMessage;
	import sceneModule.view.group.mediator.CreateOrJoinWindowMediator;
	import sceneModule.view.group.mediator.GroupWindowMediator;
	import sceneModule.view.group.view.CreateOrJoinWindow;
	import sceneModule.view.group.view.GroupWindow;
	import sceneModule.view.groupBattle.command.GroupBattleMessage;
	import sceneModule.view.groupBattle.mediator.CityListComponentMediator;
	import sceneModule.view.groupBattle.mediator.GroupBattleInfoComponentMediator;
	import sceneModule.view.groupBattle.mediator.GroupCityComponentMediator;
	import sceneModule.view.groupBattle.mediator.LingDiComponentMediator;
	import sceneModule.view.groupBattle.mediator.XuYuanComponentMediator;
	import sceneModule.view.groupBattle.view.CityListComponent;
	import sceneModule.view.groupBattle.view.GroupBattleInfoComponent;
	import sceneModule.view.groupBattle.view.GroupCityComponent;
	import sceneModule.view.groupBattle.view.LingDiComponent;
	import sceneModule.view.groupBattle.view.XuYuanComponent;
	import sceneModule.view.guanjue.command.GetGuanjueInfoCommand;
	import sceneModule.view.guanjue.command.GetShengWangInfoCommand;
	import sceneModule.view.guanjue.event.GuanjueEvent;
	import sceneModule.view.guanjue.event.ShengWangEvent;
	import sceneModule.view.guanjue.mediator.GuanjueWindowMediator;
	import sceneModule.view.guanjue.mediator.ShengWangComponentMediator;
	import sceneModule.view.guanjue.mediator.ShengWangItemRenderMediator;
	import sceneModule.view.guanjue.view.GuanjueWindow;
	import sceneModule.view.guanjue.view.ShengWangComponent;
	import sceneModule.view.guanjue.view.ShengWangItemRender;
	import sceneModule.view.jingji.command.JingJiMessage;
	import sceneModule.view.jingji.mediator.JingJiBattleJieSuanWindowMediator;
	import sceneModule.view.jingji.mediator.JingJiComponentMediator;
	import sceneModule.view.jingji.mediator.JingjiWindowMediator;
	import sceneModule.view.jingji.view.JingJiBattleJieSuanWindow;
	import sceneModule.view.jingji.view.JingJiComponent;
	import sceneModule.view.jingji.view.JingjiWindow;
	import sceneModule.view.mail.command.GetMailListResponseCommand;
	import sceneModule.view.mail.event.GetMailListResponseEvent;
	import sceneModule.view.mail.mediator.MainMailItemRenderMediator;
	import sceneModule.view.mail.mediator.MainMenuMailMediator;
	import sceneModule.view.mail.view.MainMailItemRender;
	import sceneModule.view.mail.view.MainMenuMailComponent;
	import sceneModule.view.mainMenu.mediator.MainMenuMediator;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.nmall.mediater.NMallMediator;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.nmall.view.NMallView;
	import sceneModule.view.pack.mediator.MainMenuEquipmentComponentMediator;
	import sceneModule.view.pack.mediator.MainMenuEquipmentGroupMediator;
	import sceneModule.view.pack.mediator.MainMenuEquipmentItemRenderMediator;
	import sceneModule.view.pack.view.MainMenuEquipmentComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentGroup;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.pata.command.PaTaMessage;
	import sceneModule.view.pata.mediator.PaTaWindowMediator;
	import sceneModule.view.pata.view.PanPaWindow;
	import sceneModule.view.pet.command.GetPetListInfoResponseCommand;
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.mediator.MainPetViewInfoComponentMediator;
	import sceneModule.view.pet.mediator.ModifyPetNameComponentMediator;
	import sceneModule.view.pet.mediator.PetBuZhenComponentMediator;
	import sceneModule.view.pet.mediator.PetChuanChengComponentMediator;
	import sceneModule.view.pet.mediator.PetComponentMediator;
	import sceneModule.view.pet.mediator.PetItemRenderMediator;
	import sceneModule.view.pet.mediator.PetMatrixItemRenderMediator;
	import sceneModule.view.pet.mediator.PetPeiYangComponentMediator;
	import sceneModule.view.pet.mediator.PetPropertyComponentMediator;
	import sceneModule.view.pet.mediator.PetTuJianComponentMediator;
	import sceneModule.view.pet.view.MainPetViewInfoComponent;
	import sceneModule.view.pet.view.ModifyPetNameComponent;
	import sceneModule.view.pet.view.PetBuZhenComponent;
	import sceneModule.view.pet.view.PetChuanChengComponent;
	import sceneModule.view.pet.view.PetComponent;
	import sceneModule.view.pet.view.PetItemRender;
	import sceneModule.view.pet.view.PetMatrixItemRender;
	import sceneModule.view.pet.view.PetPeiYangComponent;
	import sceneModule.view.pet.view.PetPropertyComponent;
	import sceneModule.view.pet.view.PetTuJianComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.pray.command.GetPrayInfoCommand;
	import sceneModule.view.pray.event.PrayEvent;
	import sceneModule.view.pray.mediator.PrayWindowMediator;
	import sceneModule.view.pray.view.PrayWindow;
	import sceneModule.view.prompted.mediator.PromptedComponentMediator;
	import sceneModule.view.prompted.view.PromptedComponent;
	import sceneModule.view.ranking.command.GetRankingListInfoResponseCommand;
	import sceneModule.view.ranking.event.GetRankingListInfoResponseEvent;
	import sceneModule.view.ranking.mediator.MainMenuRankingComponentMediator;
	import sceneModule.view.ranking.view.MainMenuRankingComponent;
	import sceneModule.view.reward.command.RewardMessage;
	import sceneModule.view.reward.mediator.RewardBattleInfoItemRenderMediator;
	import sceneModule.view.reward.mediator.RewardBattleInfoWindowMediator;
	import sceneModule.view.reward.mediator.RewardDayOrGuideItemRenderMediator;
	import sceneModule.view.reward.mediator.RewardDayOrGuideWindowMediator;
	import sceneModule.view.reward.mediator.RewardItemRenderMediator;
	import sceneModule.view.reward.mediator.RewardNewGuideWindowMediator;
	import sceneModule.view.reward.mediator.RewardWindowMediator;
	import sceneModule.view.reward.view.RewardBattleInfoItemRender;
	import sceneModule.view.reward.view.RewardBattleInfoWindow;
	import sceneModule.view.reward.view.RewardDayOrGuideItemRender;
	import sceneModule.view.reward.view.RewardDayOrGuideWindow;
	import sceneModule.view.reward.view.RewardItemRender;
	import sceneModule.view.reward.view.RewardNewGuideWindow;
	import sceneModule.view.reward.view.RewardWindow;
	import sceneModule.view.role.mediator.MainMenuRoleMediator;
	import sceneModule.view.role.mediator.NMainRoleEquipmentItemRenderMediator;
	import sceneModule.view.role.view.MainMenuRoleComponent;
	import sceneModule.view.role.view.MainRoleEquipmentItemRender;
	import sceneModule.view.roleInfo.mediator.MainLookRoleInfoComponentMediator;
	import sceneModule.view.roleInfo.mediator.MainRoleInfoComponentMediator;
	import sceneModule.view.roleInfo.mediator.OtherRoleInfoShowMediator;
	import sceneModule.view.roleInfo.mediator.RoleInfoShowMediator;
	import sceneModule.view.roleInfo.view.MainLookRoleInfoComponent;
	import sceneModule.view.roleInfo.view.MainRoleInfoComponent;
	import sceneModule.view.roleInfo.view.OtherRoleInfoShowComponent;
	import sceneModule.view.roleInfo.view.RoleInfoShowComponent;
	import sceneModule.view.sg.command.ShenDiMessage;
	import sceneModule.view.sg.mediator.ActiveShenGeConfimComponentMediator;
	import sceneModule.view.sg.mediator.ShenDiWindowMediator;
	import sceneModule.view.sg.mediator.ShenGeItemRenderMediator;
	import sceneModule.view.sg.view.ActiveShenGeConfimComponent;
	import sceneModule.view.sg.view.ShenDiWindow;
	import sceneModule.view.sg.view.ShenGeItemRender;
	import sceneModule.view.shop.command.GetShopInfoResponseCommand;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	import sceneModule.view.shop.mediator.NpcShopComponentMediator;
	import sceneModule.view.shop.mediator.NpcShopItemComponentMediator;
	import sceneModule.view.shop.mediator.NpcShopItemMediator;
	import sceneModule.view.shop.mediator.NpcShopSellItemComponentMediator;
	import sceneModule.view.shop.view.NpcShopComponent;
	import sceneModule.view.shop.view.NpcShopItemComponent;
	import sceneModule.view.shop.view.NpcShopItemView;
	import sceneModule.view.shop.view.NpcShopSellItemComponent;
	import sceneModule.view.skill.command.GetBattleSkillInfoResponseCommand;
	import sceneModule.view.skill.command.GetSkillInfoResponseCommand;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.mediator.MainMenuBattleSkillComponentMediator;
	import sceneModule.view.skill.mediator.MainMenuSkillComponentMediator;
	import sceneModule.view.skill.mediator.MainMenuSkillItemRenderMediator;
	import sceneModule.view.skill.view.MainMenuBattleSkillComponent;
	import sceneModule.view.skill.view.MainMenuSkillComponent;
	import sceneModule.view.skill.view.MainMenuSkillItemRender;
	import sceneModule.view.sysOpe.mediator.CorpsAppJoinCorpsComponentMediator;
	import sceneModule.view.sysOpe.mediator.SysOpeCommonWindowMediator;
	import sceneModule.view.sysOpe.mediator.SysOpeEquipmentWindowMediator;
	import sceneModule.view.sysOpe.mediator.SysOpeGuaJiComponentMediator;
	import sceneModule.view.sysOpe.mediator.SysOpeWindowMediator;
	import sceneModule.view.sysOpe.view.CorpsAppJoinCorpsComponent;
	import sceneModule.view.sysOpe.view.SysOpeCommonWindow;
	import sceneModule.view.sysOpe.view.SysOpeEquipmentWindow;
	import sceneModule.view.sysOpe.view.SysOpeGuaJiComponent;
	import sceneModule.view.sysOpe.view.SysOpeWindow;
	import sceneModule.view.systemInfo.meidator.SystemInfoComponentMediator;
	import sceneModule.view.systemInfo.view.SystemInfoComponent;
	import sceneModule.view.target.mediator.TargetTaskRewardItemRenderMediator;
	import sceneModule.view.target.mediator.TargetTaskWindowMediator;
	import sceneModule.view.target.view.TargetTaskRewardItemRender;
	import sceneModule.view.target.view.TargetTaskWindow;
	import sceneModule.view.task.command.GetProcessTaskListInfoCommand;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.command.TaskTrackingCommand;
	import sceneModule.view.task.event.GetProcessTaskListInfoEvent;
	import sceneModule.view.task.event.TaskTrackingEvent;
	import sceneModule.view.task.mediator.MainMenuTaskMediator;
	import sceneModule.view.task.mediator.MainTaskComponentMediator;
	import sceneModule.view.task.mediator.NTaskNpcMediator;
	import sceneModule.view.task.mediator.NewTaskMediator;
	import sceneModule.view.task.mediator.TaskMediator;
	import sceneModule.view.task.mediator.TaskNpcInfoMediator;
	import sceneModule.view.task.view.MainMenuTaskComponent;
	import sceneModule.view.task.view.MainTaskComponent;
	import sceneModule.view.task.view.NTaskNpcView;
	import sceneModule.view.task.view.NewTaskComponent;
	import sceneModule.view.task.view.TaskComponent;
	import sceneModule.view.task.view.TaskNpcInfoComponent;
	import sceneModule.view.tavern.command.GetWowInfoResponseCommand;
	import sceneModule.view.tavern.command.GetXingYunWowInfoResponseCommand;
	import sceneModule.view.tavern.event.WOWEvent;
	import sceneModule.view.tavern.event.XingYunWOWEvent;
	import sceneModule.view.tavern.mediator.PetHeadItemRenderMediator;
	import sceneModule.view.tavern.mediator.WOWItemRenderMediator;
	import sceneModule.view.tavern.mediator.WOWTavernComponentMediator;
	import sceneModule.view.tavern.mediator.WOWXingYunItemRenderMediator;
	import sceneModule.view.tavern.mediator.WOWXingYunTavernComponentMediator;
	import sceneModule.view.tavern.view.PetHeadItemRender;
	import sceneModule.view.tavern.view.WOWItemRender;
	import sceneModule.view.tavern.view.WOWTavernComponent;
	import sceneModule.view.tavern.view.WOWXingYunItemRender;
	import sceneModule.view.tavern.view.WOWXingYunTavernComponent;
	import sceneModule.view.territory.mediator.AramWindowMediator;
	import sceneModule.view.territory.mediator.LianjinWindowMediator;
	import sceneModule.view.territory.mediator.TerritoryWindowMediator;
	import sceneModule.view.territory.view.AramWindow;
	import sceneModule.view.territory.view.LianjinWindow;
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.ui.CopySceneInfoComponent;
	import sceneModule.view.ui.GuideWindowLayer;
	import sceneModule.view.ui.MenuBar;
	import sceneModule.view.ui.PosLinkView;
	import sceneModule.view.ui.SoundComponent;
	import sceneModule.view.ui.mediator.CopySceneInfoComponentMediator;
	import sceneModule.view.ui.mediator.GuideWindowLayerMediator;
	import sceneModule.view.ui.mediator.NPosLinkMediator;
	import sceneModule.view.ui.mediator.NUIProgressBarMediator;
	import sceneModule.view.ui.mediator.SoundComponentMediator;
	import sceneModule.view.vip.command.VIPmessage;
	import sceneModule.view.vip.mediator.VipWindowMediator;
	import sceneModule.view.vip.view.VipWindow;
	import sceneModule.view.wordmap.mediator.SceneMapMediator;
	import sceneModule.view.wordmap.mediator.WordMapMediator;
	import sceneModule.view.wordmap.model.MapMessage;
	import sceneModule.view.wordmap.view.SceneMapView;
	import sceneModule.view.wordmap.view.WordmapComponent;
	import sceneModule.view.zhanxing.command.GetJiFengInfoCommand;
	import sceneModule.view.zhanxing.command.ZhanXingMessage;
	import sceneModule.view.zhanxing.event.JiFengEvent;
	import sceneModule.view.zhanxing.mediator.BodyOrPackXYItemRenderMediator;
	import sceneModule.view.zhanxing.mediator.FuWenWindowMediator;
	import sceneModule.view.zhanxing.mediator.HeChengXYConfimComponentMediator;
	import sceneModule.view.zhanxing.mediator.JiFengExchangeComponentMediator;
	import sceneModule.view.zhanxing.mediator.XingYunItemRenderMediator;
	import sceneModule.view.zhanxing.mediator.ZhanXingWindowMediator;
	import sceneModule.view.zhanxing.mediator.jiFengItemRenderMediator;
	import sceneModule.view.zhanxing.view.BodyOrPackXYItemRender;
	import sceneModule.view.zhanxing.view.FuWenWindow;
	import sceneModule.view.zhanxing.view.HeChengXYConfimComponent;
	import sceneModule.view.zhanxing.view.JiFengExchangeComponent;
	import sceneModule.view.zhanxing.view.JiFengExchangeItemRender;
	import sceneModule.view.zhanxing.view.XingYunItemRender;
	import sceneModule.view.zhanxing.view.ZhanXingWindow;
	
	import service.ChatSocketService;
	import service.IChatSocketServer;
	import service.ISocketServer;

	public class SceneModuleContext extends Context
	{
		/**
		 * constructor 
		 * @param contextView 关联视图
		 * @param autoStartup 自动启动
		 * 
		 */	
		public function SceneModuleContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		/**
		 * 初始化模块结构 
		 * 
		 */		
		override public function startup():void
		{
			injector.mapValue(ISocketServer,(this.contextView as SceneModule).getSocketService());
			injector.mapValue(ServerConfig,(this.contextView as SceneModule).getServerConfig());
			injector.mapValue(IPopUpShow,(this.contextView as SceneModule).getPopUpShow());
			injector.mapValue(Sprite,(this.contextView as SceneModule).getSpritePBE());
			injector.mapValue(MainMenuEquipmentTooltip,(this.contextView as SceneModule).getTooltip());
			injector.mapValue(ProgressBarControl,(this.contextView as SceneModule).getProgressBarInstance());
			injector.mapValue(PopUpWindowLayer,(this.contextView as SceneModule).getPopUpWindow());
			injector.mapValue(NCropMessage,NCropMessage.getInstance());
			this.injector.mapSingletonOf(IChatSocketServer, ChatSocketService);
			
			WordSceneSprite.getInstance().itemtips = (this.contextView as SceneModule).getTooltip();
			
			//Character
			this.injector.mapSingletonOf(NCropsRootView,NCropsRootView);
			this.injector.mapSingletonOf(NCropsOutView,NCropsOutView);
			this.injector.mapSingletonOf(NCropsInView,NCropsInView);
			this.injector.mapSingletonOf(NCropRequestView,NCropRequestView);
			this.injector.mapSingletonOf(NCropMemberView,NCropMemberView);
			this.injector.mapSingletonOf(NCropEmblemView,NCropEmblemView);
			this.injector.mapSingletonOf(NCropKejiView, NCropKejiView);
			this.injector.mapSingletonOf(PosLinkView,PosLinkView);
			this.injector.mapSingletonOf(MainMenuFriendView,MainMenuFriendView);
			this.injector.mapSingletonOf(MainMenuTaskComponent,MainMenuTaskComponent);
			this.injector.mapSingletonOf(UILoaderProgressBarView,UILoaderProgressBarView);
			//this.injector.mapSingletonOf(NTaskNpcView,NTaskNpcView);
			
			//世界地图
			//this.injector.mapSingletonOf(WordmapComponent, WordmapComponent);
			//世界地图
			//this.injector.mapSingletonOf(SceneMapView, SceneMapView);
			
			mediatorMap.mapView(SceneEffectLayer,SceneEffectLayerMediator);
			
			//buff
			mediatorMap.mapView(BuffComponentItemRender,BuffComponentItemRenderMeidator);
			
			//Prompted
			mediatorMap.mapView(PromptedComponent,PromptedComponentMediator);
			
			//SystemInfoComponnet
			mediatorMap.mapView(SystemInfoComponent,SystemInfoComponentMediator);
			
			mediatorMap.mapView(MainRoleInfoComponent,MainRoleInfoComponentMediator);
			mediatorMap.mapView(MainLookRoleInfoComponent,MainLookRoleInfoComponentMediator);
			mediatorMap.mapView(AddToBlackWarningComponent,AddToBlackWarningComponentMediator);
			
			mediatorMap.mapView(ColonManEquipmentItemRender,ColonManEquipmentItemRenderMediator);
			mediatorMap.mapView(MainColoPrivilegeWindow,MainColoPrivilegeWindowMediator);
			mediatorMap.mapView(MainColoPrivilegeFuBenItemRender,MainColoPrivilegeFuBenItemRenderMediator);
			mediatorMap.mapView(MainColoPrivilegeFuBenColoInfoWindow,MainColoPrivilegeFuBenColoInfoWindowMediator);
			
			mediatorMap.mapView(MenuBar,MenuBarMediator);
			//mapView
			mediatorMap.mapView(ScenePageView,ScenePageMediator);			
			//mail mediatorMap
			mediatorMap.mapView(MainMailItemRender,MainMailItemRenderMediator);
			mediatorMap.mapView(MainMenuMailComponent,MainMenuMailMediator);
			mediatorMap.mapView(MainMenuEquipmentComponent,MainMenuEquipmentComponentMediator);
			mediatorMap.mapView(MainMenuEquipmentGroup,MainMenuEquipmentGroupMediator);
//			mediatorMap.mapView(RoomRoleInfoComponent,RoomRoleInfoComponentMediator);
			mediatorMap.mapView(MainMenuEquipmentItemRender,MainMenuEquipmentItemRenderMediator);
			
			mediatorMap.mapView(CopySceneInfoComponent,CopySceneInfoComponentMediator);
			
			mediatorMap.mapView(MainMenuComponent,MainMenuMediator);
			//chat mediatorMap
			mediatorMap.mapView(ChatWindow,ChatWindowMediator);
			mediatorMap.mapView(MainOneToOneChatWindow,MainOneToOneChatWindowMediator);
			//roleList mediatorMap
			mediatorMap.mapView(OtherRoleInfoShowComponent,OtherRoleInfoShowMediator);
			//battle mediatorMap
			mediatorMap.mapView(BattleFlipComponent,BattleFlipMediator);
			mediatorMap.mapView(BattleFlipItemRender,BattleFlipItemRenderMediator);
			mediatorMap.mapView(BattleSuccessSettlementWindow,BattleSuccessSettlementComponentMediator);
			mediatorMap.mapView(BattleSuccessSettlementItemRender,BattleSuccessSettlementItemRenderMediator);
			mediatorMap.mapView(BattleFailSettlementWindow,BattleFailSettlementComponentMediator);
			mediatorMap.mapView(BattleColonizationWindow,BattleColonizationWindowMediator);
			//blacksmith mediatorMap
			mediatorMap.mapView(MainStrEquipmentItemRender,MainStrEquipmentItemRenderMediator);
			mediatorMap.mapView(MainStrFunctionComponent,MainStrFunctionComponentMediator);
//			mediatorMap.mapView(MainBlacksmithComponent,MainBlacksmithComponentMediator);
			mediatorMap.mapView(MainEquipmentComponent,MainEquipmentComponentMediator);
//			mediatorMap.mapView(BlacksmithCastingComponent,BlacksmithCastingComponentMediator);
//			mediatorMap.mapView(BlacksmithStrengthenComponent,BlacksmithStrengthenComponentMediator);
//			mediatorMap.mapView(BlacksmithSynthesisComponent,BlacksmithSynthesisComponentMediator);
			
			mediatorMap.mapView(MainColoManagerWindow,MainColoManagerWindowMediator);
			
			//副本选择
			mediatorMap.mapView(NCopySceneChoseView, NCopySceneChoseMediator);
			
			//战役
			mediatorMap.mapView(ZhanyiView, ZhanyiViewMediator);
			
			
			//role
			mediatorMap.mapView(MainMenuRoleComponent,MainMenuRoleMediator);
			mediatorMap.mapView(MainRoleEquipmentItemRender,NMainRoleEquipmentItemRenderMediator);
			//Skill
			mediatorMap.mapView(MainMenuSkillComponent,MainMenuSkillComponentMediator);
			mediatorMap.mapView(MainMenuSkillItemRender,MainMenuSkillItemRenderMediator);
			mediatorMap.mapView(MainMenuBattleSkillComponent,MainMenuBattleSkillComponentMediator);
			commandMap.mapEvent(GetBattleSkillInfoResponseEvent.GETBATTLESKILLINFORESPONSE,GetBattleSkillInfoResponseCommand);
			commandMap.mapEvent(GetSkillInfoResponseEvent.GETSKILLINFORESPONSE,GetSkillInfoResponseCommand);
			//日程表
			commandMap.mapEvent(CalendarEvent.CalendarEvent_INFO_CHANGE,GetCalendarInfoResponseCommand);
			//官爵系统
			commandMap.mapEvent(GuanjueEvent.GUANJUE_EVENT,GetGuanjueInfoCommand);
			//威望
			commandMap.mapEvent(ShengWangEvent.SHNEGWANGCOMPONMENT_EVENT,GetShengWangInfoCommand);
			//属性转移
//			commandMap.mapEvent(ZhuanYiEvent.SHUXINGZHUANYIEVENT,ZhuanYiCommand);
			
			//祈祷
			commandMap.mapEvent(PrayEvent.Pray_EVENT,GetPrayInfoCommand);
			
			//魔兽酒馆
			commandMap.mapEvent(WOWEvent.WOW_EVENT,GetWowInfoResponseCommand);
			
			//魔兽酒馆，幸运值兑换宠物页面
			commandMap.mapEvent(XingYunWOWEvent.XINGYUNWOWINFO_EVENT,GetXingYunWowInfoResponseCommand);
			
			//积分兑换
			commandMap.mapEvent(JiFengEvent.JIFENGINFOCOMP_EVENT,GetJiFengInfoCommand);
			
			//商店
			mediatorMap.mapView(NpcShopComponent,NpcShopComponentMediator);
			mediatorMap.mapView(NpcShopItemComponent,NpcShopItemComponentMediator);
			mediatorMap.mapView(NpcShopItemView,NpcShopItemMediator);
			mediatorMap.mapView(NpcShopSellItemComponent,NpcShopSellItemComponentMediator);
			//Task MediatorMap
            mediatorMap.mapView(NewTaskComponent,NewTaskMediator);
			mediatorMap.mapView(MainMenuTaskComponent,MainMenuTaskMediator);
			mediatorMap.mapView(TaskNpcInfoComponent,TaskNpcInfoMediator);
			mediatorMap.mapView(TaskComponent,TaskMediator);	
			//Ranking
			mediatorMap.mapView(MainMenuRankingComponent,MainMenuRankingComponentMediator);
			commandMap.mapEvent(GetRankingListInfoResponseEvent.GETRANKINGLISTINFORESPONSE,GetRankingListInfoResponseCommand);
			
			//sysOpe
			mediatorMap.mapView(SysOpeWindow,SysOpeWindowMediator);
			mediatorMap.mapView(CorpsAppJoinCorpsComponent,CorpsAppJoinCorpsComponentMediator);
			mediatorMap.mapView(SysOpeCommonWindow,SysOpeCommonWindowMediator);
			mediatorMap.mapView(SysOpeEquipmentWindow,SysOpeEquipmentWindowMediator);
			mediatorMap.mapView(SysOpeGuaJiComponent,SysOpeGuaJiComponentMediator);
			
		    //我的领地
			mediatorMap.mapView(TerritoryWindow,TerritoryWindowMediator);
			mediatorMap.mapView(LianjinWindow,LianjinWindowMediator);
			mediatorMap.mapView(AramWindow,AramWindowMediator);
			
			//系统公告
			mediatorMap.mapView(AnnounComponent,AnnounComponentMediator);
			
			//新的军团
			mediatorMap.mapView(NCropsRootView,NCorpsRootMediator);
			mediatorMap.mapView(NCropsInView,NCorpsInMediator);
			mediatorMap.mapView(NCropsOutView,NCorpsOutMediator);
			mediatorMap.mapView(NCropRequestView,NCorpsRequestMediator);
			mediatorMap.mapView(NCropMemberView,NCorpsMemberMediator);
			mediatorMap.mapView(NCropEmblemView,NCorpsEmblemMediator);
			
			mediatorMap.mapView(NCropKejiView, NCorpsKejiMediator);
			
			//世界地图
			mediatorMap.mapView(WordmapComponent, WordMapMediator);
			//场景地图
			mediatorMap.mapView(SceneMapView, SceneMapMediator);
			//商城
			mediatorMap.mapView(NMallView, NMallMediator);
			//trip点连接
			mediatorMap.mapView(PosLinkView, NPosLinkMediator);
			//好友
			mediatorMap.mapView(MainMenuFriendView, MainMenuFriendMediator);
			//npc任务控件
			mediatorMap.mapView(NTaskNpcView, NTaskNpcMediator);
			//ui加载进度条
			mediatorMap.mapView(UILoaderProgressBarView, NUIProgressBarMediator);
			
			//commandMap
			commandMap.mapEvent(GetRoleInfoResponseEvent.GET_ROLEINFO_SUCCESS_EVENT,GetRoleInfoResponseCommand);
			commandMap.mapEvent(GetRoleItemResponseEvent.GET_ROLEITEM_EVENT,GetRoleItemResponseCommand);
			commandMap.mapEvent(GetRoleItemInPackageResponseEvent.GETROLEITEMINPACKAGEVENT,GetRoleItemInPackageResponseCommand);
			commandMap.mapEvent(GetItemsInTempPackageResponseEvent.GETITEMSINTEMPPACKAGEEVENT,GetItemsInTempPackageResponseCommand);
			commandMap.mapEvent(GetWarehouseInfoResponseEvent.GETWAREHOUSEINFORESPONSE,GetWarehouseInfoResponseCommand);
			commandMap.mapEvent(GetShopInfoResponseEvent.GETSHOPINFORESPONSE,GetShopInfoResponseCommand);
			commandMap.mapEvent(GetPlayerFrindsResponseEvent.GETPLAYERFRINDSRESPONSE,GetPlayerFrindsResponseCommand);
			commandMap.mapEvent(GetMailListResponseEvent.GETMAILLISTRESPONSE,GetMailListResponseCommand);
			commandMap.mapEvent(TeamMemberInfoResponseEvent.TEAMMEMBERINFOEVENT,TeamMemberInfoResponseCommand);
			//ai commandMap
			commandMap.mapEvent(EnterBattlePlaceResponseEvent.ENTERBATTLEPLACERESPONSE,EnterBattlePlaceResponseCommand);
			//Pet
			mediatorMap.mapView(PetComponent,PetComponentMediator);
			mediatorMap.mapView(PetPropertyComponent,PetPropertyComponentMediator);
			mediatorMap.mapView(PetPeiYangComponent,PetPeiYangComponentMediator);
			mediatorMap.mapView(PetBuZhenComponent,PetBuZhenComponentMediator);
			mediatorMap.mapView(PetChuanChengComponent,PetChuanChengComponentMediator);
			mediatorMap.mapView(PetTuJianComponent,PetTuJianComponentMediator);
			
			mediatorMap.mapView(ModifyPetNameComponent,ModifyPetNameComponentMediator);
			mediatorMap.mapView(PetItemRender,PetItemRenderMediator);
			mediatorMap.mapView(PetMatrixItemRender,PetMatrixItemRenderMediator);
			mediatorMap.mapView(MainPetViewInfoComponent,MainPetViewInfoComponentMediator);
			commandMap.mapEvent(GetPetListInfoResponseEvent.GETPETLISTINFO,GetPetListInfoResponseCommand);
			
			//Reward
			mediatorMap.mapView(RewardWindow,RewardWindowMediator);
			mediatorMap.mapView(RewardItemRender,RewardItemRenderMediator);
			mediatorMap.mapView(RewardBattleInfoWindow,RewardBattleInfoWindowMediator);
			mediatorMap.mapView(RewardBattleInfoItemRender,RewardBattleInfoItemRenderMediator);
			mediatorMap.mapView(RewardDayOrGuideWindow,RewardDayOrGuideWindowMediator);
			mediatorMap.mapView(RewardNewGuideWindow,RewardNewGuideWindowMediator);
			
			mediatorMap.mapView(ColonizationBattleByCopySceneComponent,ColonizationBattleByCopySceneComponentMediator);
			mediatorMap.mapView(BattleColonizationFailWindow,BattleColonizationFailWindowMediator);
			mediatorMap.mapView(RewardDayOrGuideItemRender,RewardDayOrGuideItemRenderMediator);
			
			//GuaJiAndSaodang
			mediatorMap.mapView(GuaJiConfimComponent,GuaJiConfimComponentMediator);
			mediatorMap.mapView(GuaJiToolTip,GuaJiToolTipMediator);
			mediatorMap.mapView(SaoDangWindow,SaoDangWindowMediator);
			
			//Target
			mediatorMap.mapView(TargetTaskWindow,TargetTaskWindowMediator);
			mediatorMap.mapView(TargetTaskRewardItemRender,TargetTaskRewardItemRenderMediator);
			
			//GameUI
			mediatorMap.mapView(GameTopUI,GameTopUImediator);
			mediatorMap.mapView(GameTopUIItemRender,GameTopUIItemRenderMediator);
			
			//Battle CommandMap
			commandMap.mapEvent(BattleOverGetItemInfoResponseEvent.BATTLEOVERITEMRESPONSE,BattleOverGetItemInfoResponseCommand);
			commandMap.mapEvent(ColonizationBattleResponseEvent.COLONIZATIONBATTLERESPONSE,ColonizationBattleResponseCommand);
			//Task CommandMap
			mediatorMap.mapView(MainTaskComponent,MainTaskComponentMediator);
			commandMap.mapEvent(TaskTrackingEvent.TASKTRACKINGEVENT,TaskTrackingCommand);
			commandMap.mapEvent(GetProcessTaskListInfoEvent.GETPROCESSTASKLISTINFO, GetProcessTaskListInfoCommand);
			
			//ShenDi
			mediatorMap.mapView(ShenDiWindow,ShenDiWindowMediator);
			mediatorMap.mapView(ShenGeItemRender,ShenGeItemRenderMediator);
			mediatorMap.mapView(ActiveShenGeConfimComponent,ActiveShenGeConfimComponentMediator);
			
			//Blacksmith
			mediatorMap.mapView(XiangQianItemRender,XiangQianItemRenderMediator);
			mediatorMap.mapView(XiangQianComponent,XiangQianComponentMediator);
			mediatorMap.mapView(XiangQianAndUnloadConfimComponent,XiangQianAndUnloadConfimComponentMediator);
			mediatorMap.mapView(HeChengComponent,HeChengComponentMediator);
			mediatorMap.mapView(StrengthenComponent,StrengthenComponentMediator);
			mediatorMap.mapView(StrengthenButton,StrengthenButtonMediator);
			
			//hao 查看他人信息
			NCropMessage.getInstance().map_mediarot = this.mediatorMap;
			injector.injectInto(NCropMessage.getInstance());
			NCropMessage.getInstance().init_events();
			
			KeyBordManager.getInstance().map_mediarot = this.mediatorMap;
			injector.injectInto(KeyBordManager.getInstance());
			
			FriendMessage.getInstance().map_mediarot = this.mediatorMap;
			injector.injectInto(FriendMessage.getInstance());
			FriendMessage.getInstance().init_events();
			
			injector.injectInto(ShenDiMessage.getInstance());
			
			injector.injectInto(BlacksmithMessage.getInstance());
			
			//npc任务消息
			injector.injectInto(TaskMessage.getInstance());
			TaskMessage.getInstance().init_events();
			
			//商城信息
			injector.injectInto(MallMessage.getInstance());
			
			//战斗消息
			injector.injectInto(BattleAndCopySceneMessage.getInstance());
			//宠物系统消息
			injector.injectInto(PetMessage.getInstance());
			PetMessage.getInstance().event_dispatcher = eventDispatcher;
			
			//占星系统
			injector.injectInto(ZhanXingMessage.getInstance());
			ZhanXingMessage.getInstance().event_dispatcher = eventDispatcher;
			mediatorMap.mapView(ZhanXingWindow,ZhanXingWindowMediator);
			mediatorMap.mapView(FuWenWindow,FuWenWindowMediator);
			mediatorMap.mapView(BodyOrPackXYItemRender,BodyOrPackXYItemRenderMediator);
			mediatorMap.mapView(HeChengXYConfimComponent,HeChengXYConfimComponentMediator);
			
			mediatorMap.mapView(XingYunItemRender,XingYunItemRenderMediator);
			
			//商店信息
			injector.injectInto(ShopMessage.getInstance());
			ShopMessage.getInstance().event_dispatcher = eventDispatcher;
			ShopMessage.getInstance().init_event();
			
			//场景信息
			injector.injectInto(SceneMessage.getInstance());
			SceneMessage.getInstance().init_event();
			
			//场景通用指令信息
			injector.injectInto(SceneModuleCommonMessage.getInstance());
			
			//地图信息
			injector.injectInto(MapMessage.getInstance());
			
			//殖民战
			injector.injectInto(RewardMessage.getInstance());
			
			//殖民管理
			injector.injectInto(ColonManMessage.getInstance());
			
			mediatorMap.mapView(RoleInfoShowComponent,RoleInfoShowMediator);
			
			//日程表
			mediatorMap.mapView(CalendarInfoComponent,CalendarInfoMediator);
			
			//官爵系统
			mediatorMap.mapView(GuanjueWindow,GuanjueWindowMediator);
			
			//威望
			mediatorMap.mapView(ShengWangComponent,ShengWangComponentMediator);
			//威望itemRender
			mediatorMap.mapView(ShengWangItemRender,ShengWangItemRenderMediator);
			
			//属性转移
			mediatorMap.mapView(ZhuanYiComponent,ZhuanYiComponentMediator);
	
			mediatorMap.mapView(ZhuanYiItemRender,ZhuanYiItemRenderMediator);
			
			mediatorMap.mapView(MainEquipmentZhuanYiComponent,MainEquipmentZhuanYiComponentMediator);
			
			
			//魔兽酒馆
			mediatorMap.mapView(WOWItemRender,WOWItemRenderMediator);
			
			mediatorMap.mapView(WOWTavernComponent,WOWTavernComponentMediator);
			
			//魔兽酒馆左侧宠物tips
			mediatorMap.mapView(PetHeadItemRender,PetHeadItemRenderMediator);
			
			mediatorMap.mapView(WOWXingYunTavernComponent,WOWXingYunTavernComponentMediator);
			
			mediatorMap.mapView(WOWXingYunItemRender,WOWXingYunItemRenderMediator);
			
			
			//积分兑换信息
			mediatorMap.mapView(JiFengExchangeItemRender,jiFengItemRenderMediator);
			mediatorMap.mapView(JiFengExchangeComponent,JiFengExchangeComponentMediator);
			
			//GM
			mediatorMap.mapView(GMcomponent,GMcomponentMediator);
			
			//JingJi
			mediatorMap.mapView(JingjiWindow,JingjiWindowMediator);
			injector.injectInto(JingJiMessage.getInstance());
			mediatorMap.mapView(JingJiComponent,JingJiComponentMediator);
			mediatorMap.mapView(JingJiBattleJieSuanWindow,JingJiBattleJieSuanWindowMediator);
			JingJiMessage.getInstance().event_dispatcher = eventDispatcher;
			
			//VIP
			injector.injectInto(VIPmessage.getInstance());
			mediatorMap.mapView(VipWindow,VipWindowMediator);
			
			mediatorMap.mapView(GuideWindowLayer,GuideWindowLayerMediator);
			//PanPa
			mediatorMap.mapView(PanPaWindow,PaTaWindowMediator);
			injector.injectInto(PaTaMessage.getInstance());
			PaTaMessage.getInstance().event_dispatcher = eventDispatcher;
			//祈祷
			mediatorMap.mapView(PrayWindow,PrayWindowMediator);
			
			mediatorMap.mapView(SoundComponent,SoundComponentMediator);
			
			//对人组队
			mediatorMap.mapView(GroupWindow,GroupWindowMediator);
			injector.injectInto(GroupMessage.getInstance());
			GroupMessage.getInstance().event_dispatcher = eventDispatcher;
			GroupMessage.getInstance().curMediatorMap = mediatorMap;
			mediatorMap.mapView(CreateOrJoinWindow,CreateOrJoinWindowMediator);
			
			//军团战
			mediatorMap.mapView(GroupCityComponent,GroupCityComponentMediator);
			mediatorMap.mapView(LingDiComponent,LingDiComponentMediator);
			mediatorMap.mapView(CityListComponent,CityListComponentMediator);
			mediatorMap.mapView(XuYuanComponent,XuYuanComponentMediator);
			mediatorMap.mapView(GroupBattleInfoComponent,GroupBattleInfoComponentMediator);
			injector.injectInto(GroupBattleMessage.getInstance());
		}
	}
}
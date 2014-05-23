package sceneModule.view.mainMenu.mediator
{
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.events.ItemClickEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.friends.friends302.getPlayerFrindsRequest;
	import proto.friends.friends302.getPlayerFrindsResponse;
	import proto.mail.mail501.getMailListRequest;
	import proto.pet.pet2300.GetPetListInfoRequest;
	import proto.ranking.ranking2001.GetRankingListInfoRequest;
	import proto.scene.scene204.getItemsInPackageRequest;
	import proto.skill.skill801.GetSkillInfoRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.event.MainMenuChangeToWriteMailComponentEvent;
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.model.vo.rankingVO.MainRankingInfoVo;
	import sceneModule.model.vo.rankingVO.RankingInfoVO;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.event.MediatorRegisterCorpsEvent;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.friend.event.GetPlayerFrindsResponseEvent;
	import sceneModule.view.friend.event.MediatorRegisterFriendEvent;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.mail.event.GetMailListResponseEvent;
	import sceneModule.view.mail.event.MainMenuMailComponentCreateCompleteEvent;
	import sceneModule.view.mail.event.MediatorRegisterMainEvent;
	import sceneModule.view.mail.view.MainMenuMailComponent;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.event.MediatorRegisterPetEvent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.ranking.event.GetRankingListInfoResponseEvent;
	import sceneModule.view.ranking.event.MediatorRegisterRankingEvent;
	import sceneModule.view.role.event.MediatorRegisterRoleEvent;
	import sceneModule.view.shop.command.ShopMessage;
	import sceneModule.view.skill.event.GetBattleSkillInfoResponseEvent;
	import sceneModule.view.skill.event.GetSkillInfoResponseEvent;
	import sceneModule.view.skill.event.MediatorRegisterSkillEvent;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.MediatorRegisterTaskEvent;
	import sceneModule.view.task.event.NTaskEvent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class MainMenuMediator extends Mediator
	{
		[Inject]
		public var comp:MainMenuComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		
		private var _cur_selected_type:Object;
		
		public function MainMenuMediator()
		{
			super();
		}
		
		override public function onRegister():void {
			//默认显示角色信息
			if(comp.data && comp.data.type == 'newMail'){
				AssetCenter.getInstance().load_package("ui_mail", to_mail, null, true);
			}else if(comp.data && comp.data.type == 'newSkill'){
				AssetCenter.getInstance().load_package("ui_skill", to_skill, null, true);
			}else{
				_cur_selected_type = "roleBtn";
				getEquipmentInfo();
				SceneModuleCommonMessage.getInstance().getEquipmentInSlotInfo();
				mediatorMap.createMediator(comp.mainRoleComp);
			}
			
			
			this.eventMap.mapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onItemClick);
			this.eventDispatcher.addEventListener("open_menu",change_to_role);
			this.eventDispatcher.addEventListener("open_mail",change_to_mail);
			
//			this.eventDispatcher.addEventListener("open_corps",change_to_corp);
			
			this.addContextListener(MainMenuChangeToWriteMailComponentEvent.MAINMENUCHANGETOWRITEMAIL,onChangeMainMenu);
			
			//skill createMediator
			this.eventMap.mapListener(comp,MediatorRegisterSkillEvent.MEDIATORREGISTER_SKILLCOMP,onRegisterSkillComp);
			this.eventMap.mapListener(comp,MediatorRegisterSkillEvent.MEDIATORREGISTER_BATTLESKILL,onRegisterSkillComp);
			this.eventMap.mapListener(comp,MediatorRegisterSkillEvent.MEDIATORREGISTER_SKILLITEMRENDER,onRegisterSkillComp);
			
			//corps createMediator
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_EMBLEM,onCreateCorpsMediator);
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_IN,onCreateCorpsMediator);
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_KEJI,onCreateCorpsMediator);
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_MEMBER,onCreateCorpsMediator);
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_OUT,onCreateCorpsMediator);
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_REQUEST,onCreateCorpsMediator);
			this.eventMap.mapListener(comp,MediatorRegisterCorpsEvent.MR_CORPS_ROOT,onCreateCorpsMediator);
			
			//friend createMediator
			this.eventMap.mapListener(comp,MediatorRegisterFriendEvent.MR_FRIEND_ALERT,onCreateFriendMediator);
			this.eventMap.mapListener(comp,MediatorRegisterFriendEvent.MR_FRIEND_INPUT,onCreateFriendMediator);
			this.eventMap.mapListener(comp,MediatorRegisterFriendEvent.MR_FRIEND_ITEMRENDER,onCreateFriendMediator);
			this.eventMap.mapListener(comp,MediatorRegisterFriendEvent.MR_FRIEND_LEVELUP,onCreateFriendMediator);
			this.eventMap.mapListener(comp,MediatorRegisterFriendEvent.MR_FRIEND_STATE,onCreateFriendMediator);
			this.eventMap.mapListener(comp,MediatorRegisterFriendEvent.MR_FRIEND_VIEW,onCreateFriendMediator);
			
			//Mail createMediator
			this.eventMap.mapListener(comp,MediatorRegisterMainEvent.MR_MAIL_COMP,onCreateMailMediator);
			this.eventMap.mapListener(comp,MediatorRegisterMainEvent.MR_MAIL_ITEMRENDER,onCreateMailMediator);
			//ranking createMediator
			this.eventMap.mapListener(comp,MediatorRegisterRankingEvent.MEDIATORREGISTERRANKING,onCreateRankingMediator);
			
			//task createMediator
			this.eventMap.mapListener(comp,MediatorRegisterTaskEvent.MEDIATORREGISTERTASKEVENT,onCreateTaskMediator);
		}
		
		private function onCreateRankingMediator(evt:MediatorRegisterRankingEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCreateTaskMediator(evt:MediatorRegisterTaskEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCreateMailMediator(evt:MediatorRegisterMainEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCreateFriendMediator(evt:MediatorRegisterFriendEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCreateCorpsMediator(evt:MediatorRegisterCorpsEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onRegisterSkillComp(evt:MediatorRegisterSkillEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function change_to_role(e:Event = null):void{
			AssetCenter.getInstance().load_package("ui_role", to_load_role_bg, null, true);
			
		}
		
		private function change_to_mail(e:Event = null):void{
			AssetCenter.getInstance().load_package("ui_mail", to_mail, null, true);
		}
		
		private function to_load_role_bg():void{
			AssetCenter.getInstance().load_package("ui_bg_role", to_load_pack, null, true);
		}
		private function to_load_pack():void{
			AssetCenter.getInstance().load_package("ui_package", to_role, null, true);
		}
		//角色模块
		private function to_role():void{
			comp.cardtype.selectedValue = "roleBtn";
			comp.viewStack.selectedIndex = 0;
			_cur_selected_type = "roleBtn";
			mediatorMap.createMediator(comp.mainRoleComp);
			comp.mainRoleComp.mainMenuEquipment.cardtype.selectedValue=CrotaResourceConfig.getInstance().getTextByModuleAndId('mainMenu','mm_dj');
			getEquipmentInfo();
			SceneModuleCommonMessage.getInstance().getEquipmentInSlotInfo();
			//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER));
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
		}
		
		
		//菜单项 change
		private function onItemClick(evt:ItemClickEvent):void {
			var selectValue:Object = comp.cardtype.selectedValue;
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.UI_CHANGE));
			switch(selectValue){
				case "roleBtn":
					change_to_role();
					break;
				case "skillBtn":
					comp.cardtype.selectedValue = _cur_selected_type;
					if(SystemDataModel.roleInfo.level<7){
						CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('mainMenu','mm_djqj'));
					}else{
						AssetCenter.getInstance().load_package("ui_skill", to_skill, null, true);
						
					}
					//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_SHOW_UI, GuideInfo.TYPE_UI_SKILL));
					break;
				case "corpsBtn":
					comp.cardtype.selectedValue = _cur_selected_type;
					if(SystemDataModel.roleInfo.level<12){
						CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('mainMenu','mm_djej'));
					}else{
					    AssetCenter.getInstance().load_package("ui_union", to_crop, null, true);
					}
					break;
				case "mailBtn":
					comp.cardtype.selectedValue=_cur_selected_type;
					AssetCenter.getInstance().load_package("ui_mail", to_mail, null, true);
					break;
				case "friendsBtn":
					comp.cardtype.selectedValue = _cur_selected_type;
					AssetCenter.getInstance().load_package("ui_friend", to_friend, null, true);
					break;
				case "taskBtn":
					comp.cardtype.selectedValue = _cur_selected_type;
					AssetCenter.getInstance().load_package("ui_task", to_task, null, true);
					break;
				case "rankingBtn":
					comp.cardtype.selectedValue = _cur_selected_type;
					AssetCenter.getInstance().load_package("ui_ranking",to_ranking,null,true);
					break;
			}
		}
		//技能
		private function to_skill():void{
			comp.viewStack.selectedIndex = 1;
			comp.cardtype.selectedValue = "skillBtn";
			_cur_selected_type = "skillBtn";
			onGetSkillData();
			onGetRoleSkillData();
//			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_SKILL)]);
		}
		
		private function to_task():void {
			comp.viewStack.selectedIndex = 6;
			mediatorMap.createMediator(comp.mainTaskComp);
			comp.cardtype.selectedValue="taskBtn";
			_cur_selected_type = "taskBtn";
			TaskMessage.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_MENU_SHOW));
		}
		
		private function to_ranking():void{
			comp.viewStack.selectedIndex = 5;
			mediatorMap.createMediator(comp.mainTaskComp);
			comp.cardtype.selectedValue = "rankingBtn";
			_cur_selected_type = "rankingBtn";
			
			if(comp.mainRankingComp){
				comp.mainRankingComp.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('mainMenu','mm_grdj');
			}
			
			onGetRankingListInfo(1);
		}
		
		private function to_mail():void
		{
			mediatorMap.createMediator(comp.mainMailComp);
			getMailList();
			if (comp.mainMailComp)
			{
				comp.mainMailComp.cardtype.selectedValue=CrotaResourceConfig.getInstance().getTextByModuleAndId('mail','mmm_qb');
				comp.mainMailComp.init_write_page();
			}
			
			comp.viewStack.selectedIndex=4;
			_cur_selected_type="mailBtn";
			comp.cardtype.selectedValue="mailBtn";
		}
		
		private function to_crop():void {
			comp.viewStack.selectedIndex = 2;
			comp.cardtype.selectedValue = "corpsBtn";
			_cur_selected_type = "corpsBtn";
			this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH));
//			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_JUNTUAN)]);
		}
		
		private function to_friend():void {
			comp.viewStack.selectedIndex = 3;
			mediatorMap.createMediator(comp.mainFriendComp);
			comp.cardtype.selectedValue = "friendsBtn";
			_cur_selected_type = "friendsBtn";
			this.dispatch(new NFriendEvent(NFriendEvent.NFriendEvent_OPEN));
		}
		
		/**
		 * 获取邮件列表
		 */
		private function getMailList():void{
			var getMailList:getMailListRequest = new getMailListRequest();
			getMailList.id = SystemDataModel.roleId;
			getMailList.mailType = 0;
			getMailList.pageCount = 1;
			var MailByteArray:ByteArray = new ByteArray();
			getMailList.writeExternal(MailByteArray);
			socketService.send(new mx.rpc.Responder(resultMailHandler,faultHandler),URLConst.GET_MAILLIST_COMMANDID,MailByteArray);
		}
		/**
		 * resultHandler 
		 */		
		private function resultMailHandler(data:Object):void{
			dispatch(new GetMailListResponseEvent(GetMailListResponseEvent.GETMAILLISTRESPONSE,data));
		}
		
		/**
		 * 获取好友信息
		 * 
		 */
		private function getFriendsList():void{
			/*var requestGetFriendsInfo:proto.friends.friends302.getPlayerFrindsRequest = new getPlayerFrindsRequest();
			requestGetFriendsInfo.id = SystemDataModel.roleId;
			requestGetFriendsInfo.type = 1;
			var playerInfoByteArray:ByteArray = new ByteArray();
			requestGetFriendsInfo.writeExternal(playerInfoByteArray);
			socketService.send(new mx.rpc.Responder(resultFriendsHandler,faultHandler),URLConst.GET_PLAYERFRIEND_COMMANDID,playerInfoByteArray);*/
		}
		/**
		 * 获取好友列表信息返回处理函数 
		 */	
		private function resultFriendsHandler(data:Object):void{
			var responseDataFriends:proto.friends.friends302.getPlayerFrindsResponse = new getPlayerFrindsResponse();
			var byteArray:ByteArray = data as ByteArray;
			responseDataFriends.readExternal(byteArray);
			if(responseDataFriends.result){
				dispatch(new GetPlayerFrindsResponseEvent(GetPlayerFrindsResponseEvent.GETPLAYERFRINDSRESPONSE,responseDataFriends));
			}else{
				popUpShow.show(responseDataFriends.message);
			}
		}
		/**
		 *获取装备信息 
		 */		
		private function getEquipmentInfo(page:int=1):void{
			//获取角色物品信息
			ShopMessage.getInstance().requese_package_info(page, ProConst.COMMON_ITEM);
			//var requestGetItemInPackage:proto.scene.scene204.getItemsInPackageRequest = new getItemsInPackageRequest();
			//requestGetItemInPackage.id = SystemDataModel.roleId;
			//requestGetItemInPackage.packCategory = ProConst.COMMON_ITEM;
			//requestGetItemInPackage.curpage = page;
			//var itemInPackageByteArray:ByteArray = new ByteArray();
			//requestGetItemInPackage.writeExternal(itemInPackageByteArray);
			//socketService.send(new mx.rpc.Responder(itemInPackageResultHandler,faultHandler),URLConst.GET_ITEMINPACKAGE_COMMANDID,itemInPackageByteArray);
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
		/**
		 * 获取技能数据 
		 */		
		private function onGetSkillData():void{
			var skillRequest:GetSkillInfoRequest = new GetSkillInfoRequest();
			skillRequest.id = SystemDataModel.roleId;
			var skillByteArray:ByteArray = new ByteArray();
			skillRequest.writeExternal(skillByteArray);
			socketService.send(new mx.rpc.Responder(skillInfoHandler,faultHandler),URLConst.SKILL_GETINFO_COMMANDID,skillByteArray);
		}
		private function skillInfoHandler(data:Object):void{
			dispatch(new GetSkillInfoResponseEvent(GetSkillInfoResponseEvent.GETSKILLINFORESPONSE,data));
		}
		/**
		 * 获取技能数据 
		 */		
		private function onGetRoleSkillData():void{
			var skillRequest:GetSkillInfoRequest = new GetSkillInfoRequest();
			skillRequest.id = SystemDataModel.roleId;
			var skillByteArray:ByteArray = new ByteArray();
			skillRequest.writeExternal(skillByteArray);
			socketService.send(new mx.rpc.Responder(RoleSkillInfoHandler,faultHandler),URLConst.SKILL_ROLESELF_COMMANDID,skillByteArray);
		}
		private function RoleSkillInfoHandler(data:Object):void{
			dispatch(new GetBattleSkillInfoResponseEvent(GetBattleSkillInfoResponseEvent.GETBATTLESKILLINFORESPONSE,data));
		}
		/**
		 *itemInPackageResultHandler 
		 */	
		private function itemInPackageResultHandler(data:Object):void{
			dispatch(new GetRoleItemInPackageResponseEvent(GetRoleItemInPackageResponseEvent.GETROLEITEMINPACKAGEVENT,data));
		}
		/**
		 * 获取排行榜信息
		 */
		private function onGetRankingListInfo(rankType:int):void{
			var getRankingRequest:GetRankingListInfoRequest = new GetRankingListInfoRequest();
			getRankingRequest.id = SystemDataModel.roleId;
			getRankingRequest.rankingType = rankType;
			var byteArray:ByteArray = new ByteArray();
			getRankingRequest.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(rankingHandler,faultHandler),URLConst.RANKING_GETLISTINFO_COMMANDID,byteArray);
			
//			SystemDataModel.mainRankingInfo.myRanking = '100';
//			SystemDataModel.mainRankingInfo.refreshTime = '2011年12月07日';
//			var arr:ArrayCollection = new ArrayCollection();
//			
//			for(var i:int=0;i<10;i++){
//				var rankingInfoVo:RankingInfoVO = new RankingInfoVO();
//				rankingInfoVo.id = i;
//				rankingInfoVo.param1 = 'param1'+i;
//				rankingInfoVo.param2 = 'param2'+i;
//				rankingInfoVo.param3 = 'param3'+i;
//				rankingInfoVo.param4 = 'param4'+i;
//				rankingInfoVo.param5 = 'param5'+i;
//				arr.addItem(rankingInfoVo);
//			}
//			SystemDataModel.mainRankingInfo.rankingInfoList.source = arr.toArray();
		}
		private function rankingHandler(data:Object):void{
			this.dispatch(new GetRankingListInfoResponseEvent(GetRankingListInfoResponseEvent.GETRANKINGLISTINFORESPONSE,data));
		}
		
		/**
		 * 写邮件时的窗口跳转控制
		 * @evt 
		 */		
		private var tempRoleName:String;
		public var wrtieMail_bitmap:Bitmap;
		private var mainMenuMail:MainMenuMailComponent;
		private function onChangeMainMenu(evt:MainMenuChangeToWriteMailComponentEvent):void{
			//			if(!mainMenuFlag){
			//				onOpenMainMenuComp();
			//			}
			AssetCenter.getInstance().load_package("ui_mail", to_mail, null, true);
						tempRoleName = evt.obj.roleName;
						comp.cardtype.selectedValue = "mailBtn";
						comp.viewStack.selectedIndex = 4;
						if(comp.mainMailComp){
							setWriteMailContent();
						}else{
							this.addContextListener(MainMenuMailComponentCreateCompleteEvent.MAINMENUMAILCOMPONENTCREATECOMPLETE,onMailCreationComplete);
						}
			
		}
		//初始化完成
		private function onMailCreationComplete(evt:MainMenuMailComponentCreateCompleteEvent):void{
			setWriteMailContent();
		}
		//设置写邮件的相应内容
		private function setWriteMailContent():void{
			comp.mainMailComp.currentState = "writeMailState";
			comp.mainMailComp.userName.text = tempRoleName;
		}
	}
}
package sceneModule.view.chat.mediator
{
	import de.polygonal.ds.sort.arrayedInsertionSort;
	import wordscene.WordSceneSprite;
	
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.System;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.LinkElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextDecoration;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import managers.KeyBordManager;
	import managers.WindowManager;
	
	import model.ProConst;
	import model.ServerConfig;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Menu;
	import mx.controls.menuClasses.MenuItemRenderer;
	import mx.core.ClassFactory;
	import mx.core.FlexGlobals;
	import mx.core.IFactory;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.ItemClickEvent;
	import mx.events.MenuEvent;
	import mx.managers.PopUpManager;
	import mx.messaging.events.MessageEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.utils.object_proxy;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.chat.chat1001.loginToChatServerRequest;
	import proto.chat.chat1002.chatMessageResponse;
	import proto.chat.chat1003.chatConectingRequest;
	import proto.chat.chat1003.chatConectingResponse;
	import proto.chat.chat1003.itemLinkData;
	import proto.chat.chat1004.ChatObjectData;
	import proto.chat.chat1004.SearchChatObjectFromFriendsRequest;
	import proto.chat.chat1004.SearchChatObjectFromFriendsResponse;
	import proto.chat.chat1007.GetChatSettingInfoRequest;
	import proto.chat.chat1007.GetChatSettingInfoResponse;
	import proto.friends.friends301.addPlayerFriendRequest;
	import proto.friends.friends301.addPlayerFriendResponse;
	import proto.friends.friends302.getPlayerFrindsRequest;
	import proto.friends.friends302.getPlayerFrindsResponse;
	import proto.group.group902.invitedGroupRequest;
	import proto.group.group902.invitedGroupResponse;
	import proto.scene.scene221.GetOtherRoleInfoRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.ChangeWindowStateEvent;
	import sceneModule.event.ChatEquipmentEvent;
	import sceneModule.event.MainApplicationChangeIndexEvent;
	import sceneModule.mediator.ScenePageMediator;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.chat.view.AddToBlackWarningComponent;
	import sceneModule.view.chat.view.ChatWindow;
	import sceneModule.view.chat.vo.ChatEquipmentVo;
	import sceneModule.view.chat.vo.NearChatFriendsInfoVo;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.friend.model.vo.FriendInfoVo;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.task.command.TaskMessage;
	
	import service.DefaultTokenHandler;
	import service.IChatSocketServer;
	import service.ISocketServer;
	
	import spark.events.TextOperationEvent;
	
	import util.ByteArrayUtil;
	import util.PackageIitemInfoSettingUtil;

	/**
	 * ChatWindowMediator 
	 * @author Yaolx
	 * 
	 */	
	public class ChatWindowMediator extends Mediator
	{
		[Inject]
		public var chatWindow:ChatWindow;
		
		[Inject]
		public var chatSocketService:IChatSocketServer;
		
		[Inject]
		public var serverConfig:ServerConfig;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		//存放装备信息
		private var itemInfoDic:Dictionary = new Dictionary();
		
		private var myMenu:Menu;
		
		private var idArr:Array;
		public function ChatWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			createSocketConnect();
			onRegisterSubscribe();
			eventMap.mapListener(chatWindow.iTextArea,TextEvent.LINK,onTextLink);
			eventMap.mapListener(chatWindow.sendBtn,MouseEvent.CLICK,onSendMessage);
			eventMap.mapListener(chatWindow,KeyboardEvent.KEY_UP,onKeyUp);
			this.eventMap.mapListener(chatWindow.cardtype,ItemClickEvent.ITEM_CLICK,onItemClick);
			this.eventDispatcher.addEventListener(ChatEquipmentEvent.CHATEQUIPMENTEVENT,onChatEquip);
			
			//appendChatInfo("GM功能暂未开启,敬请期待!",4);
		}
		
		private function onKeyUp(evt:KeyboardEvent):void{
			if(evt.keyCode == Keyboard.ENTER){
				onSendMessage();
				
			}
		}
		/**
		 * 超链接事件 
		 * @param evt
		 * 
		 */	
		private var linkType:int;//临时超链接类型
		private var sendId:int;//临时相应的超链接所需的id
		private var tempName:String;//临时的超链接名称
		private var tempItemId:int;
		private function onTextLink(evt:TextEvent):void{
			if(SystemDataModel.isBattleStatusFlag)return;
			chatWindow.mouseEnabled = true;
			var tempP:Array;
			if(evt.text.indexOf("?")>=0){
				tempP = evt.text.split("?");
				if(tempP.length == 4){
				   sendId = tempP[0];
				   linkType = tempP[1];
				   tempName = tempP[2];
				   tempItemId = tempP[3];
					   switch(linkType){
						   case ProConst.CHATLINK_EQUIP:
							   //弹出装备menu
							   addEquipMenu();
							   break;
						   case ProConst.CHATLINK_ROLE:
							   //弹出角色MENU
							   TaskMessage.getInstance().clear_find_path();
							   if(sendId != SystemDataModel.roleId){
								   addRoleMenu();
							   }
							  
							   break;
						   case ProConst.CHATLINK_BOSS:
							   //怪物
							   addBossMenu();
							   break;
					   }
				}else{
					popUpShow.show("参数个数报错!!!");
				}
			}else{
				popUpShow.show("Error chatLink");
			}
		}
		/**
		 * 弹出装备Menu
		 */
		private var equipmentTooltip:MainMenuEquipmentTooltip;
		private function addEquipMenu():void{
			if(itemInfoDic.hasOwnProperty(tempItemId)){
				equipmentTooltip = new MainMenuEquipmentTooltip();
//				trace(itemInfoDic[tempItemId]);
				equipmentTooltip.curDataInfo = itemInfoDic[tempItemId] as PackageItem;
				PopUpManager.addPopUp(equipmentTooltip,FlexGlobals.topLevelApplication as DisplayObject);
				equipmentTooltip.x = FlexGlobals.topLevelApplication.mouseX;
				equipmentTooltip.y = FlexGlobals.topLevelApplication.mouseY - equipmentTooltip.height;
				FlexGlobals.topLevelApplication.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			}
			
		}
		private function onMouseDown(evt:MouseEvent):void{
			FlexGlobals.topLevelApplication.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			PopUpManager.removePopUp(equipmentTooltip);
		}
		/**
		 * 弹出怪物menu
		 */
		private function addBossMenu():void{
			var arr:Array = new Array(['查看'],['复制'],['寻路']);
			myMenu = Menu.createMenu(null,getItemMenuData(arr), false);
			myMenu.labelField = 'label';
			myMenu.addEventListener(MenuEvent.ITEM_CLICK,onBossMenuItemClick);
			myMenu.show(FlexGlobals.topLevelApplication.mouseX,FlexGlobals.topLevelApplication.mouseY);
		}
		/**
		 * BossMenuItemClick
		 */
		private function onBossMenuItemClick(evt:MenuEvent):void{
			switch(evt.index){
				case 0:
					popUpShow.show("查看怪物");
					break;
				case 1:
					popUpShow.show("复制怪物");
					break;
				case 2:
					popUpShow.show("寻路怪物");
					break;
			}
		}
		/**
		 * 复制
		 */
		private function onCopyBoss():void{
			//TODO
		}
		/**
		 * 寻路 
		 * 
		 */		
		private function onSearchRoad():void{
			//TODO
		}
		/**
		 * 弹出角色menu
		 */
		private var tempArr:Array=new Array();
		private var arrl:Array = new Array([CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_ckzl')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jwhy')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sl')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_fzmc')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_hmd')]);
		private var arrb:Array = new Array([CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_ckzl')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jwhy')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sl')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_fzmc')]);
		private function addRoleMenu():void{
			var len:int=SystemDataModel.blackPlayerList.length;
			if(len==0)
			{
				tempArr=arrl;
			}else
			{
				for(var i:int=0;i<len;i++){
					var blackListVo:FriendInfoVo = SystemDataModel.blackPlayerList.getItemAt(i) as FriendInfoVo;
					
					if(tempName==blackListVo.roleName){
						tempArr=arrb;
					}else
					{
						tempArr=arrl;
					}
				}
			}
			
			myMenu = Menu.createMenu(null,getItemMenuData(tempArr), false);
			myMenu.width = 100;
			myMenu.labelField = 'label';
			myMenu.addEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
			myMenu.show(FlexGlobals.topLevelApplication.mouseX,FlexGlobals.topLevelApplication.mouseY - myMenu.height-40);
			chatWindow.iTextArea.setFocus();
		}
		/**
		 * MenuItemClick
		 */
		private function onMenuItemClick(evt:MenuEvent):void{
			switch(evt.index){
				case 0:
					//查看资料
					this.dispatch(new NFriendEvent(NFriendEvent.NFriendEvent_LOOK_INFO,sendId,true));
					viewRoleInfo();
					
					break;
				case 1:
					//加为好友
					onAddFriends(1,tempName);
					getBlackName();
					break;
				case 2:
					//密语
					chatOneSelf();
					break;
				case 3:
					//复制昵称
					System.setClipboard(tempName);
					break;
				case 4:
					//加为黑名单
					if(SystemDataModel.addBlackFlag){
						onAddFriends(2,tempName);
					}else{
						onAddBlackFunction(tempName);
					}
					break;
			}
		}
		private function onAddBlackFunction(name:String):void{
			
			var len:int=SystemDataModel.blackPlayerList.length;
			var obj:Object=new Object();
			obj.name=name;
			if(len==0){
				WindowManager.createWindow(AddToBlackWarningComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
				return;
			}
			
			for(var i:int=0;i<len;i++){
				var blackListVo:FriendInfoVo = SystemDataModel.blackPlayerList.getItemAt(i) as FriendInfoVo;
				
				if(name==blackListVo.roleName){
					return;
				}
			}
			WindowManager.createWindow(AddToBlackWarningComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		/**
		 * 添加好友
		 * id int类型，角色id；playerName: 要添加玩家名字；type: 关系类型 1.好友 2.仇敌；isSheildMail: 是否屏蔽邮件  true/false；content: 添加好友的邮件内容。
		 */
		private function onAddFriends(type:int,name:String):void{
			var addFriendsRequest:proto.friends.friends301.addPlayerFriendRequest = new addPlayerFriendRequest();
			addFriendsRequest.id = SystemDataModel.roleId;
			addFriendsRequest.type = type;
			addFriendsRequest.playerName = name;
			var addFriendsByteArray:ByteArray = new ByteArray();
			addFriendsRequest.writeExternal(addFriendsByteArray);
			socketServer.send(new mx.rpc.Responder(resultAddHandler,faultHandler),URLConst.ADD_FRIENDS_COMMANDID,addFriendsByteArray);
		}
		/**
		 * resultHandler 
		 */		
		private function resultAddHandler(data:Object):void{
			var responseData:proto.friends.friends301.addPlayerFriendResponse = new addPlayerFriendResponse();
			var byteArray:ByteArray = data as ByteArray;
			responseData.readExternal(byteArray);
			if(!responseData.result){
				popUpShow.show(responseData.message);
			}
			
		}
		
		public function getBlackName():void
		{
			var requestGetFriendsInfo:proto.friends.friends302.getPlayerFrindsRequest = new getPlayerFrindsRequest();
			requestGetFriendsInfo.id = SystemDataModel.roleId;
			//			requestGetFriendsInfo.type = 2;
			var playerInfoByteArray:ByteArray = new ByteArray();
			requestGetFriendsInfo.writeExternal(playerInfoByteArray);
			socketServer.send(new mx.rpc.Responder(getBlackListHandler,faultHandler),URLConst.GET_BLACKPLAYER_COMMANDID,playerInfoByteArray,true);
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
		/**
		 * 角色查看
		 */
		private function viewRoleInfo():void{
//			onLookOtherRoleInfo(sendId);
			NCropMessage.getInstance().request_see_other(sendId);
		}
		/**
		 * 行会邀请
		 */
		private function inviteFamily():void{
			//TODO
		}
		
		/**
		 * 组队
		 */
		private function inviteGroup(roleId:int):void{
			var request:invitedGroupRequest = new invitedGroupRequest();
			request.id = SystemDataModel.roleId;
			request.tid = roleId;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(resultGroupHandler,faultHandler),URLConst.INVITED_GROUP_COMMANDID,byteArray);
		}
		private function resultGroupHandler(data:Object):void{
			var responseByteArray:ByteArray = data as ByteArray;
			var responseData:invitedGroupResponse = new invitedGroupResponse();
			responseData.readExternal(responseByteArray);
			if(responseData.result){
				
			}
		}
		/**
		 * 私聊
		 */
		private function chatOneSelf():void{
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,sendId,tempName));
		}
		private function getItemMenuData(itemArr:Array):Array {
			var l:int = itemArr.length;
			var itemMenuData:Array = new Array();
			for(var i:int=0;i<l;i++){
				var menuItem:Object = new Object();
				menuItem.label = itemArr[i];
				itemMenuData.push(menuItem);
			}
			return itemMenuData;
		}
		private var textFlow:TextFlow = new TextFlow();
		private var p:ParagraphElement = new ParagraphElement();
		private var linkElement:LinkElement = new LinkElement();
		private var spanElement:SpanElement = new SpanElement();
		private function onChatEquip(evt:ChatEquipmentEvent):void{
//			chatWindow.myMessage.text += "[%"+evt.chatEquipVo.name+"%]";
			var arr:Array = new Array();
			var roleInfo:itemLinkData = new itemLinkData();
			roleInfo.chatEquipType = ProConst.CHATLINK_ROLE;
			roleInfo.id =  SystemDataModel.roleId;
			arr.push(roleInfo);
			arr.push(evt.chatEquipVo);
			onSendMessageOrEquipment("[%"+evt.chatEquipVo.name+"%]",arr);
		}
		/**
		 * 
		 * ItemClickEvent
		 */
		private function onItemClick(evt:ItemClickEvent):void{
			setCurrentInfo();
		}
		/**
		 * 设置聊天框内显示相应的频道信息
		 */
		private function setCurrentInfo():void{
			var cardValue:Object = chatWindow.cardtype.selectedValue;
			switch(cardValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_zh'):
					chatWindow.iTextArea.htmlText = chatWindow.compositeMessage;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sj'):
					chatWindow.iTextArea.htmlText = chatWindow.worldMessage;
					chatWindow.chatTypeCB.selectedIndex = 0;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_dq'):
					chatWindow.iTextArea.htmlText = chatWindow.currentMessage;
					chatWindow.chatTypeCB.selectedIndex = 1;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jt'):
					chatWindow.iTextArea.htmlText = chatWindow.corpsMessage;
					chatWindow.chatTypeCB.selectedIndex = 2;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_gm'):
					chatWindow.iTextArea.htmlText = chatWindow.gmMessage;
					break;
			}
			chatWindow.onValueCommit();
		}
		/**
		 * 创建聊天Socket连接 
		 * 
		 */	
		private function createSocketConnect():void{
			chatSocketService.host = serverConfig.chatSocketServerIp;
			chatSocketService.port = serverConfig.chatSocketServerPort;
			chatSocketService.connect();
			var request:loginToChatServerRequest = new loginToChatServerRequest();
			request.id = SystemDataModel.roleId;
			request.placeId = SystemDataModel.placeId;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			chatSocketService.send(new mx.rpc.Responder(resultConnectHandler,faultHandler),URLConst.CHAT_SERVER_COMMANDID,byteArray);
		}
		
		/**
		 * 订阅消息
		 * 
		 */
		private function onRegisterSubscribe():void{
			chatSocketService.send(new mx.rpc.Responder(resultMessageHandler,faultHandler),1002,null,false);
		}
		/**
		 * 收到服务器广播消息处理 
		 * @param evt
		 * 
		 */		
		private const ONELINE_LENGTH:int = 1000;
		private var t_l:int;
		private function resultMessageHandler(evt:Object):void{
		    var byteArray:ByteArray = evt as ByteArray;
			var responseData:chatMessageResponse = new chatMessageResponse();
			responseData.readExternal(byteArray);
			
			var newMessage:String = "";
			switch(responseData.topic){
				case ProConst.WORLD_INFO:
					newMessage += "<font color='#ffffff'>["+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sj')+"]<u><a href='event:"+responseData.linkData[0].id+"?"+responseData.linkData[0].chatEquipType+"?"+responseData.linkData[0].name+"?"+responseData.linkData[0].itemInfo+"'><font color='#92d050'>"+setSplitLengthToString(responseData.fromName)+"</font></a></u></font>";
					break;
				case ProConst.CURRENT_INFO:
					newMessage += "<font color='#ffffff'>["+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_dq')+"]<u><a href='event:"+responseData.linkData[0].id+"?"+responseData.linkData[0].chatEquipType+"?"+responseData.linkData[0].name+"?"+responseData.linkData[0].itemInfo+"'><font color='#92d050'>"+setSplitLengthToString(responseData.fromName)+"</font></a></u></font>";
					break;
				case ProConst.CORPS_INFO:
					newMessage += "<font color='#00b050'>["+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jt')+"]<u><a href='event:"+responseData.linkData[0].id+"?"+responseData.linkData[0].chatEquipType+"?"+responseData.linkData[0].name+"?"+responseData.linkData[0].itemInfo+"'><font color='#92d050'>"+setSplitLengthToString(responseData.fromName)+"</font></a></u></font>";
					break;
				case ProConst.GM_INFO:
					newMessage += "<font color='#ff0000'>["+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_gm')+"]</font>";
					break;
				case ProConst.SYSTEM_INFO:
					newMessage += "<font color='#ffff00'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_tg')+"</font>";
					break;
				case ProConst.CORPSSYSTEM_INFO:
					newMessage += "<font color='#00b050'>["+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jt')+"]</font>";
					break;
			}
			newMessage += setSplitLengthToString(":");
			var chatMessage:String = "";
			var tempA:Array;
			var link_index:int;
			if(responseData.content.indexOf("[%")>=0){
				tempA=responseData.content.split("[%");
				var al:int = tempA.length;
				for(var ai:int=0;ai<al;ai++){
					if(tempA[ai].indexOf("%]")>=0){
						var tempB:Array = tempA[ai].split("%]");
						var bl:int = tempB.length;
						for(var bi:int=0;bi<bl;bi++){
							if(bi == 0){
								++link_index;
								if(responseData.linkData[link_index].chatEquipType == 0 && responseData.linkData[link_index].itemInfo){
									if(!itemInfoDic.hasOwnProperty(responseData.linkData[link_index].itemInfo.id)){
										
										itemInfoDic[responseData.linkData[link_index].itemInfo.id] = PackageIitemInfoSettingUtil.PackageItemSetting(responseData.linkData[link_index].itemInfo);
									}
									
									switch(itemInfoDic[responseData.linkData[link_index].itemInfo.id].nowQuality){
										case 0:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u>"+setSplitLengthToString(tempB[bi])+"</u></a>";
											break;
										case 1:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#00FF00'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
										case 2:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#00FFFF'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
										case 3:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#9900FF'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
										case 4:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#FFFF00'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
										case 5:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#FF6600'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
										case 6:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#FF0000'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
										case 7:
											chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+responseData.linkData[link_index].itemInfo.id+"'><u><font color='#FF00CC'>"+setSplitLengthToString(tempB[bi])+"</font></u></a>";
											break;
									}
								}else{
									chatMessage += "<a href='event:"+responseData.linkData[link_index].id+"?"+responseData.linkData[link_index].chatEquipType+"?"+responseData.linkData[link_index].name+"?"+0+"'><u>"+setSplitLengthToString(tempB[bi])+"</u></a>";
								}
								
							}else{
								chatMessage+=setSplitLengthToString(tempB[bi]);
							}
						}
					}else{
						chatMessage+=setSplitLengthToString(tempA[ai]);
					}
				}
			}else{
				chatMessage = setSplitLengthToString(responseData.content);
			}
			switch(responseData.topic){
				case ProConst.WORLD_INFO:
					newMessage += "<font color='#ffffff'>"+chatMessage+"</font>";
					break;
				case ProConst.CURRENT_INFO:
					newMessage += "<font color='#ffffff'>"+chatMessage+"</font>";
					break;
				case ProConst.CORPS_INFO:
					newMessage += "<font color='#ffffff'>"+chatMessage+"</font>";
					break;
				case ProConst.GM_INFO:
					newMessage += "<font color='#ff0000'>"+chatMessage+"</font>";
					break;
				case ProConst.SYSTEM_INFO:
					newMessage += "<font color='#ffff00'>"+chatMessage+"</font>";
					break;
			}
			//消息完成后把标志位设为0
			t_l = 0;
			//把自己发的言同时显示在聊天泡泡中
			if(SystemDataModel.roleInfo.nickname == responseData.fromName){
				//TODO wordscene
				//characterOp.setCharacterChatPopo(SystemDataModel.roleId,responseData.content);
			}			
			WordSceneSprite.getInstance().say(responseData.id, chatMessage);
			appendChatInfo(newMessage,responseData.topic);
		}
		/**
		 * 把当前的角色插入到最近联系人的集合中 
		 */		
		private function insertNearChatList(id:int,name:String):void{
			var l:int = chatWindow.nearChatList.length;
			for(var i:int=0;i<l;i++){
				if(chatWindow.nearChatList[i].roleName == name){
					chatWindow.nearChatList.removeItemAt(i);
				}
			}
			var roleInfo:NearChatFriendsInfoVo = new NearChatFriendsInfoVo();
			roleInfo.roleId = id;
			roleInfo.roleName = name;
			chatWindow.nearChatList.addItemAt(roleInfo,0)
			while(chatWindow.nearChatList.length > 10){
				chatWindow.nearChatList.removeItemAt(chatWindow.nearChatList.length);
			}
		}
	    /**
		 * 向聊天框添加聊天内容
		 * 
		 */
		private var cfg:Configuration = TextFlow.defaultConfiguration;	
		private var normalFmt:TextLayoutFormat = new TextLayoutFormat(cfg.defaultLinkNormalFormat);
		private var hoverFmt:TextLayoutFormat = new TextLayoutFormat(cfg.defaultLinkHoverFormat);
		
		private function setTextFormat():void{
			normalFmt.color = 0xFF0000; // red
			normalFmt.textDecoration = TextDecoration.NONE;
			
			hoverFmt.color = 0xFF00FF; // purple
			hoverFmt.textDecoration = TextDecoration.UNDERLINE;
			
			cfg.defaultLinkNormalFormat = normalFmt;
			cfg.defaultLinkHoverFormat = hoverFmt;
		}
		//根据相应的类型添加到相应的信息集合中
		private function appendChatInfo(message:String,type:int):void{
			setTextFormat();
		    
			switch(type){
				case ProConst.WORLD_INFO:
					appendInfoToComposite(message);
					appendInfoToWorld(message);
					break;
				case ProConst.CURRENT_INFO:
					appendInfoToComposite(message);
					appendInfoToCurrent(message);
					break;
				case ProConst.CORPS_INFO:
					appendInfoToComposite(message);
					appendInfoToCorps(message);
					break;
				case ProConst.GM_INFO:
					appendInfoToComposite(message);
					appendInfoToGM(message);
					break;
				case ProConst.SYSTEM_INFO:
					appendInfoToComposite(message);
					break;
			}
			//显示相应的信息
			setCurrentInfo();
		}
		private function setSplitLengthToString(message:String):String{
			var str:String = "";
			var l:int = message.length;
			for(var i:int=0;i<l;i++){
				t_l += ByteArrayUtil.__getStringBytesLength(message.charAt(i),"gb2312");
				//如果字符串长度等于指定长度 则加换行符且加两个空格
				if(t_l == ONELINE_LENGTH){
					str += (message.charAt(i)+"<br>      ");
					//把标志位设为默认状态0
					t_l = 0;
				}else if(t_l > ONELINE_LENGTH){
					//如果加上此字符串后长度大于指定长度，则先换行加两个空格后在加上此字符串
					str += ("<br>      "+message.charAt(i));
					//把标志位设为默认状态0
					t_l = ByteArrayUtil.__getStringBytesLength(message.charAt(i),"gb2312");;
				}else{
					str += message.charAt(i);
				}
			}
			return str;
		}
		/**
		 * 把信息添加到综合频道信息集合中
		 */
		private const MAXCOUNT:int = 60;
		private function appendInfoToComposite(message:String):void{
			//如果信息集合中德数据大于200条，则删除最早的一条
			if(chatWindow.compositeMessageArr.length >=MAXCOUNT){
				chatWindow.compositeMessageArr.shift();
			}
			//信息添加到全部信息集合中
			chatWindow.compositeMessageArr.push(message);
			//组织综合所有数据
			var l:int = chatWindow.compositeMessageArr.length;
			chatWindow.compositeMessage='';
			for(var i:int=0;i<l;i++){
				if(i==0){
					chatWindow.compositeMessage += chatWindow.compositeMessageArr[i];
				}else{
					chatWindow.compositeMessage += ("<br>"+chatWindow.compositeMessageArr[i]);
				}
				
			}
		}
		/**
		 * 把信息添加到世界频道信息集合中
		 */
		private function appendInfoToWorld(message:String):void{
			//如果信息世界中德数据大于200条，则删除最早的一条
			if(chatWindow.worldMessageArr.length >=MAXCOUNT){
				chatWindow.worldMessageArr.shift();
			}
			//信息添加到世界信息集合中
			chatWindow.worldMessageArr.push(message);
			//组织世界所有数据
			var l:int = chatWindow.worldMessageArr.length;
			chatWindow.worldMessage='';
			for(var i:int=0;i<l;i++){
				if(i != 0){
					chatWindow.worldMessage += ("<br>"+chatWindow.worldMessageArr[i]);
				}else{
					chatWindow.worldMessage += chatWindow.worldMessageArr[i];
				}
			}
		}
		/**
		 * 把信息添加到当前频道信息集合中
		 */
		private function appendInfoToCurrent(message:String):void{
			//如果信息当前中德数据大于200条，则删除最早的一条
			if(chatWindow.currentMessageArr.length >=MAXCOUNT){
				chatWindow.currentMessageArr.shift();
			}
			//信息添加到当前信息集合中
			chatWindow.currentMessageArr.push(message);
			//组织当前所有数据
			var l:int = chatWindow.currentMessageArr.length;
			chatWindow.currentMessage='';
			for(var i:int=0;i<l;i++){
				if(i==0){
					chatWindow.currentMessage += chatWindow.currentMessageArr[i];
				}else{
					chatWindow.currentMessage += ("<br>"+chatWindow.currentMessageArr[i]);
				}
				
			}
		}
		/**
		 * 把信息添加到军团频道信息集合中
		 */
		private function appendInfoToCorps(message:String):void{
			//如果信息军团中德数据大于200条，则删除最早的一条
			if(chatWindow.corpsMessageArr.length >=MAXCOUNT){
				chatWindow.corpsMessageArr.shift();
			}
			//信息添加到军团信息集合中
			chatWindow.corpsMessageArr.push(message);
			//组织军团所有数据
			var l:int = chatWindow.corpsMessageArr.length;
			chatWindow.corpsMessage='';
			for(var i:int=0;i<l;i++){
				if(i==0){
					chatWindow.corpsMessage += chatWindow.corpsMessageArr[i];
				}else{
					chatWindow.corpsMessage += ("<br>"+chatWindow.corpsMessageArr[i]);
				}
				
			}
		}
		/**
		 * 把信息添加到GM频道信息集合中
		 */
		private function appendInfoToGM(message:String):void{
			//如果信息GM中德数据大于200条，则删除最早的一条
			if(chatWindow.gmMessageArr.length >=MAXCOUNT){
				chatWindow.gmMessageArr.shift();
			}
			//信息添加到GM信息集合中
			chatWindow.gmMessageArr.push(message);
			//组织GM所有数据
			var l:int = chatWindow.gmMessageArr.length;
			chatWindow.gmMessage='';
			for(var i:int=0;i<l;i++){
				if(i==0){
					chatWindow.gmMessage += chatWindow.gmMessageArr[i];
				}else{
					chatWindow.gmMessage += ("<br>"+chatWindow.gmMessageArr[i]);
				}
				
			}
		}
		/**
		 * 发送消息
		 */
		private var preSendTime:int;
		private function onSendMessage(evt:MouseEvent=null):void{
			var msg:String = this.chatWindow.myMessage.text;
			var msgArr:Array = msg.split("\DreamY");
			if(msgArr.length<=1){
				if(SystemDataModel.roleInfo.level < 0){
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','mtotcW_jbxz'));
					return;
				}
			}else{
				msg = msg.slice(7,int.MAX_VALUE);
			}
			if(chatWindow.chatTypeCB.selectedIndex == 2){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','mtotcW_jtxz'));
				return;
			}
			
			if(this.chatWindow.myMessage.text == ""){
//				trace("内容不能为空！！！！");
				return;
			}
			var roleInfo:itemLinkData = new itemLinkData();
			roleInfo.chatEquipType = ProConst.CHATLINK_ROLE;
			roleInfo.id =  SystemDataModel.roleId;
			roleInfo.name = SystemDataModel.roleInfo.nickname;
			var curTime:int = getTimer();
			if((curTime - preSendTime)<1000){
				onWarringOrErrorInfo("<font color='#ffff00'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sm')+"</font>");
				preSendTime = curTime;
				return;
			}
			onSendMessageOrEquipment(msg, new Array(roleInfo));
			//hao
			//debug command
			KeyBordManager.getInstance().cmd(chatWindow.myMessage.text);
			
			
			preSendTime = curTime;
			//清空消息内容
			chatWindow.myMessage.text="";
		}
		/**
		 *发送聊天信息或装备信息 
		 * @param str
		 * @param linkArr
		 * 
		 */		
		private function onSendMessageOrEquipment(str:String,linkArr:Array):void{
			var request:proto.chat.chat1003.chatConectingRequest = new chatConectingRequest();
			request.id = SystemDataModel.roleId;
			request.content = str;
			request.topic = chatWindow.chatTypeCB.selectedIndex + 1;
			request.linkData = linkArr;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			chatSocketService.send(new mx.rpc.Responder(resultHandler,faultHandler),1003,byteArray);
			switch(chatWindow.chatTypeCB.selectedIndex){
				case 0:
					chatWindow.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sj');
					break;
				case 1:
					chatWindow.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_dq');
					break;
				case 2:
					chatWindow.cardtype.selectedValue = CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jt');
					break;
			}
			setCurrentInfo();
		}
		private function resultHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:chatConectingResponse = new chatConectingResponse();
			responseData.readExternal(byteArray);
			if(!responseData.result){
				onWarringOrErrorInfo(responseData.message);
			}
		}
		/**
		 * 错误或警告信息
		 */
		private function onWarringOrErrorInfo(message:String):void{
			var war_message:String = "<font color='#ffff00'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_tg')+"+"+message+"</font>";
			switch(chatWindow.chatTypeCB.selectedIndex){
				case 0:
					appendInfoToWorld(message);
					break;
				case 1:
					appendInfoToCurrent(message);
					break;
				case 2:
					appendInfoToCorps(message);
					break;
			}
			//显示相应的信息
			setCurrentInfo();
		}
		/**
		 * faultHandler 
		 */		
		private function faultHandler(dat:Object):void{
			
		}
		/**
		 * 返回值处理
		 * 
		 */
		private function resultConnectHandler(data:Object):void{
			
		}
	}
}
package sceneModule.view.chat.mediator
{
	/**
	 * 私聊对话框mediator 
	 */	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.chat.chat1011.GetOneObjectChatInfoRequest;
	import proto.chat.chat1011.GetOneObjectChatInfoResponse;
	import proto.chat.chat1012.ServerSendChatInfoResponse;
	import proto.chat.chat1013.SendChatMessageRequest;
	import proto.chat.chat1014.CloseChatWindowRequest;
	import proto.friends.friends301.addPlayerFriendRequest;
	import proto.friends.friends301.addPlayerFriendResponse;
	import proto.friends.friends303.removePlayerFriendRequest;
	import proto.friends.friends303.removePlayerFriendResponse;
	import proto.scene.scene221.GetOtherRoleInfoRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.chat.view.MainOneToOneChatWindow;
	import sceneModule.view.chat.vo.WhisperChatObjectInfoVO;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.IChatSocketServer;
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;

	public class MainOneToOneChatWindowMediator extends Mediator
	{
		[Inject]
		public var comp:MainOneToOneChatWindow;
		
		[Inject]
		public var chatServer:IChatSocketServer;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function MainOneToOneChatWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.chatObjectList,IndexChangeEvent.CHANGE,onSelectedChatObject);
			this.eventMap.mapListener(comp.sendBtn,MouseEvent.CLICK,onSendMessage);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.addFriends,MouseEvent.CLICK,onAddFriend);
			this.eventMap.mapListener(comp.addBlackFriends,MouseEvent.CLICK,onBlackFrineds);
			
			this.eventMap.mapListener(comp.viewInfo,MouseEvent.CLICK,onLookOtherRoleInfo);
			//添加服务器推送的聊天信息
			addServerSendClientChatInfo();
			//选择某一个私聊对象
//			onGetChatObjectInfo(comp.data.chatObjectId);
			
			init_view();
			onGetChatObjectInfo(comp.data.chatObjectId);
		}
		
		private function init_view():void{
			comp.bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_whisper", "whisper_bg");
		}
		
		private function onSelectedChatObject(evt:IndexChangeEvent = null):void{
			//私聊对象id
			comp.data = comp.chatObjectList.selectedItem;
			//选择某一个私聊对象
			onGetChatObjectInfo(comp.data.chatObjectId);
		}
		/**
		 * 选择私聊对象获取私聊对象聊天记录信息 
		 * @param chatId 私聊对象id
		 */		
		private function onGetChatObjectInfo(chatId:int):void{
			var getChatObjListReq:GetOneObjectChatInfoRequest = new GetOneObjectChatInfoRequest();
			getChatObjListReq.id = SystemDataModel.roleId;
			getChatObjListReq.chatObjectId = chatId;
			var byteArray:ByteArray = new ByteArray();
			getChatObjListReq.writeExternal(byteArray);
			chatServer.send(new mx.rpc.Responder(getOneObjectInfoHandler,faultHandler),URLConst.CHAT_GETONEOBJINFO_COMMANDID,byteArray);
		}
		private function getOneObjectInfoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetOneObjectChatInfoResponse = new GetOneObjectChatInfoResponse();
			responseData.readExternal(byteArray);
			var chatObj:Object = new Object();
//			comp.data.chatObjectId = comp.data.chatObjectId;
			comp.data.name = responseData.name;
//			comp.data.level = responseData.level;
			comp.contentSizeShow2.text = 'Lv.'+responseData.level;
//			comp.data.perfession = responseData.perfession;
			comp.contentSizeShow1.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','mtotcWM_zy')+responseData.perfession;
//			comp.data.chatObjectPos = responseData.chatObjectPos;
			comp.contentSizeShow3.text = responseData.chatObjectPos;
			
//			comp.data = chatObj;
			if(responseData.result){
				comp.chatInfoTextArea.htmlText = responseData.chatMessage;
			}
		}
		/**
		 *发送私聊信息 
		 */		
		private function onSendMessage(evt:MouseEvent):void{
			if(comp.writeChatContent.text){
				var sendMsgReq:SendChatMessageRequest = new SendChatMessageRequest();
				sendMsgReq.id = SystemDataModel.roleId;
				sendMsgReq.chatId = comp.data.chatObjectId;
				sendMsgReq.chatMessage = comp.writeChatContent.text;
				var byteArray:ByteArray = new ByteArray();
				sendMsgReq.writeExternal(byteArray);
				chatServer.send(new mx.rpc.Responder(sendMsgHandler,faultHandler),URLConst.CHAT_SENDCHATMESSAGE_COMMANDID,byteArray);
				
				comp.writeChatContent.text = '';
				comp.onMainChange();
			}
		}
		private function sendMsgHandler(data:Object):void{
			
		}
		/**
		 * 关闭私聊窗口 
		 * @param evt
		 * 
		 */		
		private function onCloseWindow(evt:MouseEvent):void{
			onSendCloseWindowCommand();
			onRemoveListener();
			WindowManager.closeWindow(MainOneToOneChatWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer);
		}
		/**
		 * 移出事件监听 
		 * @param evt
		 * 
		 */		
		private function onRemoveListener():void{
			
		}
		/**
		 * 发送关闭窗口信息 
		 * @param evt
		 * 
		 */		
		private function onSendCloseWindowCommand():void{
			var closeWindowReq:CloseChatWindowRequest = new CloseChatWindowRequest();
			closeWindowReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			closeWindowReq.writeExternal(byteArray);
			chatServer.send(new mx.rpc.Responder(closeWindowHandler,faultHandler),URLConst.CHAT_CLOSECHATWINDOW_COMMANDID,byteArray);
		}
		private function closeWindowHandler(data:Object):void{
			
		}
		/**
		 * 监听服务器推送的私聊信息
		 */
		private function addServerSendClientChatInfo():void{
			chatServer.send(new mx.rpc.Responder(serverSendClientHandler,faultHandler),URLConst.CHAT_SERVERTOINFO_COMMANDID,null,false);
		}
		private function serverSendClientHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ServerSendChatInfoResponse = new ServerSendChatInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.id == comp.data.chatObjectId){
				comp.chatInfoTextArea.htmlText = responseData.chatMessage;
				//设置滚动条位置
				comp.chatInfoTextArea.validateNow();
				//当前显示的首行字符的行号
				comp.chatInfoTextArea.verticalScrollPosition=comp.chatInfoTextArea.maxVerticalScrollPosition;//最大行号
			}
			
		}
		/**
		 * 查看其他玩家信息
		 */
		private function onLookOtherRoleInfo(evt:MouseEvent):void{
			NCropMessage.getInstance().request_see_other(comp.data.chatObjectId);
		}
		
		/**
		 * 加为好友 
		 * @param evt
		 * 
		 */		
		private function onAddFriend(evt:MouseEvent):void{
			if(comp.f_btn_flag){
				request_remove_friend(comp.data.chatObjectId);
			}else{
				onAddFriends(1,comp.data.name);
			}
		}
		/**
		 * 加为黑名单 
		 * @param type
		 * @param name
		 * 
		 */	
		private function onBlackFrineds(evt:MouseEvent):void{
			onAddFriends(2,comp.data.name);
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
			socketService.send(new mx.rpc.Responder(resultAddHandler,faultHandler),URLConst.ADD_FRIENDS_COMMANDID,addFriendsByteArray);
		}
		/**
		 * resultHandler 
		 */		
		private function resultAddHandler(data:Object):void{
			var responseData:proto.friends.friends301.addPlayerFriendResponse = new addPlayerFriendResponse();
			var byteArray:ByteArray = data as ByteArray;
			responseData.readExternal(byteArray);
			if(responseData.result){
				comp.f_btn_flag = true;
			}
		}
		
		//删除好友
		public function request_remove_friend(roleId:int):void{
			var msg:removePlayerFriendRequest = new removePlayerFriendRequest();
			msg.friendId = roleId;
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			socketService.send(new Responder(response_remove_friend,faultHandler),URLConst.REMOVE_FRIEND_COMMANDID,bytes);
		}
		private function response_remove_friend(bytes:ByteArray):void{
			var msg:removePlayerFriendResponse = new removePlayerFriendResponse();
			msg.readExternal(bytes);
			if(msg.result){
				comp.f_btn_flag = false;
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
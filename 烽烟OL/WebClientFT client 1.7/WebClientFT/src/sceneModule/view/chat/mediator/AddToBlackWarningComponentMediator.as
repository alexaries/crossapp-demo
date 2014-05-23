package sceneModule.view.chat.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.friends.friends301.addPlayerFriendRequest;
	import proto.friends.friends301.addPlayerFriendResponse;
	import proto.friends.friends302.getPlayerFrindsRequest;
	import proto.friends.friends302.getPlayerFrindsResponse;
	
	import sceneModule.mediator.ScenePageMediator;
	import sceneModule.view.chat.view.AddToBlackWarningComponent;
	import sceneModule.view.friend.model.vo.FriendInfoVo;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	import service.SocketService;

	public class AddToBlackWarningComponentMediator extends Mediator
	{
		[Inject]
		public var comp:AddToBlackWarningComponent;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function AddToBlackWarningComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onSubmit);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.mapListener(comp.addBlackShowFlag,MouseEvent.CLICK,onChangeShowFlag);
		}
		
		private function onSubmit(evt:MouseEvent):void{
			onAddFriends(2,comp.data.name);
			onCloseWindow();
		}
		
		private function onCancel(evt:MouseEvent):void{
			onCloseWindow();
		}
		
		private function onChangeShowFlag(evt:MouseEvent):void{
			if(comp.addBlackShowFlag.selected){
				SystemDataModel.addBlackFlag = true;
			}
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
			if(responseData.result)
			{
				getBlackName();
			}
		}
		
		//获取黑名单
		public function getBlackName():void
		{
			var requestGetFriendsInfo:proto.friends.friends302.getPlayerFrindsRequest = new getPlayerFrindsRequest();
			requestGetFriendsInfo.id = SystemDataModel.roleId;
			var playerInfoByteArray:ByteArray = new ByteArray();
			requestGetFriendsInfo.writeExternal(playerInfoByteArray);
			socketServer.send(new mx.rpc.Responder(getBlackListHandler,faultHandler),URLConst.GET_BLACKPLAYER_COMMANDID,playerInfoByteArray,true);
		}
		
		public function getBlackListHandler(data:Object):void
		{
//			SystemDataModel.blackPlayerList.removeAll();
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
		
		private function onCloseWindow():void{
			this.eventMap.unmapListener(comp.submitBtn,MouseEvent.CLICK,onSubmit);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.unmapListener(comp.addBlackShowFlag,MouseEvent.CLICK,onChangeShowFlag);
			WindowManager.closeWindow(AddToBlackWarningComponent.NAME,false,false,null,popUpWindowLayer);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
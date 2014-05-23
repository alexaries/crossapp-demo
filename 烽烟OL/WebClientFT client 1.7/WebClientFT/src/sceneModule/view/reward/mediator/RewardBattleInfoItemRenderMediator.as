package sceneModule.view.reward.mediator
{
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.system.System;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Menu;
	import mx.core.FlexGlobals;
	import mx.events.MenuEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.friends.friends301.addPlayerFriendRequest;
	import proto.friends.friends301.addPlayerFriendResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.reward.view.RewardBattleInfoItemRender;
	
	import service.ISocketServer;

	/**
	 * RewardBattleInfoItemRenderMediator 
	 * @author Dream-Y
	 * 
	 */	
	public class RewardBattleInfoItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:RewardBattleInfoItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		public function RewardBattleInfoItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.lb,TextEvent.LINK,onTextLink);
			this.eventMap.mapListener(comp.lb0,TextEvent.LINK,onTextLink);
			this.eventMap.mapListener(comp,MouseEvent.CLICK,onMouseClick);
		}
		private function onMouseClick(evt:MouseEvent):void{
//			trace("asadfadfad");
		}
		
		private var roleId:int;
		private var roleName:String;
		private function onTextLink(evt:TextEvent):void{
			var tempP:Array;
			if(evt.text.indexOf("?")>=0){
				tempP = evt.text.split("?");
				if(tempP.length == 2){
					roleId = tempP[0];
					roleName = tempP[1];
					addRoleMenu();
				}
			}
		}
		/**
		 * 弹出角色menu
		 */
		private var myMenu:Menu;
		private var arrl:Array = new Array([CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_ckzl')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_jwhy')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_sl')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_fzmc')],[CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','cwM_hmd')]);
		private function addRoleMenu():void{
			myMenu = Menu.createMenu(null,getItemMenuData(arrl), false);
			myMenu.width = 100;
			myMenu.labelField = 'label';
			myMenu.addEventListener(MenuEvent.ITEM_CLICK,onMenuItemClick);
			myMenu.show(FlexGlobals.topLevelApplication.mouseX,FlexGlobals.topLevelApplication.mouseY - myMenu.height);
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
			socketService.send(new  mx.rpc.Responder(resultAddHandler,faultHandler),URLConst.ADD_FRIENDS_COMMANDID,addFriendsByteArray);
		}
		/**
		 * resultHandler 
		 */		
		private function resultAddHandler(data:Object):void{
			var responseData:proto.friends.friends301.addPlayerFriendResponse = new addPlayerFriendResponse();
			var byteArray:ByteArray = data as ByteArray;
			responseData.readExternal(byteArray);
//			if(!responseData.result){
//				popUpShow.show(responseData.message);
//			}
			
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
		/**
		 * 私聊
		 */
		private function chatOneSelf():void{
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,roleId,roleName));
		}
		/**
		 * MenuItemClick
		 */
		private function onMenuItemClick(evt:MenuEvent):void{
			switch(evt.index){
				case 0:
					//查看资料
					this.dispatch(new NFriendEvent(NFriendEvent.NFriendEvent_LOOK_INFO,roleId,true));
					NCropMessage.getInstance().request_see_other(roleId);
					break;
				case 1:
					//加为好友
					onAddFriends(1,roleName);
					break;
				case 2:
					//密语
					chatOneSelf();
					break;
				case 3:
					//复制昵称
					System.setClipboard(roleName);
					break;
				case 4:
					//加为黑名单
					if(SystemDataModel.addBlackFlag){
						onAddFriends(2,roleName);
					}
					break;
			}
		}
	}
}
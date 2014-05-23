package sceneModule.view.roleInfo.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import wordscene.event.PlusEvent;
	import wordscene.WordSceneSprite;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.friend.command.FriendMessage;
	import sceneModule.view.roleInfo.view.OtherRoleInfoShowComponent;
	
	import service.ISocketServer;

	/**
	 * 查看其他玩家信息 
	 * @author Yaolx
	 * 
	 */    
	public class OtherRoleInfoShowMediator extends Mediator
	{
		[Inject]
		public var otherRoleInfoShowComp:OtherRoleInfoShowComponent;
		
		public function OtherRoleInfoShowMediator()
		{
			super();
		}
		override public function onRegister():void{
			eventMap.mapListener(otherRoleInfoShowComp.viewInfoBtn,MouseEvent.CLICK,onViewRoleInfo);
			eventMap.mapListener(otherRoleInfoShowComp.friendBtn,MouseEvent.CLICK,onAddFriends);
			eventMap.mapListener(otherRoleInfoShowComp.chatBtn,MouseEvent.CLICK,onChatWithRole);
			eventMap.mapListener(otherRoleInfoShowComp.pkBtn,MouseEvent.CLICK,onPk);
		}
		/**
		 * 查看角色信息
		 */
		private function onViewRoleInfo(evt:MouseEvent):void{
			NCropMessage.getInstance().request_see_other(SystemDataModel.otherInfo.id);
		}
		/**
		 * 添加好友
		 */
		private function onAddFriends(evt:MouseEvent):void{
			FriendMessage.getInstance().requese_add_friend(1, SystemDataModel.otherInfo.nickname);
		}
		
		private function onChatWithRole(evt:MouseEvent):void{
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,SystemDataModel.otherInfo.id,SystemDataModel.otherInfo.nickname));
		}
		
		private function onPk(evt:MouseEvent):void {
			WordSceneSprite.getInstance().dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_SCENE_PK, {id:SystemDataModel.otherInfo.id}));
		}
		
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
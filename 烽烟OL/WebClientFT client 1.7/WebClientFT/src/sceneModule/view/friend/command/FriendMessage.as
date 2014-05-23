package sceneModule.view.friend.command 
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	
	import org.robotlegs.core.IMediatorMap;
	
	import proto.corps.corps1318.UnionInviteOtherRequest;
	import proto.corps.corps1318.UnionInviteOtherResponse;
	import proto.corps.corps1319.UnionInvitePlayerNotify;
	import proto.corps.corps1320.UnionInviteReplyRequest;
	import proto.corps.corps1320.UnionInviteReplyResponse;
	import proto.corps.corps1321.UnionInvitePlayerBackNotify;
	import proto.friends.friends301.addPlayerFriendRequest;
	import proto.friends.friends301.addPlayerFriendResponse;
	import proto.friends.friends302.getPlayerFrindsRequest;
	import proto.friends.friends302.getPlayerFrindsResponse;
	import proto.friends.friends303.removePlayerFriendRequest;
	import proto.friends.friends303.removePlayerFriendResponse;
	import proto.friends.friends308.addPlayerFriendtoRequest;
	import proto.friends.friends309.FriendChangeStateRequest;
	import proto.friends.friends309.FriendChangeStateResponse;
	import proto.friends.friends310.FriendLevelUpNotify;
	import proto.friends.friends311.FriendLevelupReplyRequest;
	import proto.friends.friends311.FriendLevelupReplyResponse;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.friend.view.NFriendAlert;
	import sceneModule.view.friend.view.NFriendLevelUpAlert;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.xtrace;
	
	
	/**
	 * ...
	 * @author hao
	 */
	public class FriendMessage extends EventDispatcher
	{
		public static const PAGE_SIZE:int = 11;
		
		[Inject]
		public var socket:ISocketServer;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		[Inject]
		public var popUpShow:IPopUpShow;
		
		public var map_mediarot:IMediatorMap;
		
		private static var _instance:FriendMessage;
		public function FriendMessage() 
		{
			
		}
		public static function getInstance():FriendMessage {
			if (null == _instance) {
				_instance = new FriendMessage();
			}
			return _instance;
		}
		private var _friend_list:Array;
		/////////////////////////////////////////////////////////////////////////////////////
		//申请好友列表
		public function requese_friend_list():void{
			var msg:getPlayerFrindsRequest = new getPlayerFrindsRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("申请还有列表",msg);
			socket.send(new Responder(response_friend_list,faultHandler),URLConst.GET_PLAYERFRIEND_COMMANDID,bytes);
		}
		
		//申请好友列表返回
		private function response_friend_list(bytes:ByteArray):void{
			var msg:getPlayerFrindsResponse = new getPlayerFrindsResponse();
			msg.readExternal(bytes);
			xtrace("申请好友列表返回", msg);
			if (msg.result) {
				_friend_list = msg.data.friends;
				this.dispatchEvent(new NFriendEvent(NFriendEvent.NFriendEvent_REFRESH_LIST,null));
			}
		}
		//添加好友
		//id int类型，角色id；playerName: 要添加玩家名字；type: 关系类型 1.好友 2.仇敌；isSheildMail: 是否屏蔽邮件  true/false；content: 添加好友的邮件内容。
		public function requese_add_friend(type:int,name:String):void{
			var msg:addPlayerFriendRequest = new addPlayerFriendRequest();
			msg.id = SystemDataModel.roleId;
			msg.type = type;
			msg.playerName = name;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("申请添加好友", msg);
			socket.send(new Responder(response_add_friend,faultHandler),URLConst.ADD_FRIENDS_COMMANDID,bytes);
		}
		private function response_add_friend(bytes:ByteArray):void{
			var msg:addPlayerFriendResponse = new addPlayerFriendResponse();
			msg.readExternal(bytes);
			xtrace("添加好友回复", msg);
			if (msg.result) {
				requese_friend_list();
			}
		}
		//删除好友
		public function request_remove_friend(roleId:int):void{
			var msg:removePlayerFriendRequest = new removePlayerFriendRequest();
			msg.friendId = roleId;
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求删除好友",msg);
			socket.send(new Responder(response_remove_friend,faultHandler),URLConst.REMOVE_FRIEND_COMMANDID,bytes);
		}
		private function response_remove_friend(bytes:ByteArray):void{
			var msg:removePlayerFriendResponse = new removePlayerFriendResponse();
			msg.readExternal(bytes);
			xtrace("请求删除好友回复",msg);
			if(msg.result){
				requese_friend_list();
			}
		}
		
		//修改心情
		public function request_change_state(content:String):void{
			var msg:FriendChangeStateRequest = new FriendChangeStateRequest();
			msg.id = SystemDataModel.roleId;
			msg.content = content;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求修改心情",msg);
			socket.send(new Responder(response_change_state,faultHandler),URLConst.FRIEND_CHANGE_STATE,bytes);
		}
		private function response_change_state(bytes:ByteArray):void{
			var msg:FriendChangeStateResponse = new FriendChangeStateResponse();
			msg.readExternal(bytes);
			xtrace("修改心情回复",msg);
		}
		
		
		//有人添加自己为好友
		private function notify_add_self(bytes:ByteArray):void {
			var msg:addPlayerFriendtoRequest = new addPlayerFriendtoRequest();
			msg.readExternal(bytes);
			xtrace("添加自己为好友广播", msg);
			//WindowManager.createWindow(
				//NFriendAlert.NAME,
				//{content:msg.playerName + "已加你为好友", ok_func:requese_add_friend, ok_args:[1, msg.playerName]},
				//null, false, false, false, null, map_mediarot, popUpWindowLayer);
			popUpShow.show(msg.playerName + "이미 추가된 친구입니다",null,null,"친구추가","나중에", requese_add_friend,requese_add_friend,[1, msg.playerName]);
		}
		
		
		//邀请他人加入军团
		public function request_invite_to_union(id:int, name:String):void {
			var msg:UnionInviteOtherRequest = new UnionInviteOtherRequest();
			msg.id = SystemDataModel.roleId;
			msg.otherid = id;
			msg.otername = name;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求邀请他人加入军团",msg);
			socket.send(new Responder(response_invite_to_union,faultHandler),URLConst.CORPS_REQUEST_INVITE_OTHER,bytes);
		}
		private function response_invite_to_union(bytes:ByteArray):void {
			var msg:UnionInviteOtherResponse = new UnionInviteOtherResponse();
			msg.readExternal(bytes);
			xtrace("邀请他人加入军团回复", msg);
		}
		
		//邀请自己进入军团广播
		private function notify_invite_to_union(bytes:ByteArray):void {
			var msg:UnionInvitePlayerNotify = new UnionInvitePlayerNotify();
			msg.readExternal(bytes);
			xtrace("邀请加入军团广播", msg);
			popUpShow.show(
				"【" + msg.playername + "】邀请你加入" + msg.unionname + "军团,是否加入?",
				null, null,
				"接受", "拒绝", 
				request_invite_union_reply,
				request_invite_union_reply,
				[msg.playerid, 1],
				[msg.playerid, 0]
			);
		}
		
		//邀请加入军团选择回复
		public function request_invite_union_reply(union_id:int, is_ok:int):void {
			var msg:UnionInviteReplyRequest = new UnionInviteReplyRequest();
			msg.id = SystemDataModel.roleId;
			msg.unionId = union_id;
			msg.isOk = is_ok;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求回复是否同意加入军团",msg);
			socket.send(new Responder(response_invite_union_reply,faultHandler),URLConst.CORPS_REQUEST_INVITE_REPLY,bytes);
		}
		private function response_invite_union_reply(bytes:ByteArray):void {
			var msg:UnionInviteReplyResponse = new UnionInviteReplyResponse();
			msg.readExternal(bytes);
			xtrace("是否同意加入军团回复", msg);
		}
		
		//好友升级广播
		private function notify_friend_lvup(bytes:ByteArray):void {
			var msg:FriendLevelUpNotify = new FriendLevelUpNotify();
			msg.readExternal(bytes);
			xtrace("好友升级广播", msg);
			WindowManager.createWindow(
				NFriendLevelUpAlert.NAME,
				{
					content:"您的好友" + msg.name + "已经升级到了" + msg.level + "级,您是否要恭喜他一下?" ,
					ok_func:request_friend_lvup_reply, ok_args:[msg.id, 1],
					bishi_func:request_friend_lvup_reply,bishi_args:[msg.id,2]
				},
				null, false, false, false, null,
				map_mediarot , popUpWindowLayer,true
			);
		}
		
		//邀请回复广播
		private function notify_invite_back_alert(bytes:ByteArray):void {
			var msg:UnionInvitePlayerBackNotify = new UnionInvitePlayerBackNotify();
			msg.readExternal(bytes);
			xtrace("邀请回复广播", msg);
			popUpShow.show(msg.msg,null,null,null,null);
		}
		
		
		//对好友升级的回复
		//操作类型 0:错误 1:恭喜 2:鄙视
		public function request_friend_lvup_reply(id:int, type:int):void {
			var msg:FriendLevelupReplyRequest = new FriendLevelupReplyRequest();
			msg.id = SystemDataModel.roleId;
			msg.friendId = id;
			msg.handleType = type;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("回复好友升级请求",msg);
			socket.send(new Responder(response_friend_lvup_reply,faultHandler),URLConst.FRIEND_REQUEST_LEVEL_UP_REPLY,bytes);
		}
		
		private function response_friend_lvup_reply(bytes:ByteArray):void {
			var msg:FriendLevelupReplyResponse = new FriendLevelupReplyResponse();
			msg.readExternal(bytes);
			CrotaCommonAlert.createCrotaBasicAlert(msg.message);
//			xtrace("回复好友升级请求返回", msg);
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:msg.message},null,false,false,false,null,map_mediarot,popUpWindowLayer,true);
		}
		
		
		private function faultHandler(o:Object):void {
			
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////
		public function init_events():void {
			//添加自己为好友广播
			socket.send(new Responder(notify_add_self, faultHandler), URLConst.FRIEND_ADD_SELF, null, false);
			//邀请加入军团
			socket.send(new Responder(notify_invite_to_union, faultHandler), URLConst.CORPS_NOTIFY_INVITE_PLAYER, null, false);
			//好友升级
			socket.send(new Responder(notify_friend_lvup, faultHandler), URLConst.FRIEND_NOTIFY_LEVEL_UP, null, false);
			//邀请回复,弹框广播
			socket.send(new Responder(notify_invite_back_alert, faultHandler), URLConst.CORPS_NOTIFY_INVITE_BACK, null, false);
		}
		
		
		public function get_page_list(page:int):Array{
			var start:int = (page - 1) * PAGE_SIZE;
			var end:int = start + PAGE_SIZE;
			var arr:Array = _friend_list.slice(start, end);
			return arr;
		}
		public function get_max_page():int {
			var r:int = Math.ceil(Number(_friend_list.length) / Number(PAGE_SIZE));
			r = (r == 0 ? 1 : r);
			return  r;
		}
		
		public function get friendsList():Array{
			return _friend_list;
		}
	}

}
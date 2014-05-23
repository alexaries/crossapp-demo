package sceneModule.view.friend.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	
	import sceneModule.event.MainMenuChangeToWriteMailComponentEvent;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.friend.command.FriendMessage;
	import sceneModule.view.friend.event.NFriendEvent;
	import sceneModule.view.friend.view.NChangeStateAlert;
	import sceneModule.view.friend.view.NFriendView;
	import sceneModule.view.friend.view.NInputAlert;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.xtrace;

	/**
	 * PlayerFriendsWindowMediator 
	 * @author Yoalx
	 * 
	 */	
	public class NFriendMediator extends Mediator
	{
		[Inject]
		public var comp:NFriendView;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		[Inject]
		public var popUpShow:IPopUpShow;
		
		private var _cur_page:int;
		
		public function NFriendMediator()
		{
			_cur_page = 1;
			super();
		}
		override public function onRegister():void{
			xtrace("初始化好友界面");
			comp.btn_addfriend.addEventListener(MouseEvent.CLICK, on_add_firend);
			comp.btn_changestate.addEventListener(MouseEvent.CLICK, on_change_state);
			comp.pre_btn.addEventListener(MouseEvent.CLICK, on_pre_page);
			comp.next_btn.addEventListener(MouseEvent.CLICK, on_next_page);
			
			comp.addEventListener(NFriendEvent.NFriendEvent_SEND_MAIL, on_send_mail);
			comp.addEventListener(NFriendEvent.NFriendEvent_LOOK_INFO, on_look_info);
			comp.addEventListener(NFriendEvent.NFriendEvent_INVIDE_TO_UNION, on_to_union);
			comp.addEventListener(NFriendEvent.NFriendEvent_CHAT, on_to_chat);
			comp.addEventListener(NFriendEvent.NFriendEvent_BLOCK, on_to_block);
			comp.addEventListener(NFriendEvent.NFriendEvent_REMOVE, on_to_remove);
			
			this.eventDispatcher.addEventListener(NFriendEvent.NFriendEvent_OPEN, init_view);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			FriendMessage.getInstance().addEventListener(NFriendEvent.NFriendEvent_REFRESH_LIST, refresh_list);
			
			init_view();
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(MainMenuComponent.NAME,false,false,null,popUpWindowLayer);
		}
		
		override public function preRemove():void {
			xtrace("卸载好友界面");
			comp.btn_addfriend.removeEventListener(MouseEvent.CLICK, on_add_firend);
			comp.btn_changestate.removeEventListener(MouseEvent.CLICK, on_change_state);
			comp.pre_btn.removeEventListener(MouseEvent.CLICK, on_pre_page);
			comp.next_btn.removeEventListener(MouseEvent.CLICK, on_next_page);
			
			
			
			comp.removeEventListener(NFriendEvent.NFriendEvent_SEND_MAIL, on_send_mail);
			comp.removeEventListener(NFriendEvent.NFriendEvent_LOOK_INFO, on_look_info);
			comp.removeEventListener(NFriendEvent.NFriendEvent_INVIDE_TO_UNION, on_to_union);
			comp.removeEventListener(NFriendEvent.NFriendEvent_CHAT, on_to_chat);
			comp.removeEventListener(NFriendEvent.NFriendEvent_BLOCK, on_to_block);
			comp.removeEventListener(NFriendEvent.NFriendEvent_REMOVE, on_to_remove);
			
			this.eventDispatcher.removeEventListener(NFriendEvent.NFriendEvent_OPEN, init_view);
			
			FriendMessage.getInstance().removeEventListener(NFriendEvent.NFriendEvent_REFRESH_LIST, refresh_list);
		}
		
		
		private function refresh_list(e:NFriendEvent = null):void {
			var message:FriendMessage = FriendMessage.getInstance();
			comp.friends_list.dataProvider = new ArrayCollection(message.get_page_list(_cur_page));
			
			comp.page_info.text = _cur_page + "/" + message.get_max_page();
			if (_cur_page <= 1) {
				comp.pre_btn.enabled = false;
			}
			else {
				comp.pre_btn.enabled = true;
			}
			var max:int = message.get_max_page();
			if (_cur_page >= max) {
				comp.next_btn.enabled = false;
			}
			else {
				comp.next_btn.enabled = true;
			}
		}
		
		
		private function init_view(e:NFriendEvent = null):void {
			real_show();
			//AssetCenter.getInstance().load_package("ui_friend", real_show, null, true, load_fail);
		}
		
		private function load_fail():void {
			xtrace("好友资源加载失败");
		}
		
		private function init_imgs():void {
			CommonTools.make_bitmap(comp.img_firend_bg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_friend", "friend_bg");
//			comp.bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_friend", "friend_bg");
		}
		
		
		private function real_show():void {
			init_imgs();
			
			
			_cur_page = 1;
			FriendMessage.getInstance().requese_friend_list();
		}
		
		
		//上一页
		private function on_pre_page(e:MouseEvent):void {
			_cur_page--;
			if (_cur_page < 1) {
				_cur_page = 1;
			}
			refresh_list();
		}
		//下一页
		private function on_next_page(e:MouseEvent):void {
			var message:FriendMessage = FriendMessage.getInstance();
			_cur_page++;
			if (_cur_page > message.get_max_page()) {
				_cur_page = message.get_max_page();
			}
			refresh_list();
		}
		
		//添加好友
		private function on_add_firend(e:MouseEvent):void {
			WindowManager.createWindow(NInputAlert.NAME,{ok_func:sure_add_friend},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		//确认添加好友
		private function sure_add_friend(name:String):void {
			FriendMessage.getInstance().requese_add_friend(1, name);
		}
		//确认加入黑名单
		private function sure_block(name:String):void {
			FriendMessage.getInstance().requese_add_friend(2, name);
		}
		//确认更改心情
		private function sure_change_state(state:String):void {
			FriendMessage.getInstance().request_change_state(state);
		}
		
		
		
		
		//更改心情
		private function on_change_state(e:MouseEvent):void {
			WindowManager.createWindow(NChangeStateAlert.NAME,{ok_func:sure_change_state},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		//删除好友
		private function on_to_remove(e:NFriendEvent):void 
		{
			FriendMessage.getInstance().request_remove_friend(e.obj.roleId);
		}
		//加入黑名单
		private function on_to_block(e:NFriendEvent):void 
		{
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','atbwC_sfj')+e.obj.roleName + CrotaResourceConfig.getInstance().getTextByModuleAndId('chat','atbwC_ishmd'),null,null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'), sure_block,null,[e.obj.roleName]);
		}
		//私聊
		private function on_to_chat(e:NFriendEvent):void 
		{
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,e.obj.roleId,e.obj.roleName));
		}
		//邀请加入公会
		private function on_to_union(e:NFriendEvent):void 
		{
			FriendMessage.getInstance().request_invite_to_union(e.obj.roleId, e.obj.roleName);
		}
		//查看玩家信息
		private function on_look_info(e:NFriendEvent):void 
		{
			NCropMessage.getInstance().request_see_other(e.obj.roleId);
		}
		//发送邮件
		private function on_send_mail(e:NFriendEvent):void 
		{
			var roleObj:Object = { };
			roleObj.roleId = e.obj.roleId;
			roleObj.roleName = e.obj.roleName;
			this.dispatch(new MainMenuChangeToWriteMailComponentEvent(MainMenuChangeToWriteMailComponentEvent.MAINMENUCHANGETOWRITEMAIL,roleObj));
		}
	}
}
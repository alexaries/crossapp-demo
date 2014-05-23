package sceneModule.view.corps.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1303.GetCorpsMemberListInfoRequest;
	import proto.corps.corps1303.GetCorpsMemberListInfoResponse;
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoRequest;
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoResponse;
	import proto.corps.corps1303.MemberListBaseInfo;
	import proto.corps.corps1303.MemberOrAppliListBaseInfo;
	import proto.corps.corps1304.AcceptOrRefuseAppliRequest;
	import proto.corps.corps1304.AcceptOrRefuseAppliResponse;
	import proto.corps.corps1306.TransferCorpsOrKickMemberRequest;
	import proto.corps.corps1306.TransferCorpsOrKickMemberResponse;
	import proto.corps.corps1309.LeaveCorpsRequest;
	import proto.corps.corps1309.LeaveCorpsResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.MainMenuChangeToWriteMailComponentEvent;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.corps.view.NCropMemberView;
	import sceneModule.view.corps.view.NCropRequestView;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.corps.view.NCropsRootView;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.ObjectToString;
	import util.xtrace;

	public class NCorpsMemberMediator extends Mediator
	{
		public static const STATE_ALL:int = 0;
		public static const STATE_SEARCH:int = 1;
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var comp:NCropMemberView;
		[Inject]
		public var popUpShow:IPopUpShow;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		[Inject]
		public var crop_msg:NCropMessage;
		
		private var _cur_state:int;
		
		private var _request_list:Array;
		private var _cur_page:int;
		private var _max_page:int;
		
		public function NCorpsMemberMediator()
		{
			super();
			_cur_state = 0;
		}
		
		override public function onRegister():void{
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_REFRESH_MEMBER_VIEW, refresh);
			
			
			comp.search_btn.addEventListener(MouseEvent.CLICK,on_search);
			comp.pre_btn.addEventListener(MouseEvent.CLICK,on_pre_btn);
			comp.next_btn.addEventListener(MouseEvent.CLICK, on_next_btn);
			comp.btn_leave.addEventListener(MouseEvent.CLICK,on_leave);
			
			
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_MEMBER_GIVE_LEADER,on_give_leader);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_MEMBER_LOOK,on_look_member);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_MEMBER_SEND_MAIL,on_send_mail);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_MEMBER_CHAT,on_chat);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_MEMBER_REMOVE,on_remove);
			
			refresh();
		}
		
		override public function preRemove():void {
			this.eventDispatcher.removeEventListener(NCropsEvent.EVENT_Crops_REFRESH_MEMBER_VIEW, refresh);
			
			
			comp.search_btn.removeEventListener(MouseEvent.CLICK,on_search);
			comp.pre_btn.removeEventListener(MouseEvent.CLICK,on_pre_btn);
			comp.next_btn.removeEventListener(MouseEvent.CLICK, on_next_btn);
			comp.btn_leave.removeEventListener(MouseEvent.CLICK,on_leave);
			
			
			comp.removeEventListener(NCropsEvent.EVENT_Crops_MEMBER_GIVE_LEADER, on_give_leader);
			comp.removeEventListener(NCropsEvent.EVENT_Crops_MEMBER_LOOK,on_look_member);
			comp.removeEventListener(NCropsEvent.EVENT_Crops_MEMBER_SEND_MAIL,on_send_mail);
			comp.removeEventListener(NCropsEvent.EVENT_Crops_MEMBER_CHAT,on_chat);
			comp.removeEventListener(NCropsEvent.EVENT_Crops_MEMBER_REMOVE,on_remove);
		}
		
		//刷新页面信息
		private function refresh(e:NCropsEvent = null):void {
			getCorpsMembersAndAppliList();
		}
		
		//显示弹出框
		private function show_alert(msg:String,tips:String):void {
			CrotaCommonAlert.createCrotaBasicAlert(msg);
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:msg,tips:tips},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		//查看资料
		private function on_look_member(e:NCropsEvent):void {
			crop_msg.request_see_other(e.obj.memberliId);
		}
		
		//搜索信息
		private function on_search(e:MouseEvent):void {
			//if(STATE_ALL == _cur_state){
			if ("" == comp.search_text.text) {
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_ssnr'),"");
			}else{
				search_request(comp.search_text.text);
			}
			//}
			//else {
			//	getCorpsMembersAndAppliList();
			//}
		}
		
		//上一页
		private function on_pre_btn(e:MouseEvent):void {
			_cur_page--;
			if (_cur_page < 1) {
				_cur_page = 1;
			}
			send_page_msg();
			
		}
		//下一页
		private function on_next_btn(e:MouseEvent):void {
			_cur_page++;
			if (_cur_page > _max_page) {
				_cur_page = _max_page;
			}
			send_page_msg();
		}
		//移交团长
		public function on_give_leader(e:NCropsEvent):void {
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_isyj')+e.obj.memberName,null,null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),request_give_leader,null,[e.obj.memberliId]);
		}
		//发送邮件
		public function on_send_mail(e:NCropsEvent):void {
			var roleObj:Object = { };
			roleObj.roleId = e.obj.memberliId;
			roleObj.roleName = e.obj.memberName;
			this.dispatch(new MainMenuChangeToWriteMailComponentEvent(MainMenuChangeToWriteMailComponentEvent.MAINMENUCHANGETOWRITEMAIL,roleObj));
		}
		//私聊
		public function on_chat(e:NCropsEvent):void {
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,e.obj.memberliId,e.obj.memberName));
		}
		//踢出
		public function on_remove(e:NCropsEvent):void {
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_sfj')+e.obj.memberName+CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_tcjt'),null,null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),request_remove_member,null,[e.obj.memberliId]);
		}
		//离开军团
		private function on_leave(e:MouseEvent):void {
			if (STATE_ALL == _cur_state) {
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_islk'),null,null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),request_leave_union,null,[]);
				//request_leave_union();
			}
			else {
				getCorpsMembersAndAppliList();
			}
		}
		
		
		//发送翻页指令
		private function send_page_msg():void {
			if (STATE_ALL == _cur_state) {
				getCorpsMembersAndAppliList(_cur_page);
			}
			else {
				search_request(comp.search_text.text, _cur_page);
			}
		}
		
		//刷新视图
		private function refresh_view():void {
			comp.request_list.dataProvider = new ArrayCollection(_request_list);
			comp.page_info.text = _cur_page + "/" + _max_page;
			
			if (1 == _cur_page) {
				comp.pre_btn.enabled = false;
			}
			else {
				comp.pre_btn.enabled = true;
			}
			if (_cur_page == _max_page) {
				comp.next_btn.enabled = false;
			}
			else {
				comp.next_btn.enabled = true;
			}
			
			
			if(STATE_SEARCH == _cur_state){
				//comp.search_btn.label = "返回";
				comp.btn_leave.label = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_fhlb');
			}
			else {
				//comp.search_text.text = "";
				//comp.search_btn.label = "查找";
				comp.btn_leave.label = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_lkjt');
			}
		}
		
		private function build_info(arr:Array):Array {
			var r_arr:Array = [];
			for each (var item:MemberListBaseInfo in arr) 
			{
				var obj:Object = { };
				obj.memberliId = item.memberliId;
				obj.memberName = item.memberName;
				obj.memberLevel = item.memberLevel;
				obj.memberProfession = item.memberProfession;
				obj.memberRank = item.memberRank;
				obj.onlineState = item.onlineState;
				obj.memberContribution = item.memberContribution;
				obj.is_leader = (NCorpsOutMediator.UNION_POS_LEADER == SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition);
				r_arr.push(obj);
			}
			return r_arr;
		}
		
		
		/**
		 * 获取军团成员列表和申请列表
		 */
		//0获取军团成员列表1按条件查找军团成员2获取申请列表3按条件查找申请成员
		private function getCorpsMembersAndAppliList(page:int = 1):void{
			var getCorpsMembersAndAppliReq:GetCorpsMemberListInfoRequest = new GetCorpsMemberListInfoRequest();
			getCorpsMembersAndAppliReq.id = SystemDataModel.roleId;
			getCorpsMembersAndAppliReq.curPage = page;
			getCorpsMembersAndAppliReq.searchCriteria = "";
			var byteArray:ByteArray = new ByteArray();
			getCorpsMembersAndAppliReq.writeExternal(byteArray);
			xtrace("发送成员列表查询消息",new ObjectToString(getCorpsMembersAndAppliReq).getString());
			socketService.send(new Responder(getCorpsMemberHandler,faultHandler),URLConst.CORPS_MEMBERORAPPLI_COMMANDID,byteArray);
		}
		private function getCorpsMemberHandler(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:GetCorpsMemberListInfoResponse = new GetCorpsMemberListInfoResponse();
			responseData.readExternal(byteArray);
			xtrace("获得成员列表返回",new ObjectToString(responseData).getString());
			if (responseData.result) {
				_cur_page = responseData.data.curPage;
				_max_page = responseData.data.maxPage;
				_request_list = build_info(responseData.data.memberListBaseInfo);
				_cur_state = STATE_ALL;
				refresh_view();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		/**
		 * 搜索申请信息
		 */
		//0获取军团成员列表1按条件查找军团成员2获取申请列表3按条件查找申请成员
		private function search_request(name:String = null,page:int = 1):void{
			var getCorpsMembersAndAppliReq:GetCorpsMemberListInfoRequest = new GetCorpsMemberListInfoRequest();
			getCorpsMembersAndAppliReq.id = SystemDataModel.roleId;
			getCorpsMembersAndAppliReq.curPage = page;
			getCorpsMembersAndAppliReq.searchCriteria = name;
			var byteArray:ByteArray = new ByteArray();
			getCorpsMembersAndAppliReq.writeExternal(byteArray);
			xtrace("搜索成员列表",new ObjectToString(getCorpsMembersAndAppliReq).getString());
			socketService.send(new Responder(search_response,faultHandler),URLConst.CORPS_MEMBERORAPPLI_COMMANDID,byteArray);
		}
		private function search_response(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:GetCorpsMemberListInfoResponse = new GetCorpsMemberListInfoResponse();
			responseData.readExternal(byteArray);
			xtrace("搜索成员返回",new ObjectToString(responseData).getString());
			if (responseData.result) {
				_cur_page = responseData.data.curPage;
				_max_page = responseData.data.maxPage;
				_request_list = build_info(responseData.data.memberListBaseInfo);
				_cur_state = STATE_SEARCH;
				refresh_view();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		//移交团长
		//操作类型0移交军团长1踢出成员
		private function request_give_leader(id:int):void {
			var msg:TransferCorpsOrKickMemberRequest = new TransferCorpsOrKickMemberRequest();
			msg.id = SystemDataModel.roleId;
			msg.operType  = 0;
			msg.memberId = id;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("移交团长",new ObjectToString(msg).getString());
			socketService.send(new Responder(response_give_leader,faultHandler),URLConst.CORPS_TRANSFERORKICK_COMMANDID,byteArray);
		}
		
		private function response_give_leader(byteArray:ByteArray):void {
			var byteArray:ByteArray = byteArray;
			var responseData:TransferCorpsOrKickMemberResponse = new TransferCorpsOrKickMemberResponse();
			responseData.readExternal(byteArray);
			xtrace("移交团长回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				send_page_msg();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		//踢出成员
		//操作类型0移交军团长1踢出成员
		private function request_remove_member(id:int):void {
			var msg:TransferCorpsOrKickMemberRequest = new TransferCorpsOrKickMemberRequest();
			msg.id = SystemDataModel.roleId;
			msg.operType  = 1;
			msg.memberId = id;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("踢出成员",new ObjectToString(msg).getString());
			socketService.send(new Responder(response_remove_member,faultHandler),URLConst.CORPS_TRANSFERORKICK_COMMANDID,byteArray);
		}
		
		private function response_remove_member(byteArray:ByteArray):void {
			var byteArray:ByteArray = byteArray;
			var responseData:TransferCorpsOrKickMemberResponse = new TransferCorpsOrKickMemberResponse();
			responseData.readExternal(byteArray);
			xtrace("踢出成员回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				send_page_msg();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		
		//离开军团
		private function request_leave_union():void {
			var msg:LeaveCorpsRequest = new LeaveCorpsRequest();
			msg.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("离开军团",new ObjectToString(msg).getString());
			socketService.send(new Responder(response_leave_union,faultHandler),URLConst.CORPS_LEAVE_COMMANDID,byteArray);
		}
		
		private function response_leave_union(byteArray:ByteArray):void {
			var byteArray:ByteArray = byteArray;
			var responseData:LeaveCorpsResponse = new LeaveCorpsResponse();
			responseData.readExternal(byteArray);
			xtrace("离开军团回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag = false;
				SystemDataModel.roleInfo.roleCorpsInfo.corpsLevel = 0;
				SystemDataModel.roleInfo.roleCorpsInfo.corpsName = "";
				SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition = 0;
				this.dispatch(new NCropsEvent(NCropsEvent.EVENT_Crops_REFRESH));
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
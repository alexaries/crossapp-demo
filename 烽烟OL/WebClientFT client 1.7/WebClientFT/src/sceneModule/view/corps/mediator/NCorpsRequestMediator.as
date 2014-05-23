package sceneModule.view.corps.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoRequest;
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoResponse;
	import proto.corps.corps1303.MemberOrAppliListBaseInfo;
	import proto.corps.corps1304.AcceptOrRefuseAppliRequest;
	import proto.corps.corps1304.AcceptOrRefuseAppliResponse;
	import proto.corps.corps1317.AppliListBaseInfo;
	import proto.corps.corps1317.GetCorpsAppliListInfoRequest;
	import proto.corps.corps1317.GetCorpsAppliListInfoResponse;
	import proto.corps.corps1323.ModifyJoinLevelRequest;
	import proto.corps.corps1323.ModifyJoinLevelResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.corps.view.NCropRequestView;
	import sceneModule.view.corps.view.NCropsInView;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.corps.view.NCropsRootView;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.ObjectToString;
	import util.xtrace;

	public class NCorpsRequestMediator extends Mediator
	{
		public static const STATE_ALL:int = 0;
		public static const STATE_SEARCH:int = 1;
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var comp:NCropRequestView;
		[Inject]
		public var popUpShow:IPopUpShow;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _cur_state:int;
		
		private var _request_list:Array;
		private var _cur_page:int;
		private var _max_page:int;
		
		public function NCorpsRequestMediator()
		{
			super();
			_cur_state = 0;
		}
		
		override public function onRegister():void{
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_REFRESH_REQUEST_VIEW, refresh);
			
			
			
			comp.search_btn.addEventListener(MouseEvent.CLICK,on_search);
			comp.pre_btn.addEventListener(MouseEvent.CLICK,on_pre_btn);
			comp.next_btn.addEventListener(MouseEvent.CLICK, on_next_btn);
			comp.btn_back.addEventListener(MouseEvent.CLICK, on_back_btn);
			
			comp.addEventListener(NCropsEvent.EVENT_Crops_ACCEPT_REQUEST, on_accetp_member);
			comp.addEventListener(NCropsEvent.EVENT_Crops_REJEST_REQUEST, on_rejest_member);
			
			comp.levelReqBtn.addEventListener(MouseEvent.CLICK,onLevelReq);
			
			
			refresh();
		}
		
		private function onLevelReq(evt:MouseEvent):void{
			var lrReq:ModifyJoinLevelRequest = new ModifyJoinLevelRequest();
			lrReq.id = SystemDataModel.roleId;
			lrReq.levelrequired = int(comp.level_request.text);
			var byteArray:ByteArray = new ByteArray();
			lrReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(lrHandler,faultHandler),URLConst.CORPS_LEVELUPREQ_COMMANDID,byteArray);
		}
		
		private function lrHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseDatat:ModifyJoinLevelResponse = new ModifyJoinLevelResponse();
			responseDatat.readExternal(byteArray);
			if(responseDatat.result){
				
			}
		}
		
		override public function preRemove():void {
			this.eventDispatcher.removeEventListener(NCropsEvent.EVENT_Crops_REFRESH_REQUEST_VIEW, refresh);
			
			
			
			comp.search_btn.removeEventListener(MouseEvent.CLICK,on_search);
			comp.pre_btn.removeEventListener(MouseEvent.CLICK,on_pre_btn);
			comp.next_btn.removeEventListener(MouseEvent.CLICK, on_next_btn);
			comp.btn_back.removeEventListener(MouseEvent.CLICK, on_back_btn);
			
			comp.removeEventListener(NCropsEvent.EVENT_Crops_ACCEPT_REQUEST, on_accetp_member);
			comp.removeEventListener(NCropsEvent.EVENT_Crops_REJEST_REQUEST, on_rejest_member);
		}
		
		//刷新页面信息
		private function refresh(e:NCropsEvent = null):void {
			getCorpsMembersAndAppliList();
		}
		
		//搜索信息
		private function on_search(e:MouseEvent):void {
			//if(STATE_ALL == _cur_state){
			if ("" == comp.search_text.text) {
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_ssnr'),"");
			}
			else{
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
		//发送翻页指令
		private function send_page_msg():void {
			if (STATE_ALL == _cur_state) {
				getCorpsMembersAndAppliList(_cur_page);
			}
			else {
				search_request(comp.search_text.text, _cur_page);
			}
		}
		
		//返回列表
		private function on_back_btn(e:MouseEvent):void {
			getCorpsMembersAndAppliList();
		}
		
		//同意申请
		private function on_accetp_member(e:NCropsEvent):void {
			xtrace("同意申请", new ObjectToString(e.obj).getString());
			onRefuseAndApprove(0, e.obj.memberliId);
		}
		//拒绝申请
		private function on_rejest_member(e:NCropsEvent):void {
			xtrace("拒绝申请", new ObjectToString(e.obj).getString());
			onRefuseAndApprove(1, e.obj.memberliId);
		}
		
		//显示弹出框
		private function show_alert(msg:String,tips:String=null):void {
			CrotaCommonAlert.createCrotaBasicAlert(msg);
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:msg,tips:tips},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
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
				comp.addElement(comp.btn_back);
			}
			else {
				remove_if_have(comp.btn_back);
			}
		}
		
		private function remove_if_have(element:IVisualElement):void{
			if(element.parent){
				comp.removeElement(element);
			}
		}
		
		private function build_info(arr:Array):Array {
			var r_arr:Array = [];
			for each (var item:AppliListBaseInfo in arr) 
			{
				var obj:Object = { };
				obj.memberliId = item.memberliId;
				obj.memberName = item.memberName;
				obj.memberLevel = item.memberLevel;
				obj.memberProfession = item.memberProfession;
				obj.memberRank = item.memberRank;
				obj.memberTime = item.memberTime;
				obj.is_leader = (SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition > 0);
				r_arr.push(obj);
			}
			return r_arr;
		}
		
		
		/**
		 * 获取军团成员列表和申请列表
		 */
		//0获取军团成员列表1按条件查找军团成员2获取申请列表3按条件查找申请成员
		private function getCorpsMembersAndAppliList(page:int = 1):void{
			var getCorpsMembersAndAppliReq:GetCorpsAppliListInfoRequest = new GetCorpsAppliListInfoRequest();
			getCorpsMembersAndAppliReq.id = SystemDataModel.roleId;
			getCorpsMembersAndAppliReq.curPage = page;
			getCorpsMembersAndAppliReq.searchCriteria = "";
			var byteArray:ByteArray = new ByteArray();
			getCorpsMembersAndAppliReq.writeExternal(byteArray);
			xtrace("发送成员和申请列表查询消息",new ObjectToString(getCorpsMembersAndAppliReq).getString());
			socketService.send(new Responder(getCorpsMemberHandler,faultHandler),URLConst.CORPS_REQUEST_LIST_COMMANDID,byteArray);
		}
		private function getCorpsMemberHandler(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:GetCorpsAppliListInfoResponse = new GetCorpsAppliListInfoResponse();
			responseData.readExternal(byteArray);
			xtrace("获得申请列表返回",new ObjectToString(responseData).getString());
			if (responseData.result) {
				_cur_page = responseData.data.curPage;
				_max_page = responseData.data.maxPage;
				comp.level_request.text= responseData.data.levelrequired.toString();
				_request_list = build_info(responseData.data.appliListBaseInfo);
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
			var getCorpsMembersAndAppliReq:GetCorpsAppliListInfoRequest = new GetCorpsAppliListInfoRequest();
			getCorpsMembersAndAppliReq.id = SystemDataModel.roleId;
			getCorpsMembersAndAppliReq.curPage = page;
			getCorpsMembersAndAppliReq.searchCriteria = name;
			var byteArray:ByteArray = new ByteArray();
			getCorpsMembersAndAppliReq.writeExternal(byteArray);
			xtrace("搜索申请列表",new ObjectToString(getCorpsMembersAndAppliReq).getString());
			socketService.send(new Responder(search_response,faultHandler),URLConst.CORPS_REQUEST_LIST_COMMANDID,byteArray);
		}
		private function search_response(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:GetCorpsAppliListInfoResponse = new GetCorpsAppliListInfoResponse();
			responseData.readExternal(byteArray);
			xtrace("搜索结果返回",new ObjectToString(responseData).getString());
			if (responseData.result) {
				_cur_page = responseData.data.curPage;
				_max_page = responseData.data.maxPage;
				_request_list = build_info(responseData.data.appliListBaseInfo);
				_cur_state = STATE_SEARCH;
				refresh_view();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		/**
		 * 拒绝或批准入团请求 
		 */		
		//操作类型 0 接受 1 拒绝
		private function onRefuseAndApprove(type:int,memberid:int):void{
			var acceptOrRefuseReq:AcceptOrRefuseAppliRequest = new AcceptOrRefuseAppliRequest();
			acceptOrRefuseReq.id = SystemDataModel.roleId;
			acceptOrRefuseReq.appliId = memberid;
			acceptOrRefuseReq.operType = type;
			var byteArray:ByteArray = new ByteArray();
			acceptOrRefuseReq.writeExternal(byteArray);
			xtrace("发送处理请求消息", new ObjectToString(acceptOrRefuseReq).getString());
			socketService.send(new mx.rpc.Responder(acceptOrRefuseHandler,faultHandler),URLConst.CORPS_ACCEPTORREFUSE_COMMANDID,byteArray);
		}
		private function acceptOrRefuseHandler(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:AcceptOrRefuseAppliResponse = new AcceptOrRefuseAppliResponse();
			responseData.readExternal(acceptByte);
			xtrace("处理入会请求回复", new ObjectToString(responseData).getString());
			if (responseData.result) {
				send_page_msg();
			}else {
				send_page_msg();
				show_alert(responseData.message);
			}
		}
		
		
		
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
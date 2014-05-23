package sceneModule.view.corps.mediator
{
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.core.IVisualElement;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1301.CorpsInfo;
	import proto.corps.corps1301.GetCorpsListInfoRequest;
	import proto.corps.corps1301.GetCorpsListInfoResponse;
	import proto.corps.corps1302.CreateCorpsRequest;
	import proto.corps.corps1302.CreateCorpsResponse;
	import proto.corps.corps1305.AppliOrUnsubscribeRequest;
	import proto.corps.corps1305.AppliOrUnsubscribeResponse;
	import proto.corps.corps1307.ModifyCorpsAnnounRequest;
	import proto.corps.corps1307.ModifyCorpsAnnounResponse;
	import proto.corps.corps1311.LevelUpEmblemRequest;
	import proto.corps.corps1311.LevelUpEmblemResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.ChoseCorpsComponent;
	import sceneModule.view.corps.view.CorpsInfoComponent;
	import sceneModule.view.corps.view.CreateCorpsComponent;
	import sceneModule.view.corps.view.ModifyCorpsAnnounComponent;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.xtrace;

	public class NCorpsOutMediator extends Mediator
	{
		public static const IN_UNION_REQUEST:int = 0;
		public static const OUT_UNION_REQUEST:int = 1;
		
		public static const LIST_STATE_ALL:int = 0;
		public static const LIST_STATE_SEARCH:int = 1;
		
		
		public static const UNION_POS_NOMAL:int = 0;
		public static const UNION_POS_YISHI:int = 1;
		public static const UNION_POS_CANMOU:int = 2;
		public static const UNION_POS_YUANLAO:int = 3;
		public static const UNION_POS_LEADER:int = 4;
		
		
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var out_view:NCropsOutView;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		[Inject]
		public var popUpShow:IPopUpShow;
		
		private var _cur_page:int;
		private var _max_page:int;
		private var _list_state:int;
		
		private var _union_list:Array;
		
		private var _t_union_lv:int;
		
		private var _union_type:int;
		
		public function NCorpsOutMediator()
		{
			super();
			_list_state = 0;
		}
		
		override public function onRegister():void{
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_VIEW_OUT_REFRESH, refresh);
			out_view.addEventListener(NCropsEvent.EVENT_Crops_SHOW_UNIONT_INFO,show_union_info);
			out_view.addEventListener(NCropsEvent.EVENT_Crops_JOIN_UNION, join_union);
			out_view.pre_btn.addEventListener(MouseEvent.CLICK,on_pre_page);
			out_view.next_btn.addEventListener(MouseEvent.CLICK,on_next_page);
			out_view.createBtn.addEventListener(MouseEvent.CLICK,on_create_union);
			out_view.search_btn.addEventListener(MouseEvent.CLICK,on_search_union);
			out_view.change_bord_btn.addEventListener(MouseEvent.CLICK,on_change_gonggao);
			out_view.union_achieve.addEventListener(MouseEvent.CLICK,on_chengjiu);
			
			
			
			
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_REMOVE_JOIN_UNION, remove_join_union);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_REMOVE_CREATE_UNION, remove_create_union);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_SEND_CREATE_UNION,on_send_create_union);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_ON_CHANGE_GONGGAO,ok_change_gonggao);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_ON_UNION_INFO_FUN_BTN,on_union_info_fun_btn);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_CHOSE, on_chose);
			
			
			init_view();
		}
		
		override public function preRemove():void {
			this.eventDispatcher.removeEventListener(NCropsEvent.EVENT_Crops_VIEW_OUT_REFRESH, refresh);
			out_view.removeEventListener(NCropsEvent.EVENT_Crops_SHOW_UNIONT_INFO,show_union_info);
			out_view.removeEventListener(NCropsEvent.EVENT_Crops_JOIN_UNION, join_union);
			out_view.pre_btn.removeEventListener(MouseEvent.CLICK,on_pre_page);
			out_view.next_btn.removeEventListener(MouseEvent.CLICK,on_next_page);
			out_view.createBtn.removeEventListener(MouseEvent.CLICK,on_create_union);
			out_view.search_btn.removeEventListener(MouseEvent.CLICK,on_search_union);
			out_view.change_bord_btn.removeEventListener(MouseEvent.CLICK,on_change_gonggao);
			out_view.union_achieve.removeEventListener(MouseEvent.CLICK,on_chengjiu);
			
			
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_REMOVE_JOIN_UNION, remove_join_union);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_REMOVE_CREATE_UNION, remove_create_union);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_SEND_CREATE_UNION, on_send_create_union);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_ON_CHANGE_GONGGAO, ok_change_gonggao);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_ON_UNION_INFO_FUN_BTN, on_union_info_fun_btn);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_CHOSE, on_chose);
			
		}
		
		private function init_view():void {
			refresh();
		}
		
		private function refresh(e:NCropsEvent = null):void {
			if(SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag){
				//out_view.img_bg.source = "assets/ncorps/union_list.png";
				CommonTools.make_bitmap(out_view.img_bg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_union', 'union_item_list_bg');
			}
			else{
				//out_view.img_bg.source = "assets/ncorps/unlin_list_no.png";
				CommonTools.make_bitmap(out_view.img_bg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge('ui_union', 'union_item_list_no_bg');
			}
			get_corps_list_info();
		}
		
		private function on_change_gonggao(e:MouseEvent):void{
			WindowManager.createWindow(ModifyCorpsAnnounComponent.NAME,null,null,false,true,false,null,mediatorMap,popUpWindowLayer,true);
		}
		private function on_chengjiu(e:MouseEvent):void{
			//WindowManager.createWindow(ModifyCorpsAnnounComponent.NAME,e.obj,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_swkf'));
		}
		private function ok_change_gonggao(e:NCropsEvent):void{
			xtrace("修改公告",e.obj);
			requese_change_gonggao(e.obj.msg);
		}
		
		
		//取得军团列表信息
		private function get_corps_list_info(curpage:int = 1):void {
			var getCorpsListReq:GetCorpsListInfoRequest = new GetCorpsListInfoRequest();
			getCorpsListReq.id = SystemDataModel.roleId;
			getCorpsListReq.getType = 0;
			getCorpsListReq.curPage = curpage;
			var byteArray:ByteArray = new ByteArray();
			getCorpsListReq.writeExternal(byteArray);
			xtrace("send GetCorpsListInfoRequest ", getCorpsListReq);
			socketService.send(new mx.rpc.Responder(getCorpsListHandler,faultHandler),URLConst.CORPS_GETORSEARCHLIST_COMMANDID,byteArray);
		}
		
		//搜索军团
		private function search_corp(name:String,cur_page:int = 1):void {
			var getCorpsListReq:GetCorpsListInfoRequest = new GetCorpsListInfoRequest();
			getCorpsListReq.id = SystemDataModel.roleId;
			getCorpsListReq.getType = 1;
			getCorpsListReq.curPage = cur_page;
			getCorpsListReq.searchCriteria = name;
			var byteArray:ByteArray = new ByteArray();
			getCorpsListReq.writeExternal(byteArray);
			xtrace("send GetCorpsListInfoRequest ", getCorpsListReq);
			socketService.send(new mx.rpc.Responder(getCorpsSearchHandler,faultHandler),URLConst.CORPS_GETORSEARCHLIST_COMMANDID,byteArray);
		}
		
		
		//取得军团列表返回
		private function getCorpsListHandler(data:ByteArray):void {
			var getCorpsListRes:GetCorpsListInfoResponse = new GetCorpsListInfoResponse();
			getCorpsListRes.readExternal(data);
			xtrace("rev GetCorpsListInfoResponse ", getCorpsListRes);
			if (getCorpsListRes.result) {
				_cur_page = getCorpsListRes.data.curPage;
				_max_page = getCorpsListRes.data.maxPage;
				_union_list = build_union_list(getCorpsListRes.data.corpsInfo);
				_list_state = LIST_STATE_ALL;
				refresh_view();
			}
			else {
				popUpShow.show(getCorpsListRes.message);
			}
		}
		
		private function build_union_list(arr:Array):Array{
			var obj:Object;
			var r_arr:Array = [];
			for each (var item:CorpsInfo in arr) 
			{
				obj = { };
				obj.corpsId = item.corpsId;
				obj.corpsImg = item.corpsImg;
				obj.corpsChief = item.corpsChief;
				obj.corpsLevel = item.corpsLevel;
				obj.curNum = item.curNum;
				obj.maxNum = item.maxNum;
				obj.onApplication = item.onApplication;
				obj.corpsTitle = item.corpsTitle;
				obj.corpsAnnouncement = item.corpsAnnouncement;
				obj.corpRunningFlag = item.runningFlag;
				obj.corpsName = item.corpsName;
				obj.leaderId = item.leaderId;
				obj.is_in_union = SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag;
				obj.self_corp_pos = SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition;
				obj.levReq = item.levelrequired;
				r_arr.push(obj);
			}
import event.GuidEvent;
import event.GuidEventCenter;

import managers.WindowManager;

import model.GuideInfo;
import model.SystemDataModel;

import resource.CrotaResourceConfig;

import sceneModule.view.Alert.view.CrotaCommonAlert;
import sceneModule.view.nmall.model.MallMessage;
import sceneModule.view.popupWin.PopUpShow;

import spark.components.Label;

			return r_arr;
		}
		
		//取得军团搜索结果返回
		private function getCorpsSearchHandler(data:ByteArray):void {
			var getCorpsListRes:GetCorpsListInfoResponse = new GetCorpsListInfoResponse();
			getCorpsListRes.readExternal(data);
			xtrace("rev GetCorpsListInfoResponse ", getCorpsListRes);
			if (getCorpsListRes.result) {
				_cur_page = getCorpsListRes.data.curPage;
				_max_page = getCorpsListRes.data.maxPage;
				_union_list = build_union_list(getCorpsListRes.data.corpsInfo);
				_list_state = LIST_STATE_SEARCH;
				refresh_view();
			}
			else {
				popUpShow.show(getCorpsListRes.message);
			}
		}
		
		//显示弹出框
		private function show_alert(msg:String,tips:String=null):void {
			CrotaCommonAlert.createCrotaBasicAlert(msg);
			
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:msg,tips:tips},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		//查看某个军团的信息
		private function show_union_info(e:NCropsEvent):void{
			xtrace("查看军团信息");
			WindowManager.createWindow(CorpsInfoComponent.NAME,e.obj,null,false,true,false,null,mediatorMap,popUpWindowLayer,true);
		}
		//移除军团信息对话框
		private function remove_join_union(e:NCropsEvent = null):void {
			WindowManager.closeWindow(CorpsInfoComponent.NAME);
		}
		//移出创建军团按钮
		private function remove_create_union(e:NCropsEvent = null):void {
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_UNION_CREATE_WINDOW));
			WindowManager.closeWindow(CreateCorpsComponent.NAME);
		}
		//请求加入军团
		private function join_union(e:NCropsEvent):void{
			if(e.obj.is_in_union){
				//在军团中
				if(UNION_POS_LEADER == e.obj.self_corp_pos){
					//军团长,进行军团讨伐
					xtrace("军团讨伐");
					//如果是自己的军团,处理升级军徽
					if (e.obj.corpsName == SystemDataModel.roleInfo.roleCorpsInfo.corpsName) {
						_t_union_lv = e.obj.corpsLevel;
						requese_up_junhui();
					}
					else{
						show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_swkf'));
					}
				}
				else{
					//非军团长
					xtrace("联系军团长");
					this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,e.obj.leaderId,e.obj.corpsChief));
				}
			}
			else{
				//var type_tag:int = e.obj.onApplication?OUT_UNION_REQUEST:IN_UNION_REQUEST;
				//appliOrUnsubsribe(type_tag, e.obj.corpsId);
				if (e.obj.onApplication) {
					requese_cancal_request(e.obj.corpsId);
				}
				else {
					appliOrUnsubsribe(e.obj.corpsId);

				}
			}
		}
		
		private function on_union_info_fun_btn(e:NCropsEvent):void {
			if(e.obj.is_in_union){
				//在军团中
				if(UNION_POS_LEADER == e.obj.self_corp_pos){
					//如果是自己的军团,处理升级军徽
					if (e.obj.corpsName == SystemDataModel.roleInfo.roleCorpsInfo.corpsName) {
						_t_union_lv = e.obj.corpsLevel;
						requese_up_junhui();
					}
					else {
						xtrace("联系军团长");
						this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,e.obj.leaderId,e.obj.corpsChief));
					}
				}
				else{
					//非军团长
					xtrace("联系军团长");
					this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,e.obj.leaderId,e.obj.corpsChief));
				}
			}
			else {
				xtrace("联系军团长");
					this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT,e.obj.leaderId,e.obj.corpsChief));
			}
		}
		
		/**
		 * 申请加入军团 
		 * @param operType 操作类型 0申请加入军团1取消申请加入军团
		 */
		private function appliOrUnsubsribe(corpsId:int):void{
			var appliOrUnSubSribeReq:AppliOrUnsubscribeRequest = new AppliOrUnsubscribeRequest();
			appliOrUnSubSribeReq.id = SystemDataModel.roleId;
			appliOrUnSubSribeReq.corpsId = corpsId;
			appliOrUnSubSribeReq.operType = 0;
			var appliByte:ByteArray = new ByteArray();
			appliOrUnSubSribeReq.writeExternal(appliByte);
			xtrace("请求加入军团", appliOrUnSubSribeReq);
			socketService.send(new mx.rpc.Responder(appliOrUnSubHandler,faultHandler),URLConst.CORPS_APPLIORUNSUBSCRIBE_COMMANDID,appliByte);
		}
		private function appliOrUnSubHandler(data:Object):void{
			var appliResByte:ByteArray = data as ByteArray;
			var appliResponse:AppliOrUnsubscribeResponse = new AppliOrUnsubscribeResponse();
			appliResponse.readExternal(appliResByte);
			xtrace("请求加入军团回复", appliResponse);
			if (appliResponse.result) {
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE,GuideInfo.ACTION_CREATE_UNION_OK));

				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_cgtj'), CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_hcl'));
				get_corps_list_info(_cur_page);
			}else{
				popUpShow.show(appliResponse.message);
			}
		}
		
		/**
		 * 创建军团 
		 */		
		private function onCreateCorps(name:String):void{
			var createCorpsRequest:CreateCorpsRequest = new CreateCorpsRequest();
			createCorpsRequest.id = SystemDataModel.roleId;
			createCorpsRequest.corpsName = name;
			createCorpsRequest.type = _union_type;
			var byteArray:ByteArray = new ByteArray();
			createCorpsRequest.writeExternal(byteArray);
			xtrace("发送创建军团指令",createCorpsRequest);
			socketService.send(new mx.rpc.Responder(createCorpsHandler,faultHandler),URLConst.CORPS_CREATE_COMMANDID,byteArray);
		}
		private function createCorpsHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var responseData:CreateCorpsResponse = new CreateCorpsResponse();
			responseData.readExternal(resByteArray);
			xtrace("创建军团回复",responseData);
			if(responseData.result){
				remove_create_union();
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_cgcj'), CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_tips'));
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE,GuideInfo.ACTION_CREATE_UNION_OK));
			}
			else{
				popUpShow.show(responseData.message);
			}
		}
		
		//创建军团
		private function on_create_union(e:MouseEvent):void{
			xtrace("显示创建军团窗口");
			if(out_view.createBtn.label=="创建军团")
			{	
			MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_ishf'),
				null, null, null, null, isChooseCorp, null);
			}else
			{
				isChooseCorp(e);
			}
		}
		
		private function isChooseCorp(obj:Object):void
		{
			if(SystemDataModel.roleInfo.coin>=100000)
			{
				if(LIST_STATE_SEARCH == _list_state){
					out_view.search_text.text = "";
					get_corps_list_info();
				}
				else{
					WindowManager.createWindow(ChoseCorpsComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer, true);
					//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_UNION_ZHENYING_CHOSE));
				}
			}else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_jbbg'));
			}
			
		}
		
		
		//显示创建对话框,关闭选择阵营对话框
		private function on_chose(e:NCropsEvent):void {
			_union_type = e.obj.type;
			WindowManager.closeWindow(ChoseCorpsComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
			WindowManager.createWindow(CreateCorpsComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer, true);
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_CREATE_UNION));
		}
		
		//搜索军团
		private function on_search_union(e:MouseEvent):void{
			xtrace("搜索军团");
			//if(LIST_STATE_SEARCH == _list_state){
				//out_view.search_text.text = "";
				//get_corps_list_info();
			//}
			//else{
			if ("" == out_view.search_text.text) {
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_ssnr'),"");
			}
			else {
				search_corp(out_view.search_text.text);
			}
				
			//}
		}
		
		//向上翻页
		private function on_pre_page(e:MouseEvent):void {
			_cur_page--;
			if (_cur_page < 1) {
				_cur_page = 1;
			}
			if(LIST_STATE_SEARCH != _list_state){
				get_corps_list_info(_cur_page);
			}
			else{
				search_corp(out_view.search_text.text,_cur_page);;
			}
		}
		//向下翻页
		private function on_next_page(e:MouseEvent):void {
			_cur_page++;
			if (_cur_page > _max_page) {
				_cur_page = _max_page;
			}
			if(LIST_STATE_SEARCH != _list_state){
				get_corps_list_info(_cur_page);
			}
			else{
				search_corp(out_view.search_text.text,_cur_page);;
			}
		}
		
		
		private function send_refresh_list():void {
			if(LIST_STATE_SEARCH != _list_state){
				get_corps_list_info(_cur_page);
			}
			else{
				search_corp(out_view.search_text.text,_cur_page);;
			}
		}
		
		//发送创建军团指令
		private function on_send_create_union(e:NCropsEvent):void{
			onCreateCorps(e.obj.name);
		}
		
		private function faultHandler(evt:FaultEvent):void {
			
		}
		
		private function refresh_view():void{
			out_view.union_list.dataProvider = new ArrayCollection(_union_list);
			out_view.createBtn.label = LIST_STATE_ALL == _list_state?CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_cjjt'):CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncmM_fhlb');
			out_view.page_info.text = _cur_page + "/" + _max_page;
			
			if (1 == _cur_page) {
				out_view.pre_btn.enabled = false;
			}
			else {
				out_view.pre_btn.enabled = true;
			}
			if (_cur_page == _max_page) {
				out_view.next_btn.enabled = false;
			}
			else {
				out_view.next_btn.enabled = true;
			}
			
			
			if(SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag){
				//已经加入军团
				out_view.addElement(out_view.union_achieve);
				remove_if_have(out_view.createBtn);
				if(UNION_POS_LEADER == SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition){
					out_view.addElement(out_view.change_bord_btn);
				}
				else{
					remove_if_have(out_view.change_bord_btn);
				}
				if (LIST_STATE_ALL != _list_state) {
					out_view.addElement(out_view.createBtn);
					remove_if_have(out_view.change_bord_btn);
					remove_if_have(out_view.union_achieve);
				}
			}
			else{
				//还没有加入军团
				out_view.addElement(out_view.createBtn);
				remove_if_have(out_view.change_bord_btn);
				remove_if_have(out_view.union_achieve);
			}
		}
		private function remove_if_have(element:IVisualElement):void{
			if(element.parent){
				out_view.removeElement(element);
			}
		}
		
		//修改公告
		private function requese_change_gonggao(str:String):void{
			var msg:ModifyCorpsAnnounRequest = new ModifyCorpsAnnounRequest();
			msg.id = SystemDataModel.roleId;
			msg.announContent = str;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("修改公告",msg);
			socketService.send(new mx.rpc.Responder(response_change_gonggao,faultHandler),URLConst.CORPS_MODIFYANNOU_COMMANDID,bytes);
		}
		private function response_change_gonggao(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:ModifyCorpsAnnounResponse = new ModifyCorpsAnnounResponse();
			responseData.readExternal(byteArray);
			xtrace("修改公告回复",responseData);
			if (responseData.result) {
				WindowManager.closeWindow(ModifyCorpsAnnounComponent.NAME);
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_cgxg'), CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_cgqx'));
				send_refresh_list();
			}
			else{
				popUpShow.show(responseData.message);
			}
		}
		
		//取消申请
		private function requese_cancal_request(id:int):void{
			var msg:AppliOrUnsubscribeRequest = new AppliOrUnsubscribeRequest();
			msg.id = SystemDataModel.roleId;
			msg.operType = 1;
			msg.corpsId = id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("取消申请",msg);
			socketService.send(new mx.rpc.Responder(response_cancal_request,faultHandler),URLConst.CORPS_APPLIORUNSUBSCRIBE_COMMANDID,bytes);
		}
		private function response_cancal_request(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:AppliOrUnsubscribeResponse = new AppliOrUnsubscribeResponse();
			responseData.readExternal(byteArray);
			xtrace("取消申请回复",responseData);
			if (responseData.result) {
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_cgqx'), CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','ncoM_hcl'));
				get_corps_list_info(_cur_page);
			}
			else{
				popUpShow.show(responseData.message);
			}
		}
		
		
		//升级军徽
		private function requese_up_junhui():void{
			var msg:LevelUpEmblemRequest = new LevelUpEmblemRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("升级军徽",msg);
			socketService.send(new mx.rpc.Responder(response_up_junhui,faultHandler),URLConst.CORPS_LEVELUPEMBLEM_COMMANDID,bytes);
		}
		private function response_up_junhui(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:LevelUpEmblemResponse = new LevelUpEmblemResponse();
			responseData.readExternal(byteArray);
			xtrace("升级军徽回复",responseData);
			if (responseData.result) {
				//show_alert("军徽等级已升至" + (_t_union_lv + 1) + "级","小贴士:军徽等级越高,可容纳的军团成员就越多!!!");
				get_corps_list_info(_cur_page);
				remove_join_union();
			}
			else {
//				popUpShow.show(responseData.message);
			}
		}
	}
}
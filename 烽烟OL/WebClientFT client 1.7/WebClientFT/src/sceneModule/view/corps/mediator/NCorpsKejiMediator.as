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
	import mx.events.ListEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoRequest;
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoResponse;
	import proto.corps.corps1303.MemberOrAppliListBaseInfo;
	import proto.corps.corps1304.AcceptOrRefuseAppliRequest;
	import proto.corps.corps1304.AcceptOrRefuseAppliResponse;
	import proto.corps.corps1306.TransferCorpsOrKickMemberRequest;
	import proto.corps.corps1306.TransferCorpsOrKickMemberResponse;
	import proto.corps.corps1310.EmblemInfo;
	import proto.corps.corps1310.GetEmblemInfoRequest;
	import proto.corps.corps1310.GetEmblemInfoResponse;
	import proto.corps.corps1310.ManagermentInfo;
	import proto.corps.corps1311.LevelUpEmblemRequest;
	import proto.corps.corps1311.LevelUpEmblemResponse;
	import proto.corps.corps1312.ModifyBugleRequest;
	import proto.corps.corps1312.ModifyBugleResponse;
	import proto.corps.corps1313.TakeCorpsChiefRequest;
	import proto.corps.corps1313.TakeCorpsChiefResponse;
	import proto.corps.corps1314.GetCorpsTechnologyListInfoRequest;
	import proto.corps.corps1314.GetCorpsTechnologyListInfoResponse;
	import proto.corps.corps1314.TechnologyInfo;
	import proto.corps.corps1315.CorpsTechnologyDonateRequest;
	import proto.corps.corps1315.CorpsTechnologyDonateResponse;
	import proto.corps.corps1316.ModifyDefaultDonateRequest;
	import proto.corps.corps1316.ModifyDefaultDonateResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.CorpsTechnologyDonateComponent;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.corps.view.NCropKejiView;
	import sceneModule.view.corps.view.NCropMemberView;
	import sceneModule.view.corps.view.NCropRequestView;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.ObjectToString;
	import util.xtrace;

	public class NCorpsKejiMediator extends Mediator
	{
		public static const BASE_PATH:String = "assets/ncorps/keji/";
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var comp:NCropKejiView;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		[Inject]
		public var popUpShow:IPopUpShow;
		
		private var _cur_page:int;
		private var _max_page:int;
		private var _list:Array;
		
		private var _selected_index:int;
		private var _is_keep_select:Boolean;
		
		
		public function NCorpsKejiMediator()
		{
			super();
			_selected_index = -1;
			_is_keep_select = false;
		}
		
		override public function onRegister():void{
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_REFRESH_Keji_VIEW, refresh);
			comp.addEventListener(NCropsEvent.EVENT_Crops_ON_CLICK_KEJI_ITEM, on_item_click);
			comp.pre_btn.addEventListener(MouseEvent.CLICK,on_pre_btn);
			comp.next_btn.addEventListener(MouseEvent.CLICK,on_next_btn);
			//comp.btn_money.addEventListener(MouseEvent.CLICK, show_juanxian);
			//comp.btn_default.addEventListener(MouseEvent.CLICK,on_default_juanxian);
			
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_REMOVE_JUANXIAN, remove_juanxian);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_ON_JUANXIAN, on_juanxian);
			
			refresh();
		}
		
		override public function preRemove():void {
			this.eventDispatcher.removeEventListener(NCropsEvent.EVENT_Crops_REFRESH_Keji_VIEW, refresh);
			
			comp.removeEventListener(NCropsEvent.EVENT_Crops_ON_CLICK_KEJI_ITEM, on_item_click);
			comp.pre_btn.removeEventListener(MouseEvent.CLICK,on_pre_btn);
			comp.next_btn.removeEventListener(MouseEvent.CLICK,on_next_btn);
			//comp.btn_money.removeEventListener(MouseEvent.CLICK, show_juanxian);
			//comp.btn_default.removeEventListener(MouseEvent.CLICK,on_default_juanxian);
			
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_REMOVE_JUANXIAN, remove_juanxian);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_ON_JUANXIAN, on_juanxian);
		}
		
		private function refresh(e:NCropsEvent = null):void {
			requese_keji_list();
		}
		private function on_item_click(e:NCropsEvent):void{
			var len:int = _list.length;
			for (var i:int = 0; i < len; i++) 
			{
				var cur:TechnologyInfo = _list[i] as TechnologyInfo;
				if (cur.technologyId == e.obj.technologyId) {
					_selected_index = i;
					break;
				}
			}
			change_to_selected();
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
			requese_keji_list(_cur_page);
		}
		
		private function on_juanxian(e:NCropsEvent = null):void {
			var t_info:TechnologyInfo = _list[_selected_index] as TechnologyInfo;
			requese_juanxian(1, t_info.technologyId);
		}
		
		private function refresh_view():void {
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
			
			
			
			comp.technologyList.dataProvider = new ArrayCollection(_list);
			comp.technologyList.validateNow();
			
			change_to_selected();
		}
		
		private function change_to_selected(old:int = -1):void {
			if (-1 != old) {
				_selected_index = old;
			}
			
			comp.technologyList.selectedIndex = _selected_index;
			xtrace("选中科技图标 " + _selected_index);
			
			
			var t_info:TechnologyInfo = _list[_selected_index] as TechnologyInfo;
			comp.l_name.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_kjmc') + t_info.technologyName;
			comp.l_level.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_kjdj')+t_info.technologyLevel.toString();
			comp.l_request_level.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_sjtj') + t_info.remainCondition;
			var pro:String = 0 == t_info.maxSchedule ? "MAX" :  t_info.curSchedule + "/" + t_info.maxSchedule;
			comp.l_progress.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_dqjd') + pro;
			comp.l_des.text = t_info.technologyDes;
			
			comp.img_selected_icon.source = BASE_PATH +  t_info.technologyImg + ".png";
			if(t_info.isenable){
				comp.wkq_icon.visible = false;
			}else{
				comp.wkq_icon.visible = true;
			}
//			trace("军徽trace" + t_info.curSchedule)
			
			//if (t_info.defaultDonate) {
			//	remove_if_have(comp.btn_default);
			//}
			//else {
			//	comp.addElement(comp.btn_default);
			//}
		}
		
		//显示弹出框
		private function show_alert(msg:String,tips:String):void {
			CrotaCommonAlert.createCrotaBasicAlert(msg);
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:msg,tips:tips},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		private function remove_if_have(element:IVisualElement):void{
			if(element.parent){
				comp.removeElement(element);
			}
		}
		
		
		//捐献窗口
		private function show_juanxian(e:MouseEvent):void {
			//var t_info:TechnologyInfo = _list[_selected_index] as TechnologyInfo;
			//var corpsLevel:int = SystemDataModel.roleInfo.roleCorpsInfo.corpsLevel;
			//if (t_info.curSchedule == t_info.maxSchedule) {
				//show_alert("捐献额已满","tips");
			//}
			//else if (corpsLevel <= t_info.technologyLevel && 800001 != t_info.technologyId) {
				//无法升级
				//show_alert("工会等级不允许","tips");
			//}
			//else{
				//WindowManager.createWindow(CorpsTechnologyDonateComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			//}
			on_juanxian();
		}
		//移除捐献
		private function remove_juanxian(e:NCropsEvent = null):void {
			WindowManager.closeWindow(CorpsTechnologyDonateComponent.NAME);
		}
		//默认捐献
		private function on_default_juanxian(e:MouseEvent):void {
			var t_info:TechnologyInfo = _list[_selected_index] as TechnologyInfo;
			if (SystemDataModel.roleInfo.roleCorpsInfo.corpsLevel <= t_info.technologyLevel && 800001 != t_info.technologyId) {
				//无法升级
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_byx'),"tips");
			}else{
				requese_defau_juanxian(t_info.technologyId);
			}
		}
		
		//科技列表
		private function requese_keji_list(curpage:int = 1):void {
			var msg:GetCorpsTechnologyListInfoRequest = new GetCorpsTechnologyListInfoRequest();
			msg.id = SystemDataModel.roleId;
			msg.curPage = curpage;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("申请科技列表",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_keji_list,faultHandler),URLConst.CORPS_TECHNOLOGYLIST_COMMANDID,bytes);
		}
		private function response_keji_list(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:GetCorpsTechnologyListInfoResponse = new GetCorpsTechnologyListInfoResponse();
			responseData.readExternal(byteArray);
			xtrace("申请科技列表回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				_cur_page = responseData.data.curPage;
				_max_page = responseData.data.maxPage;
				_list = responseData.data.technologyInfo;
				
				
				if (_is_keep_select) {
					_is_keep_select = false;
				}
				else{
					_selected_index = 0;
				}
				
				refresh_view();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		//捐献魔币
		private function requese_juanxian(num:int,id:int):void{
			var msg:CorpsTechnologyDonateRequest = new CorpsTechnologyDonateRequest();
			msg.id = SystemDataModel.roleId;
			msg.donateNum = num;
			msg.technologyId = id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("捐献金币",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_juanxian,faultHandler),URLConst.CORPS_DONATEGOLD_COMMANDID,bytes);
		}
		private function response_juanxian(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:CorpsTechnologyDonateResponse = new CorpsTechnologyDonateResponse();
			responseData.readExternal(byteArray);
			xtrace("捐献金币回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				remove_juanxian();
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_jxcg'), CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nckjM_tips'));
				_is_keep_select = true;
				send_page_msg();
			}
			else {
				//popUpShow.show(responseData.message);
			}
		}
		
		//默认捐献
		private function requese_defau_juanxian(id:int):void{
			var msg:ModifyDefaultDonateRequest = new ModifyDefaultDonateRequest();
			msg.id = SystemDataModel.roleId;
			msg.technologyId = id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("默认捐献",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_defau_juanxian,faultHandler),URLConst.CORPS_MOFIGYDONATE_COMMANDID,bytes);
		}
		private function response_defau_juanxian(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:ModifyDefaultDonateResponse = new ModifyDefaultDonateResponse();
			responseData.readExternal(byteArray);
			xtrace("默认捐献回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				remove_juanxian();
				_is_keep_select = true;
				send_page_msg();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
	}
}
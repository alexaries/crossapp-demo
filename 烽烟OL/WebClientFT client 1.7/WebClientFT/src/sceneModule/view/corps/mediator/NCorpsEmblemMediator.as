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
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.corps.event.NCropsEvent;
	import sceneModule.view.corps.view.ModifyCorpsBugleComponent;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.corps.view.NCropEmblemView;
	import sceneModule.view.corps.view.NCropMemberView;
	import sceneModule.view.corps.view.NCropRequestView;
	import sceneModule.view.corps.view.NCropsOutView;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.ObjectToString;
	import util.xtrace;

	public class NCorpsEmblemMediator extends Mediator
	{
		public static const BASE_PATH:String = "assets/ncorps/junhui/";
		
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var comp:NCropEmblemView;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		[Inject]
		public var popUpShow:IPopUpShow;
		
		private var _info:EmblemInfo;
		
		
		
		public function NCorpsEmblemMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventDispatcher.addEventListener(NCropsEvent.EVENT_Crops_REFRESH_Emblem_VIEW, refresh);
			
			comp.btn_get_pos.addEventListener(MouseEvent.CLICK,on_get_pos);
			comp.btn_change_junhao.addEventListener(MouseEvent.CLICK,on_change_junhao);
			comp.btn_up_junhui.addEventListener(MouseEvent.CLICK, on_up_junhui);
			
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_REMOVE_CHANGE_JUNHAO,on_remove_junhao);
			NCropMessage.getInstance().addEventListener(NCropsEvent.EVENT_Crops_ON_CHANGE_JUNHAO,on_change_junhao_ok);
			
			refresh();
		}
		
		override public function preRemove():void {
			this.eventDispatcher.removeEventListener(NCropsEvent.EVENT_Crops_REFRESH_Emblem_VIEW, refresh);
			
			comp.btn_get_pos.removeEventListener(MouseEvent.CLICK,on_get_pos);
			comp.btn_change_junhao.removeEventListener(MouseEvent.CLICK,on_change_junhao);
			comp.btn_up_junhui.removeEventListener(MouseEvent.CLICK, on_up_junhui);
			
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_REMOVE_CHANGE_JUNHAO,on_remove_junhao);
			NCropMessage.getInstance().removeEventListener(NCropsEvent.EVENT_Crops_ON_CHANGE_JUNHAO,on_change_junhao_ok);
		}
		
		private function refresh(e:NCropsEvent = null):void {
			request_get_info();
		}
		
		//接位
		private function on_get_pos(e:MouseEvent):void {
			requese_get_pos();
		}
		//修改军号
		private function on_change_junhao(e:MouseEvent):void {
			WindowManager.createWindow(ModifyCorpsBugleComponent.NAME,null,null,false,true,false,null,mediatorMap,popUpWindowLayer,true);
		}
		//升级军徽
		private function on_up_junhui(e:MouseEvent):void {
			requese_up_junhui();
		}
		
		//移除修改军号窗口
		private function on_remove_junhao(e:NCropsEvent = null):void {
			WindowManager.closeWindow(ModifyCorpsBugleComponent.NAME);
		}
		//确认修改军号
		private function on_change_junhao_ok(e:NCropsEvent):void {
			requese_change_junhao(e.obj.msg);
		}
		
		
		private function refresh_view():void {
			comp.img_junhui.source = BASE_PATH + _info.corpsImg + ".png";
//			comp.l_junhua.text = _info.bugleTxt;
			
			comp.l_creater.text = _info.corpsFounder;
			comp.l_create_data.text = _info.createData;
			comp.l_union_level.text = _info.corpsLevel.toString();
			comp.l_emblem_level.text = _info.emblemLevel.toString();
			comp.l_leader.text = _info.corpsChief;
			
//			trace("军团trace" + _info.bugleTxt);
			//元老
			var yuanlao_str:String = build_str(_info.veteranList);
			//参谋
			var canmou_str:String = build_str(_info.staffInfo);
			//议事
			var yishi_str:String = build_str(_info.orderInfo);
			
			comp.l_yuanlao.text = yuanlao_str;
			comp.l_canmou.text = canmou_str;
			comp.l_yishi.text = yishi_str;
			
			
			var money:int = 0;
			switch (_info.emblemLevel) 
			{
				case 1:
					money = 100;
					break;
				case 2:
					money = 200;
					break;
				case 3:
					money = 500;
					break;
				case 4:
					money = 1000;
					break;
				case 5:
					money = 2000;
					break;
				case 6:
					money = 5000;
					break;
				case 7:
					money = 10000;
					break;
				case 8:
					money = 20000;
					break;
				case 9:
					money = 50000;
					break;
				case 10:
					money = 100000;
					break;
				default:
			}
			comp.l_des_up_junhui.text = money + CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nceM_zcy');
			var pro_percent:Number = (_info.curProgress / _info.maxPorgress)*100;
			var pro_percent_s:String = pro_percent.toFixed(2);
			comp.l_progress.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nceM_dqjy') + _info.curProgress + "/" + _info.maxPorgress + "(" + pro_percent_s + "%)";
			comp.pro_bar_mask.scaleX = (_info.curProgress / _info.maxPorgress);
			
			var pos:int = SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition;
			switch (pos) 
			{
				case NCorpsOutMediator.UNION_POS_LEADER:
					//军团长
					remove_if_have(comp.btn_get_pos);
					remove_if_have(comp.l_des_get_pos);
					//test
					//comp.addElement(comp.btn_get_pos);
					//comp.addElement(comp.l_des_get_pos);
					//end test
					comp.addElement(comp.btn_change_junhao);
					comp.addElement(comp.l_des_change_junhao);
					comp.addElement(comp.btn_up_junhui);
					comp.addElement(comp.l_des_up_junhui);
					break;
				case NCorpsOutMediator.UNION_POS_YUANLAO:
				case NCorpsOutMediator.UNION_POS_CANMOU:
				case NCorpsOutMediator.UNION_POS_YISHI:
					//管理层
					comp.addElement(comp.btn_get_pos);
					comp.addElement(comp.l_des_get_pos);
					remove_if_have(comp.btn_change_junhao);
					remove_if_have(comp.l_des_change_junhao);
					comp.addElement(comp.btn_up_junhui);
					comp.addElement(comp.l_des_up_junhui);
					break;
				case NCorpsOutMediator.UNION_POS_NOMAL:
					//普通成员
					remove_if_have(comp.btn_get_pos);
					remove_if_have(comp.l_des_get_pos);
					remove_if_have(comp.btn_change_junhao);
					remove_if_have(comp.l_des_change_junhao);
					comp.addElement(comp.btn_up_junhui);
					comp.addElement(comp.l_des_up_junhui);
					break;
				default:
					break;
			}
			
			
		}
		
		private function remove_if_have(element:IVisualElement):void{
			if(element.parent){
				comp.removeElement(element);
			}
		}
		
		private function build_str(arr:Array):String {
			var r_str:String = "";
			for each (var item:ManagermentInfo in arr) 
			{
				r_str += (item.roleName + "  ")
			}
			return r_str;
		}
		
		//显示弹出框
		private function show_alert(msg:String,tips:String):void {
			CrotaCommonAlert.createCrotaBasicAlert(msg);
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:msg,tips:tips},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		
		
		/**
		 * 获取军徽信息
		 */
		private function request_get_info():void{
			var msg:GetEmblemInfoRequest = new GetEmblemInfoRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("获取军团信息",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_get_info,faultHandler),URLConst.CORPS_GETEMBLEMINFO_COMMANDID,bytes);
		}
		private function response_get_info(byteArray:ByteArray):void {
			var byteArray:ByteArray = byteArray;
			var responseData:GetEmblemInfoResponse = new GetEmblemInfoResponse();
			responseData.readExternal(byteArray);
			xtrace("获取军团信息回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				_info = responseData.data;
				refresh_view();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		/**
		 * 接替军团长职位 
		 */		
		private function requese_get_pos():void{
			var msg:TakeCorpsChiefRequest = new TakeCorpsChiefRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("接替军团长职位",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_get_pos,faultHandler),URLConst.CORPS_TASKCHIEF_COMMANDID,bytes);
		}
		private function response_get_pos(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:TakeCorpsChiefResponse = new TakeCorpsChiefResponse();
			responseData.readExternal(byteArray);
			xtrace("接替军团长职位回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				request_get_info();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		//修改军号
		private function requese_change_junhao(content:String):void{
			var msg:ModifyBugleRequest = new ModifyBugleRequest();
			msg.id = SystemDataModel.roleId;
			msg.bugleTxt = content;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("修改军号",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_change_junhao,faultHandler),URLConst.CORPS_MODIFYBUGLE_COMMANDID,bytes);
		}
		private function response_change_junhao(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:ModifyBugleResponse = new ModifyBugleResponse();
			responseData.readExternal(byteArray);
			xtrace("修改军号回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				on_remove_junhao();
				show_alert(CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nceM_cgjh'),CrotaResourceConfig.getInstance().getTextByModuleAndId('corps','nceM_tips') );
				request_get_info();
			}
			else {
				popUpShow.show(responseData.message);
			}
		}
		
		//升级军徽
		private function requese_up_junhui():void{
			var msg:LevelUpEmblemRequest = new LevelUpEmblemRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("升级军徽",new ObjectToString(msg).getString());
			socketService.send(new mx.rpc.Responder(response_up_junhui,faultHandler),URLConst.CORPS_LEVELUPEMBLEM_COMMANDID,bytes);
		}
		private function response_up_junhui(data:ByteArray):void{
			var byteArray:ByteArray = data;
			var responseData:LevelUpEmblemResponse = new LevelUpEmblemResponse();
			responseData.readExternal(byteArray);
			xtrace("升级军徽回复",new ObjectToString(responseData).getString());
			if (responseData.result) {
				//show_alert("军徽等级已升至" + (_info.emblemLevel+1) + "级","小贴士:军徽等级越高,可容纳的军团成员就越多!!!");
				request_get_info();
			}
			else {
//				popUpShow.show(responseData.message);
			}
		}
		
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
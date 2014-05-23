package sceneModule.view.colonMan.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.reward.reward2406.ActibationElixirResponse;
	import proto.reward.reward2406.ActivationElixirRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.colonMan.command.ColonManMessage;
	import sceneModule.view.colonMan.event.MediatorRegisterColonManItemEuipmentEvent;
	import sceneModule.view.colonMan.view.ColonManElixirToolTip;
	import sceneModule.view.colonMan.view.MainColoManagerWindow;
	import sceneModule.view.pack.event.PackageInfoChangeEvent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.reward.command.RewardMessage;
	import sceneModule.view.reward.view.RewardWindow;
	
	import service.ISocketServer;

	public class MainColoManagerWindowMediator extends Mediator
	{
		[Inject]
		public var comp:MainColoManagerWindow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function MainColoManagerWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtnWin,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.elixir_li,MouseEvent.CLICK,onActivationLi);
			this.eventMap.mapListener(comp.elixir_jing,MouseEvent.CLICK,onActivationJing);
			this.eventMap.mapListener(comp.elixir_min,MouseEvent.CLICK,onActivationMin);
			this.eventMap.mapListener(comp.elixir_nai,MouseEvent.CLICK,onActivationNai);
			this.eventMap.mapListener(comp.elixir_zhi,MouseEvent.CLICK,onActivationZhi);
			this.eventMap.mapListener(comp.buyAllBtn,MouseEvent.CLICK,onBuyAllEli);
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePage);
			this.eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPage);
			
			this.eventMap.mapListener(comp.elixir_jing,MouseEvent.MOUSE_OVER,onMouseOverJing);
			this.eventMap.mapListener(comp.elixir_li,MouseEvent.MOUSE_OVER,onMouseOverLi);
			this.eventMap.mapListener(comp.elixir_min,MouseEvent.MOUSE_OVER,onMouseOverMin);
			this.eventMap.mapListener(comp.elixir_nai,MouseEvent.MOUSE_OVER,onMouseOverNai);
			this.eventMap.mapListener(comp.elixir_zhi,MouseEvent.MOUSE_OVER,onMouseOverZhi);
			this.eventMap.mapListener(comp.elixir_jing,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.elixir_li,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.elixir_min,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.elixir_nai,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.elixir_zhi,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.elixir_jing,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.mapListener(comp.elixir_li,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.mapListener(comp.elixir_min,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.mapListener(comp.elixir_nai,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.mapListener(comp.elixir_zhi,MouseEvent.MOUSE_MOVE,onMouseMove);
			
			ColonManMessage.getInstance().addEventListener(PackageInfoChangeEvent.CANGKUINFOCHANGEVENT,onCangKuInfoChange);
			
			comp.addEventListener(MediatorRegisterColonManItemEuipmentEvent.MEDIATORREGISTERCOLONMANITEMEUIPMENT,onRegisterMediatorItem);
			
			this.eventMap.mapListener(comp.obtainAllBtn,MouseEvent.CLICK,onObtainAll);
			
			this.eventMap.mapListener(comp.rewardBtn,MouseEvent.CLICK,onRewardWindow);
		}
		
		private function onRewardWindow(evt:MouseEvent):void{
			onCloseWindow();
			RewardMessage.getInstance().getRewardList();
			AssetCenter.getInstance().load_package("ui_colo_jiangjin",to_Jiangji,null,true);
		}
		
		private function to_Jiangji():void{
			WindowManager.createWindow(RewardWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onObtainAll(evt:MouseEvent):void{
			ColonManMessage.getInstance().onObatinItem(0,0);
		}
			
		
		private function onRegisterMediatorItem(evt:MediatorRegisterColonManItemEuipmentEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCangKuInfoChange(evt:PackageInfoChangeEvent):void{
			comp.setEquipInfo();
		}
		private var elixirTis:ColonManElixirToolTip;
		private function onAddTips(mes:String):void{
			if(null == elixirTis){
				elixirTis = new ColonManElixirToolTip();
			}
			elixirTis.l_juntuan_name.text = mes;
			
			popUpWindowLayer.addElement(elixirTis);
			
			onMouseMove();
		}
		
		private function onMouseMove(evt:MouseEvent = null):void{
			if(elixirTis){
				elixirTis.x = popUpWindowLayer.mouseX;
				elixirTis.y = popUpWindowLayer.mouseY;
			}
		}
		
		private function onMouseOverJing(evt:MouseEvent):void{
//			if(SystemDataModel.colonizationInfo.copyInfoArr.length!=0 && SystemDataModel.colonizationInfo.copyInfoArr.getItemAt(comp.rewardList.selectedIndex).jingshen_info.status == 0){
				onAddTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_js'));
//			}
			
		}
		private function onMouseOverLi(evt:MouseEvent):void{
//			if(SystemDataModel.colonizationInfo.copyInfoArr.length!=0 && SystemDataModel.colonizationInfo.copyInfoArr.getItemAt(comp.rewardList.selectedIndex).liliang_info.status == 0){
				onAddTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_ll'));
//			}
			
		}
		private function onMouseOverMin(evt:MouseEvent):void{
//			if(SystemDataModel.colonizationInfo.copyInfoArr.length!=0 && SystemDataModel.colonizationInfo.copyInfoArr.getItemAt(comp.rewardList.selectedIndex).minjie_info.status == 0){
				onAddTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_mj'));
//			}
			
		}
		private function onMouseOverNai(evt:MouseEvent):void{
//			if(SystemDataModel.colonizationInfo.copyInfoArr.length!=0 && SystemDataModel.colonizationInfo.copyInfoArr.getItemAt(comp.rewardList.selectedIndex).naili_info.status == 0){
				onAddTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_nl'));
//			}
			
		}
		private function onMouseOverZhi(evt:MouseEvent):void{
//			if(SystemDataModel.colonizationInfo.copyInfoArr.length!=0 && SystemDataModel.colonizationInfo.copyInfoArr.getItemAt(comp.rewardList.selectedIndex).zhili_info.status == 0){
				onAddTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_zl'));
//			}
			
		}
		private function onMouseOut(evt:MouseEvent):void{
			if(elixirTis && popUpWindowLayer.contains(elixirTis)){
				popUpWindowLayer.removeElement(elixirTis);
			}
		}
		
		private function onPrePage(evt:MouseEvent):void{
			ColonManMessage.getInstance().getColoManInfo(SystemDataModel.colonizationInfo.curPage - 1);
		}
		
		private function onNextPage(evt:MouseEvent):void{
			ColonManMessage.getInstance().getColoManInfo(SystemDataModel.colonizationInfo.curPage + 1);
		}
		
		private function onActivationLi(evt:MouseEvent):void{
			//力量
			temp_type = 1;
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_isll'),CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmitBuy);
		}
		
		private function onActivationJing(evt:MouseEvent):void{
			//精神
			temp_type = 4;
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_isjs'),CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmitBuy);
		}
		
		private function onActivationMin(evt:MouseEvent):void{
			//敏捷
			temp_type = 2;
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_ismj'),CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmitBuy);
		}
		
		private function onActivationNai(evt:MouseEvent):void{
			//耐力
			temp_type = 5;
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_isnl'),CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmitBuy);
		}
		
		private function onActivationZhi(evt:MouseEvent):void{
			//智力
			temp_type = 3;
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_iszl'),CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmitBuy);
		}
		
		private function onBuyAllEli(evt:MouseEvent):void{
			temp_type = 6;
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','mcmWM_iswb'),CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmitBuy);
		}
		
		private var temp_type:int;
		private function onSubmitBuy(evt:MouseEvent):void{
			onActivationElixir(temp_type);
		}
		
		private function onActivationElixir(elixir:int):void{
			if(SystemDataModel.colonizationInfo.copyInfoArr.length!=0){
				var actEliReq:ActivationElixirRequest = new ActivationElixirRequest();
				actEliReq.id = SystemDataModel.roleId;
				actEliReq.elixirType = elixir;
				actEliReq.cId = SystemDataModel.colonizationInfo.copyInfoArr.getItemAt(comp.rewardList.selectedIndex).c_id;
				var byteArray:ByteArray = new ByteArray();
				actEliReq.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(activationEliHandler,faultHandler),URLConst.REWARD_ACTIVA_ELI_COMMANDID,byteArray);
			}
			
		}
		
		private function activationEliHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ActibationElixirResponse = new ActibationElixirResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				//激活成功
				ColonManMessage.getInstance().getColoManInfo(SystemDataModel.colonizationInfo.curPage);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			WindowManager.closeWindow(MainColoManagerWindow.NAME,false,false,null,popUpWindowLayer,mediatorMap);
		}
	}
}
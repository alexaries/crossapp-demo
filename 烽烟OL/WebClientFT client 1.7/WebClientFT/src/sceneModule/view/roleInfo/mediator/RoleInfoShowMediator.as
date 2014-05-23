package sceneModule.view.roleInfo.mediator
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guaji.guaji3200.StartUpGuaJiRequest;
	import proto.guaji.guaji3200.StartUpGuaJiResponse;
	import proto.scene.scene224.AddHuoLiRequest;
	import proto.scene.scene224.AddHuoLiResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.gaAndsd.view.GuaJiToolTip;
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.roleInfo.view.RoleInfoShowComponent;
	import sceneModule.view.roleInfo.view.RoleInfoShowTooltip;
	import sceneModule.view.vip.command.VIPmessage;
	import sceneModule.view.vip.view.VipWindow;
	
	import service.ISocketServer;

	public class RoleInfoShowMediator extends Mediator
	{

		private var _tips:RoleInfoShowTooltip;

		[Inject]
		public var comp:RoleInfoShowComponent;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;

		public var roleInfoShowTooltip:RoleInfoShowTooltip;
		
		private var guaJiTips:GuaJiToolTip;

		public function RoleInfoShowMediator()
		{
			super();
		}

		override public function onRegister():void
		{

			eventMap.mapListener(comp.l_level, MouseEvent.MOUSE_OVER, onLevelMouseOver);
			eventMap.mapListener(comp.l_level, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(comp.l_level, MouseEvent.MOUSE_MOVE, onMouseMove);

			eventMap.mapListener(comp.l_qian, MouseEvent.MOUSE_OVER, onQianMouseOver);
			eventMap.mapListener(comp.l_qian, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(comp.l_qian, MouseEvent.MOUSE_MOVE, onMouseMove);

			eventMap.mapListener(comp.l_vip, MouseEvent.MOUSE_OVER, onVipMouseOver);
			eventMap.mapListener(comp.l_vip, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(comp.l_vip, MouseEvent.MOUSE_MOVE, onMouseMove);

			eventMap.mapListener(comp.l_zuan, MouseEvent.MOUSE_OVER, onZuanMouseOver);
			eventMap.mapListener(comp.l_zuan, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(comp.l_zuan, MouseEvent.MOUSE_MOVE, onMouseMove);

			eventMap.mapListener(comp.hl_txt, MouseEvent.MOUSE_OVER, onActiveMouseOver);
			eventMap.mapListener(comp.hl_txt, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(comp.hl_txt, MouseEvent.MOUSE_MOVE, onMouseMove);

			eventMap.mapListener(comp.xl_txt, MouseEvent.MOUSE_OVER, onHpMouseOver);
			eventMap.mapListener(comp.xl_txt, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(comp.xl_txt, MouseEvent.MOUSE_MOVE, onMouseMove);
			
//			eventMap.mapListener(comp.guajiBtn,MouseEvent.CLICK,setGuaJiFun);
			
//			eventMap.mapListener(comp.guajiBtn,MouseEvent.MOUSE_OVER,onMouseGuaJiOver);
//			eventMap.mapListener(comp.guajiBtn,MouseEvent.MOUSE_OUT,onMouseGuaJiOut);
//			eventMap.mapListener(comp.guajiBtn,MouseEvent.MOUSE_MOVE,onMouseGuaJiMove);
			
			//eventMap.mapListener(comp.addHL,MouseEvent.MOUSE_OVER,onMouseHLOver);
			//eventMap.mapListener(comp.addHL,MouseEvent.MOUSE_OUT,onMouseHLOut);
			//eventMap.mapListener(comp.addHL,MouseEvent.MOUSE_MOVE,onMouseHLMove);
			//eventMap.mapListener(comp.addHL,MouseEvent.CLICK,onaddHL);
			
//			eventMap.mapListener(comp.vipBtn,MouseEvent.CLICK,onOpenVIP);
			
//			registerVIPEvent();

		}
		
		private function onaddHL(evt:MouseEvent):void{
			popUpShow.show(getAddHuoLiDes(), null, null, null, null, submitAddHL, null, null);
		}
		
		private function submitAddHL(evt:MouseEvent):void{
			if(getAddHuoLiEnable()){
				var addHLreq:AddHuoLiRequest = new AddHuoLiRequest();
				addHLreq.id = SystemDataModel.roleId;
				var byteArray:ByteArray = new ByteArray();
				addHLreq.writeExternal(byteArray);
				socket.send(new mx.rpc.Responder(addHLhandler,faultHandler),URLConst.ADD_HUOLI_COMMANDID,byteArray);
			}else{
				popUpShow.show("오늘은 활력을 더 이상 구매할 수 없습니다!");
			}
		}
		
		private function addHLhandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:AddHuoLiResponse = new AddHuoLiResponse();
			responseData.readExternal(byteArray);
			if(!responseData.result && responseData.failType == 1){
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_zbz'), null, null, null, null, onChongZhi, null, null);
			}
		}
		
		private function onChongZhi(evt:MouseEvent):void{
			var url:URLRequest = new URLRequest("http://www.bigzhu.com/Payment");
			navigateToURL(url, '_blank');
		}
		
		private function onMouseHLMove(evt:MouseEvent =null):void{
			if(hlTips){
				hlTips.x = comp.mouseX + 5;
				hlTips.y = comp.mouseY + 5;
			}
		}
		
		private function getAddHuoLiDes():String{
			var des:String = '';
			if(SystemDataModel.roleInfo.roletype == 0){
				if(SystemDataModel.roleInfo.buyHLcount == 0){
					des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_sses');
				}else{
					des =  CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_hlyw');
				}
			}else{
				if(SystemDataModel.roleInfo.roletype<=3){
					if(SystemDataModel.roleInfo.buyHLcount == 0){
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_sses');
					}else{
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_hlyw');
					}
				}else if(SystemDataModel.roleInfo.roletype == 4 || SystemDataModel.roleInfo.roletype == 5){
					if(SystemDataModel.roleInfo.buyHLcount == 6){
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_sses');
					}else{
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_sshl')+(SystemDataModel.roleInfo.buyHLcount+1)*20+CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan');
					}
				}else if(SystemDataModel.roleInfo.roletype == 6 || SystemDataModel.roleInfo.roletype == 7){
					if(SystemDataModel.roleInfo.buyHLcount == 21){
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_hlyw');
					}else{
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_sshl')+(SystemDataModel.roleInfo.buyHLcount+1)*20+CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan');
					}
				}else if(SystemDataModel.roleInfo.roletype >= 8){
					if(SystemDataModel.roleInfo.buyHLcount == 46){
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_hlyw');
					}else{
						des = CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_sshl')+(SystemDataModel.roleInfo.buyHLcount+1)*20+CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan');
					}
				}
			}
			return des;
		}
		
		private function getAddHuoLiEnable():Boolean{
			var flag:Boolean
			if(SystemDataModel.roleInfo.roletype == 0){
				if(SystemDataModel.roleInfo.buyHLcount == 0){
					flag = true;
				}else{
					flag = false;
				}
			}else{
				if(SystemDataModel.roleInfo.roletype<=3){
					if(SystemDataModel.roleInfo.buyHLcount == 0){
						flag = true;
					}else{
						flag = false;
					}
				}else if(SystemDataModel.roleInfo.roletype == 4 || SystemDataModel.roleInfo.roletype == 5){
					if(SystemDataModel.roleInfo.buyHLcount == 6){
						flag = false;
					}else{
						flag = true;
					}
				}else if(SystemDataModel.roleInfo.roletype == 6 || SystemDataModel.roleInfo.roletype == 7){
					if(SystemDataModel.roleInfo.buyHLcount == 21){
						flag = false;
					}else{
						flag = true;
					}
				}else if(SystemDataModel.roleInfo.roletype >= 8){
					if(SystemDataModel.roleInfo.buyHLcount == 46){
						flag = false;
					}else{
						flag = true;
					}
				}
			}
			return flag;
		}
		
		private var hlTips:MainSmallDesTooltip;
		private function onMouseHLOver(evt:MouseEvent):void{
			if (!hlTips)
			{
				hlTips=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			
			hlTips.curDes = getAddHuoLiDes();
			popUpWindowLayer.addElement(hlTips);
			onMouseHLMove();
		}
		
		private function onMouseHLOut(evt:MouseEvent):void{
			if(hlTips){
				popUpWindowLayer.removeElement(hlTips);
			}
		}
		
//		private function registerVIPEvent():void{
//			socket.send(new mx.rpc.Responder(vipHandler,faultHandler),URLConst.VIP_AUTO_OPEN_COMMANDID,null,false);
//		}
		
//		private function vipHandler(data:Object):void{
//			onOpenVIP();
//		}
//		
//		private function onOpenVIP(evt:MouseEvent = null):void{
//			AssetCenter.getInstance().load_package("ui_vip",to_vip,null,true,null,null,null);
//		}
		
		private function to_vip():void{
			WindowManager.createWindow(VipWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onMouseGuaJiOver(evt:MouseEvent):void{
			if(!SystemDataModel.isGuaJiFlag)return;
			if(!guaJiTips){
				guaJiTips = new GuaJiToolTip();
				comp.addElement(guaJiTips);
				onMouseGuaJiMove();
				mediatorMap.createMediator(guaJiTips);
			}
		}
		
		private function onMouseGuaJiOut(evt:MouseEvent):void{
			if(guaJiTips){
				comp.removeElement(guaJiTips);
				guaJiTips = null;
			}
		}
		
		private function onMouseGuaJiMove(evt:MouseEvent = null):void{
			if(guaJiTips){
				guaJiTips.x = comp.mouseX + 10;
				guaJiTips.y = comp.mouseY + 10;
			}
		}
		
		/**
		 * 挂机功能 
		 */	
		private function setGuaJiFun(evt:MouseEvent):void{
			var startGuaJiReq:StartUpGuaJiRequest = new StartUpGuaJiRequest();
			startGuaJiReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			startGuaJiReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(guajiHandler,faultHandler),URLConst.GUAJI_START_COMMANDID,byteArray);
		}
		
		private function guajiHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:StartUpGuaJiResponse = new StartUpGuaJiResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
			    SystemDataModel.isGuaJiFlag = true;
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}


		private function onMouseMove(evt:MouseEvent):void
		{
			setSmallDesPos();
		}

		//设置简短描述ToolTip位置
		private function setSmallDesPos():void
		{
			if (roleInfoShowTooltip)
			{
				roleInfoShowTooltip.x=comp.mouseX + 10;
				roleInfoShowTooltip.y=comp.mouseY + 10;
			}
		}

		private function onMouseOut(evt:MouseEvent):void
		{
			if (roleInfoShowTooltip && roleInfoShowTooltip.parent)
			{
				comp.removeElement(roleInfoShowTooltip);
			}
			comp.hl_txt.text = '';
			comp.xl_txt.text = '';
			eventMap.mapListener(comp.l_level, MouseEvent.MOUSE_OVER, onLevelMouseOver);
		}

		private function onLevelMouseOver(evt:MouseEvent):void
		{
			if (!roleInfoShowTooltip)
			{
				roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			}
			roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_dqdj') + SystemDataModel.roleInfo.level + CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_xyj') + SystemDataModel.roleInfo.maxExp + CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy');
			comp.addElement(roleInfoShowTooltip);
		}

		private function onQianMouseOver(evt:MouseEvent):void
		{
			if (!roleInfoShowTooltip)
			{
				roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			}
			roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_dqjb') + SystemDataModel.roleInfo.coin;
			comp.addElement(roleInfoShowTooltip);
		}

		private function onZuanMouseOver(evt:MouseEvent):void
		{
			if (!roleInfoShowTooltip)
			{
				roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			}
			roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan')+"：" + SystemDataModel.roleInfo.gold;
			comp.addElement(roleInfoShowTooltip);
		}

		private function onVipMouseOver(evt:MouseEvent):void
		{
			if (!roleInfoShowTooltip)
			{
				roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			}
			roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_viphy') + SystemDataModel.roleInfo.roletype;
			comp.addElement(roleInfoShowTooltip);
		}

		private function onHpMouseOver(evt:MouseEvent):void
		{
			if (!roleInfoShowTooltip)
			{
				roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			}
			comp.xl_txt.text = SystemDataModel.roleInfo.hp+'/'+SystemDataModel.roleInfo.maxHp;
			roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_smz') + SystemDataModel.roleInfo.hp;
			comp.addElement(roleInfoShowTooltip);
		}

		private function onActiveMouseOver(evt:MouseEvent):void
		{
			//if (!roleInfoShowTooltip)
			//{
				//roleInfoShowTooltip=ToolTipManager.showToolTip(RoleInfoShowTooltip.NAME) as RoleInfoShowTooltip;
			//}
			comp.hl_txt.text=SystemDataModel.roleInfo.exp+'/' + SystemDataModel.roleInfo.maxExp;
			//roleInfoShowTooltip.msDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('roleInfo','rnsM_hlz')+SystemDataModel.roleInfo.energy;
			//comp.addElement(roleInfoShowTooltip);
		}
	}
}

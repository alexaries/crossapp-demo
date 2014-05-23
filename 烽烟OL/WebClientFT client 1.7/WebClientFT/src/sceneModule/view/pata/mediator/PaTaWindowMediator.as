package sceneModule.view.pata.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.panpa.panpa4200.GetCurLevelInfoRequest;
	import proto.panpa.panpa4200.GetCurLevelInfoResponse;
	import proto.panpa.panpa4201.RefreshInfoRequest;
	import proto.panpa.panpa4201.RefreshInfoResponse;
	import proto.panpa.panpa4202.AutoPaTaRequest;
	import proto.panpa.panpa4202.AutoPaTaResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.pata.command.PaTaMessage;
	import sceneModule.view.pata.event.PaTaBattleAndMoveEvent;
	import sceneModule.view.pata.view.PanPaWindow;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class PaTaWindowMediator extends Mediator
	{
		[Inject]
		public var comp:PanPaWindow;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function PaTaWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submit,MouseEvent.CLICK,onStartBattle);
			this.eventMap.mapListener(comp.refreshBtn,MouseEvent.CLICK,onRefresh);
			this.eventMap.mapListener(comp.autoBtn,MouseEvent.CLICK,onAutoBattle);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onClosePanPa);
			eventMap.mapListener(comp.refreshBtn,MouseEvent.MOUSE_OVER,onMouseHLOver);
			eventMap.mapListener(comp.refreshBtn,MouseEvent.MOUSE_OUT,onMouseHLOut);
			eventMap.mapListener(comp.refreshBtn,MouseEvent.MOUSE_MOVE,onMouseHLMove);
			
			onGetCurPanPaInfo();
			
			PaTaMessage.getInstance().event_dispatcher.addEventListener(PaTaBattleAndMoveEvent.PATABATTLEANDMOVEEVENT,onPaTa);
		}
		
		private function onPaTa(event:PaTaBattleAndMoveEvent):void{
			comp.iLeftComp.onMoveMapLayerAndRole();
		}
		
		private var hlTips:MainSmallDesTooltip;
		private function onMouseHLOver(evt:MouseEvent):void{
			if (!hlTips)
			{
				hlTips=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			
			
			hlTips.curDes = CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ptwm_hf')+SystemDataModel.panPaInfoVo.reZuan+CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ptwm_hfdes')+SystemDataModel.panPaInfoVo.reCount+CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ptwm_ci');
			popUpWindowLayer.addElement(hlTips);
			onMouseHLMove();
		}
		
		private function onMouseHLOut(evt:MouseEvent):void{
			if(hlTips){
				popUpWindowLayer.removeElement(hlTips);
			}
		}
		
		private function onMouseHLMove(evt:MouseEvent =null):void{
			if(hlTips){
				if(popUpWindowLayer.mouseX + hlTips.width > FlexGlobals.topLevelApplication.width){
					hlTips.x = FlexGlobals.topLevelApplication.width - hlTips.width;
				}else{
					hlTips.x = popUpWindowLayer.mouseX + 5;
				}
				hlTips.y = popUpWindowLayer.mouseY + 5;
			}
		}
		
		private function onGetCurPanPaInfo():void{
			var curInfoReq:GetCurLevelInfoRequest = new GetCurLevelInfoRequest();
			curInfoReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			curInfoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(curInfoHandler,faultHandler),URLConst.PANPA_INFO_COMMANDID,byteArray);
		}
		
		private function curInfoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetCurLevelInfoResponse = new GetCurLevelInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.panPaInfoVo.curLev = responseData.panPaInfo.curLev;
				SystemDataModel.panPaInfoVo.curMonster = responseData.panPaInfo.curMonster;
				var resultArr:Array = responseData.panPaInfo.obtainItem.split(' ');
				SystemDataModel.panPaInfoVo.obtainItem='';
				for each(var str:Object in resultArr){
					SystemDataModel.panPaInfoVo.obtainItem += str+'\n';
				}
				SystemDataModel.panPaInfoVo.reCount = responseData.panPaInfo.reCount;
				SystemDataModel.panPaInfoVo.reZuan = responseData.panPaInfo.reZuan;
				comp.iLeftComp.onAddMapLayer();
			}
		}
		
		private function onClosePanPa(evt:MouseEvent):void{
			WindowManager.closeWindow(PanPaWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function onStartBattle(evt:MouseEvent):void{
			PaTaMessage.getInstance().onPaTaBattle();
		}
		
		private function onAutoBattle(evt:MouseEvent):void{
			var autoReq:AutoPaTaRequest = new AutoPaTaRequest();
			autoReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			autoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(autoHandler,faultHandler),URLConst.PANPA_AUTO_COMMANDID,byteArray);
		}
		
		private function autoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:AutoPaTaResponse = new AutoPaTaResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
                var l:int = responseData.paTaInfoList.length;
				for(var i:int=0;i<l;i++){
					comp.txt_content +=(responseData.paTaInfoList[i].itemStr)+'\n';
				}
			}
		}
		
		private function onRefresh(evt:MouseEvent):void{
			if(SystemDataModel.panPaInfoVo.reZuan > 0){
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ptwm_sfhf')+SystemDataModel.panPaInfoVo.reZuan+CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ptwm_sfhfdes'), null, null, null, null, onSendInfo,null,null);
			}else{
				onSendInfo();
			}
			
		}
		
		private function onSendInfo(evt:MouseEvent = null):void{
			var refreshReq:RefreshInfoRequest = new RefreshInfoRequest();
			refreshReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			refreshReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(refreshHandler,faultHandler),URLConst.PANPA_REFRESH_COMMANDID,byteArray);
		}
		
		private function refreshHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:RefreshInfoResponse = new RefreshInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				onShowAutoComp();
			}
		}
		
		private function onHideAutoComp():void{
			comp.autoBtn.visible = false;
			comp.iTextArea.visible = false;
			comp.iLab1.visible = true;
			comp.iLab2.visible = true;
			comp.iLab3.visible = true;
			comp.submit.visible = true;
			comp.refreshBtn.visible = true;
		}
		
		private function onShowAutoComp():void{
			comp.autoBtn.visible = true;
			comp.iTextArea.visible = true;
			comp.iLab1.visible = false;
			comp.iLab2.visible = false;
			comp.iLab3.visible = false;
			comp.submit.visible = false;
			comp.refreshBtn.visible = false;
			comp.pt2Img.visible = true;
			comp.pt1Img.visible = false;
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
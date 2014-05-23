package sceneModule.view.gaAndsd.mediator
{
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.utils.ByteArray;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guaji.guaji3205.BattleInfo;
	import proto.guaji.guaji3205.SaoDangRequest;
	import proto.guaji.guaji3205.SaoDangResponse;
	
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.copyScene.model.FubenChoseItemVo;
	import sceneModule.view.gaAndsd.view.SaoDangWindow;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class SaoDangWindowMediator extends Mediator
	{
		[Inject]
		public var comp:SaoDangWindow;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function SaoDangWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.rBtn,MouseEvent.CLICK,onStartSaoDang);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.sdTextArea,TextEvent.LINK,onTextLink);
		}
		
		private function onRemoveTips(evt:MouseEvent):void{
			if(clickLinkFlag){
				clickLinkFlag = false;
				return;
			}
			if(tips){
				if(popUpWindowLayer.getElementIndex(tips)>=0){
					popUpWindowLayer.removeElement(tips);
					tips = null;
					FlexGlobals.topLevelApplication.removeEventListener(MouseEvent.CLICK,onRemoveTips);
				}
			}
		}
		
		private var tips:MainMenuEquipmentTooltip;
		private var clickLinkFlag:Boolean;
		private function onTextLink(evt:TextEvent):void{
			clickLinkFlag = true;
			var curItemInfo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(int(evt.text));
			if(curItemInfo){
				if(!tips){
					tips = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
				}
				tips.curDataInfo = curItemInfo;
				popUpWindowLayer.addElement(tips);
				FlexGlobals.topLevelApplication.addEventListener(MouseEvent.CLICK,onRemoveTips);
				//设置ToolTip位置
				tips.x = FlexGlobals.topLevelApplication.mouseX+10;
				tips.y = FlexGlobals.topLevelApplication.mouseY - 50;
			}
		}
		
		private function onStartSaoDang(evt:MouseEvent):void{
//			onCreateInfo();
			var req:SaoDangRequest = new SaoDangRequest();
			req.id = SystemDataModel.roleId;
			switch(comp.cardtype.selectedValue){
				case 'no1':
					req.fubenId = (comp.data as FubenChoseItemVo).id0;
					break;
				case 'no2':
					req.fubenId = (comp.data as FubenChoseItemVo).id1;
					break;
				case 'no3':
					req.fubenId = (comp.data as FubenChoseItemVo).id2;
					break;
			}
			switch(comp.sdGroup.selectedValue){
				case 'no1':
					req.sdType = 1;
					break;
				case 'no2':
					req.sdType = 0;
					break;
			}
			if(req.sdType == 1){
				if(int(comp.numTxt.text) == 0){
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('gaAndsd','sdWM_sdls'));
					return;
				}
			}
				req.sdRound = int(comp.numTxt.text);
				var byteArray:ByteArray = new ByteArray();
				req.writeExternal(byteArray);
				socket.send(new mx.rpc.Responder(sdHandler,faultHandler),URLConst.GUAJI_SAODANG_COMMANDID,byteArray);
				comp.rBtn.enabled = false;
		}
		
		private function sdHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:SaoDangResponse = new SaoDangResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				comp.battleDes = responseData.baInfoList;
			}else{
				comp.rBtn.enabled = true;
			}
		}
		
		private function onCreateInfo():void{
			var arr:Array = new Array();
			for(var i:int=0;i<10;i++){
				var battleInfo:BattleInfo = new BattleInfo();
				battleInfo.baDesStr = '<a href="event:11000"><u>第'+i+'次战斗.............</u></a>\n';
				arr.push(battleInfo);
			}
			comp.battleDes = arr;
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(SaoDangWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
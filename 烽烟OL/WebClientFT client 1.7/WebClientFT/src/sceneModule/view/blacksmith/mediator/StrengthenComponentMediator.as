package sceneModule.view.blacksmith.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.blacksmith.blacksmith2102.StrengthenItemRequest;
	import proto.blacksmith.blacksmith2102.StrengthenItemResponse;
	import proto.blacksmith.blacksmith2117.GetNextLevelItemInfoRequest;
	import proto.blacksmith.blacksmith2117.GetNextLevelItemInfoResponse;
	
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.blacksmith.command.BlacksmithMessage;
	import sceneModule.view.blacksmith.view.StrengthenComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.command.ShopMessage;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class StrengthenComponentMediator extends Mediator
	{
		[Inject]
		public var comp:StrengthenComponent;

		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;

		public function StrengthenComponentMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			this.eventMap.mapListener(comp.equipment, IndexChangeEvent.CHANGE, onIndexChange);
			this.eventMap.mapListener(comp.pre_btn, MouseEvent.CLICK, onPrePage);
			this.eventMap.mapListener(comp.next_btn, MouseEvent.CLICK, onNextPage);
			this.eventMap.mapListener(comp.sBtn, MouseEvent.CLICK, onStrengthen);
			this.eventMap.mapListener(comp.cleanCD,MouseEvent.CLICK,onCleanCD);
		}
		
		private function onCleanCD(evt:MouseEvent):void{
			if(SystemDataModel.strWinTime>(SystemDataModel.roleInfo.roletype+1)*20*60){
				var mes:int = SystemDataModel.strWinTime;
				var zuan:int=0;
				zuan = mes / 60;
				if(mes % 60 > 0){
					zuan += 1;
				}
				popUpShow.show("是否花费"+zuan+"钻减少"+zuan+"分冷却时间！", null, null, null, null, submitHandler,null,null);
			}
			
		}
		
		private function submitHandler(evt:MouseEvent):void{
			BlacksmithMessage.getInstance().cleanCDHandler();
		}

		private function onStrengthen(evt:MouseEvent):void
		{
			if(SystemDataModel.roleInfo.level<2){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','sbM_djbz2'));
				return;
			}
			if(comp.s1.data){
				var strReq:StrengthenItemRequest=new StrengthenItemRequest();
				strReq.id=SystemDataModel.roleId;
				strReq.itemId=comp.s1.data.id;
				var byteArray:ByteArray=new ByteArray();
				strReq.writeExternal(byteArray);
				socket.send(new mx.rpc.Responder(strHandler, faultHandler), URLConst.BLACKSMITH_STRENGTHEN_COMMANDID, byteArray);
			}
		}

		private function strHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:StrengthenItemResponse=new StrengthenItemResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				ShopMessage.getInstance().getStrengthenPackageInfo(SystemDataModel.strPackageInfo.curPage);
				getOneItemNextInfo(comp.equipment.selectedItem.id);
				clearInfo();
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_EXCUTE_QIANGHUA)]);			}

		}

		private function onPrePage(evt:MouseEvent):void
		{
			ShopMessage.getInstance().getStrengthenPackageInfo(SystemDataModel.strPackageInfo.curPage - 1);
		}

		private function onNextPage(evt:MouseEvent):void
		{
			ShopMessage.getInstance().getStrengthenPackageInfo(SystemDataModel.strPackageInfo.curPage + 1);
		}

		private function onIndexChange(evt:IndexChangeEvent):void
		{
			var tId:int=comp.equipment.selectedItem.id;
			getOneItemNextInfo(tId);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ZHUNBEI_QIANGHUA)]);
		}

		private function getOneItemNextInfo(id:int):void
		{
			var oneReq:proto.blacksmith.blacksmith2117.GetNextLevelItemInfoRequest=new GetNextLevelItemInfoRequest();
			oneReq.id=SystemDataModel.roleId;
			oneReq.itemId=id;
			var byteArray:ByteArray=new ByteArray();
			oneReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(nextHandler, faultHandler), URLConst.BLACKSMITH_STRENGTHEN_ONE_COMMANDID, byteArray);
		}

		private function nextHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:GetNextLevelItemInfoResponse=new GetNextLevelItemInfoResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				var rItem1:PackageItem=CrotaItemConfig.getItemInfoByTempleteId(responseData.nextInfo.mubanid);
				rItem1.id=responseData.nextInfo.itemId;
				comp.s1.data=rItem1;
				comp.lev.text=responseData.nextInfo.qhlevel.toString();
				comp.eff.text=responseData.nextInfo.strEff + ' +' + responseData.nextInfo.effValue;
				comp.req.text=responseData.nextInfo.reqCoin.toString();
				if (SystemDataModel.roleInfo.coin >= responseData.nextInfo.reqCoin)
				{
					comp.sBtn.enabled=true;
				}
				else
				{
					comp.sBtn.enabled=false;
				}
			}
		}

		private function clearInfo():void
		{
//			comp.s1.data=null;
//			comp.lev.text='';
//			comp.eff.text='';
//			comp.req.text='';
//			comp.equipment.selectedIndex=-1;
//			comp.sBtn.enabled=false;
		}

		private function faultHandler(evt:FaultEvent):void
		{

		}
	}
}

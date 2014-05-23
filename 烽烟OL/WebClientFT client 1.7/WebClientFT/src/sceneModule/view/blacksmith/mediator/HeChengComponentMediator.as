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
	
	import proto.blacksmith.blacksmith2115.GetOneItemHechengRequest;
	import proto.blacksmith.blacksmith2115.GetOneItemHechengResponse;
	import proto.blacksmith.blacksmith2116.HeChengRequest;
	import proto.blacksmith.blacksmith2116.HeChengResponse;
	
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.blacksmith.command.BlacksmithMessage;
	import sceneModule.view.blacksmith.view.HeChengComponent;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class HeChengComponentMediator extends Mediator
	{
		[Inject]
		public var comp:HeChengComponent;
		
		[Inject]
		public var socket:ISocketServer;
		public function HeChengComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.ItemList,IndexChangeEvent.CHANGE,onIndexChangeEvent);
			this.eventMap.mapListener(comp.hcBtn,MouseEvent.CLICK,onHeCheng);
			
//			mediatorMap.createMediator(comp.s1);
//			mediatorMap.createMediator(comp.s2);
//			mediatorMap.createMediator(comp.s3);
		}
		
		private function onIndexChangeEvent(evt:IndexChangeEvent):void{
			clearInfo();
			getOneHeChengInfo(comp.ItemList.selectedItem.itemId);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_BUZHEN)]);

		}
		
		private function getOneHeChengInfo(itemId:int):void{
			var oneHCreq:GetOneItemHechengRequest = new GetOneItemHechengRequest();
			oneHCreq.id = SystemDataModel.roleId;
			oneHCreq.itemId = itemId;
			var byteArray:ByteArray = new ByteArray();
			oneHCreq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(hcHandler,faultHandler),URLConst.BLACKSMITH_HECHENG_ONE_COMMANDID,byteArray);
		}
		
		private function hcHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetOneItemHechengResponse = new GetOneItemHechengResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				comp.reqLab.text = responseData.data.coinrequired.toString();
				var rItem1:PackageItem  = CrotaItemConfig.getItemInfoByTempleteId(responseData.data.itemA);
				rItem1.templateId = responseData.data.itemA;
				rItem1.stack = responseData.data.itemAGoal;
				comp.s1.iLabel.text = responseData.data.itemAcnt+'/'+responseData.data.itemAGoal;
				var rItem2:PackageItem  = CrotaItemConfig.getItemInfoByTempleteId(responseData.data.itemB);
				rItem2.templateId = responseData.data.itemB;
				rItem2.stack = responseData.data.itemBGoal;
				comp.s2.iLabel.text = responseData.data.itemBcnt+'/'+responseData.data.itemBGoal;
				var rItem3:PackageItem  = CrotaItemConfig.getItemInfoByTempleteId(responseData.data.itemBound);
				rItem3.templateId = responseData.data.itemBound;
				comp.s1.data = rItem1;
				comp.s2.data = rItem2;
				comp.s3.data = rItem3;
				if(responseData.data.itemAcnt>=responseData.data.itemAGoal && responseData.data.itemBcnt >= responseData.data.itemBGoal){
					comp.hcBtn.enabled = true;
				}else{
					comp.hcBtn.enabled = false;
				}
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onHeCheng(evt:MouseEvent):void{
			var hcReq:HeChengRequest = new HeChengRequest();
			hcReq.id = SystemDataModel.roleId;
			hcReq.itemId = comp.s3.data.templateId;
			var byteArray:ByteArray = new ByteArray();
			hcReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(hc_Handler,faultHandler),URLConst.BLACKSMITH_HECHENG_COMMANDID,byteArray);
//			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_LIKE_BUZHEN)]);

		}
		private function hc_Handler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var response:HeChengResponse = new HeChengResponse();
			response.readExternal(byteArray);
			if(response.result){
				BlacksmithMessage.getInstance().getAllHeChengInfo();
				comp.ItemList.selectedIndex = -1;
				clearInfo();
//				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','hcCM_hhcg')+"！");
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_LIKE_BUZHEN)]);

			}
		}
		
		private function clearInfo():void{
			comp.s1.data = null;
			comp.s2.data = null;
			comp.s3.data = null;
			comp.hcBtn.enabled = false;
			comp.reqLab.text = '';
			comp.s1.iLabel.text = '';
			comp.s2.iLabel.text = '';
		}
	}
}
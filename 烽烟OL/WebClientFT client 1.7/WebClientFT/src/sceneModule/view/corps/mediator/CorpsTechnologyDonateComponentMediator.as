package sceneModule.view.corps.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1314.GetCorpsTechnologyListInfoRequest;
	import proto.corps.corps1315.CorpsTechnologyDonateRequest;
	import proto.corps.corps1315.CorpsTechnologyDonateResponse;
	
	import sceneModule.view.corps.event.GetCorpsTechnologyListInfoResponseEvent;
	import sceneModule.view.corps.view.CorpsTechnologyDonateComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class CorpsTechnologyDonateComponentMediator extends Mediator
	{
		[Inject]
		public var comp:CorpsTechnologyDonateComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function CorpsTechnologyDonateComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.preBtn,MouseEvent.CLICK,onPreNum);
			this.eventMap.mapListener(comp.nextBtn,MouseEvent.CLICK,onNextNum);
			this.eventMap.mapListener(comp.maxNumBtn,MouseEvent.CLICK,onMaxNum);
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onSubmitDonate);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCancel);
		}
		/**
		 * 最大数量
		 */
		private function onMaxNum(evt:MouseEvent):void{
			comp.numTxt.text = SystemDataModel.roleInfo.gold.toString();
		}
		/**
		 * 魔币数量减少100
		 */
		private function onPreNum(evt:MouseEvent):void{
			var goldNum:int = int(comp.numTxt.text) - 100;
			if(goldNum > SystemDataModel.roleInfo.gold){
				goldNum = SystemDataModel.roleInfo.gold;
			}
			comp.numTxt.text = goldNum.toString();
		}
		/**
		 * 魔币数量增加100
		 */
		private function onNextNum(evt:MouseEvent):void{
			var goldNum:int = int(comp.numTxt.text) + 100;
			if(goldNum > SystemDataModel.roleInfo.gold){
				goldNum = SystemDataModel.roleInfo.gold;
			}
			comp.numTxt.text = goldNum.toString();
		}
		/**
		 * 捐献魔币
		 */
		private function onSubmitDonate(evt:MouseEvent):void{
			var donateRequest:CorpsTechnologyDonateRequest = new CorpsTechnologyDonateRequest();
			donateRequest.id = SystemDataModel.roleId;
			donateRequest.donateNum = int(comp.numTxt.text);
			donateRequest.technologyId = comp.data.technologyId;
			var byteArray:ByteArray = new ByteArray();
			donateRequest.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(donateHandler,faultHandler),URLConst.CORPS_DONATEGOLD_COMMANDID,byteArray);
			onCloseWindowRemoveListener();
		}
		private function donateHandler(data:Object):void{
			var resByteArray:ByteArray = data as ByteArray;
			var responseData:CorpsTechnologyDonateResponse = new CorpsTechnologyDonateResponse();
			responseData.readExternal(resByteArray);
			if(responseData.result){
				getCorpsTechnologyInfo();
			}else{
				popUpShow.show(responseData.message);
			}
		}
		/**
		 * 军团科技
		 */
		private function getCorpsTechnologyInfo():void{
			var getTechnologyReq:GetCorpsTechnologyListInfoRequest = new GetCorpsTechnologyListInfoRequest();
			getTechnologyReq.id = SystemDataModel.roleId;
			getTechnologyReq.curPage = 1;
			var technologyByteArray:ByteArray = new ByteArray();
			getTechnologyReq.writeExternal(technologyByteArray);
			socketService.send(new mx.rpc.Responder(technologyHandler,faultHandler),URLConst.CORPS_TECHNOLOGYLIST_COMMANDID,technologyByteArray);
		}
		private function technologyHandler(data:Object):void{
			this.dispatch(new GetCorpsTechnologyListInfoResponseEvent(GetCorpsTechnologyListInfoResponseEvent.GETCORPSTECHNOLOGYLISTINFORESPONSE,data));
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
		/**
		 * 取消
		 */
		private function onCancel(evt:MouseEvent):void{
			onCloseWindowRemoveListener();
		}
		/**
		 * 关闭窗口
		 */
		private function onCloseWindowRemoveListener():void{
			WindowManager.closeWindow(CorpsTechnologyDonateComponent.NAME,false,false,null,popUpWindowLayer);
			this.eventMap.unmapListener(comp.preBtn,MouseEvent.CLICK,onPreNum);
			this.eventMap.unmapListener(comp.nextBtn,MouseEvent.CLICK,onNextNum);
			this.eventMap.unmapListener(comp.maxNumBtn,MouseEvent.CLICK,onMaxNum);
			this.eventMap.unmapListener(comp.submitBtn,MouseEvent.CLICK,onSubmitDonate);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
	}
}
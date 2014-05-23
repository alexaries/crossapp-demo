package sceneModule.view.tavern.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import managers.WindowManager;
	import model.SystemDataModel;
	import model.URLConst;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import org.robotlegs.mvcs.Mediator;
	import proto.tavern.tavern3503.GetTavernListInfoRequest;
	import sceneModule.view.tavern.event.XingYunWOWEvent;
	import sceneModule.view.tavern.event.XingYunWOWItemRenderEvent;
	import sceneModule.view.tavern.view.WOWXingYunTavernComponent;
	
	import service.ISocketServer;

	/**
	 *
	 *
	 */
	public class WOWXingYunTavernComponentMediator extends Mediator
	{
		[Inject]
		public var comp:WOWXingYunTavernComponent;

		[Inject]
		public var socketService:ISocketServer;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		public function WOWXingYunTavernComponentMediator()
		{
			super();
		}

		override public function preRegister():void
		{
			getXingYun();
			this.eventMap.mapListener(comp.closeBtn, MouseEvent.CLICK, onCloseWindow);
			this.eventMap.mapListener(comp,XingYunWOWItemRenderEvent.XINGYUNWOWINFOITEMRENDER_EVENT,onXingYunComp);
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK, onPrePageData);
			this.eventMap.mapListener(comp.next_btn, MouseEvent.CLICK, onNextPageData);
		}
	
		private function onXingYunComp(evt:XingYunWOWItemRenderEvent):void
		{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onPrePageData(evt:MouseEvent):void
		{
			getXingYun(SystemDataModel.xingYunTravernInfo.page - 1);
		}
		
		private function onNextPageData(evt:MouseEvent):void
		{
			getXingYun(SystemDataModel.xingYunTravernInfo.page + 1);
		}
		
		//幸运值兑换宠物页面
		private function getXingYun(page:int=1):void
		{
			
			var get3503Req:GetTavernListInfoRequest=new GetTavernListInfoRequest();
			get3503Req.id=SystemDataModel.roleId;
			get3503Req.npcId=10001;
			get3503Req.page=page;
//			if(page>=1)
//			{
//				comp.data=null;
//			}
			var byteArray:ByteArray=new ByteArray();
			get3503Req.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(luckExchangeHandler, faultHandler), URLConst.LUCKEXCHANGE_COMMANDID, byteArray);
		}
		
		private function luckExchangeHandler(data:Object):void
		{
			dispatch(new XingYunWOWEvent(XingYunWOWEvent.XINGYUNWOWINFO_EVENT, data));
		}
		
		private function faultHandler(evt:FaultEvent):void
		{
			
		}
		
		
		private function onCloseWindow(evt:MouseEvent):void
		{
			this.eventMap.unmapListener(comp.pre_btn,MouseEvent.CLICK, onPrePageData);
			this.eventMap.unmapListener(comp.next_btn, MouseEvent.CLICK, onNextPageData);
			WindowManager.closeWindow(WOWXingYunTavernComponent.NAME, false, false,WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer);
		}
		
		
	}
}

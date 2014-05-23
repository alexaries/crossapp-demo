package sceneModule.view.zhanxing.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import managers.WindowManager;
	import model.SystemDataModel;
	import model.URLConst;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import org.robotlegs.mvcs.Mediator;
	import proto.zhanxing.jifenginfo3609.GetJiFengListInfoRequest;
	import sceneModule.view.zhanxing.command.GetJiFengInfoCommand;
	import sceneModule.view.zhanxing.event.JiFengEvent;
	import sceneModule.view.zhanxing.event.JiFengItemRenderEvent;
	import sceneModule.view.zhanxing.view.JiFengExchangeComponent;
	import service.ISocketServer;

	public class JiFengExchangeComponentMediator extends Mediator
	{

		[Inject]
		public var comp:JiFengExchangeComponent;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socketServer:ISocketServer;

		public function JiFengExchangeComponentMediator()
		{
			super();
		}

		override public function preRegister():void
		{
			getJiFengExcInfo();
			this.eventMap.mapListener(comp.closeBtn, MouseEvent.CLICK, onCloseWindow);
			this.eventMap.mapListener(comp,JiFengItemRenderEvent.JIFENG_EVENT,onJiFengExcItemRenderComp);
			this.eventMap.mapListener(comp,JiFengItemRenderEvent.JIFENGITEMRENDER_EVENT,onJiFengExcItemRenderComp);
			this.eventMap.mapListener(comp.pre_btn, MouseEvent.CLICK, onPrePageData);
			this.eventMap.mapListener(comp.next_btn, MouseEvent.CLICK, onNextPageData);
		}

		private function onPrePageData(evt:MouseEvent):void
		{
			getJiFengExcInfo(SystemDataModel.jifengInfo.curpage - 1);
		}
		
		private function onNextPageData(evt:MouseEvent):void
		{
			getJiFengExcInfo(SystemDataModel.jifengInfo.curpage + 1);
		}
		
		private function faultHandler(evt:FaultEvent):void
		{

		}
		
		private function getJiFengExcInfo(page:int=1):void
		{
			var getJiFenReq:GetJiFengListInfoRequest=new GetJiFengListInfoRequest();
			getJiFenReq.id=SystemDataModel.roleId;
			getJiFenReq.nowpage=page;
			var byteArray:ByteArray=new ByteArray();
			getJiFenReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(jiFengHandler, faultHandler), URLConst.JIFENGEXCHANGE_COMMANDID, byteArray);
		}
		
		private function jiFengHandler(data:Object):void
		{
			dispatch(new JiFengEvent(JiFengEvent.JIFENGINFOCOMP_EVENT, data));
		}
		
		private function onJiFengExcItemRenderComp(evt:JiFengItemRenderEvent):void
		{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void
		{
			this.eventMap.unmapListener(comp,JiFengItemRenderEvent.JIFENG_EVENT,onJiFengExcItemRenderComp);
			this.eventMap.unmapListener(comp,JiFengItemRenderEvent.JIFENGITEMRENDER_EVENT,onJiFengExcItemRenderComp);
			WindowManager.closeWindow(JiFengExchangeComponent.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer, mediatorMap);
		}

	}
}

package sceneModule.view.guanjue.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.guanjue.event.ShengWangEvent;
	import sceneModule.view.guanjue.event.ShengWangItemRenderEvent;
	import sceneModule.view.guanjue.view.ShengWangComponent;
	
	import service.ISocketServer;

	public class ShengWangComponentMediator extends Mediator
	{

		[Inject]
		public var comp:ShengWangComponent;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socketServer:ISocketServer;

		public function ShengWangComponentMediator()
		{
			super();
		}

		override public function preRegister():void
		{
			this.eventMap.mapListener(comp.clokeBtn, MouseEvent.CLICK, onCloseWindow);
			
			this.eventMap.mapListener(comp,ShengWangItemRenderEvent.SHNEGWANG_EVENT,onShengWangItemRenderComp);
			this.eventMap.mapListener(comp,ShengWangItemRenderEvent.SHNEGWANGITEMRENDER_EVENT,onShengWangItemRenderComp);
		}

		private function faultHandler(evt:FaultEvent):void
		{

		}

		private function onShengWangItemRenderComp(evt:ShengWangItemRenderEvent):void
		{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void
		{
			WindowManager.closeWindow(ShengWangComponent.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer, mediatorMap);
		}

	}
}

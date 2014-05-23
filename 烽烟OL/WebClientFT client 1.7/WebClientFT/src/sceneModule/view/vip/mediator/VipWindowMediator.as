package sceneModule.view.vip.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.vip.view.VipWindow;

	public class VipWindowMediator extends Mediator
	{
		[Inject]
		public var comp:VipWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function VipWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(VipWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
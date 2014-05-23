package sceneModule.view.ui.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.ui.GuideWindowLayer;

	public class GuideWindowLayerMediator extends Mediator
	{
		[Inject]
		public var comp:GuideWindowLayer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function GuideWindowLayerMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onSubmit);
		}
		
		private function onSubmit(evt:MouseEvent):void{
			this.eventMap.unmapListener(comp.submitBtn,MouseEvent.CLICK,onSubmit);
			WindowManager.closeWindow(GuideWindowLayer.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
package sceneModule.view.pet.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.pet.view.MainPetViewInfoComponent;

	public class MainPetViewInfoComponentMediator extends Mediator
	{
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var comp:MainPetViewInfoComponent;
		
		public function MainPetViewInfoComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(MainPetViewInfoComponent.NAME,false,false,WindowManager.CACHE_POLICY_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
package sceneModule.view.group.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.group.view.CreateOrJoinWindow;

	public class CreateOrJoinWindowMediator extends Mediator
	{
		[Inject]
		public var comp:CreateOrJoinWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function CreateOrJoinWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(CreateOrJoinWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
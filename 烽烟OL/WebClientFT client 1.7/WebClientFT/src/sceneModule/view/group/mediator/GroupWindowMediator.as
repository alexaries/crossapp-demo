package sceneModule.view.group.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.group.command.GroupMessage;
	import sceneModule.view.group.view.CreateOrJoinWindow;
	import sceneModule.view.group.view.GroupWindow;

	public class GroupWindowMediator extends Mediator
	{
		[Inject]
		public var comp:GroupWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function GroupWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			GroupMessage.getInstance().setTimeDuWuList();
			GroupMessage.getInstance().addBattleEventListener();
			this.eventMap.mapListener(comp.hchlBtn,MouseEvent.CLICK,onHcHl);
			this.eventMap.mapListener(comp.djtyBtn,MouseEvent.CLICK,onDjTy);
			this.eventMap.mapListener(comp.hdkjBtn,MouseEvent.CLICK,onHdKj);
		}
		
		private function onHcHl(evt:MouseEvent):void{
			onCreateDuiWu(1);
		}
		
		private function onDjTy(evt:MouseEvent):void{
			onCreateDuiWu(2);
		}
		
		private function onHdKj(evt:MouseEvent):void{
			onCreateDuiWu(3);
		}
		
		private function onCreateDuiWu(dType:int):void{
			GroupMessage.getInstance().onPopUpCreateOrJoinWindow('Create',dType);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(GroupWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
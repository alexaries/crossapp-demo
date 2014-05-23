package sceneModule.view.roleInfo.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.roleInfo.view.MainLookRoleInfoComponent;

	public class MainLookRoleInfoComponentMediator extends Mediator
	{
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer; 
		
		[Inject]
		public var comp:MainLookRoleInfoComponent;
		public function MainLookRoleInfoComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.canBtn,MouseEvent.CLICK,onCloseWindow);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_0);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_1);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_2);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_3);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_4);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_5);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_6);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_7);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_8);
			mediatorMap.createMediator(comp.roleInfoComp.comp_role_style.comp_pos_9);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(MainLookRoleInfoComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer);
		}
	}
}
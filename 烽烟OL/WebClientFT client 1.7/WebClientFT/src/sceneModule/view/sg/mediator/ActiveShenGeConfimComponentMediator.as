package sceneModule.view.sg.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.sg.command.ShenDiMessage;
	import sceneModule.view.sg.view.ActiveShenGeConfimComponent;

	public class ActiveShenGeConfimComponentMediator extends Mediator
	{
		[Inject]
		public var comp:ActiveShenGeConfimComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ActiveShenGeConfimComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.rBtn,MouseEvent.CLICK,onActive);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
		
		private function onActive(evt:MouseEvent):void{
			if(comp.showBox.selected){
				SystemDataModel.activeSGFlag = false;
			}
			ShenDiMessage.getInstance().onActiveShenGe(comp.data.sgID);
			onCancel();
			
		}
		
		private function onCancel(evt:MouseEvent = null):void{
			WindowManager.closeWindow(ActiveShenGeConfimComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
//			WindowManager.closeAllWindows();
		}
	}
}
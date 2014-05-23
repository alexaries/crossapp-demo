package sceneModule.view.blacksmith.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.blacksmith.command.BlacksmithMessage;
	import sceneModule.view.blacksmith.view.XiangQianAndUnloadConfimComponent;
	
	import util.DelayExcuter;

	public class XiangQianAndUnloadConfimComponentMediator extends Mediator
	{
		[Inject]
		public var comp:XiangQianAndUnloadConfimComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function XiangQianAndUnloadConfimComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.rBtn,MouseEvent.CLICK,onXiangQian);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
		
		private function onXiangQian(evt:MouseEvent):void{
			if(comp.data.type == 0){
				BlacksmithMessage.getInstance().xq(comp.data.itemId,comp.data.sId,comp.data.isBodyFlag,comp.data.pos);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.PET_PEIYANG_ACTION)]);
			}else{
				BlacksmithMessage.getInstance().unLoadXq(comp.data.itemId,comp.data.sId,comp.data.isBodyFlag,comp.data.pos);
			}
			
			onCancel();
		}
		
		private function onCancel(evt:MouseEvent = null):void{
			WindowManager.closeWindow(XiangQianAndUnloadConfimComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
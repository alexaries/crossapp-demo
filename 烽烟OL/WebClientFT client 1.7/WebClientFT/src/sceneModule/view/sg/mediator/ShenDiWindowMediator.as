package sceneModule.view.sg.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.sg.command.ShenDiMessage;
	import sceneModule.view.sg.event.MediatorRegisterSGEvent;
	import sceneModule.view.sg.view.ShenDiWindow;
	
	import util.DelayExcuter;

	public class ShenDiWindowMediator extends Mediator
	{
		[Inject]
		public var comp:ShenDiWindow;
		
		[Inject]
		public var popUpWindowlayer:PopUpWindowLayer;
		public function ShenDiWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			ShenDiMessage.getInstance().getShenDiInfo();
			
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePageData);
			this.eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPageData);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			eventMap.mapListener(comp,MediatorRegisterSGEvent.MEDIATORREGISTERSGEVENT,onRegisterItemRenderMediator);
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterSGEvent):void{
			mediatorMap.createMediator(evt._view);
		}
		
		private function onPrePageData(evt:MouseEvent):void{
			ShenDiMessage.getInstance().getShenDiInfo(SystemDataModel.shenDiInfo.curPage - 1);
		}
		
		private function onNextPageData(evt:MouseEvent):void{
			ShenDiMessage.getInstance().getShenDiInfo(SystemDataModel.shenDiInfo.curPage + 1);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(ShenDiWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowlayer,mediatorMap);
		}
	}
}
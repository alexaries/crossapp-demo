package sceneModule.view.colonMan.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.colonMan.command.ColonManMessage;
	import sceneModule.view.colonMan.event.MediatorRegisterColonManItemEuipmentEvent;
	import sceneModule.view.colonMan.view.MainColoPrivilegeWindow;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class MainColoPrivilegeWindowMediator extends Mediator
	{
		[Inject]
		public var comp:MainColoPrivilegeWindow;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function MainColoPrivilegeWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.closeBtnWin,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePageData);
			this.eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPageData);
			this.eventMap.mapListener(comp.ColoList,IndexChangeEvent.CHANGE,onColoListChange);
			comp.addEventListener(MediatorRegisterColonManItemEuipmentEvent.MEDIATORREGISTERCOLOPRIVILEGE,onRegisterMediatorItem);
			
			if(comp.ColoList.selectedItem){
				ColonManMessage.getInstance().getColoFuBenGroupInfo(comp.ColoList.selectedItem.coloId);
			}
		}
		
		private function onRegisterMediatorItem(evt:MediatorRegisterColonManItemEuipmentEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onColoListChange(evt:IndexChangeEvent):void{
			ColonManMessage.getInstance().getColoFuBenGroupInfo(comp.ColoList.selectedItem.coloId);
			
		}
		
		private function onPrePageData(evt:MouseEvent):void{
			ColonManMessage.getInstance().getColoPrivilegeData(SystemDataModel.colonizationPrivilegeInfo.curPage - 1);
		}
		
		private function onNextPageData(evt:MouseEvent):void{
			ColonManMessage.getInstance().getColoPrivilegeData(SystemDataModel.colonizationPrivilegeInfo.curPage + 1);
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			SystemDataModel.curColonizationFuBenInfo.fubenList.removeAll();
			WindowManager.closeWindow(MainColoPrivilegeWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
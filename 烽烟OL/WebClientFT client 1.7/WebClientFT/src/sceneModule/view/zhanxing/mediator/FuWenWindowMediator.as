package sceneModule.view.zhanxing.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.events.CollectionEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.zhanxing.command.ZhanXingMessage;
	import sceneModule.view.zhanxing.event.JiFengItemRenderEvent;
	import sceneModule.view.zhanxing.view.FuWenWindow;
	import sceneModule.view.zhanxing.view.ZhanXingWindow;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class FuWenWindowMediator extends Mediator
	{
		[Inject]
		public var comp:FuWenWindow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function FuWenWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			this.eventMap.mapListener(comp.cBtn,MouseEvent.CLICK,onOpenZX);
			
			this.eventMap.mapListener(comp.hcBtn,MouseEvent.CLICK,onHeCheng);
			
			this.eventMap.mapListener(comp.pList,IndexChangeEvent.CHANGE,onIndexChange);
			
			this.eventMap.mapListener(comp,JiFengItemRenderEvent.BODYORPACKXYITEMRENDEREVENT,onCreateMediator);
			
			SystemDataModel.zhanxingInfo.ropInfoList.addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollection);
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
			tempIndex = comp.pList.selectedIndex;
			SystemDataModel.opeId = comp.pList.selectedItem.rpId;
		}
		private var tempIndex:int = 0;
		private function onCollection(evt:CollectionEvent):void{
			comp.pList.selectedIndex = tempIndex;
			if(comp.body1.data){
				comp.body1.data = comp.pList.selectedItem.xyBody1;
				comp.body2.data = comp.pList.selectedItem.xyBody2;
				comp.body3.data = comp.pList.selectedItem.xyBody3;
				comp.body4.data = comp.pList.selectedItem.xyBody4;
				comp.body5.data = comp.pList.selectedItem.xyBody5;
				comp.body6.data = comp.pList.selectedItem.xyBody6;
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ADD_EQUIP)]);

			}
		}
		
		private function onOpenZX(evt:MouseEvent):void{
			onCloseWindow();
			WindowManager.createWindow(ZhanXingWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		private function onHeCheng(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().YiJianHeCheng();
		}
		
		private function onCreateMediator(evt:JiFengItemRenderEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			WindowManager.closeWindow(FuWenWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
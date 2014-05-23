package sceneModule.view.colonMan.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	
	import sceneModule.view.colonMan.view.MainColoPrivilegeFuBenColoInfoWindow;
	import sceneModule.view.colonMan.view.MainColoPrivilegeFuBenItemRender;
	import sceneModule.view.colonMan.view.MainColoPrivilegeWindow;
	import sceneModule.view.copyScene.view.ColonizationBattleByCopySceneComponent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class MainColoPrivilegeFuBenItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:MainColoPrivilegeFuBenItemRender;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function MainColoPrivilegeFuBenItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp,MouseEvent.CLICK,onColonization);
			
			
		}
		
		private function onColonization(evt:MouseEvent):void{
			WindowManager.closeWindow(MainColoPrivilegeWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
			AssetCenter.getInstance().load_package("ui_coloMan_TeQuan",to_colorMan,null,true);
		}
		
		private function to_colorMan():void{
			var obj:Object = new Object();
			obj.cId = comp.data.fuBenId;
			obj.camp = comp.data._fu_camp;
			WindowManager.createWindow(MainColoPrivilegeFuBenColoInfoWindow.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer, false);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QINLUE)]);
		}
		
		
	}
}
package sceneModule.view.jingji.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	import flash.events.Event;
	import wordscene.event.PlusEvent;
	import wordscene.WordSceneSprite;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.jingji.command.JingJiMessage;
	import sceneModule.view.jingji.view.JingJiComponent;
	import sceneModule.view.jingji.view.JingjiWindow;
	
	import util.DelayExcuter;

	public class JingJiComponentMediator extends Mediator
	{
		[Inject]
		public var comp:JingJiComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function JingJiComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.jjBtn, MouseEvent.CLICK, onOpenJingJiWin);
			WordSceneSprite.getInstance().addEventListener(PlusEvent.PlusEvent_OPEN_JINGJI, onOpenJingJiWin);
		}
		
		private function onOpenJingJiWin(evt:Event):void{
			if(SystemDataModel.isGuaJiFlag){
				WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			}else{
				if(SystemDataModel.roleInfo.level >= 15){
					AssetCenter.getInstance().load_package("ui_jingji",to_jingji,null,true);
				}else{
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('jingji','jjCM_15kq'));
				}
			}
		}
		
		private function to_jingji():void{
			JingJiMessage.getInstance().getJingJiInfo();
			JingJiMessage.getInstance().GetJingJiRankingInfo();
			WindowManager.createWindow(JingjiWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);

		}
	}
}
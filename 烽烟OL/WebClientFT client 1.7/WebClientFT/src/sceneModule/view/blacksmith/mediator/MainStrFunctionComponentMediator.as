package sceneModule.view.blacksmith.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.MediatorRegisterItemEuipmentEvent;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.blacksmith.command.BlacksmithMessage;
	import sceneModule.view.blacksmith.event.ZhuanYiEvent;
	import sceneModule.view.blacksmith.view.MainStrFunctionComponent;
	import sceneModule.view.shop.command.ShopMessage;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class MainStrFunctionComponentMediator extends Mediator
	{
		[Inject]
		public var comp:MainStrFunctionComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function MainStrFunctionComponentMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.funList,IndexChangeEvent.CHANGE,onFunListChange);
			this.eventMap.mapListener(comp.closeWinBtn,MouseEvent.CLICK,onCloseWindow);
			comp.addEventListener(MediatorRegisterItemEuipmentEvent.MEDIATORREGISTERCOMMISSIONITEMEUIPMENT,onRegisterMediatorItem);
			comp.addEventListener(MediatorRegisterItemEuipmentEvent.MEDIATORREGISTERXIANGQIAN,onRegisterMediatorItem);
			comp.addEventListener(MediatorRegisterItemEuipmentEvent.MEDIATORREGISTERHECHENG,onRegisterMediatorItem);
			
			comp.addEventListener(ZhuanYiEvent.SHUXINGZHUANYIEVENT,onRegisterMediatorItemZhuanYi);
			comp.addEventListener(ZhuanYiEvent.SHUXINGZHUANYIRENDEREVENT,onRegisterMediatorItemZhuanYi);
			comp.addEventListener(ZhuanYiEvent.SHUXINGZHUANYIDRAGEVENT,onRegisterMediatorItemZhuanYi);
			
			ShopMessage.getInstance().getStrengthenPackageInfo();
		}
		
		private function onRegisterMediatorItem(evt:MediatorRegisterItemEuipmentEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onRegisterMediatorItemZhuanYi(evt:ZhuanYiEvent):void{
			mediatorMap.createMediator(evt._obj);
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			WindowManager.closeWindow(MainStrFunctionComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		private var curSelIndex:int=0;
		private function onFunListChange(evt:IndexChangeEvent):void{
			switch(comp.funList.selectedIndex){
				case 0:
					ShopMessage.getInstance().getStrengthenPackageInfo();
					break;
				case 1:
					if(SystemDataModel.roleInfo.level<11){
						CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz11'));
						comp.funList.selectedIndex = curSelIndex;
					}else{
						BlacksmithMessage.getInstance().getXQPackInfo();
						BlacksmithMessage.getInstance().getXQStoreInfo();
						new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.XQ_CHOOSEPACK)]);

					}
					
					break;
				case 2:
					if(SystemDataModel.roleInfo.level<21){
						CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz21'));
						comp.funList.selectedIndex = curSelIndex;
					}else{
					BlacksmithMessage.getInstance().getAllHeChengInfo();
					new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.UI_HECHENG)]);
					}
					break;
				case 3:
					if(SystemDataModel.roleInfo.level<30){
						CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','msfCM_djbz30'));
						comp.funList.selectedIndex = curSelIndex;
					}
					break;
			}
			comp.viewStack.selectedIndex = comp.funList.selectedIndex;
			curSelIndex = comp.funList.selectedIndex;
		}
	}
}
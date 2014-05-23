package sceneModule.view.groupBattle.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.groupBattle.command.GroupBattleMessage;
	import sceneModule.view.groupBattle.view.CityListComponent;
	import sceneModule.view.groupBattle.view.GroupCityComponent;
	import sceneModule.view.groupBattle.view.LingDiComponent;
	import sceneModule.view.groupBattle.view.XuYuanComponent;

	public class GroupCityComponentMediator extends Mediator
	{
		[Inject]
		public var comp:GroupCityComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function GroupCityComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.cardtype,Event.CHANGE,onChangeView);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			onChangeView();
			GroupBattleMessage.getInstance().getGroupLingDiInfo();
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			comp.content_layer.removeAllElements();
			WindowManager.closeWindow(GroupCityComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function onChangeView(evt:Event = null):void{
			switch(comp.cardtype.selectedValue){
				case 0:
					GroupBattleMessage.getInstance().getGroupLingDiInfo();
					var ldComp:LingDiComponent = new LingDiComponent();
					comp.content_layer.removeAllElements();
					comp.content_layer.addElement(ldComp);
					break;
				case 1:
					GroupBattleMessage.getInstance().getCityListInfo();
					var clComp:CityListComponent = new CityListComponent();
					comp.content_layer.removeAllElements();
					comp.content_layer.addElement(clComp);
					break;
				case 2:
					GroupBattleMessage.getInstance().getXuYuanInfo();
					var xyComp:XuYuanComponent = new XuYuanComponent();
				    comp.content_layer.removeAllElements();
					comp.content_layer.addElement(xyComp);
					break;
			}
		}
	}
}
package sceneModule.view.GameTopUI.mediator {
	import flash.events.MouseEvent;
	import managers.WindowManager;
	import org.robotlegs.mvcs.Mediator;
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.colonMan.command.ColonManMessage;
	import sceneModule.view.colonMan.view.MainColoManagerWindow;
	import sceneModule.view.GameTopUI.view.GameTopUIItemRender;
	import sceneModule.view.group.view.GroupWindow;
	import sceneModule.view.groupBattle.view.GroupBattleInfoComponent;
	import sceneModule.view.reward.command.RewardMessage;
	import sceneModule.view.reward.view.RewardDayOrGuideWindow;
	import sceneModule.view.reward.view.RewardWindow;
	import service.ISocketServer;
	import util.CommonTools;
	
	public class GameTopUIItemRenderMediator extends Mediator {
		[Inject]
		public var comp:GameTopUIItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function GameTopUIItemRenderMediator() {
			super();
		}
		
		override public function onRegister():void {
			this.eventMap.mapListener(comp, MouseEvent.CLICK, onFunction);
		}
		
		private function onFunction(evt:MouseEvent):void {
			if (!CommonTools.delayClick())
				return;
			if (comp.data.anouType == 1) {
				RewardMessage.getInstance().getRewardList();
				AssetCenter.getInstance().load_package("ui_colo_jiangjin", to_Jiangji, null, true);
			} else if (comp.data.anouType == 2 || comp.data.anouType == 3) {
				ColonManMessage.getInstance().getColoManInfo(1);
				ColonManMessage.getInstance().getCangKuInfo();
				AssetCenter.getInstance().load_package("ui_coloman", to_coloman, null, true);
			} else if (comp.data.anouType == 9) {
				AssetCenter.getInstance().load_package("ui_group", to_group, null, true);
			} else if (comp.data.anouType == 10) {
				WindowManager.createWindow(GroupBattleInfoComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			} else if (comp.data.anouType == 4 || comp.data.anouType == 5 || comp.data.anouType == 8) {
				if (0 < comp.surTime) {
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('GameTopUI', 'gtuIR_lqwd'));
					return;
				}
				AssetCenter.getInstance().load_package("ui_day_reward", to_RewardDay, null, true);
			}
		}
		
		private function to_group():void {
			WindowManager.createWindow(GroupWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		private function to_Jiangji():void {
			WindowManager.createWindow(RewardWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		private function to_coloman():void {
			WindowManager.createWindow(MainColoManagerWindow.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
		
		private function to_RewardDay():void {
			var obj:Object = new Object();
			obj.type = comp.data.anouType;
			WindowManager.createWindow(RewardDayOrGuideWindow.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer);
		}
	
	}
}
package sceneModule.view.jingji.mediator {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import wordscene.event.PlusEvent;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.jingji.command.JingJiMessage;
	import sceneModule.view.jingji.view.JingjiWindow;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.popupWin.PopUpShow;
	
	public class JingjiWindowMediator extends Mediator {
		[Inject]
		public var comp:JingjiWindow;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function JingjiWindowMediator() {
			super();
		}
		
		override public function onRegister():void {
			this.eventMap.mapListener(comp.closeBtn, MouseEvent.CLICK, onCloseWindowHandler);
			this.eventMap.mapListener(comp.addBtn, MouseEvent.CLICK, onAddCount);
			JingJiMessage.getInstance().addEventListener(PlusEvent.PlusEvent_CLOSE_JINGJI, onCloseWindowHandler);
		}
		
		private function onAddCount(evt:MouseEvent):void {
			if (SystemDataModel.roleInfo.roletype <= SystemDataModel.mainJingJiInfoVo.buyTZCount) {
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('jingji', 'jjWM_djbz'), null, null, null, null, null, null, null);
			} else {
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan', 'cmeIRM_sfff') + SystemDataModel.mainJingJiInfoVo.buyReqZuan + CrotaResourceConfig.getInstance().getTextByModuleAndId('jingji', 'jjWM_zjcs'), null, null, null, null, submitHandler, null, null);
			}
		
		}
		
		private function submitHandler(evt:MouseEvent):void {
			JingJiMessage.getInstance().addJingJiCount();
		}
		
		private function onCloseWindowHandler(evt:Event = null):void {
			if (comp.bg) {
				comp.bg.source = null;
				comp.bg = null;
				comp.role_list.dataProvider = new ArrayCollection();
				comp.role_list0.dataProvider = new ArrayCollection();
				comp.role_list = null;
				comp.role_list0 = null;
			}
			SystemDataModel.mainJingJiInfoVo.battleInfoList.source = null;
			WindowManager.closeWindow(JingjiWindow.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer, mediatorMap);
		}
	}
}
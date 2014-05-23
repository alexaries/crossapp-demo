package sceneModule.view.sg.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.sg.command.ShenDiMessage;
	import sceneModule.view.sg.view.ActiveShenGeConfimComponent;
	import sceneModule.view.sg.view.ShenGeItemRender;
	import sceneModule.view.sg.view.ShenGeToolTip;
	import sceneModule.view.sg.vo.ShenGeInfoVO;
	import sceneModule.view.territory.view.TerritoryWindow;
	
	import util.DelayExcuter;

	public class ShenGeItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:ShenGeItemRender;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ShenGeItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp,MouseEvent.CLICK,onActiveShenGe);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private var tooltip:ShenGeToolTip;
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data){
				if(!tooltip){
					tooltip = new ShenGeToolTip();
				}
				//设置ToolTip位置
				setTooltipPosition();
				popUpWindowLayer.addElement(tooltip);
				tooltip.shenGeInfo = comp.data as ShenGeInfoVO;
			}		
		}
		//鼠标移动 设置ToolTip位置
		private function onMouseMove(evt:MouseEvent):void{
			if(tooltip){
				setTooltipPosition();
			}
		}
		/**
		 * 当鼠标移出，设置Tooltip为不可见
		 */
		private function onMouseOut(evt:MouseEvent):void{
			if(tooltip && popUpWindowLayer.contains(tooltip))popUpWindowLayer.removeElement(tooltip);
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			tooltip.y = FlexGlobals.topLevelApplication.mouseY;
			if(1000 - FlexGlobals.topLevelApplication.mouseX - insetPosX < tooltip.width){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX - tooltip.width - 10;
			}else{
				tooltip.x = FlexGlobals.topLevelApplication.mouseX + insetPosX;
			}
		}
		
		private function onActiveShenGe(evt:MouseEvent):void{
			if(!comp.data.activateFlag){
				if(SystemDataModel.activeSGFlag){
					WindowManager.createWindow(ActiveShenGeConfimComponent.NAME,comp.data,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
					new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QUEREN_SHENGGE)]);
				}else{
					ShenDiMessage.getInstance().onActiveShenGe(comp.data.sgID);
				}
			}
		}
		
	}
}
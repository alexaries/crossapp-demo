package sceneModule.view.target.mediator
{
	import flash.events.MouseEvent;
	
	import managers.ToolTipManager;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.target.view.TargetTaskRewardItemRender;

	public class TargetTaskRewardItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:TargetTaskRewardItemRender;
		
		public var tooltip:MainMenuEquipmentTooltip;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function TargetTaskRewardItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data.rewardType !=0 )return;
			if(comp.data && comp.data.itemId !=0){
				if(!tooltip){
					tooltip = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
				}
				var packgeItem:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(comp.data.itemId);//VO
				tooltip.curDataInfo = packgeItem;
				//设置ToolTip位置
				setTooltipPosition();
				popUpWindowLayer.addElement(tooltip);
				
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
	}
}
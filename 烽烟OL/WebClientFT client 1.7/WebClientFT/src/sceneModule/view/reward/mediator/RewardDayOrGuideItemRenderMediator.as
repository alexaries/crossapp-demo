package sceneModule.view.reward.mediator
{
	import flash.events.MouseEvent;
	
	import managers.ToolTipManager;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.reward.view.RewardDayOrGuideItemRender;

	public class RewardDayOrGuideItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:RewardDayOrGuideItemRender;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public var tooltip:MainMenuEquipmentTooltip;
		public var desToolTip:MainSmallDesTooltip;
		public function RewardDayOrGuideItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			eventMap.mapListener(comp.equipImg,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp.equipImg,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp.equipImg,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data){
				if(comp.data.type==0){
					if(!tooltip){
						tooltip = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
					}
					var packgeItem:PackageItem = comp.data.itemsBonus as PackageItem;
					tooltip.curDataInfo = packgeItem;
//					trace('addTooltip..............');
					//设置ToolTip位置
					setTooltipPosition(tooltip);
					popUpWindowLayer.addElement(tooltip);
				}else{
					if(!desToolTip){
						desToolTip=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
					}
					switch(comp.data.type){
						case 1:
							desToolTip.curDes = CrotaResourceConfig.getInstance().getTextByModuleAndId('reward','rdogIR_lqfl')+comp.data.rewardNum+CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjW_jb');
							break;
						case 2:
							desToolTip.curDes = CrotaResourceConfig.getInstance().getTextByModuleAndId('reward','rdogIR_lqfl')+comp.data.rewardNum+CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan');
							break;
						case 3:
							desToolTip.curDes = CrotaResourceConfig.getInstance().getTextByModuleAndId('reward','rdogIR_lqfl')+comp.data.rewardNum+CrotaResourceConfig.getInstance().getTextByModuleAndId('reward','rdogIR_tl');
							break;
					}
					setTooltipPosition(desToolTip);
					popUpWindowLayer.addElement(desToolTip);
				}
			}		
		}
		//鼠标移动 设置ToolTip位置
		private function onMouseMove(evt:MouseEvent):void{
			if(comp.data.type == 0){
				if(tooltip){
					setTooltipPosition(tooltip);
				}
			}else{
				if(desToolTip){
					setTooltipPosition(desToolTip);
				}
			}
			
		}
		/**
		 * 当鼠标移出，设置Tooltip为不可见
		 */
		private function onMouseOut(evt:MouseEvent):void{
			if(comp.data.type == 0){
				if(tooltip && popUpWindowLayer.contains(tooltip))popUpWindowLayer.removeElement(tooltip);
			}else{
				if(desToolTip && popUpWindowLayer.contains(desToolTip))popUpWindowLayer.removeElement(desToolTip);
			}
			
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition(tips:IVisualElement):void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			tips.y = FlexGlobals.topLevelApplication.mouseY;
			if(1000 - FlexGlobals.topLevelApplication.mouseX - insetPosX < tips.width){
				tips.x = FlexGlobals.topLevelApplication.mouseX - tips.width - 10;
			}else{
				tips.x = FlexGlobals.topLevelApplication.mouseX + insetPosX;
			}
		}
	}
}
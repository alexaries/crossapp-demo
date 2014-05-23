package sceneModule.view.battle.mediator
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.battle.view.BattleSuccessSettlementItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;

	public class BattleSuccessSettlementItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:BattleSuccessSettlementItemRender;
		
		[Inject]
		public var tooltip:MainMenuEquipmentTooltip;
		public function BattleSuccessSettlementItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.equipImg,MouseEvent.MOUSE_MOVE,onMouseMove);
			this.eventMap.mapListener(comp.equipImg,MouseEvent.MOUSE_OVER,onMouseOver);
			this.eventMap.mapListener(comp.equipImg,MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		private function init_view():void{
			comp.suc_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_battle_suc", "suc_img");
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			if(tooltip.visible){
				setTooltipPosition();
			}
		}
		
		private function onMouseOver(evt:MouseEvent):void{
			if(!tooltip.visible && comp.data){
				var packgeItem:PackageItem = comp.data.itemsBonus as PackageItem;
				tooltip.curDataInfo = packgeItem;
				tooltip.visible = true;
				//设置ToolTip位置
				setTooltipPosition();
			}
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			
			if(FlexGlobals.topLevelApplication.mouseY + tooltip.height > 570){
				tooltip.y = 570 - tooltip.height;
			}else{
				tooltip.y = FlexGlobals.topLevelApplication.mouseY;
			}
			if(1000 - FlexGlobals.topLevelApplication.mouseX - insetPosX < tooltip.width){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX - tooltip.width - 10;
			}else{
				tooltip.x = FlexGlobals.topLevelApplication.mouseX + insetPosX;
			}
		}
		
		/**
		 * 当鼠标移出，设置Tooltip为不可见
		 */
		private function onMouseOut(evt:MouseEvent):void{
			if(tooltip.visible)tooltip.visible=false;
		}
	}
}
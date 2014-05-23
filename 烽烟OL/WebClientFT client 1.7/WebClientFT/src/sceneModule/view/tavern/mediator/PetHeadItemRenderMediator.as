package sceneModule.view.tavern.mediator
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.tavern.tavern3500.Schedule;
	
	import sceneModule.view.tavern.view.PetHeadItemRender;
	import sceneModule.view.tavern.view.WOWToolTip;
	
	import service.ISocketServer;

	/**
	 *
	 */
	public class PetHeadItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:PetHeadItemRender;

		[Inject]
		public var socketService:ISocketServer;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function PetHeadItemRenderMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			eventMap.mapListener(comp.petImg,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp.petImg,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp.petImg,MouseEvent.MOUSE_MOVE,onMouseMove);
		}

		/**
		 * 如果有数据则显示Tooltip
		 */
		private var tooltip:WOWToolTip;
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data){
				if(!tooltip){
					tooltip = new WOWToolTip();
				}
				//设置ToolTip位置
				setTooltipPosition();
				popUpWindowLayer.addElement(tooltip);
				tooltip.putWowInfo = comp.data as Schedule;
				
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
			if(tooltip && popUpWindowLayer.contains(tooltip))
				popUpWindowLayer.removeElement(tooltip);
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			tooltip.y = FlexGlobals.topLevelApplication.mouseY-50;
			if(1000 - FlexGlobals.topLevelApplication.mouseX - insetPosX < tooltip.width){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX - tooltip.width - 10;
			}else{
				tooltip.x = FlexGlobals.topLevelApplication.mouseX + insetPosX;
			}
		}
		
	}
}

package sceneModule.view.zhanxing.mediator
{
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.zhanxing.view.XingYunItemRender;
	import sceneModule.view.zhanxing.view.XingYunToolTip;
	import sceneModule.view.zhanxing.vo.XingYunBasicInfoVO;

	public class XingYunItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:XingYunItemRender;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function XingYunItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			eventMap.mapListener(comp.img,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp.img,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp.img,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private var tooltip:XingYunToolTip;
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data){
				if(!tooltip){
					tooltip = new XingYunToolTip();
				}
				//设置ToolTip位置
				setTooltipPosition();
				popUpWindowLayer.addElement(tooltip);
				tooltip.putXingYunInfo = comp.data as XingYunBasicInfoVO;
				
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
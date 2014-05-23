package sceneModule.view.blacksmith.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import managers.ToolTipManager;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.blacksmith.view.XiangQianItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;

	public class XiangQianItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:XiangQianItemRender;
		private var intervalID:Number = 0 ;
		private var timeOffset:Number = 300 ;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public var tooltip:MainMenuEquipmentTooltip;
		public function XiangQianItemRenderMediator()
		{
			super();
		}
		override public function onRegister():void{
//			eventMap.mapListener(comp,MouseEvent.CLICK,onDoClick);
//			eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			
			comp.mouseChildren = false;
			
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
				
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data && comp.data.id !=0){
				if(!tooltip){
					tooltip = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
				}
				var packgeItem:PackageItem = comp.data as PackageItem;
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
		
		//鼠标事件类型
		private var mouseClickStrFlag:String;
		private var evtClick:MouseEvent;
		//MouseDown
		private function onMouseDown(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
			evtClick = evt;
			clearInterval(intervalID);
			
			intervalID = setInterval(doClick,timeOffset);
		}
		//MouseClick
		private function onDoClick(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
			
		}
		private function doClick():void{
			
			clearInterval(intervalID);
			if(mouseClickStrFlag =="click"){
				
			}else if(mouseClickStrFlag == "mouseDown"){
				//鼠标按下，执行拖拽操作
				comp.onClick(evtClick);
			}
		}
	}
}
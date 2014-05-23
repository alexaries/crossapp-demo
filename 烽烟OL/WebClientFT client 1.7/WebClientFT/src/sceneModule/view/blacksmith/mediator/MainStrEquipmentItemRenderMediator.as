package sceneModule.view.blacksmith.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import managers.ToolTipManager;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.blacksmith.event.BlacksmithDoubleClickInPackEvent;
	import sceneModule.view.blacksmith.view.MainStrEquipmentItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	
	import service.ISocketServer;

	public class MainStrEquipmentItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:MainStrEquipmentItemRender;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public var tooltip:MainMenuEquipmentTooltip;
		
		private var intervalID:Number = 0 ;
		private var timeOffset:Number = 300 ;
		public function MainStrEquipmentItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			comp.doubleClickEnabled = true;
			comp.mouseChildren = false;
			comp.buttonMode = true;
			comp.useHandCursor = true;
//			eventMap.mapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
//			eventMap.mapListener(comp,MouseEvent.CLICK,onDoClick);
//			eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private function onMouseOver(evt:MouseEvent):void{
			comp.borderOverEffectImg.visible = true;
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
			comp.borderOverEffectImg.visible = false;
			if(tooltip && popUpWindowLayer.contains(tooltip))popUpWindowLayer.removeElement(tooltip);
			
			//			comp.filters=[];
			//			comp.borderOverEffectImg.visible = false;
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
//		private var mouseClickStrFlag:String;
//		private var evtClick:MouseEvent;
//		//MouseDown
//		private function onMouseDown(evt:MouseEvent):void{
//			mouseClickStrFlag = evt.type.toString();
//			evtClick = evt;
//			clearInterval(intervalID);
//			
//			intervalID = setInterval(doClick,timeOffset);
//		}
		//MouseClick
//		private function onDoClick(evt:MouseEvent):void{
//			mouseClickStrFlag = evt.type.toString();
//			
//		}
		//MouseDoubleClick
//		private function onDoubleClick(evt:MouseEvent):void{
//			mouseClickStrFlag = evt.type.toString();
//		}
		
//		private function doClick():void{
//			
//			clearInterval(intervalID);
//			if(mouseClickStrFlag == "doubleClick"){
//				//执行鼠标双击事件
//				//强化
//				this.dispatch(new BlacksmithDoubleClickInPackEvent(BlacksmithDoubleClickInPackEvent.BLACKSMITHDOUBLECLICKINPACK,comp.data.id,comp.data.position,comp.data.isBodyFlag,comp.data.templateId));
//			}else if(mouseClickStrFlag =="click"){
//			}else if(mouseClickStrFlag == "mouseDown"){
//			}
//		}
	}
}
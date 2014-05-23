package sceneModule.view.role.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import managers.ToolTipManager;
	
	import model.SystemDataModel;
	
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.pack.view.MainMenuEquipmentItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.role.view.MainRoleEquipmentItemRender;

	public class NMainRoleEquipmentItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:MainRoleEquipmentItemRender;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public var tooltip:MainMenuEquipmentTooltip;
		public function NMainRoleEquipmentItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			comp.doubleClickEnabled = true;
			comp.mouseChildren = false;
			eventMap.mapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
			eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			this.eventMap.mapListener(comp,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		override public function onRemove():void{
			eventMap.unmapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
			eventMap.unmapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			this.eventMap.unmapListener(comp,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.unmapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			
			eventMap.unmapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.unmapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.unmapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
			comp.equipImg.source = null;
			comp.borderOverEffectImg.source = null;
		}
		//MouseDown
		//鼠标事件类型
		private var mouseClickStrFlag:String;
		private var evtClick:MouseEvent;
		private var intervalID:Number = 0 ;
		private var timeOffset:Number = 300 ;
		private function onMouseDown(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
			evtClick = evt;
			clearInterval(intervalID);
			
			intervalID = setInterval(doClick,timeOffset);
		}
		//MouseDoubleClick
		private function onDoubleClick(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
		}
		
		private function doClick():void{
			
			clearInterval(intervalID);
			if(mouseClickStrFlag == "doubleClick"){
				//执行鼠标双击事件
				SceneModuleCommonMessage.getInstance().unEquipEquipment(comp.rolePos,-1,SystemDataModel.packageinfoVo.curPage);
			}else if(mouseClickStrFlag == "mouseDown"){
				//鼠标按下，执行拖拽操作
				comp.onClick(evtClick);
			}
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
				popUpWindowLayer.addElement(tooltip);
				//设置ToolTip位置
				setTooltipPosition();
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
			comp.filters=[];
			comp.borderOverEffectImg.visible = false;
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			tooltip.y = FlexGlobals.topLevelApplication.mouseY;
			if(FlexGlobals.topLevelApplication.mouseY + tooltip.height > 650){
				tooltip.y = 650 - tooltip.height;
			}else{
				tooltip.y = FlexGlobals.topLevelApplication.mouseY;
			}
			if(1000 - FlexGlobals.topLevelApplication.mouseX - insetPosX < tooltip.width){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX - tooltip.width - 10;
			}else{
				tooltip.x = FlexGlobals.topLevelApplication.mouseX + insetPosX;
			}
		}
		
		private function onDragEnter(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(MainMenuEquipmentItemRender.FROMPACKAGE)){
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}
		}
		
		private function onDragDrop(evt:DragEvent):void{
			var dragData:Object = evt.dragSource.dataForFormat(MainMenuEquipmentItemRender.FROMPACKAGE);
			if(dragData && comp.rolePos != -1 && dragData !=-1){
				//穿装备
				SceneModuleCommonMessage.getInstance().onEquipEquipment(dragData.position,comp.rolePos);
			}
		}
	}
}
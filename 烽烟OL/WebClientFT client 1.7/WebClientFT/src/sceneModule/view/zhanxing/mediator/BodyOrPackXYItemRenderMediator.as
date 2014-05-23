package sceneModule.view.zhanxing.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.zhanxing.command.ZhanXingMessage;
	import sceneModule.view.zhanxing.view.BodyOrPackXYItemRender;
	import sceneModule.view.zhanxing.view.HeChengXYConfimComponent;
	import sceneModule.view.zhanxing.view.XingYunToolTip;
	import sceneModule.view.zhanxing.vo.XingYunBasicInfoVO;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;

	public class BodyOrPackXYItemRenderMediator extends Mediator
	{
		
		[Inject]
		public var comp:BodyOrPackXYItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function BodyOrPackXYItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			comp.mouseChildren = false;
			comp.xyImg.mouseEnabled = false;
			eventMap.mapListener(comp,MouseEvent.DOUBLE_CLICK,onDoubleClick);
			eventMap.mapListener(comp,MouseEvent.CLICK,onDoClick);
			eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onMouseDown);
			eventMap.mapListener(comp,DragEvent.DRAG_ENTER,onDragEnter);
			eventMap.mapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		/**
		 * 如果有数据则显示Tooltip
		 */
		private var tooltip:XingYunToolTip;
		private function onMouseOver(evt:MouseEvent):void{
			if(comp.data.xyId != 0){
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
		
		//鼠标事件类型
		private var mouseClickStrFlag:String;
		private var evtClick:MouseEvent;
		private var intervalID:Number = 0 ;
		private var timeOffset:Number = 300 ;
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
		//MouseDoubleClick
		private function onDoubleClick(evt:MouseEvent):void{
			mouseClickStrFlag = evt.type.toString();
		}
		
		private function doClick():void{
			
			clearInterval(intervalID);
			if(mouseClickStrFlag == "doubleClick"){
				//执行鼠标双击事件
			}else if(mouseClickStrFlag =="click"){
				//鼠标单击事件 如果有物品数据则显示Menu菜单，如果个子为开放则弹出开启个子提示框
			}else if(mouseClickStrFlag == "mouseDown"){
				//鼠标按下，执行拖拽操作
				onStartDrag(evtClick);
			}
		}
		
		private function onStartDrag(evt:MouseEvent):void{
			if(comp.data && comp.data.xyId){
				var iu:IUIComponent=evt.target as IUIComponent;
				var ds:DragSource=new DragSource();
				if(comp._bodyPos == 0){
					ds.addData(comp, BodyOrPackXYItemRender.XINGYUNFROMPACK);
				}else{
					ds.addData(comp, BodyOrPackXYItemRender.XINGYUNFROMBODY);
				}
				
				//当前装备的部位用于左侧装备栏的效果
				var dragProxy:Image = new Image();
				dragProxy.width = 55;
				dragProxy.height = 55;
				dragProxy.source = comp.xyImg.source;
				dragProxy.mouseChildren =false;
				dragProxy.mouseEnabled = false;
				DragManager.doDrag(iu, ds, evt,dragProxy); // 开始拖动这个物体
			}
		}
		private var dragType:String;
		private function onDragEnter(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(BodyOrPackXYItemRender.XINGYUNFROMPACK)){
				dragType = BodyOrPackXYItemRender.XINGYUNFROMPACK;
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}else if(evt.dragSource.hasFormat(BodyOrPackXYItemRender.XINGYUNFROMBODY)){
				dragType = BodyOrPackXYItemRender.XINGYUNFROMBODY;
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}
		}
		
		private function onShowConfimWindow(type:int,fPos:int,tPos:int,des:String='',id:int=0):void{
			var obj:Object = new Object();
			obj.des = des;
			obj.type = type;
			obj.fPos = fPos;
			obj.tPos = tPos;
			obj.id = id;
			WindowManager.createWindow(HeChengXYConfimComponent.NAME,obj,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		private function getTunShiInfo(obj1:Object,obj2:Object):String{
		    var tsInfo:String='';
			if(obj1.quality > obj2.quality){
				tsInfo = '<font color="'+CommonTools.get_equipement_color_html(obj1.quality)+'">['+obj1.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jts')+'<font color="'+CommonTools.get_equipement_color_html(obj2.quality)+'">['+obj2.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jhd')+getTunShiJingYan(obj2.quality,obj2.level,obj2.exp)+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy');
			}else if(obj1.quality == obj2.quality){
				if(obj1.level>obj2.level){
					tsInfo = '<font color="'+CommonTools.get_equipement_color_html(obj1.quality)+'">['+obj1.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jts')+'<font color="'+CommonTools.get_equipement_color_html(obj2.quality)+'">['+obj2.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jhd')+getTunShiJingYan(obj2.quality,obj2.level,obj2.exp)+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy');
				}else{
					tsInfo = '<font color="'+CommonTools.get_equipement_color_html(obj2.quality)+'">['+obj2.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jts')+'<font color="'+CommonTools.get_equipement_color_html(obj1.quality)+'">['+obj1.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jhd')+getTunShiJingYan(obj1.quality,obj1.level,obj1.exp)+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy');
				}
			}else{
				tsInfo = '<font color="'+CommonTools.get_equipement_color_html(obj2.quality)+'">['+obj2.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jts')+'<font color="'+CommonTools.get_equipement_color_html(obj1.quality)+'">['+obj1.xyName+']</font>'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','bpxyIR_jhd')+getTunShiJingYan(obj1.quality,obj1.level,obj1.exp)+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy');
			}
			return tsInfo;
		}
		
		private function getTunShiJingYan(qual:int,lev:int,exp:int):int{
			var maxExp:int=0;
//			trace('qual'+qual+'lev'+lev+'exp'+exp);
			for(var i:int=1;i<lev;i++){
				maxExp += qual*120*i;
			}
//			trace(maxExp);
			maxExp += exp+(qual*30);
			return maxExp;
		}
		
		private function onDragDrop(evt:DragEvent):void{
			if(dragType == BodyOrPackXYItemRender.XINGYUNFROMPACK){
				var obj:Object = evt.dragSource.dataForFormat(BodyOrPackXYItemRender.XINGYUNFROMPACK);
				if(obj){
					if(obj.data.xyId == comp.data.xyId)return;
					if(comp._bodyPos == 0){
						if(comp.data.xyId != 0){
							//在背包中互相吞噬
							onShowConfimWindow(3,obj.data.position,comp.data.position,getTunShiInfo(obj.data,comp.data));
						}else{
							//在背包中移动
							ZhanXingMessage.getInstance().OpeXingYun(3,obj.data.position,comp.data.position,comp._roleOrPetId);
						}
					}else{
						if(comp.data){
							if(comp.data.xyId != 0){
								//从背包拖到身上吞噬
								onShowConfimWindow(1,obj.data.position,comp._bodyPos,getTunShiInfo(obj.data,comp.data),comp._roleOrPetId);
							}else{
								//从背包拖到身上装载
								//在背包中移动
								ZhanXingMessage.getInstance().OpeXingYun(1,obj.data.position,comp._bodyPos,comp._roleOrPetId);
								new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ADD_EQUIP)]);
							}
						}
					}
				}
			}else if(dragType == BodyOrPackXYItemRender.XINGYUNFROMBODY){
				var obj1:Object = evt.dragSource.dataForFormat(BodyOrPackXYItemRender.XINGYUNFROMBODY);
				if(obj1){
					if(obj1.data.xyId == comp.data.xyId)return;
					if(comp._bodyPos == 0){
						if(comp.data.xyId != 0){
							//从角色身上拖到背包吞噬
							onShowConfimWindow(0,obj1.data.position,comp.data.position,getTunShiInfo(obj1.data,comp.data),obj1._bodyPos);
						}else{
							//从角色身上拖到背包
							ZhanXingMessage.getInstance().OpeXingYun(0,obj1._bodyPos,comp.data.position,SystemDataModel.opeId);
						}
					}else{
						if(comp.data.xyId != 0){
							//从身上
							onShowConfimWindow(2,obj1._bodyPos,comp._bodyPos,getTunShiInfo(obj1.data,comp.data),comp._roleOrPetId);
						}else{
							//从背包拖到身上装载
							ZhanXingMessage.getInstance().OpeXingYun(2,obj1._bodyPos,comp._bodyPos,SystemDataModel.opeId);
						}
					}
				}
			}
			
		}
	}
}
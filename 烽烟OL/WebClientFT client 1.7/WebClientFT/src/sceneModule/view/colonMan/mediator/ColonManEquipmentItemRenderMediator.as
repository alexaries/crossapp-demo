package sceneModule.view.colonMan.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.ToolTipManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.reward.reward2408.ObtainItemRequest;
	import proto.reward.reward2408.ObtainItemResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.colonMan.command.ColonManMessage;
	import sceneModule.view.colonMan.view.ColonManEquipmentItemRender;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class ColonManEquipmentItemRenderMediator extends Mediator
	{
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var comp:ColonManEquipmentItemRender;
		
		public var tooltip:MainMenuEquipmentTooltip;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function ColonManEquipmentItemRenderMediator()
		{
			super();
		}
		override public function onRegister():void{
			eventMap.mapListener(comp,MouseEvent.CLICK,onDoClick);
			
			eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
			eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
			eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onDoClick(evt:MouseEvent):void{
			//拾取一个和开格子
			//鼠标单击事件 如果有物品数据则显示Menu菜单，如果个子为开放则弹出开启个子提示框
			if(comp.data && comp.data.id !=0){
				//拾取一个
				ColonManMessage.getInstance().onObatinItem(comp.data.position,1);
			}else if(!comp.curTileIsClock){
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','cmeIRM_sfff') + onSetOpenPackDomand(comp.data.position) + CrotaResourceConfig.getInstance().getTextByModuleAndId('colonMan','cmeIRM_zktbb'), null, null, null, null, submitOpenPackHandler, null, null);
			}
		}
		
		/**
		 * 计算开背包所花费的魔钻数
		 */
		private function onSetOpenPackDomand(pos:int):int{
			//所开背包格子数
			var count:int = pos - 5;
			//本次所开背包第一个格子魔钻
			var startMoney:int = (SystemDataModel.cangKuInfoVo.curOpenMaxCount - 5)*2;
			//本次所开背包所需所有的魔钻数
			var maxMoney:int;
			var curMoney:int;
			for(var i:int=0;i<count;i++){
				curMoney = startMoney + i*2;
				maxMoney +=curMoney;
			}
			return maxMoney;
		}
		
		
		//确定开放背包个子
		private function submitOpenPackHandler(evt:MouseEvent):void{
			ColonManMessage.getInstance().onOpenCangku(comp.data.position);
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
//				trace('addTooltip..............');
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
		
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
package sceneModule.view.shop.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.shop.shop206.getNpcShopInfoRequest;
	import proto.shop.shop213.buyItemInMyshopRequest;
	import proto.shop.shop213.buyItemInMyshopResponse;
	import proto.shop.shop219.npcShopBuyItemRequest;
	import proto.shop.shop219.npcShopBuyItemResponse;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.model.vo.itemsVo.PackgeInfoVo;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.pack.view.MainMenuEquipmentComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	import sceneModule.view.shop.view.NpcShopBuyItemView;
	import sceneModule.view.shop.view.NpcShopItemView;
	
	import service.ISocketServer;
	import service.SocketService;

	public class NpcShopItemMediator extends Mediator
	{
		
		//标志位  鼠标是否在Tooltip内
		private var inToolTipSideFlag:Boolean;
		//标志位 鼠标是否在物品上
		private var inItemSideFlag:Boolean;
		[Inject]
		public var socketServer:ISocketServer;
		[Inject]
		public var popUpShow:IPopUpShow;
		[Inject]
		public var comp:NpcShopItemView;
		
		[Inject]
		public var tooltip:MainMenuEquipmentTooltip;
		
		public function NpcShopItemMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.eventMap.mapListener(comp.imgItemIcon,MouseEvent.MOUSE_OVER,onMouseOver);
			this.eventMap.mapListener(comp.imgItemIcon,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.mapListener(comp.imgItemIcon,MouseEvent.MOUSE_MOVE,onMouseMove);
			
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			if(tooltip.visible){
				setTooltipPosition();
			}
		}
		/**
		 * 如果有数据则显示Tooltip
		 */
		private function onMouseOver(evt:MouseEvent):void{
			inItemSideFlag = true;
			if(!tooltip.visible && comp.data && comp.data.id !=0){
				var packgeItem:PackageItem = comp.data as PackageItem;
				tooltip.curDataInfo = packgeItem;
				tooltip.visible = true;
				setTooltipPosition();
			}			
		}
		/**
		 * 当鼠标移出，设置Tooltip为不可见
		 */
		private function onMouseOut(evt:MouseEvent):void{
			inItemSideFlag = false;
			setTooltipVisible();
		}
		/**
		 * 设置ToolTip是否显示
		 */
		private function setTooltipVisible():void{
			if(tooltip.visible && !inItemSideFlag && !inToolTipSideFlag){
				tooltip.visible = false;
			}
		}
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			var insetPosY:int = comp.height - comp.mouseY;
			var insetPosX:int = comp.width - comp.mouseX;
			if(FlexGlobals.topLevelApplication.mouseY + tooltip.height > 650){
				tooltip.y=650 - tooltip.height;
			}else{
				tooltip.y=FlexGlobals.topLevelApplication.mouseY;
			}
			if(1000 - FlexGlobals.topLevelApplication.mouseX < tooltip.width){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX - tooltip.width - 10;
			}else{
				tooltip.x = FlexGlobals.topLevelApplication.mouseX;
			}
		}
	}
}
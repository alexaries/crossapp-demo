package sceneModule.view.zhanxing.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.territory.view.TerritoryWindow;
	import sceneModule.view.zhanxing.command.ZhanXingMessage;
	import sceneModule.view.zhanxing.event.MediatorRegisterXyEvent;
	import sceneModule.view.zhanxing.view.FuWenWindow;
	import sceneModule.view.zhanxing.view.JiFengExchangeComponent;
	import sceneModule.view.zhanxing.view.ZhanXingWindow;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class ZhanXingWindowMediator extends Mediator
	{
		
		[Inject]
		public var comp:ZhanXingWindow;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ZhanXingWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.iTxt1,MouseEvent.CLICK,onAuto);
			this.eventMap.mapListener(comp.iTxt2,MouseEvent.CLICK,onObtain);
			this.eventMap.mapListener(comp.iTxt3,MouseEvent.CLICK,onDrop);
			this.eventMap.mapListener(comp.iTxt4,MouseEvent.CLICK,onOpenPack);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.cBtn,MouseEvent.CLICK,onChangeByCoin);
			this.eventMap.mapListener(comp.bx1,MouseEvent.CLICK,onBox1);
			this.eventMap.mapListener(comp.bx2,MouseEvent.CLICK,onBox2);
			this.eventMap.mapListener(comp.bx3,MouseEvent.CLICK,onBox3);
			this.eventMap.mapListener(comp.bx4,MouseEvent.CLICK,onBox4);
			this.eventMap.mapListener(comp.bx5,MouseEvent.CLICK,onBox5);
			
			ZhanXingMessage.getInstance().getXingYuanListInfo();
			
			eventMap.mapListener(comp,MediatorRegisterXyEvent.MEDIATORREGISTERXYEVENT,onRegisterItemRenderMediator);
			
			
			this.eventMap.mapListener(comp.bx1,MouseEvent.MOUSE_OVER,onMouseOver1Handler);
			this.eventMap.mapListener(comp.bx1,MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			this.eventMap.mapListener(comp.bx1,MouseEvent.MOUSE_OUT,onMouseOutHandler);
			
			this.eventMap.mapListener(comp.bx2,MouseEvent.MOUSE_OVER,onMouseOver2Handler);
			this.eventMap.mapListener(comp.bx2,MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			this.eventMap.mapListener(comp.bx2,MouseEvent.MOUSE_OUT,onMouseOutHandler);
			
			this.eventMap.mapListener(comp.bx3,MouseEvent.MOUSE_OVER,onMouseOver3Handler);
			this.eventMap.mapListener(comp.bx3,MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			this.eventMap.mapListener(comp.bx3,MouseEvent.MOUSE_OUT,onMouseOutHandler);
			
			this.eventMap.mapListener(comp.bx4,MouseEvent.MOUSE_OVER,onMouseOver4Handler);
			this.eventMap.mapListener(comp.bx4,MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			this.eventMap.mapListener(comp.bx4,MouseEvent.MOUSE_OUT,onMouseOutHandler);
			
			this.eventMap.mapListener(comp.bx5,MouseEvent.MOUSE_OVER,onMouseOver5Handler);
			this.eventMap.mapListener(comp.bx5,MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			this.eventMap.mapListener(comp.bx5,MouseEvent.MOUSE_OUT,onMouseOutHandler);
		}
		private function onMouseOver1Handler(evt:MouseEvent):void{
			onShowTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_mz')+'\n'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_tbfy')+'：10000');
		}
		private function onMouseOver2Handler(evt:MouseEvent):void{
			onShowTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_tz')+'\n'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_tbfy')+'：20000');
		}
		private function onMouseOver3Handler(evt:MouseEvent):void{
			onShowTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_yz')+'\n'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_tbfy')+'：30000');
		}
		private function onMouseOver4Handler(evt:MouseEvent):void{
			onShowTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_hj')+'\n'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_tbfy')+'：50000');
		}
		private function onMouseOver5Handler(evt:MouseEvent):void{
			onShowTips(CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_sm')+'\n'+CrotaResourceConfig.getInstance().getTextByModuleAndId('zhanxing','zxWM_tbfy')+'：100000');
		}
		private var tooltip:MainSmallDesTooltip;
		private function onShowTips(txt:String):void{
			if(!tooltip){
				tooltip = ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			tooltip.curDes = txt;
			popUpWindowLayer.addElement(tooltip);
			//设置ToolTip位置
			setTooltipPosition();
		}
		
		private function onMouseMoveHandler(evt:MouseEvent):void{
			//设置ToolTip位置
			setTooltipPosition();
		}
		
		private function onMouseOutHandler(evt:MouseEvent):void{
			if(tooltip)popUpWindowLayer.removeElement(tooltip);
		}
		
		/**
		 * 设置Tooltip在屏幕的坐标
		 */
		private function setTooltipPosition():void{
			if(tooltip){
				tooltip.x = FlexGlobals.topLevelApplication.mouseX + 5;
				tooltip.y = FlexGlobals.topLevelApplication.mouseY + 5;
			}
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterXyEvent):void{
			mediatorMap.createMediator(evt._view);
		}
		
		private function onBox1(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ZhanXing(1);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_JIHUO_SHENGGE)]);

		}
		private function onBox2(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ZhanXing(2);
		}
		private function onBox3(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ZhanXing(3);
		}
		private function onBox4(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ZhanXing(4);
		}
		private function onBox5(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ZhanXing(5);
		}
		
		private function onChangeByCoin(evt:MouseEvent):void{
			onCloseWindow();
			WindowManager.createWindow(JiFengExchangeComponent.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onOpenPack(evt:MouseEvent):void{
			onCloseWindow();
			ZhanXingMessage.getInstance().getRoleOrPetList();
			ZhanXingMessage.getInstance().initEquipBackground();
			ZhanXingMessage.getInstance().getPackXingYunList();
			AssetCenter.getInstance().load_package("ui_zhanxing",to_fuWen,null,true);
		}
		
		private function to_fuWen():void{
			WindowManager.createWindow(FuWenWindow.NAME,null,TerritoryWindow.NAME,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_SHANGDIAN)]);

		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			WindowManager.closeWindow(ZhanXingWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function onAuto(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().onAutoZhanXing();
		}
		
		private function onObtain(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ObtainOrDrop(0);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_BUZHEN)]);

		}
		
		private function onDrop(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().ObtainOrDrop(1);
		}
		
		
	}
}
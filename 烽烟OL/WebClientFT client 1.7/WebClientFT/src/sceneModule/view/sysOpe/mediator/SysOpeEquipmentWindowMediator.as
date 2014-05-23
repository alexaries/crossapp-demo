package sceneModule.view.sysOpe.mediator
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.view.sysOpe.view.SysOpeEquipmentWindow;
	
	import service.ISocketServer;

	public class SysOpeEquipmentWindowMediator extends Mediator
	{
		[Inject]
		public var comp:SysOpeEquipmentWindow;
		
		[Inject]
		public var socketServer:ISocketServer;
		public function SysOpeEquipmentWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.anBtn,MouseEvent.CLICK,onAnEquip);
		}
		
		private function onAnEquip(evt:MouseEvent):void{
			//穿装备
			//发送穿装备指令
			SceneModuleCommonMessage.getInstance().onEquipEquipment(comp.curObj.pos,comp.curObj.toPos,comp.curObj.page);
			onCloseWindow();
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			comp.parent.removeChild(comp);
		}
	}
}
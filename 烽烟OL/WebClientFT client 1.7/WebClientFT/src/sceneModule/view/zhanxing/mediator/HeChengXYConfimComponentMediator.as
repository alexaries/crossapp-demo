package sceneModule.view.zhanxing.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.zhanxing.command.ZhanXingMessage;
	import sceneModule.view.zhanxing.view.HeChengXYConfimComponent;
	
	import service.ISocketServer;

	public class HeChengXYConfimComponentMediator extends Mediator
	{
		[Inject]
		public var comp:HeChengXYConfimComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function HeChengXYConfimComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.rBtn,MouseEvent.CLICK,onHeCheng);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
		
		private function onHeCheng(evt:MouseEvent):void{
			ZhanXingMessage.getInstance().OpeXingYun(comp.data.type,comp.data.fPos,comp.data.tPos,comp.data.id);
			onCancel();
		}
		
		private function onCancel(evt:MouseEvent=null):void{
			WindowManager.closeWindow(HeChengXYConfimComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
package sceneModule.view.sysOpe.mediator
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.gaAndsd.event.GuaJiCancelEvent;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	import sceneModule.view.jingji.command.JingJiMessage;
	import sceneModule.view.sysOpe.view.SysOpeGuaJiComponent;

	public class SysOpeGuaJiComponentMediator extends Mediator
	{
		[Inject]
		public var comp:SysOpeGuaJiComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function SysOpeGuaJiComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			JingJiMessage.getInstance().addEventListener(GuaJiCancelEvent.GUAJICANCELEVENT,onCancelGuaJi);
			startTimeToAddExp();
		}
		
		private var timer:Timer;
		private var lun:int;
		private function startTimeToAddExp():void{
			if(comp.gjTime>0){
				if(!timer){
					timer = new Timer(1000);
					timer.addEventListener(TimerEvent.TIMER,onTimer);
				}
				if(!timer.running){
					timer.start();
					lun = 0;
				}
			}
		}
		private function onTimer(evt:TimerEvent):void{
			if(comp.gjTime>0)comp.gjTime--;
			lun ++;
			if(lun%15==0){
				comp.expCount += SystemDataModel.roleInfo.level/10*SystemDataModel.roleInfo.level;
			}
			if(comp.gjTime<=0){
				timer.stop();
				onCancelGuaJi();
			}
		}
		
		public function onCancelGuaJi(evt:GuaJiCancelEvent = null):void{
			if(timer){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,onTimer);
				timer =null;
			}
			if(comp && comp.parent){
				comp.parent.removeChild(comp);
			}
			
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.createWindow(GuaJiConfimComponent.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
	}
}
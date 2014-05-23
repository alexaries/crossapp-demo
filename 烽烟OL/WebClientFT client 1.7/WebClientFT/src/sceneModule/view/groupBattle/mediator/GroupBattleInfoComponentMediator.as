package sceneModule.view.groupBattle.mediator
{
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.group.command.GroupMessage;
	import sceneModule.view.groupBattle.command.GroupBattleMessage;
	import sceneModule.view.groupBattle.view.GroupBattleInfoComponent;

	public class GroupBattleInfoComponentMediator extends Mediator
	{
		[Inject]
		public var comp:GroupBattleInfoComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function GroupBattleInfoComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			GroupBattleMessage.getInstance().getGroupBattleInfo();
			
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			onStartGetInfo();
			
			GroupMessage.getInstance().addBattleEventListener();
		}
		
		private var timer:Timer;
		private const TIME:int = 1000;
		private var num:int=0;
		private function onStartGetInfo():void{
			if(!timer){
				timer = new Timer(TIME);
				timer.addEventListener(TimerEvent.TIMER,onTimerComplete);
			}
			timer.start();
			
		}
		
		private function onTimerComplete(evt:TimerEvent):void{
			num++;
			if(SystemDataModel.groupBattleInfo.groupBattleInfo.remainTime>0){
				SystemDataModel.groupBattleInfo.groupBattleInfo.remainTime -= 1;
			}
			if(num%10 == 0){
				GroupBattleMessage.getInstance().getGroupBattleInfo();
			}
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(GroupBattleInfoComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
package sceneModule.view.groupBattle.mediator
{
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.groupBattle.command.GroupBattleMessage;
	import sceneModule.view.groupBattle.view.LingDiComponent;

	public class LingDiComponentMediator extends Mediator
	{
		[Inject]
		public var comp:LingDiComponent;
		public function LingDiComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.obBtn,MouseEvent.CLICK,onObtainJiangLi);
		}
		
		private function onObtainJiangLi(evt:MouseEvent):void{
			GroupBattleMessage.getInstance().ontainJiangLi();
		}
	}
}
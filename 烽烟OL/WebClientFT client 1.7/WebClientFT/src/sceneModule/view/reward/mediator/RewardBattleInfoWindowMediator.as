package sceneModule.view.reward.mediator
{
	/**
	 * RewardBattleInfoWindowMediator 
	 */	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.reward.command.RewardMessage;
	import sceneModule.view.reward.event.MediatorRegisterRewardBattleEvent;
	import sceneModule.view.reward.view.RewardBattleInfoWindow;
	import sceneModule.view.reward.view.RewardWindow;
	
	import service.ISocketServer;

	public class RewardBattleInfoWindowMediator extends Mediator
	{
		[Inject]
		public var comp:RewardBattleInfoWindow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function RewardBattleInfoWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePage);
			this.eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPage);
			this.eventMap.mapListener(comp.backBtn,MouseEvent.CLICK,onBackRewardWin);
			eventMap.mapListener(comp,MediatorRegisterRewardBattleEvent.MEDIATORREGISTERREWARDBATTLEEVENT,onRegisterItemRenderMediator);
		}
		
		private function onBackRewardWin(evt:MouseEvent):void{
			onCloseWindow();
			WindowManager.createWindow(RewardWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterRewardBattleEvent):void{
			mediatorMap.createMediator(evt._view);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			WindowManager.closeWindow(RewardBattleInfoWindow.NAME,false,false,null,popUpWindowLayer);
		}
		
		private function onPrePage(evt:MouseEvent):void{
			RewardMessage.getInstance().getRewardBattleInfo(SystemDataModel.rewardBattleVo.curPage - 1);
		}
		
		private function onNextPage(evt:MouseEvent):void{
			RewardMessage.getInstance().getRewardBattleInfo(SystemDataModel.rewardBattleVo.curPage + 1);
		}
	}
}
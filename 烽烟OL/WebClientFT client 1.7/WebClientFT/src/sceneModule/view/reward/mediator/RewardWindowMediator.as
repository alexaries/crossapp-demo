package sceneModule.view.reward.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.reward.command.RewardMessage;
	import sceneModule.view.reward.event.MediatorRegisterRewardEvent;
	import sceneModule.view.reward.view.RewardWindow;
	
	import service.ISocketServer;

	/**
	 * RewardWindowMediator 
	 * @author Dream-Y
	 * 
	 */	
	public class RewardWindowMediator extends Mediator
	{
		[Inject]
		public var comp:RewardWindow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function RewardWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePage);
			this.eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPage);
			this.eventMap.mapListener(comp.obAllReBtn,MouseEvent.CLICK,onObtainAllReward);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			eventMap.mapListener(comp,MediatorRegisterRewardEvent.MEDIATORREGISTERREWARDEVENT,onRegisterItemRenderMediator);
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterRewardEvent):void{
			mediatorMap.createMediator(evt._view);
		}
		
		private function onPrePage(evt:MouseEvent):void{
			//上一页数据
			RewardMessage.getInstance().getRewardList(SystemDataModel.rewardInfo.curPage - 1);
		}
		
		private function onNextPage(evt:MouseEvent):void{
			//下一页数据
			RewardMessage.getInstance().getRewardList(SystemDataModel.rewardInfo.curPage + 1);
		}
		
		private function onObtainAllReward(evt:MouseEvent):void{
			//领取所有奖励
			RewardMessage.getInstance().obtainAllReward();
			onCloseWindow();
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			//关闭RewardWindow
			WindowManager.closeWindow(RewardWindow.NAME,false,false,null,popUpWindowLayer);
		}
	}
}
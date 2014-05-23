package sceneModule.view.reward.mediator
{
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mx.utils.object_proxy;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.reward.command.RewardMessage;
	import sceneModule.view.reward.view.RewardBattleInfoWindow;
	import sceneModule.view.reward.view.RewardItemRender;
	import sceneModule.view.reward.view.RewardWindow;
	
	import service.ISocketServer;

	/**
	 * RewardItemRenderMediator 
	 * @author Dream-Y
	 * 
	 */	
	public class RewardItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:RewardItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function RewardItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.iBtn,MouseEvent.CLICK,onBtnClick);
			this.eventMap.mapListener(comp.obtainBtn,MouseEvent.CLICK,onObtainReward);
		}
		
		private function onBtnClick(evt:MouseEvent):void{
			//侵略详细信息
			RewardMessage.getInstance().getRewardBattleInfo(1);
//			RewardMessage.getInstance().onShiftBattle();
			WindowManager.closeWindow(RewardWindow.NAME,false,false,null,popUpWindowLayer);
			WindowManager.createWindow(RewardBattleInfoWindow.NAME,null,null,false,false,false,null,mediatorMap,popUpWindowLayer);
		}
		
		private function onObtainReward(evt:MouseEvent):void{
			//获取奖励
			RewardMessage.getInstance().obtainOneReward(comp.data.r_id);
		}
	}
}
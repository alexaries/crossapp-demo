package sceneModule.view.jingji.mediator
{
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import loader.ProgressBarControl;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle704.quitFightRequest;
	import proto.battle.battle704.quitFightResponse;
	
	import sceneModule.event.BattleOverAndEffectEvent;
	import sceneModule.view.jingji.view.JingJiBattleJieSuanWindow;
	
	import service.ISocketServer;

	public class JingJiBattleJieSuanWindowMediator extends Mediator
	{
		[Inject]
		public var comp:JingJiBattleJieSuanWindow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var progressBar:ProgressBarControl;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function JingJiBattleJieSuanWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submit,MouseEvent.CLICK,onSubmit);
		}
		
		private function onSubmit(evt:MouseEvent):void{
			WindowManager.closeWindow(JingJiBattleJieSuanWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
			sendQuitBattle();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		/**
		 * 退出战斗请求
		 */
		private function sendQuitBattle():void{
			var quitFightQuest:quitFightRequest = new quitFightRequest();
			quitFightQuest.id = SystemDataModel.roleId;
			var byteArrayQuit:ByteArray = new ByteArray();
			quitFightQuest.writeExternal(byteArrayQuit);
			socketService.send(new mx.rpc.Responder(QuitFightResultHandler,faultHandler),URLConst.QUIT_BATTLE_COMMANDID,byteArrayQuit);
		}
		
		/**
		 * QuitFightResultHandler
		 */
		private function QuitFightResultHandler(data:Object):void{
			var responseByteArray:ByteArray = data as ByteArray;
			var quitResponse:quitFightResponse = new quitFightResponse();
			quitResponse.readExternal(responseByteArray);
			if(quitResponse.result){
				SystemDataModel.sceneIsLoaded = true;
				if(SystemDataModel.jingjiBattleFlag){
					SystemDataModel.jingjiBattleFlag = false;
				}else if(SystemDataModel.groupBattleFlag){
					SystemDataModel.groupBattleFlag = false;
				}else{
					this.dispatch(new BattleOverAndEffectEvent(BattleOverAndEffectEvent.BATTLEOVERANDEFFECT));
					SystemDataModel.panPaBattleFlag = false;
					SystemDataModel.openPanPaUI = true;
				}
				
				SystemDataModel.isBattleStatusFlag = false;
				GuidEventCenter.getInstance().dispatchEvent(
					new SwitchMaskEvent(
						SwitchMaskEvent.SwitchMaskEvent_SHOW
					)
				);
				
				//显示加载条
				progressBar.visible = true;
				
			}
		}
	}
}
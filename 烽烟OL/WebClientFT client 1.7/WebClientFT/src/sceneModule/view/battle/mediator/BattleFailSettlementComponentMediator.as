package sceneModule.view.battle.mediator
{
	import Animation.AnimationOnceManager;
	import wordscene.WordSceneSprite;
	
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle704.quitFightRequest;
	import proto.battle.battle704.quitFightResponse;
	
	import resource.AssetCenter;
	
	import sceneModule.event.BattleOverAndEffectEvent;
	import sceneModule.view.battle.view.BattleFailSettlementWindow;
	
	import service.ISocketServer;

	/**
	 * 战斗失败结算界面 
	 * @author Dream-Y
	 * 
	 */	
	public class BattleFailSettlementComponentMediator extends Mediator
	{
		[Inject]
		public var comp:BattleFailSettlementWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketService:ISocketServer;
		public function BattleFailSettlementComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.backSceneBtn,MouseEvent.CLICK,onBackScene);
			
			init_view();
		}
		
		private function init_view():void{
			comp.bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("common_res", "fail_battle_img");
//			comp.bg1_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("common_res", "com1_img");
		}
		
		private function onBackScene(evt:MouseEvent):void{
			sendQuitBattle();
			onCloseWindow();
		}
		
		private function onCloseWindow():void{
			this.dispatch(new BattleOverAndEffectEvent(BattleOverAndEffectEvent.BATTLEOVERANDEFFECT));
			onRemoveListener();
			WindowManager.closeWindow(BattleFailSettlementWindow.NAME,false,false,null,popUpWindowLayer);
		}
		
		private function onRemoveListener():void{
//			this.eventMap.unmapListener(comp.backSceneBtn,MouseEvent.CLICK,onBackScene);
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
		 * 战斗场景切换动画
		 */
		private function addSwitchBattleAnimation():void{
			//var animation:AnimationOnceManager = new AnimationOnceManager(URLConst.SWITCH_BATTLEANIMATION_URL);
			//animation.addToParent();
			//animation.setPosition(0,0);
			//animation.play();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		/**
		 * QuitFightResultHandler
		 */
		private function QuitFightResultHandler(data:Object):void{
			var responseByteArray:ByteArray = data as ByteArray;
			var quitResponse:quitFightResponse = new quitFightResponse();
			quitResponse.readExternal(responseByteArray);
			if(quitResponse.result){
				GuidEventCenter.getInstance().dispatchEvent(
					new SwitchMaskEvent(
						SwitchMaskEvent.SwitchMaskEvent_SHOW,
						destory_battle
					)
				);
					
				//战斗场景切换动画
				//addSwitchBattleAnimation();
				//				LevelManager.instance.unloadCurrentLevel();
				//				characterOp.removeCurrentSceneCharacter();
				//				LevelManager.instance.loadLevel(quitResponse.data.placeId);
				//				LevelManager.instance.addEventListener(LevelEvent.LEVEL_LOADED_EVENT,levelLoaded);
			}
		}
		
		private function destory_battle():void {
			GuidEventCenter.getInstance().dispatchEvent(
					new SwitchMaskEvent(
						SwitchMaskEvent.SwitchMaskEvent_HIDE
					)
			);
			//销毁战斗场景中的所有实体
			//TODO wordscene
			WordSceneSprite.getInstance().fightSceneSp.clear();
			//rBattleShow.destroyRBattleEntities();
			//添加鼠标点击NPC事件
			SystemDataModel.sceneIsLoaded = true;
			SystemDataModel.isBattleStatusFlag = false;
		}
	}
}
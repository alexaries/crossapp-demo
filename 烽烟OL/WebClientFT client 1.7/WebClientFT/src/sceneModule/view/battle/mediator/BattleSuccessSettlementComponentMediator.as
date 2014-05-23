package sceneModule.view.battle.mediator
{
	/**
	 * 战斗胜利Window Mediator 
	 */	
	import Animation.AnimationOnceManager;
	
	
	import event.GuidClearEvent;
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.SoundConst;
	import managers.SoundManager;
	import managers.WindowManager;
	
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle704.quitFightRequest;
	import proto.battle.battle704.quitFightResponse;
	
	import resource.AssetCenter;
	
	import sceneModule.event.BattleOverAndEffectEvent;
	import sceneModule.view.battle.event.BattleFlipEvent;
	import sceneModule.view.battle.event.MediatorRegisterBattleBettlementEvent;
	import sceneModule.view.battle.view.BattleSuccessSettlementWindow;
	
	import service.ISocketServer;
	
	import util.CommonTools;

	public class BattleSuccessSettlementComponentMediator extends Mediator
	{
		[Inject]
		public var comp:BattleSuccessSettlementWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketService:ISocketServer;
		public function BattleSuccessSettlementComponentMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onSubmit);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onClose);
			
			eventMap.mapListener(comp,MediatorRegisterBattleBettlementEvent.MEDIATORREGISTERBATTLEBETTLEMENT,onRegisterItemRenderMediator);
		}
		
		override public function onRegister():void{
			init_view();
		}
		
		private function init_view():void{
			util.CommonTools.make_bitmap(comp.bgImg).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_battle_suc", "suc_bg");
			//comp.bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_battle_suc", "suc_bg");
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterBattleBettlementEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		private function onClose(evt:MouseEvent):void{
			onCloseBattleWindow();
		}
		
		private function onSubmit(evt:MouseEvent):void{
			onCloseBattleWindow();
		}
		
		private function onCloseBattleWindow():void{
			this.dispatch(new BattleOverAndEffectEvent(BattleOverAndEffectEvent.BATTLEOVERANDEFFECT));
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_FIGHT_JIANGLI));
			if(SystemDataModel.battleInfoVo.fightType == 4){
				//发送翻牌子事件
				this.dispatch(new BattleFlipEvent(BattleFlipEvent.BATTLEFLIPEVENT));
			}else{
				//退出战斗
				sendQuitBattle();
			}
			
			WindowManager.closeWindow(BattleSuccessSettlementWindow.NAME, false, false, null, popUpWindowLayer);
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
			//销毁战斗场景中的所有实体
			if(quitResponse.result){
				SoundManager.getInstance().stop(SoundConst.BATTLE_SOUND);
				if(ProConst.MAX_CITY_ID >= SystemDataModel.placeId){
					SoundManager.getInstance().stop(SoundConst.FUBEN_SOUND);
					SoundManager.getInstance().play(SoundConst.CITY_SOUND,0,-1);
				}else{
					SoundManager.getInstance().stop(SoundConst.CITY_SOUND);
					SoundManager.getInstance().play(SoundConst.FUBEN_SOUND,0,-1);
				}
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
			//添加鼠标点击NPC事件
			SystemDataModel.sceneIsLoaded = true;
			SystemDataModel.isBattleStatusFlag = false;
		}
	}
}
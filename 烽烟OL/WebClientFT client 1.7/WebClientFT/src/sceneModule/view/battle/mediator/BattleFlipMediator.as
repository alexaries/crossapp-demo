package sceneModule.view.battle.mediator
{
	import wordscene.WordSceneSprite;
	
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import managers.WindowManager;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle704.quitFightRequest;
	import proto.battle.battle704.quitFightResponse;
	import proto.battle.battle706.TurnOneCard;
	import proto.battle.battle707.TurnCardRequest;
	import proto.battle.battle707.TurnCardResponse;
	import proto.battle.battle708.TurnAllCards;
	import proto.copyScene.copyScene1502.escInstanceRequest;
	import proto.copyScene.copyScene1502.escInstanceResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.battle.command.BattleAndCopySceneMessage;
	import sceneModule.view.battle.event.MediatorRegisterBattleBettlementEvent;
	import sceneModule.view.battle.view.BattleFlipComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.popupWin.PopUpShow;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class BattleFlipMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var battleFlipComp:BattleFlipComponent;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function BattleFlipMediator()
		{
			super();
		}
		
		override public function preRegister():void{
	
			//添加翻牌子服务器发回的信息
			addServerSendInfo();
			//添加翻所有牌子事件请求
			addTurnAllCard();
			
			init_view();
			
			onStartTimeAnimation();
			
			eventMap.mapListener(battleFlipComp,MediatorRegisterBattleBettlementEvent.MEDIATORREGISTERBATTLEBETTLEMENT,onRegisterItemRenderMediator);
		}
		
		private function onRegisterItemRenderMediator(evt:MediatorRegisterBattleBettlementEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		/**
		 * 开始播放倒计时动画
		 */
		private var timer:Timer;
		private const TIMEFRAME:int=1000;
		private var timeHandler:Function;
		public function onStartTimeAnimation(timeEndHandler:Function=null):void{
			timeHandler = timeEndHandler;
			timer = new Timer(TIMEFRAME);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			timer.reset();
			timer.start();				
		}
		/**
		 * 控制倒计时
		 */
		private function onTimer(evt:TimerEvent):void{
			if(battleFlipComp.mc && (battleFlipComp.mc.currentFrame < battleFlipComp.mc.framesLoaded)){
				battleFlipComp.mc.gotoAndStop(battleFlipComp.mc.currentFrame + 1);
			}else if(battleFlipComp.mc && (battleFlipComp.mc.currentFrame >= battleFlipComp.mc.framesLoaded)){
				if(battleFlipComp.mc.framesLoaded > 1){
					battleFlipComp.mc.stop();
					timer.stop();
					turnAllCard();
					new DelayExcuter(1000,onRemoveFlipComp,null);
					//						timeHandler();
//					onRemoveFlipComp();
					timer.removeEventListener(TimerEvent.TIMER,onTimer);
					timer.reset();
				}
			}
		}
		
		private function onRemoveFlipComp():void{
			battleFlipComp.destoryThisCache();
			WindowManager.closeWindow(BattleFlipComponent.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer);
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_FANPAIZI));
			//清除翻牌数据
			SystemDataModel.battleOverItemInfoCollection.removeAll();
			if(SystemDataModel.roleInfo.energy>=5){
				//判断自己是否是队长，如果是队长则弹出提示框，询问是否再次征战该副本
				var battleCopyScene:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfM_iszz')+"？";
				popUpShow.show(battleCopyScene, null, null,CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfM_cxzz') ,  CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfM_tcfb'), submitEnterBattle, onEscCopySceneHandler);
				
			}else{
				onEscCopySceneHandler();
			}
			
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_FIGHT_AGAIN));
		}
		/**
		 * 退出副本
		 */
		private function onEscCopySceneHandler(evt:MouseEvent=null):void{
			//发送退出战斗请求
			WordSceneSprite.getInstance().fightSceneSp.fightOver();
			BattleAndCopySceneMessage.getInstance().onEscCopyScene();
			return;
			sendQuitBattle();
			//退出副本
			BattleAndCopySceneMessage.getInstance().onEscCopyScene();
		}
		
		/**
		 * 再次征战副本
		 */
		private function submitEnterBattle(data:Object):void {
			WordSceneSprite.getInstance().fightSceneSp.fightOver();
			//重新征战副本请求
			var enterInstanceR:escInstanceRequest = new escInstanceRequest();
			enterInstanceR.id = SystemDataModel.roleId;
			var enterInstanceB:ByteArray = new ByteArray();
			enterInstanceR.writeExternal(enterInstanceB);
			socketService.send(new mx.rpc.Responder(enterInstanceHandler,faultHandler),URLConst.SUBMITENTER_COPYSCENE_COMMANDID,enterInstanceB);
		}
		/**
		 * 确定再次征战副本返回处理
		 */
		private function enterInstanceHandler(data:Object):void {
			WordSceneSprite.getInstance().fightSceneSp.fightOver();
			return;
			var enterInstanceByte:ByteArray = data as ByteArray;
			var enterInstanceResponseData:escInstanceResponse = new escInstanceResponse();
			enterInstanceResponseData.readExternal(enterInstanceByte);
			if(enterInstanceResponseData.result){
				//SystemDataModel.sceneIsLoaded = true;
			}else{
				popUpShow.show(enterInstanceResponseData.message);
			}
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
				//销毁战斗场景中的所有实体
				//添加鼠标点击NPC事件
//				eventMap.mapListener(applicationScene,MousePosEvent.MOUSE_SELECTED_EVENT,onMouseClickNpc);				
//				SystemDataModel.sceneIsLoaded = true;
				new DelayExcuter(1000,function():void{
					SystemDataModel.isBattleStatusFlag = false;
				},null);
				
				//战斗场景切换动画
//				addSwitchBattleAnimation();
			}else{
				popUpShow.show(quitResponse.message);
			}
			
		}
		/**
		 * 退出副本
		 */
		private function cancelCopyScene(data:Object):void{
			
		}
		
		private function init_view():void{
//			battleFlipComp.bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_battle_suc","flip_bg");
		}
		/**
		 * 添加翻所有牌子事件请求
		 */
		private function addTurnAllCard():void{
			socketService.send(new mx.rpc.Responder(resultTurnAllCaidHandler,faultHandler),URLConst.TURN_ALLITEM_COMMANDID,null,false);
		}
		
		private function addServerSendInfo():void{
			socketService.send(new mx.rpc.Responder(resultTurnOneCaidHandler,faultHandler),URLConst.SEND_SELECTEDITEM_COMMANDID,null,false);
		}
		
		private function resultTurnOneCaidHandler(data:Object):void{
			var turnOneCardByteArray:ByteArray = data as ByteArray
			var requestTurnOneCar:TurnOneCard = new TurnOneCard();
			requestTurnOneCar.readExternal(turnOneCardByteArray);
			//翻动一张牌子
			battleFlipComp.turnOneCardFunction(requestTurnOneCar.cardId,requestTurnOneCar.nickname);
			
			SystemDataModel.flipCount +=1;
		}
	
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function turnAllCard():void{
			//翻所有牌子  实现方式：通过改变牌子对象的nickName来实现翻动所有为翻动的牌子
			var l:int = SystemDataModel.battleOverItemInfoCollection.length;
			for(var i:int=0;i<l;i++){
				if(!SystemDataModel.battleOverItemInfoCollection[i].nickName){
					SystemDataModel.battleOverItemInfoCollection[i].nickName = CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfM_xt');
				}
			}
		}
		
		private function resultTurnAllCaidHandler(data:Object):void{
			var turnAllByteArray:ByteArray = data as ByteArray;
			var turnAllResponse:TurnAllCards = new TurnAllCards();
			turnAllResponse.readExternal(turnAllByteArray);
			if(turnAllResponse.signal){
				turnAllCard();
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,onTimer);
				new DelayExcuter(1000,onRemoveFlipComp,null);
			}
		}
	}
}
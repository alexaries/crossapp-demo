package sceneModule.view.battle.mediator
{
	import event.GuidClearEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle713.EscColonizationBattleRequest;
	
	import sceneModule.event.BattleOverAndEffectEvent;
	import sceneModule.view.battle.view.BattleColonizationFailWindow;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class BattleColonizationFailWindowMediator extends Mediator
	{
		
		[Inject]
		public var comp:BattleColonizationFailWindow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		public function BattleColonizationFailWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseClick(evt:MouseEvent):void{
			
			this.dispatch(new BattleOverAndEffectEvent(BattleOverAndEffectEvent.BATTLEOVERANDEFFECT));
			onEscColonizationBattle();
			WindowManager.closeWindow(BattleColonizationFailWindow.NAME, false, false, null, popUpWindowLayer);
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.CLOSE_QINLUE_JIEGUO_SHIBAI));
			new DelayExcuter(1000,function():void{
				SystemDataModel.isBattleStatusFlag = false;
			},null);
		}
		/**
		 * 退出殖民战
		 */
		private function onEscColonizationBattle():void{
			SystemDataModel.isColonizationFlag = false;
			var escColReq:EscColonizationBattleRequest = new EscColonizationBattleRequest();
			escColReq.id = SystemDataModel.roleId;
			if(SystemDataModel.battleInfoVo.battleResult == 1){
				escColReq.battleResult = true;
			}else{
				escColReq.battleResult = false;
			}
			escColReq.sceneId = SystemDataModel.colCopyId;
			var byteArray:ByteArray = new ByteArray();
			escColReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(escColHandler,faultHandler),URLConst.BATTLE_ESCCOL_COMMANDID,byteArray);
		}
		private function escColHandler(data:Object):void{
			//销毁战斗场景中的所有实体
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
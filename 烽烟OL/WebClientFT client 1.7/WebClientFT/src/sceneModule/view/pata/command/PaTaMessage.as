package sceneModule.view.pata.command
{
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	import util.Logging;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import loader.ProgressBarControl;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	
	import proto.panpa.panpa4203.BuffInfo;
	import proto.panpa.panpa4203.EnemyArray;
	import proto.panpa.panpa4203.FightData;
	import proto.panpa.panpa4203.TowerBattleRequest;
	import proto.panpa.panpa4203.TowerBattleResponse;
	import proto.panpa.panpa4203.initBattleData;
	
	import sceneModule.model.rvo.RBattleAllRoundVo;
	import sceneModule.model.rvo.RBattleBuffVo;
	import sceneModule.model.rvo.RBattleEnemyVo;
	import sceneModule.model.rvo.RBattleInitChaVo;
	import sceneModule.model.rvo.RBattleInitVo;
	import sceneModule.model.rvo.RBattleRoundVo;
	import sceneModule.view.pata.event.PaTaBattleAndMoveEvent;
	import sceneModule.view.pata.view.PanPaWindow;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class PaTaMessage extends EventDispatcher
	{
		
		[Inject]
		public var progressBar:ProgressBarControl;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private static var _instance:PaTaMessage;
		
		private var _event_dispatcher:IEventDispatcher;
		public function PaTaMessage()
		{
		}
		
		public static function getInstance():PaTaMessage{
			if(null == _instance){
				_instance = new PaTaMessage();
			}
			return _instance;
		}
		
		public function set event_dispatcher(value:IEventDispatcher):void 
		{
			_event_dispatcher = value;
		}
		
		public function get event_dispatcher():IEventDispatcher{
			return _event_dispatcher;
		}
		
		public function onPaTaBattle():void{
			var abReq:TowerBattleRequest = new TowerBattleRequest();
			abReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			abReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(abHandler,faultHandler),URLConst.PANPA_BATTLE_COMMANDID,byteArray);
		}
		private var _resData:TowerBattleResponse;
		private function abHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:TowerBattleResponse = new TowerBattleResponse();
			responseData.readExternal(byteArray);
			Logging.log("接受到爬塔信息", Logging.o2s(responseData));
			if(responseData.result){
				PaTaMessage.getInstance().resData = responseData;
				PaTaMessage.getInstance().event_dispatcher.dispatchEvent(new PaTaBattleAndMoveEvent(PaTaBattleAndMoveEvent.PATABATTLEANDMOVEEVENT));
			}else{
				popUpShow.show(responseData.message);
			}
		}
		
		public function set resData(value:TowerBattleResponse):void{
			_resData = value;
		}
		
		public function get resData():TowerBattleResponse{
			return _resData;
		}
		
		public function onStartBattle(responseData:TowerBattleResponse):void {
			Logging.log("开始爬塔");
			WindowManager.closeWindow(PanPaWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE);
			//GuidEventCenter.getInstance().dispatchEvent(
				//new SwitchMaskEvent(
					//SwitchMaskEvent.SwitchMaskEvent_SHOW
				//)
			//);
			SystemDataModel.panPaBattleFlag = true;
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
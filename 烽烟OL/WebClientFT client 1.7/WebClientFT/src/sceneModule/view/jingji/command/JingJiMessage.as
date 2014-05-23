package sceneModule.view.jingji.command
{
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	import util.Logging;
	import wordscene.event.PlusEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import loader.ProgressBarControl;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.jingji.jingji3700.BattleInfo;
	import proto.jingji.jingji3700.DiRenInfo;
	import proto.jingji.jingji3700.GetJingJiRequest;
	import proto.jingji.jingji3700.GetJingJiResponse;
	import proto.jingji.jingji3701.JingJiCDResponse;
	import proto.jingji.jingji3702.JingJiRankInfoRequest;
	import proto.jingji.jingji3702.JingJiRankInfoResponse;
	import proto.jingji.jingji3703.AddJingJiCountRequest;
	import proto.jingji.jingji3703.AddJingJiCountResponse;
	import proto.jingji.jingji3704.ArenaBattleRequest;
	import proto.jingji.jingji3704.BuffInfo;
	import proto.jingji.jingji3704.EnemyArray;
	import proto.jingji.jingji3704.FightData;
	import proto.jingji.jingji3704.FightResponse;
	import proto.jingji.jingji3704.initBattleData;
	import proto.jingji.jingji3705.JingjiCleanCDRequest;
	import proto.jingji.jingji3705.JingjiCleanCDResponse;
	
	import sceneModule.model.rvo.RBattleAllRoundVo;
	import sceneModule.model.rvo.RBattleBuffVo;
	import sceneModule.model.rvo.RBattleEnemyVo;
	import sceneModule.model.rvo.RBattleInitChaVo;
	import sceneModule.model.rvo.RBattleInitVo;
	import sceneModule.model.rvo.RBattleRoundVo;
	import sceneModule.view.jingji.vo.BattleInfoVO;
	import sceneModule.view.jingji.vo.DiRenInfoVO;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.gaAndsd.view.GuaJiConfimComponent;
	
	import service.ISocketServer;

	public class JingJiMessage extends EventDispatcher
	{
		
		[Inject]
		public var progressBar:ProgressBarControl;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _event_dispatcher:IEventDispatcher;
		
		private static var _instance:JingJiMessage;
		public function JingJiMessage()
		{
		}
		
		public static function getInstance():JingJiMessage{
			if(null == _instance){
				_instance = new JingJiMessage();
			}
			
			return _instance;
		}
		
		public function getJingJiInfo():void{
			var jjReq:GetJingJiRequest = new GetJingJiRequest();
			jjReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			jjReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(jjHandler,faultHandler),URLConst.JINGJI_INFO_COMMANDID,byteArray);
		}
		
		private function jjHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetJingJiResponse = new GetJingJiResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainJingJiInfoVo.jifen = responseData.jingjiInfo.jifen;
				SystemDataModel.mainJingJiInfoVo.liansheng = responseData.jingjiInfo.liansheng;
				SystemDataModel.mainJingJiInfoVo.rank = responseData.jingjiInfo.rank;
				SystemDataModel.mainJingJiInfoVo.rankInfo = responseData.jingjiInfo.rankInfo;
				SystemDataModel.mainJingJiInfoVo.tzCount = responseData.jingjiInfo.tzCount;
				SystemDataModel.mainJingJiInfoVo.weiwang = responseData.jingjiInfo.weiwang;
				SystemDataModel.mainJingJiInfoVo.buyTZCount = responseData.jingjiInfo.addCount;
				SystemDataModel.mainJingJiInfoVo.buyReqZuan = responseData.jingjiInfo.reqCoin;
				SystemDataModel.mainJingJiInfoVo.obtainTime = responseData.jingjiInfo.obtainTime;
				startTimer();
				var l:int = responseData.jingjiInfo.battleInfoList.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var batInfo:BattleInfo = responseData.jingjiInfo.battleInfoList[i];
					var battleInfoVo:BattleInfoVO = new BattleInfoVO();
					battleInfoVo.battleStr = batInfo.battleStr;
					arr.addItem(battleInfoVo);
				}
				SystemDataModel.mainJingJiInfoVo.battleInfoList.source = arr.toArray();
//				var rl:int = responseData.jingjiInfo.drList.length;
				var rl:int = responseData.jingjiInfo.drList.length;
				var arr_role:ArrayCollection = new ArrayCollection();
				for(var ri:int=0;ri<rl;ri++){
					var difen:DiRenInfo = responseData.jingjiInfo.drList[ri];
					var dfInfoVo:DiRenInfoVO = new DiRenInfoVO();
					dfInfoVo.bId = difen.bId;
					dfInfoVo.bLevel = difen.bLevel;
					dfInfoVo.bName = difen.bName;
					dfInfoVo.bRank = difen.bRank;
					dfInfoVo.profession = difen.profession;
					arr_role.addItem(dfInfoVo);
				}
				SystemDataModel.mainJingJiInfoVo.drList.source = arr_role.toArray();
			}
		}
		private var tempId:int;
		public function cleanCD(id:int):void{
			tempId = id;
			var clReq:JingjiCleanCDRequest = new JingjiCleanCDRequest();
			clReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			clReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(clHandler,faultHandler),URLConst.JINGJI_CLEAN_CD_COMMANDID,byteArray);
		}
		
		private function clHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JingjiCleanCDResponse = new JingjiCleanCDResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				jingjiBattle(tempId);
			}
		}
		
		public function getCDTime():void{
			socketService.send(new mx.rpc.Responder(CDHandler,faultHandler),URLConst.JINGJI_CD_TIME_COMMANDID,null,false);
		}
		
		private function CDHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JingJiCDResponse = new JingJiCDResponse();
			responseData.readExternal(byteArray);
			SystemDataModel.mainJingJiInfoVo.CDTime = responseData.cdTime;
			startTimer();
		}
		
		private var timer:Timer;
		private function startTimer():void{
			if(!timer){
				timer = new Timer(1000);
				timer.addEventListener(TimerEvent.TIMER,onTimer);
			}
			
			if(!timer.running){
				if(SystemDataModel.mainJingJiInfoVo.CDTime>0 || SystemDataModel.mainJingJiInfoVo.obtainTime>0){
					timer.start();
				}
			}
		}
		
		private function onTimer(evt:TimerEvent):void{
			if(SystemDataModel.mainJingJiInfoVo.CDTime>0){
				SystemDataModel.mainJingJiInfoVo.CDTime -= 1;
			}
			if(SystemDataModel.mainJingJiInfoVo.obtainTime>0){
				SystemDataModel.mainJingJiInfoVo.obtainTime -= 1;
			}
			if(SystemDataModel.mainJingJiInfoVo.CDTime<=0 && SystemDataModel.mainJingJiInfoVo.obtainTime<=0){
				timer.stop();
			}
		}
		
		public function GetJingJiRankingInfo():void{
			var jjRankReq:JingJiRankInfoRequest = new JingJiRankInfoRequest();
			jjRankReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			jjRankReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(jjRankHandler,faultHandler),URLConst.JINGJI_RANKING_COMMANDID,byteArray,false);
		}
		
		private function jjRankHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JingJiRankInfoResponse = new JingJiRankInfoResponse();
			responseData.readExternal(byteArray);
			SystemDataModel.mainJingJiInfoVo.rankAnnou = responseData.anStr;
		}
		
		public function addJingJiCount():void{
			var addCountReq:AddJingJiCountRequest = new AddJingJiCountRequest();
			addCountReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			addCountReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(addCountHandler,faultHandler),URLConst.JINGJI_ADDCOUNT_COMMANDID,byteArray);
		}
		
		private function addCountHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:AddJingJiCountResponse = new AddJingJiCountResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainJingJiInfoVo.tzCount = responseData.bCount;
				SystemDataModel.mainJingJiInfoVo.buyTZCount = responseData.addCount;
				SystemDataModel.mainJingJiInfoVo.buyReqZuan = responseData.reqCoin;
			}
		}
		
		public function jingjiBattle(t_id:int):void{
			var abReq:ArenaBattleRequest = new ArenaBattleRequest();
			abReq.id = SystemDataModel.roleId;
			abReq.tiID = t_id;
			var byteArray:ByteArray = new ByteArray();
			abReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(abHandler,faultHandler),URLConst.JINGJI_BATTLE_COMMANDID,byteArray);
		}
		
		private function abHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:FightResponse = new FightResponse();
			responseData.readExternal(byteArray);
			Logging.log("竞技场进入战斗", Logging.o2s(responseData));
			if(responseData.result){
				//初始化战场
				//GuidEventCenter.getInstance().dispatchEvent(
					//new SwitchMaskEvent(
						//SwitchMaskEvent.SwitchMaskEvent_SHOW
					//)
				//);
				SystemDataModel.jingjiBattleFlag = true;
				this.dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_CLOSE_JINGJI));
			}else{
				popUpShow.show(responseData.message);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		public function set event_dispatcher(value:IEventDispatcher):void 
		{
			_event_dispatcher = value;
		}
		
		public function get event_dispatcher():IEventDispatcher{
			return _event_dispatcher;
		}
	}
}
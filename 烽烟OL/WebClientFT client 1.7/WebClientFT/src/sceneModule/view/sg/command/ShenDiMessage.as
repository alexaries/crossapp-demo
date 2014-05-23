package sceneModule.view.sg.command
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.shenchi.shenchi3400.GetShenChiInfoRequest;
	import proto.shenchi.shenchi3400.GetShenChiInfoResponse;
	import proto.shenchi.shenchi3400.ShenGeInfo;
	import proto.shenchi.shenchi3401.ActiveShenGeRequest;
	import proto.shenchi.shenchi3401.ActiveShenGeResponse;
	
	import sceneModule.view.sg.vo.ShenGeInfoVO;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class ShenDiMessage extends EventDispatcher
	{
		[Inject]
		public var socket:ISocketServer;
		
		private static var _instance:ShenDiMessage;
		
		public static function getInstance():ShenDiMessage{
			if(null == _instance){
				_instance = new ShenDiMessage();
			}
			return _instance;
		}
		
		public function ShenDiMessage()
		{
		}
		
		public function getShenDiInfo(page:int=1):void{
			var getSDreq:GetShenChiInfoRequest = new GetShenChiInfoRequest();
			getSDreq.id = SystemDataModel.roleId;
			getSDreq.page = page;
			var byteArray:ByteArray = new ByteArray();
			getSDreq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(sdHandler,faultHandler),URLConst.GUANDI_GETINFO_COMMANDID,byteArray);
		}
		private function sdHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetShenChiInfoResponse = new GetShenChiInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.shenDiInfo.curPage = responseData.shenChiInfo.curPage;
				SystemDataModel.shenDiInfo.des = responseData.shenChiInfo.des;
				SystemDataModel.shenDiInfo.douqi = responseData.shenChiInfo.douqi;
				SystemDataModel.shenDiInfo.maxPage = responseData.shenChiInfo.maxPage;
				SystemDataModel.shenDiInfo.nextBtnFlag = responseData.shenChiInfo.nextBtnFlag;
				var l:int = responseData.shenChiInfo.shenGeList.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var sgInfo:ShenGeInfo = responseData.shenChiInfo.shenGeList[i];
					var sgInfoVo:ShenGeInfoVO = new ShenGeInfoVO();
					sgInfoVo.activateFlag = sgInfo.activateFlag;
					sgInfoVo.reqDQ = sgInfo.reqDQ;
					sgInfoVo.sgID = sgInfo.sgID;
					sgInfoVo.sgName = sgInfo.sgName;
					sgInfoVo.sgType = sgInfo.sgType;
					sgInfoVo.sgDes = sgInfo.sgDes;
					sgInfoVo.reqLev = sgInfo.level;
					arr.addItem(sgInfoVo);
				}
				SystemDataModel.shenDiInfo.shenGeList.source = arr.toArray();
			}
		}
		
		public function onActiveShenGe(sgID:int):void{
			var acSGreq:ActiveShenGeRequest = new ActiveShenGeRequest();
			acSGreq.id = SystemDataModel.roleId;
			acSGreq.sgID = sgID;
			var byteArray:ByteArray = new ByteArray();
			acSGreq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(acHandler,faultHandler),URLConst.GUANDI_ACTIVE_SHENGE_COMMANDID,byteArray);
		}
		private function acHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ActiveShenGeResponse = new ActiveShenGeResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getShenDiInfo(SystemDataModel.shenDiInfo.curPage);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_SHENGGE)]);

			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
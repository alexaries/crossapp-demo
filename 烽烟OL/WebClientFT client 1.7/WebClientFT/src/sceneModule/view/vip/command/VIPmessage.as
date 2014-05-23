package sceneModule.view.vip.command
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.vip.vip3800.GetVIPInfoRequest;
	import proto.vip.vip3800.GetVIPInfoResponse;
	import proto.vip.vip3800.VIPInfo;
	
	import sceneModule.view.vip.VIPdataChangeEvent;
	import sceneModule.view.vip.vo.VIPInfoVO;
	
	import service.ISocketServer;

	public class VIPmessage extends EventDispatcher
	{
		[Inject]
		public var socket:ISocketServer;
		private static var _instance:VIPmessage;
		
		private var _event_dispatcher:IEventDispatcher;
		
		public function VIPmessage()
		{
		}
		
		public static function getInstance():VIPmessage{
			if(null == _instance){
				_instance = new VIPmessage();
			}
			
			return _instance;
		}
		
		public function getVipInfo():void{
			var vipReq:GetVIPInfoRequest = new GetVIPInfoRequest();
			vipReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			vipReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(vipHanlder,faultHanlder),URLConst.VIP_INFO_COMMANDID,byteArray);
		}
		
		private function vipHanlder(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetVIPInfoResponse = new GetVIPInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
				SystemDataModel.mainVipInfo.exp = responseData.data.exp;
				SystemDataModel.mainVipInfo.maxexp = responseData.data.maxexp;
				SystemDataModel.mainVipInfo.msg = responseData.data.msg;
				SystemDataModel.mainVipInfo.viplevel = responseData.data.viplevel;
				var l:int = responseData.data.vipinfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var vipInfo:VIPInfo = responseData.data.vipinfo[i];
					var vipInfoVo:VIPInfoVO = new VIPInfoVO();
					vipInfoVo.funcname = vipInfo.funcname;
					vipInfoVo.vip1cnt = vipInfo.vip1cnt;
					vipInfoVo.vip2cnt = vipInfo.vip2cnt;
					vipInfoVo.vip3cnt = vipInfo.vip3cnt;
					vipInfoVo.vip4cnt = vipInfo.vip4cnt;
					vipInfoVo.vip5cnt = vipInfo.vip5cnt;
					vipInfoVo.vip6cnt = vipInfo.vip6cnt;
					vipInfoVo.vip7cnt = vipInfo.vip7cnt;
					vipInfoVo.vip8cnt = vipInfo.vip8cnt;
					vipInfoVo.vip9cnt = vipInfo.vip9cnt;
					vipInfoVo.vip10cnt = vipInfo.vip10cnt;
					arr.addItem(vipInfoVo);
				}
				SystemDataModel.mainVipInfo.vipinfoList.source = arr.toArray();
				VIPmessage.getInstance().dispatchEvent(new VIPdataChangeEvent(VIPdataChangeEvent.VIPDATACHANGEEVENT));
			}
		}
		
		private function faultHanlder(evt:FaultEvent):void{
			
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
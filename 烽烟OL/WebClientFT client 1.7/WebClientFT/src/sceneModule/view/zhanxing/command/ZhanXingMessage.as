package sceneModule.view.zhanxing.command
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.zhanxing.XingYunBasicInfo;
	import proto.zhanxing.zhanxing3600.GetXingYunListRequest;
	import proto.zhanxing.zhanxing3600.GetXingYunListResponse;
	import proto.zhanxing.zhanxing3601.ZhanXingRequest;
	import proto.zhanxing.zhanxing3601.ZhanXingResponse;
	import proto.zhanxing.zhanxing3602.YiJianObtainAndDropRequest;
	import proto.zhanxing.zhanxing3602.YiJianObtainAndDropResponse;
	import proto.zhanxing.zhanxing3603.YJXingYunInfo;
	import proto.zhanxing.zhanxing3603.YiJianZhanXingRequest;
	import proto.zhanxing.zhanxing3603.YiJianZhanXingResponse;
	import proto.zhanxing.zhanxing3604.GetRoleAndPetListRequest;
	import proto.zhanxing.zhanxing3604.GetRoleAndPetListResponse;
	import proto.zhanxing.zhanxing3604.RoleAndPetInfo;
	import proto.zhanxing.zhanxing3605.GetPackXingYunListInfoRequest;
	import proto.zhanxing.zhanxing3605.GetPackXingYunListInfoResponse;
	import proto.zhanxing.zhanxing3605.PackInfo;
	import proto.zhanxing.zhanxing3606.YiJianHeChengRequest;
	import proto.zhanxing.zhanxing3606.YiJianHeChengResponse;
	import proto.zhanxing.zhanxing3607.OpeXingXunRequest;
	import proto.zhanxing.zhanxing3607.OpeXingXunResponse;
	
	import sceneModule.view.zhanxing.vo.RoleOrPetBasicInfoVO;
	import sceneModule.view.zhanxing.vo.XingYunBasicInfoVO;
	import sceneModule.view.zhanxing.vo.XingYunPackInfoVO;
	import sceneModule.view.zhanxing.vo.ZhanXingInfoVO;
	
	import service.ISocketServer;

	public class ZhanXingMessage extends EventDispatcher
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _event_dispatcher:IEventDispatcher;
		
		private static var _instance:ZhanXingMessage;
		public function ZhanXingMessage()
		{
		}
		
		public static function getInstance():ZhanXingMessage{
			if(null == _instance){
				_instance = new ZhanXingMessage();
			}
			
			return _instance;
		}
		
		public function getXingYuanListInfo():void{
			var getXYlistReq:GetXingYunListRequest = new GetXingYunListRequest();
			getXYlistReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getXYlistReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(xyListHandler,faultHandler),URLConst.ZHANXING_XINGYUNLIST_INFO_COMMANDID,byteArray);
		}
		
		private function xyListHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetXingYunListResponse = new GetXingYunListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.zhanxingInfo.curBX = responseData.showIndex;
				SystemDataModel.zhanxingInfo.maxCount = responseData.maxCount;
				var l:int = responseData.xyList.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var xyBaseInfo:XingYunBasicInfo = responseData.xyList[i];
					var xyInfoVo:XingYunBasicInfoVO = new XingYunBasicInfoVO();
					setXYInfo(xyInfoVo,xyBaseInfo);
					arr.addItem(xyInfoVo);
				}
				SystemDataModel.zhanxingInfo.xyList.source = arr.toArray();
			}
		}
		/**
		 * 
		 * @param type 0拾取1卖出
		 * 
		 */		
		public function ObtainOrDrop(type:int):void{
			var odReq:YiJianObtainAndDropRequest = new YiJianObtainAndDropRequest();
			odReq.id = SystemDataModel.roleId;
			odReq.type = type;
			var byteArray:ByteArray = new ByteArray();
			odReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(odHandler,faultHandler),URLConst.ZHANXING_OBTAIN_DROP_COMMANDID,byteArray);
		}
		
		private function odHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:YiJianObtainAndDropResponse = new YiJianObtainAndDropResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getXingYuanListInfo();
			}
		}
		
		public function onAutoZhanXing():void{
			var auReq:YiJianZhanXingRequest = new YiJianZhanXingRequest();
			auReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			auReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(auHandler,faultHandler),URLConst.ZHANXING_YIJIAN_ZHANXING_COMMANDID,byteArray);
		}
		
		private function auHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:YiJianZhanXingResponse = new YiJianZhanXingResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				
				tempArr = responseData.yjXYinfoList;
				onYIJIAN();
				
			}
		}
		
		private var timer:Timer;
		private var tempArr:Array;
		private function onYIJIAN():void{
			if(timer == null){
				timer = new Timer(300);
				timer.addEventListener(TimerEvent.TIMER,onTimer);
			}
			timer.start();
		}
		private function onTimer(evt:TimerEvent):void{
			if(tempArr && tempArr.length>0){
				var info:YJXingYunInfo = tempArr[0];
				SystemDataModel.zhanxingInfo.curBX = info.showIndex;
				SystemDataModel.zhanxingInfo.maxCount = info.maxCount;
				var xyInfoVo:XingYunBasicInfoVO = new XingYunBasicInfoVO();
				setXYInfo(xyInfoVo,info.xyInfo);
				SystemDataModel.zhanxingInfo.xyList.addItem(xyInfoVo);
				tempArr.shift();
			}else{
				timer.stop();
			}
		}
		
		public function ZhanXing(index:int):void{
			var zxReq:ZhanXingRequest = new ZhanXingRequest();
			zxReq.id = SystemDataModel.roleId;
			zxReq.sIndex = index;
			var byteArray:ByteArray = new ByteArray();
			zxReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(zxHandler,faultHandler),URLConst.ZHANXING_ZHANXING_COMMANDID,byteArray);
		}
		private function zxHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ZhanXingResponse = new ZhanXingResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.zhanxingInfo.curBX = responseData.showIndex;
				SystemDataModel.zhanxingInfo.maxCount = responseData.maxCount;
				var xyInfoVo:XingYunBasicInfoVO = new XingYunBasicInfoVO();
				setXYInfo(xyInfoVo,responseData.xyInfo);
				SystemDataModel.zhanxingInfo.xyList.addItem(xyInfoVo);
			}
		}
		
		public function getRoleOrPetListJia():void{
			var l:int = 5;
			var arr:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<l;i++){
				var rOPInfoVo:RoleOrPetBasicInfoVO = new RoleOrPetBasicInfoVO();
				rOPInfoVo.icon = 1;
				rOPInfoVo.rpId = 2;
				rOPInfoVo.rpLevel = 4;
				rOPInfoVo.rpName = '花为悦己者容,士为知己者死';
				rOPInfoVo.xyBody1.icon = 2;
				rOPInfoVo.xyBody1.type = 2;
				rOPInfoVo.xyBody1.xyDes = '花为悦己者容,士为知己者死';
				rOPInfoVo.xyBody1.xyId = 4;
				rOPInfoVo.xyBody1.xyName = '花为悦己者容,士为知己者死';
				rOPInfoVo.xyBody1.exp = 6;
				rOPInfoVo.xyBody1.maxexp = 7;
				rOPInfoVo.xyBody1.quality = 3;
				rOPInfoVo.xyBody1.xytemId = 2;
				rOPInfoVo.xyBody1.level = 2;
				arr.addItem(rOPInfoVo);
			}
			SystemDataModel.zhanxingInfo.ropInfoList.source = arr.toArray();
		}
		
		public function getRoleOrPetList():void{
//			getRoleOrPetListJia();
			var rpReq:GetRoleAndPetListRequest = new GetRoleAndPetListRequest();
			rpReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			rpReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(rpHandler,faultHandler),URLConst.ZHANXING_PETORROLELIST_COMMANDID,byteArray);
		}
		
		private function rpHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetRoleAndPetListResponse = new GetRoleAndPetListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.roleAndPetInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var rAndPInfoVo:RoleAndPetInfo = responseData.roleAndPetInfo[i];
					var rOPInfoVo:RoleOrPetBasicInfoVO = new RoleOrPetBasicInfoVO();
					rOPInfoVo.icon = rAndPInfoVo.icon;
					rOPInfoVo.rpId = rAndPInfoVo.rpId;
					rOPInfoVo.rpLevel = rAndPInfoVo.rpLevel;
					rOPInfoVo.rpName = rAndPInfoVo.rpName;
					if(rAndPInfoVo.xyBody1){
						setXYInfo(rOPInfoVo.xyBody1,rAndPInfoVo.xyBody1);
					}
					if(rAndPInfoVo.xyBody2){
						setXYInfo(rOPInfoVo.xyBody2,rAndPInfoVo.xyBody2);
					}
					if(rAndPInfoVo.xyBody3){
						setXYInfo(rOPInfoVo.xyBody3,rAndPInfoVo.xyBody3);
					}
					if(rAndPInfoVo.xyBody4){
						setXYInfo(rOPInfoVo.xyBody4,rAndPInfoVo.xyBody4);
					}
					if(rAndPInfoVo.xyBody5){
						setXYInfo(rOPInfoVo.xyBody5,rAndPInfoVo.xyBody5);
					}
					if(rAndPInfoVo.xyBody6){
						setXYInfo(rOPInfoVo.xyBody6,rAndPInfoVo.xyBody6);
					}
					arr.addItem(rOPInfoVo);
				}
				SystemDataModel.zhanxingInfo.ropInfoList.source = arr.toArray();
			}
		}
		
		public function getPackXingYunList():void{
			var pxyReq:GetPackXingYunListInfoRequest = new GetPackXingYunListInfoRequest();
			pxyReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			pxyReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(pxyHandler,faultHandler),URLConst.ZHANXING_XINGYUNPACK_COMMANDID,byteArray);
		}
		private function pxyHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetPackXingYunListInfoResponse = new GetPackXingYunListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.xyPackList.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var xyInfo:PackInfo = responseData.xyPackList[i];
					var xyPackInfo:XingYunPackInfoVO = new XingYunPackInfoVO();
					xyPackInfo.pos = xyInfo.postion;
					setXYInfo(xyPackInfo.xyInfoVo,xyInfo.xyInfo);
					arr.addItem(xyPackInfo);
				}
				SystemDataModel.zhanxingInfo.pkXYInfoList.source = arr.toArray();
				setEquipInfo();
			}
		}
		
		//初始化装备栏背景
		public function initEquipBackground():void{
			
			//每页总共的格子数
			var tile_count:int = 20;
			var tileArrayCollection:ArrayCollection = new ArrayCollection();
			for(var i:int=0;i<tile_count;i++){
				var packageInfo:XingYunBasicInfoVO = new XingYunBasicInfoVO();
				//格子的位置 从0开始
				packageInfo.position = i;
				tileArrayCollection.addItem(packageInfo);
			}
			SystemDataModel.zhanxingInfo.dataCollection.source = tileArrayCollection.toArray();
		}
		//设置每个格子的数据信息
		public function setEquipInfo():void{
			//先把原来的数据清理掉
			var dl:int = SystemDataModel.zhanxingInfo.dataCollection.length;
			var l:int=SystemDataModel.zhanxingInfo.pkXYInfoList.length;
			for(var di:int = 0;di<dl;di++){
				SystemDataModel.zhanxingInfo.dataCollection[di].position = di;
				SystemDataModel.zhanxingInfo.dataCollection[di].xyId=0;//星运id
				SystemDataModel.zhanxingInfo.dataCollection[di].type=0;//找图标所需
				SystemDataModel.zhanxingInfo.dataCollection[di].icon=0;//找图标所需
				SystemDataModel.zhanxingInfo.dataCollection[di].xyName='';//星运名称
				SystemDataModel.zhanxingInfo.dataCollection[di].xyDes='';//星运描述
				SystemDataModel.zhanxingInfo.dataCollection[di].price='';//星运价格
			}
			//赋值
			for(var i1:int=0;i1<l;i1++){
				var xyBasicInfoVo:XingYunPackInfoVO = SystemDataModel.zhanxingInfo.pkXYInfoList[i1];
				var index:int=xyBasicInfoVo.pos;
				SystemDataModel.zhanxingInfo.dataCollection[index].xyId=xyBasicInfoVo.xyInfoVo.xyId;//星运id
				SystemDataModel.zhanxingInfo.dataCollection[index].type=xyBasicInfoVo.xyInfoVo.type;//找图标所需
				SystemDataModel.zhanxingInfo.dataCollection[index].icon=xyBasicInfoVo.xyInfoVo.icon;//找图标所需
				SystemDataModel.zhanxingInfo.dataCollection[index].xyName=xyBasicInfoVo.xyInfoVo.xyName;//星运名称
				SystemDataModel.zhanxingInfo.dataCollection[index].xyDes=xyBasicInfoVo.xyInfoVo.xyDes;//星运描述
				SystemDataModel.zhanxingInfo.dataCollection[index].price=xyBasicInfoVo.xyInfoVo.price;//星运价格
				SystemDataModel.zhanxingInfo.dataCollection[index].level=xyBasicInfoVo.xyInfoVo.level;//星运价格
				
				SystemDataModel.zhanxingInfo.dataCollection[index].quality=xyBasicInfoVo.xyInfoVo.quality;//星运品质
				SystemDataModel.zhanxingInfo.dataCollection[index].exp=xyBasicInfoVo.xyInfoVo.exp;//星运经验
				SystemDataModel.zhanxingInfo.dataCollection[index].maxexp=xyBasicInfoVo.xyInfoVo.maxexp;//星运总经验
			}
		}
		
		public function YiJianHeCheng():void{
			var yjhcReq:YiJianHeChengRequest = new YiJianHeChengRequest();
			yjhcReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			yjhcReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(yjhcHandler,faultHandler),URLConst.ZHANXING_YIJIANHECHENG_COMMANDID,byteArray);
		}
		private function yjhcHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:YiJianHeChengResponse = new YiJianHeChengResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getPackXingYunList();
			}
		}
		
		public function OpeXingYun(type:int,fPos:int,tPos:int,id:int=0):void{
			var opReq:OpeXingXunRequest = new OpeXingXunRequest();
			opReq.id = SystemDataModel.roleId;
			opReq.opeId = id;
			opReq.fromPos = fPos;
			opReq.toPos = tPos;
			opReq.opeType = type;
			var byteArray:ByteArray = new ByteArray();
			opReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(opHandler,faultHandler),URLConst.ZHANXING_OPE_XINGYUN_COMMANDID,byteArray);
		}
		private function opHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:OpeXingXunResponse = new OpeXingXunResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				switch(responseData.oType){
					case 0:
						getRoleOrPetList();
						getPackXingYunList();
						break;
					case 1:
						getRoleOrPetList();
						getPackXingYunList();
						break;
					case 2:
						getRoleOrPetList();
						break;
					case 3:
						getPackXingYunList();
						break;
				}
			}
		}
		
		public function setXYInfo(xyInfoVo:XingYunBasicInfoVO,xyInfo:XingYunBasicInfo):void{
			xyInfoVo.icon = xyInfo.icon;
			xyInfoVo.type = xyInfo.type;
			xyInfoVo.xyDes = xyInfo.xyDes;
			xyInfoVo.xyId = xyInfo.xyId;
			xyInfoVo.xyName = xyInfo.xyName;
			xyInfoVo.exp = xyInfo.exp;
			xyInfoVo.maxexp = xyInfo.maxexp;
			xyInfoVo.quality = xyInfo.quality;
			xyInfoVo.xytemId = xyInfo.xytemId;
			xyInfoVo.level = xyInfo.level;
			xyInfoVo.price = xyInfo.price;
		}
		
		public function setXYInfoNull(xyInfoVo:XingYunBasicInfoVO):void{
			xyInfoVo.icon = 0;
			xyInfoVo.type = 0;
			xyInfoVo.xyDes = '';
			xyInfoVo.xyId = 0;
			xyInfoVo.xyName = '';
			xyInfoVo.exp = 0;
			xyInfoVo.maxexp = 0;
			xyInfoVo.quality = 0;
			xyInfoVo.xytemId = 0;
			xyInfoVo.level = 0;
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
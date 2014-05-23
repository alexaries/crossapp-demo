package sceneModule.view.blacksmith.command
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.blacksmith.blacksmith2110.GetXiangQianPackInfoRequest;
	import proto.blacksmith.blacksmith2110.GetXiangQianPackInfoResponse;
	import proto.blacksmith.blacksmith2110.XQItemInfo;
	import proto.blacksmith.blacksmith2111.GetXiangQianStoreInfoRequest;
	import proto.blacksmith.blacksmith2111.GetXiangQianStoreInfoResponse;
	import proto.blacksmith.blacksmith2112.XiangQianRequest;
	import proto.blacksmith.blacksmith2112.XiangQianResponse;
	import proto.blacksmith.blacksmith2113.UnLoadXiangQianRequest;
	import proto.blacksmith.blacksmith2113.UnLoadXiangQianResponse;
	import proto.blacksmith.blacksmith2114.GetAllHechengInfosRequest;
	import proto.blacksmith.blacksmith2114.GetAllHechengInfosResponse;
	import proto.blacksmith.blacksmith2114.HeChenInfo;
	import proto.blacksmith.blacksmith2121.CleanCDRequest;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.blacksmith.event.XiangQianDataChangeEvent;
	import sceneModule.view.blacksmith.vo.HeChenInfoVO;
	
	import service.ISocketServer;
	
	import util.PackageIitemInfoSettingUtil;

	public class BlacksmithMessage extends EventDispatcher
	{
		private static var _instance:BlacksmithMessage;
		
		[Inject]
		public var socket:ISocketServer;
		
		public static function getInstance():BlacksmithMessage{
			if(null == _instance){
				_instance = new BlacksmithMessage();
			}
			
			return _instance;
		}
		
		public function BlacksmithMessage()
		{
		}
		
		public function cleanCDHandler():void{
			var cleanReq:CleanCDRequest = new CleanCDRequest();
			cleanReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			cleanReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(cleanHandler,faultHandler),URLConst.BLACKSMITH_CLEAN_CD_COMMANDID,byteArray);
		}
		
		private function cleanHandler(data:Object):void{
			
		}
		
		public function getXQPackInfo(page:int = 1):void{
			var xqPackInfoReq:GetXiangQianPackInfoRequest = new GetXiangQianPackInfoRequest();
			xqPackInfoReq.id = SystemDataModel.roleId;
			xqPackInfoReq.page = page;
			var byteArray:ByteArray = new ByteArray();
			xqPackInfoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(xqPHandler,faultHandler),URLConst.BLACKSMITH_XQ_PACK_INFO_COMMANDID,byteArray);
		}
		
		private function xqPHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetXiangQianPackInfoResponse = new GetXiangQianPackInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.curPage = responseData.xqPackInfo.curPage;
				SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.maxPage = responseData.xqPackInfo.maxPage;
				var l:int = responseData.xqPackInfo.xqItemInfo.length;
				var itemList:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var packageItem:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(responseData.xqPackInfo.xqItemInfo[i].itemInfo.templateId); 
					PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageItem,responseData.xqPackInfo.xqItemInfo[i].itemInfo);
					if(responseData.xqPackInfo.xqItemInfo[i].inBody == 1){
						packageItem.isBodyFlag = true;
					}else{
						packageItem.isBodyFlag = false;
					}
					itemList.addItem(packageItem);
				}
				SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.itemList.source = itemList.toArray();
				this.dispatchEvent(new XiangQianDataChangeEvent(XiangQianDataChangeEvent.XIANGQIANDATACHANGE));
			}
		}
		
		public function getXQStoreInfo(page:int=1):void{
			var getStReq:GetXiangQianStoreInfoRequest = new GetXiangQianStoreInfoRequest();
			getStReq.id = SystemDataModel.roleId;
			getStReq.page = page;
			var byteArray:ByteArray = new ByteArray();
			getStReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(stHandler,faultHandler),URLConst.BLACKSMITH_XQ_STORE_INFO_COMMANDID,byteArray);
		}
		
		private function stHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetXiangQianStoreInfoResponse = new GetXiangQianStoreInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.curPage = responseData.xqStoreInfo.curPage;
				SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.maxPage = responseData.xqStoreInfo.maxPage;
				var l:int = responseData.xqStoreInfo.itemInfo.length;
				var itemList:ArrayCollection = new ArrayCollection();
				for(var i:int = 0;i<l;i++){
					var packageItem:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(responseData.xqStoreInfo.itemInfo[i].templateId); 
					PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageItem,responseData.xqStoreInfo.itemInfo[i]);
					itemList.addItem(packageItem);
				}
				SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.storeList.source = itemList.toArray();
			}
		}
		
		public function xq(itemId:int,sId:int,type:int,pos:int):void{
			var xqReq:XiangQianRequest = new XiangQianRequest();
			xqReq.id = SystemDataModel.roleId;
			xqReq.sId = sId;
			xqReq.equipId = itemId;
			xqReq.type = type;
			xqReq.position = pos;
			var byteArray:ByteArray = new ByteArray();
			xqReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(xqHandler,faultHandler),URLConst.BLACKSMITH_XQ_COMMANDID,byteArray);
		}
		
		private function xqHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:XiangQianResponse = new XiangQianResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getXQPackInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.curPage);
				getXQStoreInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.curPage);
			}
		}
		
		public function unLoadXq(itemId:int,sId:int,type:int,pos:int):void{
			var unLoadXqReq:UnLoadXiangQianRequest = new UnLoadXiangQianRequest();
			unLoadXqReq.id = SystemDataModel.roleId;
			unLoadXqReq.equipId = itemId;
			unLoadXqReq.type = type;
			unLoadXqReq.position = pos;
			var byteArray:ByteArray = new ByteArray();
			unLoadXqReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(unLoadHandler,faultHandler),URLConst.BLACKSMITH_UNLOAD_XQ_COMMANDID,byteArray);
		}
		
		private function unLoadHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:UnLoadXiangQianResponse = new UnLoadXiangQianResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getXQPackInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.curPage);
				getXQStoreInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.curPage);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		//合成
		public function getAllHeChengInfo():void{
			var hcInfoReq:GetAllHechengInfosRequest = new GetAllHechengInfosRequest();
			hcInfoReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			hcInfoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(hcHandler,faultHandler),URLConst.BLACKSMITH_HECHENG_ALL_COMMANDID,byteArray);
		}
		private function hcHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetAllHechengInfosResponse = new GetAllHechengInfosResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l1:int = responseData.data.equiplist.length;
				var arr1:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l1;i++){
					var hcInfo:HeChenInfo = responseData.data.equiplist[i];
					var hcInfoVo:HeChenInfoVO = new HeChenInfoVO();
					hcInfoVo.itemId = hcInfo.itemId;
					hcInfoVo.itemname = hcInfo.itemname;
					hcInfoVo.level = hcInfo.level;
					arr1.addItem(hcInfoVo);
				}
				var l2:int = responseData.data.gemlist.length;
				var arr2:ArrayCollection = new ArrayCollection();
				for(var i2:int=0;i2<l2;i2++){
					var hcInfo2:HeChenInfo = responseData.data.gemlist[i2];
					var hcInfoVo2:HeChenInfoVO = new HeChenInfoVO();
					hcInfoVo2.itemId = hcInfo2.itemId;
					hcInfoVo2.itemname = hcInfo2.itemname;
					hcInfoVo2.level = hcInfo2.level;
					arr2.addItem(hcInfoVo2);
				}
				SystemDataModel.mainStrInfoVo.hcInfoVo.equiplist.source = arr1.toArray();
				SystemDataModel.mainStrInfoVo.hcInfoVo.gemlist.source = arr2.toArray();
			}
		}
	}
}
package sceneModule.view.shop.command 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	
	import proto.blacksmith.blacksmith2109.GetStrengthenPackageInfoRequest;
	import proto.blacksmith.blacksmith2109.GetStrengthenPackageInfoResponse;
	import proto.scene.scene204.getItemsInPackageRequest;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.pack.vo.PackageInfoVO;
	
	import service.ISocketServer;
	
	import util.PackageIitemInfoSettingUtil;
	import util.xtrace;

	/**
	 * ...
	 * @author ...
	 */
	public class ShopMessage extends EventDispatcher
	{
		[Inject]
		public var socket:ISocketServer;
		
		private var _event_dispatcher:IEventDispatcher;
		
		private static var _instance:ShopMessage;
		public static function getInstance():ShopMessage {
			if (null == _instance) {
				_instance = new ShopMessage();
			}
			return _instance;
		}
		public function ShopMessage() 
		{
			
		}
		
		public function init_event():void {
			
		}
		
		
		//获取角色背包信息		
		public function requese_package_info(page:int=1,type:int=1):void{
			var msg:getItemsInPackageRequest = new getItemsInPackageRequest();
			msg.id = SystemDataModel.roleId;
			msg.packCategory = type;
			msg.curpage = page;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("获取角色背包数据");
			socket.send(new Responder(response_package_info,faultHandler),URLConst.GET_ITEMINPACKAGE_COMMANDID,bytes);
		}
		private function response_package_info(data:Object):void {
			xtrace("角色背包数据回复");
			_event_dispatcher.dispatchEvent(new GetRoleItemInPackageResponseEvent(GetRoleItemInPackageResponseEvent.GETROLEITEMINPACKAGEVENT,data));
		}
		
		//获取强化背包数据信息
		public function getStrengthenPackageInfo(page:int=1):void{
			var getStrReq:GetStrengthenPackageInfoRequest = new GetStrengthenPackageInfoRequest();
			getStrReq.id = SystemDataModel.roleId;
			getStrReq.curPage = page;
			var byteArray:ByteArray = new ByteArray();
			getStrReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(strPackageHandler,faultHandler),URLConst.BLACKSMITH_PACKAGE_INFO_COMMANDID,byteArray);
		}
		
		private function strPackageHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetStrengthenPackageInfoResponse = new GetStrengthenPackageInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
				SystemDataModel.strPackageInfo.curPage = responseData.data.nowPage;
				SystemDataModel.strPackageInfo.maxPage = responseData.data.maxPage;
				var l:int = responseData.data.strItemList.length;
				var itemList:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var packageItem:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(responseData.data.strItemList[i].item.templateId); 
					PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageItem,responseData.data.strItemList[i].item);
					if(responseData.data.strItemList[i].itemtag == 1){
						packageItem.isBodyFlag = true;
					}else{
						packageItem.isBodyFlag = false;
					}
					itemList.addItem(packageItem);
				}
				SystemDataModel.strPackageInfo.itemEquipInfoList.source = itemList.toArray();
			}
		}
		
		private function faultHandler(e:Object):void {
			
		}
		
		public function set event_dispatcher(value:IEventDispatcher):void 
		{
			_event_dispatcher = value;
		}
	}

}
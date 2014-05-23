package sceneModule.view.nmall.model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	
	import proto.shop.shop208.getMallItemInfoRequest;
	import proto.shop.shop208.getMallItemInfoResponse;
	import proto.shop.shop214.buyItemInMallRequest;
	import proto.shop.shop214.buyItemInMallResponse;
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.xtrace;
	
	/**
	 * ...
	 * @author hao
	 */
	public class MallMessage extends EventDispatcher
	{
		public static const MallMessage_REFRESH_ITEMS:String = "MallMessage_REFRESH_ITEMS";
		public static const MallMessage_REFRESH_MONEY:String = "MallMessage_REFRESH_MONEY";
		
		
		[Inject]
		public var socket:ISocketServer;
		[Inject]
		public var popUpShow:IPopUpShow;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private static var _instance:MallMessage;
		public static function getInstance():MallMessage {
			if (null == _instance) {
				_instance = new MallMessage();
			}
			return _instance;
		}
		
		public function MallMessage() 
		{
			_shop_items = [];
		}
		
		///////////////////////////////////////////////////
		private var _shop_items:Array;
		private var _price_items:Array;
		
		private var _cur_page:int;
		private var _max_page:int;
		private var _categores:int=1;
		
		//////////////////////////////////////////////////
		public function request_items(page:int = 1,categories:int = 1):void{
			var msg:getMallItemInfoRequest = new getMallItemInfoRequest();
			msg.id = SystemDataModel.roleId;
			msg.page = page;
			msg.categories = categories;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("申请商城信息",msg);
			socket.send(new Responder(response_items ,faultHandler),URLConst.GET_MALLSHOP_COMMANDID,bytes);
		}
		
		private function response_items(bytes:ByteArray):void {
			var msg:getMallItemInfoResponse = new getMallItemInfoResponse();
			msg.readExternal(bytes);
			xtrace("商城信息回复", msg);
			if (msg.result) {
				_cur_page = msg.data.curpage;
				_max_page = msg.data.goal;
				_shop_items = msg.data.items;
				_categores = msg.data.categories;
				_price_items = msg.data.zxItems;
				this.dispatchEvent(new Event(MallMessage_REFRESH_ITEMS));
			}
		}
		
		public function request_buy(itemId:int):void{
			var request:buyItemInMallRequest = new buyItemInMallRequest();
			request.id = SystemDataModel.roleId;
			request.itemTemplateId = itemId;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			xtrace("请求购买物品",request);
			socket.send(new mx.rpc.Responder(donateHandler,faultHandler),URLConst.GET_SHOP_ITEM,byteArray);
		}
		
		private function donateHandler(data:Object):void{
			var responseByte:ByteArray = data as ByteArray;
			var responseData:buyItemInMallResponse = new buyItemInMallResponse();
			responseData.readExternal(responseByte);
			xtrace("请求购买物品回复", responseData);
			if (responseData.result) {
				
			}else{
				//var pDes:String = "您的钻石数量不足，无法购买，请您充值。";
				//popUpShow.show(pDes);
			}
		}
		
		private function faultHandler(o:Object):void 
		{
			
		}
		
		
		
		
		public function get shop_items():Array 
		{
			return _shop_items;
		}
		
		public function get price_items():Array{
			return this._price_items;
		}
		
		public function set shop_items(value:Array):void 
		{
			_shop_items = value;
		}
		
		public function get cur_page():int 
		{
			return _cur_page;
		}
		
		public function get max_page():int 
		{
			return _max_page;
		}
		
		public function get categories():int{
			return this._categores;
		}
		
	}

}
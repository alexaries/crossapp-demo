package sceneModule.view.wordmap.model 
{
	import event.KeyFuncEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import managers.KeyBordManager;
	import model.SystemDataModel;
	import model.URLConst;
	import mx.rpc.Responder;
	import proto.map.ChangeUnionColorRequest;
	import proto.map.ChangeUnionColorResponse;
	import proto.map.InstanceMapInfosRequest;
	import proto.map.InstanceMapInfosResponse;
	import proto.map.SceneMapInfosRequest;
	import proto.map.SceneMapInfosResponse;
	import proto.scene.scene601.enterPlaceRequest;
	import proto.scene.scene601.enterPlaceResponse;
	import service.ISocketServer;
	import util.ObjectToString;
	import util.xtrace;
	/**
	 * ...
	 * @author hao
	 */
	public class MapMessage extends EventDispatcher
	{
		public static const MapMessage_EVENT_REFRESH_SELF_COLOR:String = "MapMessage_EVENT_REFRESH_SELF_COLOR";
		public static const MapMessage_EVENT_REFRESH_PLACE_COLOR:String = "MapMessage_EVENT_REFRESH_PLACE_COLOR";
		public static const MapMessage_EVENT_CLOSE_COLOR_SP:String = "MapMessage_EVENT_CLOSE_COLOR_SP";
		
		[Inject]
		public var socket:ISocketServer;
		
		private static var _instance:MapMessage;
		public static function getInstance():MapMessage {
			if (null == _instance) {
				_instance = new MapMessage();
			}
			return _instance;
		}
		
		public function MapMessage() 
		{
			_self_color = 0xFFFFFF;
		}
		////////////////////////////////////////////////////////////////////////
		
		private var _self_color:uint;
		private var _scene_infos:Array;
		private var _instance_infos:Array;
		
		////////////////////////////////////////////////////////////////////////
		//请求切换场景
		public function requese_change_map(mapid:int):void{
			var msg:enterPlaceRequest = new enterPlaceRequest();
			msg.id = SystemDataModel.roleId;
			msg.placeId = mapid;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("发送请求切换场景消息", new ObjectToString(msg).getString());
			socket.send(new Responder(response_change_map,faultHandler),URLConst.ENTER_PLACE_COMMANDID,byteArray);
		}
		
		private function response_change_map(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:enterPlaceResponse = new enterPlaceResponse();
			responseData.readExternal(acceptByte);
			xtrace("请求场景切换回复", new ObjectToString(responseData).getString());
			if (responseData.result) {
				KeyBordManager.getInstance().dispatchEvent(new KeyFuncEvent(KeyFuncEvent.KeyFuncEvent_MAP_CHANGE));
			}
		}
		
		//请求城镇地图数据
		public function requese_scene_map_info():void{
			var msg:SceneMapInfosRequest = new SceneMapInfosRequest();
			msg.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("发送请求场景地图数据", new ObjectToString(msg).getString());
			socket.send(new Responder(response_scene_map_info,faultHandler),URLConst.MAP_REQUEST_SCENE_INFOS,byteArray);
		}
		
		private function response_scene_map_info(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:SceneMapInfosResponse = new SceneMapInfosResponse();
			responseData.readExternal(acceptByte);
			xtrace("请求场景地图数据回复", new ObjectToString(responseData).getString());
			if (responseData.result) {
				_self_color = responseData.selfColor;
				_scene_infos = responseData.infos;
				this.dispatchEvent(new Event(MapMessage_EVENT_REFRESH_SELF_COLOR));
				this.dispatchEvent(new Event(MapMessage_EVENT_REFRESH_PLACE_COLOR));
			}
		}
		
		
		//请求副本组地图数据
		public function requese_instance_map_info():void{
			var msg:InstanceMapInfosRequest = new InstanceMapInfosRequest();
			msg.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("发送请求副本组地图数据", new ObjectToString(msg).getString());
			socket.send(new Responder(response_instance_map_info,faultHandler),URLConst.MAP_REQUEST_INSTANCE_INFOS,byteArray);
		}
		
		private function response_instance_map_info(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:InstanceMapInfosResponse = new InstanceMapInfosResponse();
			responseData.readExternal(acceptByte);
			xtrace("请求副本组地图数据回复", new ObjectToString(responseData).getString());
			if (responseData.result) {
				_self_color = responseData.selfColor;
				_instance_infos = responseData.infos;
				this.dispatchEvent(new Event(MapMessage_EVENT_REFRESH_SELF_COLOR));
				this.dispatchEvent(new Event(MapMessage_EVENT_REFRESH_PLACE_COLOR));
			}
		}
		
		//请求修改本军团势力颜色
		public function requese_union_color(color:uint):void{
			var msg:ChangeUnionColorRequest = new ChangeUnionColorRequest();
			msg.id = SystemDataModel.roleId;
			msg.color = color;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("发送请求副本组地图数据", new ObjectToString(msg).getString());
			socket.send(new Responder(response_union_color,faultHandler),URLConst.MAP_REQUEST_CHANGE_COLOR,byteArray);
		}
		
		private function response_union_color(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:ChangeUnionColorResponse = new ChangeUnionColorResponse();
			responseData.readExternal(acceptByte);
			xtrace("请求副本组地图数据回复", new ObjectToString(responseData).getString());
			if (responseData.result) {
				_self_color = responseData.color;
				this.dispatchEvent(new Event(MapMessage_EVENT_REFRESH_SELF_COLOR));
				this.dispatchEvent(new Event(MapMessage_EVENT_CLOSE_COLOR_SP));
			}
		}
		
		private function faultHandler(o:Object):void 
		{
			
		}
		
		public function get instance_infos():Array 
		{
			return _instance_infos;
		}
		
		public function get scene_infos():Array 
		{
			return _scene_infos;
		}
		
		public function get self_color():uint 
		{
			return _self_color;
		}
		
	}

}
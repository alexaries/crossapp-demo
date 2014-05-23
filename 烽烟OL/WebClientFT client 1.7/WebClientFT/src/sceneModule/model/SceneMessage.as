package sceneModule.model 
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import model.SystemDataModel;
	import model.URLConst;
	import mx.rpc.Responder;
	import proto.scene.scene606.SceneEntityListRequest;
	import proto.scene.scene606.SceneEntityListResponse;
	import proto.scene.scene607.SceneHeroMoveRequest;
	import proto.scene.scene607.SceneHeroMoveResponse;
	import proto.scene.scene608.SceneCreateEntityNotify;
	import proto.scene.scene609.SceneRemoveEntityNotify;
	import proto.scene.scene610.SceneEntityMoveNotify;
	import proto.scene.scene611.SceneRefreshEntityNotify;
	import service.ISocketServer;
	import util.xtrace;
	/**
	 * ...
	 * @author hao
	 */
	public class SceneMessage extends EventDispatcher
	{
		[Inject]
		public var socket:ISocketServer;
		
		private static var _instance:SceneMessage;
		public static function getInstance():SceneMessage {
			if (null == _instance) {
				_instance = new SceneMessage();
			}
			return _instance;
		}
		public function SceneMessage() 
		{
			
		}
		
		//请求场景实体列表
		public function request_scene_entity_list():void {
			var msg:SceneEntityListRequest = new SceneEntityListRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求场景实体列表", msg);
			socket.send(new Responder(response_scene_entity_list,faultHandler),URLConst.SCENE_REQUEST_ENTITY_LIST,bytes);
		}
		private function response_scene_entity_list(bytes:ByteArray):void {
			var msg:SceneEntityListResponse = new SceneEntityListResponse();
			msg.readExternal(bytes);
			xtrace("场景实体列表回复", msg);
		}
		
		//主控角色移动
		public function request_hero_move(posx:int, posy:int):void {
			var msg:SceneHeroMoveRequest = new SceneHeroMoveRequest();
			msg.id = SystemDataModel.roleId;
			msg.posx = posx;
			msg.posy = posy;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求主控角色移动", msg);
			socket.send(new Responder(response_hero_move,faultHandler),URLConst.SCENE_REQUEST_HEARO_MOVE,bytes);
		}
		private function response_hero_move(bytes:ByteArray):void {
			var msg:SceneHeroMoveResponse = new SceneHeroMoveResponse();
			msg.readExternal(bytes);
			xtrace("主控角色移动回复", msg);
		}
		
		//创建实体广播
		private function notify_create_entity(bytes:ByteArray):void {
			var msg:SceneCreateEntityNotify = new SceneCreateEntityNotify();
			msg.readExternal(bytes);
			xtrace("创建实体广播", msg);
		}
		
		//删除实体广播
		private function notify_remove_entity(bytes:ByteArray):void {
			var msg:SceneRemoveEntityNotify = new SceneRemoveEntityNotify();
			msg.readExternal(bytes);
			xtrace("删除实体广播", msg);
		}
		
		//实体移动广播
		private function notify_entity_move(bytes:ByteArray):void {
			var msg:SceneEntityMoveNotify = new SceneEntityMoveNotify();
			msg.readExternal(bytes);
			xtrace("实体移动广播", msg);
		}
		
		//更新实体广播
		private function notify_entity_refresh(bytes:ByteArray):void {
			var msg:SceneRefreshEntityNotify = new SceneRefreshEntityNotify();
			msg.readExternal(bytes);
			xtrace("刷新实体熟悉广播", msg);
		}
		
		
		private function faultHandler(e:Object):void {
			
		}
		
		public function init_event():void {
			socket.send(new Responder(notify_create_entity, faultHandler), URLConst.SCENE_NOTIFY_CREATE_ENTITY, null, false);
			socket.send(new Responder(notify_remove_entity, faultHandler), URLConst.SCENE_NOTIFY_REMOVE_ENTITY, null, false);
			socket.send(new Responder(notify_entity_move, faultHandler), URLConst.SCENE_NOTIFY_ENTITY_MOVE, null, false);
			socket.send(new Responder(notify_entity_refresh, faultHandler), URLConst.SCENE_NOTIFY_REFRESH_ENTITY_PROPERTY, null, false);
		}
		
	}

}
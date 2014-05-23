package sceneModule.view.battle.command
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import proto.copyScene.copyScene1502.escInstanceRequest;
	import proto.copyScene.copyScene1502.escInstanceResponse;
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class BattleAndCopySceneMessage extends EventDispatcher
	{
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		
		private static var _instance:BattleAndCopySceneMessage;
		
		public function BattleAndCopySceneMessage()
		{
		}
		
		public static function getInstance():BattleAndCopySceneMessage{
			if(null == _instance){
				_instance = new  BattleAndCopySceneMessage();
			}
			return _instance;
		}
		
		/**
		 * 退出副本
		 */
		public function onEscCopyScene():void{
			var espSceneQuest:escInstanceRequest = new escInstanceRequest();
			espSceneQuest.id = SystemDataModel.roleId;
			var espSceneByte:ByteArray = new ByteArray();
			espSceneQuest.writeExternal(espSceneByte);
			socketService.send(new mx.rpc.Responder(espCopySceneHandler,faultHandler),URLConst.ESC_COPYSCENE_COMMANDID,espSceneByte);
		}
		private function espCopySceneHandler(data:Object):void{
			var espByteArray:ByteArray = data as ByteArray;
			var espSceneResponse:escInstanceResponse = new escInstanceResponse();
			espSceneResponse.readExternal(espByteArray);
			if(!espSceneResponse.result){
				popUpShow.show(espSceneResponse.message);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
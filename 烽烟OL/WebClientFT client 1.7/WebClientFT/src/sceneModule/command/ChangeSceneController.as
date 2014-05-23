package sceneModule.command
{
	import com.pblabs.engine.core.LevelEvent;
	import com.pblabs.engine.core.LevelManager;
	
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Actor;
	
	import proto.scene.scene601.enterPlaceRequest;
	import proto.scene.scene601.enterPlaceResponse;
	
	import sceneModule.rcommand.trigger.PlayerLogic;
	
	import service.ISocketServer;

	/**
	 * 场景调整控制类 
	 * 此类获取PBE传进来的场景id和回调函数，和服务器交互，是否可以进行跳转 
	 * @author Yaolx
	 * 
	 */	
	public class ChangeSceneController extends Actor
	{
		[Inject]
		public var socketService:ISocketServer;
		
		
		public function ChangeSceneController()
		{
			super();
		}
		
		public function changeSceneFunction(sceneId:int):void{
			var enterRequest:enterPlaceRequest = new enterPlaceRequest();
			enterRequest.id = SystemDataModel.roleId;
			enterRequest.placeId = SystemDataModel.placeId;
			//				enterRequest.force = false;
			var byteArrayEnterPlace:ByteArray = new ByteArray();
			enterRequest.writeExternal(byteArrayEnterPlace);
			socketService.send(new mx.rpc.Responder(resultHandler,faultHandler),URLConst.ENTER_PLACE_COMMANDID,byteArrayEnterPlace);
			
		}
		private function resultHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:enterPlaceResponse = new enterPlaceResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var nextLevel:int = responseData.data.placeInfo.id;
				var levelCount:int = LevelManager.instance.levelCount;
				LevelManager.instance.unloadCurrentLevel();
				    if(nextLevel>levelCount){
//				    trace("LevelCount is not available...");
				    LevelManager.instance.loadLevel(1);
				}else{
				    LevelManager.instance.loadLevel(nextLevel);
				}
							
				LevelManager.instance.addEventListener(LevelEvent.LEVEL_LOADED_EVENT,levelLoaded);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
		
		}
		private function levelLoaded(e:LevelEvent):void{
			LevelManager.instance.removeEventListener(LevelEvent.LEVEL_LOADED_EVENT,levelLoaded);
			PlayerLogic.serverResponseHandler();
		}
	}
}
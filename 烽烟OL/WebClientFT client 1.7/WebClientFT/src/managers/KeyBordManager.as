package managers 
{
	import Animation.AnimationManager;
	
	
	import event.KeyFuncEvent;
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	
	import org.robotlegs.core.IMediatorMap;
	
	import proto.battle.battle703.BuffInfo;
	import proto.copyScene.copyScene1506.instanceActivateRequest;
	import proto.copyScene.copyScene1506.instanceActivateResponse;
	import proto.copyScene.copyScene1506.item;
	
	import sceneModule.view.copyScene.model.FuBenItemVo;
	import sceneModule.view.copyScene.model.FubenChoseItemVo;
	import sceneModule.view.copyScene.view.NCopySceneChoseView;
	import sceneModule.view.corps.event.NCropMessage;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.wordmap.model.MapConfig;
	import sceneModule.view.wordmap.model.MapMessage;
	
	import service.ISocketServer;
	
	import spark.components.RichEditableText;
	
	import util.ObjectToString;
	import util.xtrace;
	
	/**
	 * ...
	 * @author hao
	 */
	public class KeyBordManager extends EventDispatcher 
	{
		[Inject]
		public var socketServer:ISocketServer;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public var map_mediarot:IMediatorMap;
		
		private static var _instance:KeyBordManager;
		public function KeyBordManager() 
		{
			_cur_key_code = -1;
			_log = "";
		}
		public static function getInstance():KeyBordManager {
			if (null == _instance) {
				_instance = new KeyBordManager();
			}
			return _instance;
		}
		/////////////////////////////////////////////////////////////////////////
		private var _cur_key_code:int;
		private var _log:String;
		/////////////////////////////////////////////////////////////////////////
		public function init(stage:Stage):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
		}
		
		
		private function key_down(e:KeyboardEvent):void {
			var tar:Object = e.target;
			
			if (tar is RichEditableText) {
				if(e.altKey){
					
				}
				else {
					return;
				}
			}
			
			if (_cur_key_code != e.keyCode) {
				_cur_key_code = e.keyCode;
				//xtrace('key_down', e.keyCode);
				exec_key_func(e.keyCode);
			}
			
		}
		private function key_up(e:KeyboardEvent):void {
			//xtrace('key_up', e.keyCode);
			_cur_key_code = -1;
		}
		
		
		private function exec_key_func(key_code:int):void {
			switch (key_code) 
			{
				case 27://ESC
					WindowManager.closeAllWindows();
					break;
				case 67: //"C"
//					if (SystemDataModel.placeId == 1000) {
//						MapMessage.getInstance().requese_change_map(1100);
//					}
//					else {
//						MapMessage.getInstance().requese_change_map(1000);
//					}
					break;
				case 76: //"L"
					System.gc();
					break;
				case 77: //"M"
					this.dispatchEvent(new KeyFuncEvent(KeyFuncEvent.KeyFuncEvent_MAP_CHANGE));
					break;
				case 119://"F8"
					System.setClipboard(_log);
					break;
				case 122://"F11"
					TaskMessage.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_SHOE_PRICE));
					var animation:AnimationManager = new AnimationManager("Task_PreRes","Task_accept_swf");
					animation.addToParent();
					animation.setPosition(300,160);
//					animation.play();
					break;
				case 73://'I'
					//Logger.print(this,WindowManager.getModalStr());
					break;
				case 80://P
					SoundManager.getInstance().stopAll();
					break;
				default:
					break;
				
			}
		}
		
		
		public function log(msg:String):void {
			_log += (new Date().toTimeString() + " : " + msg + "\n");
		}
		
		public function cmd(msg:String):void {
			var arr:Array = msg.split(new RegExp(" +"));
			if (arr.length > 1) {
				if ("/debug" == arr[0]) {
					if ("" == arr[arr.length - 1]) {
						arr.pop();
					}
					switch (arr[1]) 
					{
						case "cp":
							System.setClipboard(_log);
							break;
						case "union":
							NCropMessage.getInstance().request_single_union_info(arr[2]);
							break;
						case "gc":
							System.gc();
							break;
						default:
							break;
					}
				}
			}
		}
		
		
		
		//////////////////////////////////////////////////////////////////////////
		//test
		
		private function faultHandler(e:Object):void {
			
		}
	}

}
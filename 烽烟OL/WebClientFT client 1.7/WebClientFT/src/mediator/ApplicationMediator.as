package mediator
{
	import Animation.AnimationOnceManager;
	import wordscene.WordSceneSprite;
	
	import com.greensock.TweenLite;
	
	import event.ApplicationReplaceModuleEvent;
	import event.ChangeModuleEvent;
	import event.ClientResourceEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	import event.PreLoadResProgressEvent;
	import event.ProgressLoadEvent;
	import event.ProgressLoadSwitchSceneEvent;
	import event.SceneInitCompleteEvent;
	import event.SceneInitCompleteManager;
	import event.SwitchMaskEvent;
	
	import factory.PBEFactory;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import interfaces.ILogonModule;
	
	import logonModule.command.LoginMessage;
	import logonModule.event.NLoginEvent;
	import logonModule.mediator.LoginPageMediator;
	import logonModule.view.ConserverAlert;
	
	import managers.WindowManager;
	
	import model.ApplicationModel;
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	import mx.core.SoundAsset;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.utils.URLUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.group.group905.OtherMessage;
	import proto.joke.joke10000.JokeMessage;
	import proto.login.login10001.getVersionResponse;
	import proto.login.login101.loginToServerRequest;
	import proto.login.login101.loginToServerResponse;
	import proto.login.login103.roleLoginRequest;
	import proto.login.login103.roleLoginResponse;
	import proto.scene.scene601.enterPlaceRequest;
	import proto.scene.scene601.enterPlaceResponse;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	import resource.ModuleList;
	
	import sceneModule.rcommand.debug.MyBox2DDebugComponent;
	import sceneModule.rcommand.scene.bg.RepeatingRenderComponent;
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnly;
	import sceneModule.rcommand.trigger.Box2DTrigger;
	import sceneModule.view.Alert.view.CrotaBasicAlert;
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.corps.view.NCorpAlert;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.popupWin.PopUpWindow;
	
	import service.ISocketServer;
	
	import util.AppVersion;
	import util.DelayExcuter;

	/**
	 * 整个应用的mediator，用来处理应用的Module关系。 
	 * @author mutou
	 * 
	 */	
	public class ApplicationMediator extends Mediator
	{
		
		[Inject]
		public var webClient:WebClient;
		
		[Inject]
		public var socketService:ISocketServer;
		
		/**
		 * 应用级数据模型 
		 */		
		[Inject]
		public var mdl:ApplicationModel;
		
		[Inject]
		public var moduleList:ModuleList;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		/**
		 * 模块实例 
		 */		
		private var _visElement:IVisualElement;
		private var _oldElement:IVisualElement;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var mySo:SharedObject;//
		
		public function ApplicationMediator()
		{
			super();
		}
		
		override public function onRegister():void{
//			socketService.connect(onConnectSucc);
			
			//模块切换事件
			this.addContextListener(ApplicationReplaceModuleEvent.APPLICATION_REPLACE_MODULE, replaceModule);
			//加载进度事件
			this._eventDispatcher.addEventListener(ProgressLoadEvent.PROGRESSLOAD,onProgressLoad);
			
			SceneInitCompleteManager.getInstance().addEventListener(SceneInitCompleteEvent.SCENEINITCOMPLETE,onSceneInitComplete);
			
			//预加载配置文件
			this._eventDispatcher.addEventListener(PreLoadResProgressEvent.PROLOADRESPROGRESS,onPreLoadResProgress);
			//预加载图片资源
			AssetCenter.getInstance().addEventListener(PreLoadResProgressEvent.PRELOADPRERESPROGRESS,onPreLoadPreResProgress);
			//预加载Zip文件
			this._eventDispatcher.addEventListener(PreLoadResProgressEvent.PRELOADZIPRESPROGRESS,onPreLoadZipResProgress);
			
			this._eventDispatcher.addEventListener(ClientResourceEvent.PRELOAD_COMMON_RESOURCE_COMPLETE,onLoginToGame);
			//获取服务器版本号
			onAddEventListenerVersion();
			
			//添加娱乐监听
			addJokeEventListener();
			//初始化PBE环境
			initPBE();	
			//服务器推送的消息
			addInjectEventListener();
			LoginMessage.getInstance().addEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_CON, show_con2server_alert);
			LoginMessage.getInstance().addEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER, close_con2server_alert);
		}
		private var ca:ConserverAlert;
		private function show_con2server_alert(e:NLoginEvent):void {
			SystemDataModel.is_logining = true;
		}
		private function close_con2server_alert(e:NLoginEvent):void {
			SystemDataModel.is_logining = false;
		}
		
		private function onSceneInitComplete(evt:SceneInitCompleteEvent):void{
			_visElement.alpha = 1;
		}
		
		private function onLoginToGame(evt:ClientResourceEvent):void{
			onEnterGame();
		}
		
		/**
		 * 
		 * @param e 响应进入游戏事件 enterGame
		 * 
		 */		
		private function onEnterGame():void{
//			CrotaCommonAlert.createCrotaBasicAlert(FlexGlobals.topLevelApplication.parameters.toString());
//			var param_obj:Object = FlexGlobals.topLevelApplication.parameters;
//			var param_str1:String = "";
//			var param_str2:String = "";
//			for (var item:String in param_obj){
//				param_str1 += item +"="+param_obj[item]+"&";
//			}
//			param_str2 = param_str1.substr(0,param_str1.length-1);
//			var param_str2:String
//			if(ExternalInterface.available){
//				try{
//					param_str2 = ExternalInterface.call("parent.location.search.substring", 1);
//				}catch(err:Error){
//				}
//			}
//			param_str2 = "user_id=yt&server_id=dz1&cm=n&timetamp=1341491122&ly=1&sign=5D8F09B85A886C1799AEE241D7F37829";
//			var linkStr:String = 'user_id='+o.user_id+'&server_id='+o.server_id+'&cm='+o.cm+'&timetamp='+o.timetamp+'&ly='+o.ly+'&sign='+o.sign;
//			
//			Alert.show(str2);
//			var bm:IBrowserManager = BrowserManager.getInstance();
//			bm.init();
//			bm.setFragment('xiaolannimei');
//			var para:String = 'url:'+bm.url+'base:'+bm.base+'title:'+bm.title+'fragment:'+bm.fragment;
//			Alert.show(bm.fragment.toString());
//			Alert.show(param_str2);
//			if(param_str2 != ''){
//				mySo = SharedObject.getLocal("webClientURL");
//				mySo.clear();
//				mySo.data.urlPas = param_str2; 
//				var flushStatus:String = null;
//				try {
//					mySo.flush();
//				} catch (error:Error) {
//					trace("保存出错，flush() error");
//				}
//				
//				//onLogin(param_str2);
//				if(ExternalInterface.available){
//					ExternalInterface.call("reUrl");
//				}
//			}else{
//				mySo = SharedObject.getLocal("webClientURL");
//				onLogin(mySo.data.urlPas);
////				dispatch(new ChangeModuleEvent(moduleList.LOGON_MODULE));
//			}
//			bm.setFragment('');
//			bm.setTitle(WebClient.title);
			dispatch(new ChangeModuleEvent(moduleList.LOGON_MODULE));
			return;
//			
//			var param_str2:String = "user_id=2&server_id=dz1&cm=1&timetamp=1343956957&ly=1&sign=6021643F9043F54C60DCF4D0DD33B7F8";
//			onLogin(param_str2);
//			return;
			if(ExternalInterface.available){
				var mySignInfo:String = ExternalInterface.call("getCookie",WebClient.MY_SIGN_INFO_STR);
				if(mySignInfo){
					onLogin(mySignInfo);
					return;
				}
			}
			mySo = SharedObject.getLocal(WebClient.MY_SIGN_INFO_STR);
			if(mySo.data.savedSignValue){
				onLogin(mySo.data.savedSignValue);
				return;
			}
			toPlatmLogin();
		}
		
		private function toPlatmLogin():void{
			var popUpWin:PopUpWindow = new PopUpWindow();
			webClient.guidLayer.addChild(popUpWin);
			popUpWin.popInfo.text = '用户名密码过期！请重新登录！1秒后自动跳到登录界面！';
			popUpWin.titleLabel.text=CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts');
			popUpWin.submitBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd');
			popUpWin.cancelBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx');
			popUpWin.x = (FlexGlobals.topLevelApplication.width-popUpWin.width)*0.5;
			popUpWin.y = (FlexGlobals.topLevelApplication.height-popUpWin.height)*0.5;
			popUpWin.submitBtn.visible = false;
			popUpWin.cancelBtn.visible = false;
			new DelayExcuter(1000,function():void{
				ExternalInterface.call("reLogin");
			},null);
		}
		
		private function onLogin(urlStr:String):void{
			if(urlStr == null || urlStr == "" || urlStr.length == 0){
				toPlatmLogin();
				return;
			}
			var request:loginToServerRequest = new loginToServerRequest();
			request.user = urlStr;
			loginStr = urlStr;
			request.password = '';
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(resultHandler,faultHandler),URLConst.LOGIN_REQUEST_COMMANDID,byteArray);
		}
		
		/**
		 * 返回值处理
		 * 
		 */
		private var loginNum:int;
		private var loginStr:String;
		private function resultHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:loginToServerResponse = new loginToServerResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.userInfo.userId = responseData.data.userId;
				SystemDataModel.roleId = responseData.data.defaultId;
				if(responseData.data.hasRole){
					onEnterGameSendCommand(responseData.data.defaultId);
				}else{
					dispatch(new ChangeModuleEvent(moduleList.CREATE_ROLE_MODULE));
				}
			}else{
				loginNum+=1;
				if(loginNum<=3){
					new DelayExcuter(3000,function():void{
						onLogin(loginStr);
					},null);
				}
			}
			
		}
		
		/**
		 * 进入游戏指令调用
		 */
		private function onEnterGameSendCommand(rId:int):void {
			var request:roleLoginRequest = new roleLoginRequest();
			request.id = rId;
			request.userId = SystemDataModel.userInfo.userId;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(resultEnterGameHandler, faultHandler), URLConst.ENTER_GAME_COMMANDID, byteArray);
		}
		/**
		 *进入游戏Result 
		 */	
		private function resultEnterGameHandler(data:Object):void {
			var byteArray:ByteArray = data as ByteArray;
			var responseData:roleLoginResponse = new roleLoginResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.placeId = responseData.data.placeId;
				var enterRequest:enterPlaceRequest = new enterPlaceRequest();
				enterRequest.id = SystemDataModel.roleId;
				enterRequest.placeId = SystemDataModel.placeId;
				var byteArrayEnterPlace:ByteArray = new ByteArray();
				enterRequest.writeExternal(byteArrayEnterPlace);
				socketService.send(new mx.rpc.Responder(resultEnterPlaceHandler,faultHandler),URLConst.ENTER_PLACE_COMMANDID,byteArrayEnterPlace);
			}
		}
		
		/**
		 * resultEnterPlaceHandler 
		 * @param data
		 * 
		 */	
		private function resultEnterPlaceHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:enterPlaceResponse = new enterPlaceResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.placeId = responseData.data.placeId;
				dispatch(new ChangeModuleEvent(moduleList.SCENE_MODULE));
			}else{
				
			} 
		}
		
		private function onConnectSucc():void{
			
		}
		
		private function initPBE():void{
			//PBE.registerType(com.pblabs.box2D.Box2DDebugComponent);
			//PBE.registerType(com.pblabs.box2D.Box2DManagerComponent);
			//PBE.registerType(com.pblabs.box2D.Box2DSpatialComponent);
			//PBE.registerType(com.pblabs.box2D.CircleCollisionShape);
			//PBE.registerType(com.pblabs.box2D.PolygonCollisionShape);
			//PBE.registerType(com.pblabs.rendering2D.SimpleSpatialComponent);
			//PBE.registerType(com.pblabs.rendering2D.ui.FlexSceneView);
			//PBE.registerType(com.pblabs.rendering2D.SpriteRenderer);
			//PBE.registerType(com.pblabs.rendering2D.SpriteSheetRenderer);
			//PBE.registerType(com.pblabs.rendering2D.spritesheet.SpriteSheetComponent);
			//PBE.registerType(com.pblabs.rendering2D.spritesheet.CellCountDivider);
			//PBE.registerType(sceneModule.rcommand.scene.bg.RepeatingRenderComponent);
			//PBE.registerType(sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnly);
			//PBE.registerType(sceneModule.rcommand.debug.MyBox2DDebugComponent);
			//PBE.registerType(sceneModule.rcommand.trigger.Box2DTrigger);
			//PBE.registerType(sceneModule.rcommand.trigger.PlayerLogic);
			//todo wordscene
			//PBE.startup(webClient.scene);
			//PBE.initializeScene(PBEFactory.createSceneView(webClient.scene.width, webClient.scene.height));
			webClient.scene.addChild(WordSceneSprite.getInstance());
		}
		/**
		 * 模块加载进度
		 * @param evt
		 */
		private function onProgressLoad(evt:ProgressLoadEvent):void{
			if(evt.e.bytesLoaded != evt.e.bytesTotal){
				webClient.proBar.visible = true;
				if(evt.e.module.url == "logonModule/LogonModule"+AppVersion.appVersionStr+".swf"){
					webClient.proBar.setLoadProgressInfo((evt.e.bytesLoaded/evt.e.bytesTotal),false,'%5/5');
				}else if(evt.e.module.url == "sceneModule/SceneModule"+AppVersion.appVersionStr+".swf"){
					webClient.proBar.setLoadProgressInfo((evt.e.bytesLoaded/evt.e.bytesTotal),false,'%1/2');
				}else{
					webClient.proBar.setLoadProgressInfo((evt.e.bytesLoaded/evt.e.bytesTotal),false);
				}
				
			}
		}
		
		private function onPreLoadResProgress(evt:PreLoadResProgressEvent):void{
			if(!webClient.proBar.visible){
				webClient.proBar.visible = true;
			}
			webClient.proBar.setLoadProgressInfo(Number(evt.loadPer),false,'%2/5');
		}
		
		private function onPreLoadPreResProgress(evt:PreLoadResProgressEvent):void{
			if(!webClient.proBar.visible){
				webClient.proBar.visible = true;
			}
			webClient.proBar.setLoadProgressInfo(Number(evt.loadPer),false,'%4/5');
		}
		
		private function onPreLoadZipResProgress(evt:PreLoadResProgressEvent):void{
			if(!webClient.proBar.visible){
				webClient.proBar.visible = true;
			}
			webClient.proBar.setLoadProgressInfo(Number(evt.loadPer),false,'%3/5');
		}
		
		/**
		 * 切换模块 
		 * @param evt
		 * 
		 */		
		private function replaceModule(evt:ApplicationReplaceModuleEvent):void
		{
			if(_visElement != null)
			{
				this._oldElement = _visElement;
			}
			_visElement = mdl.getActiveModule();
			_visElement.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			_visElement.alpha = 0;
			_visElement = webClient.sceneLayer.addElement(_visElement);
			if(this._oldElement != null){
				_oldElement.alpha = 0;
			}
				//隐藏切换场景
			GuidEventCenter.getInstance().dispatchEvent(new SwitchMaskEvent(SwitchMaskEvent.SwitchMaskEvent_HIDE));
		}
		/**
		 * 当前活动的模块添加到舞台
		 * @param evt
		 */
		private function onAddToStage(evt:Event):void
		{
			if(mdl.getLoadModule() != 'sceneModule'){
				TweenLite.to(webClient.proBar, 1, {alpha:0.0, onComplete:hideProBar});
				_visElement.alpha = 1;
			}else {
				//移除原来模块
				removeOldElement();
			}
		}
		
		private function hideProBar():void
		{
			webClient.proBar.alpha = 1;
			webClient.proBar.visible = false;
			removeOldElement();
		}
		
		private function removeOldElement():void{
			//移除原来模块
			if(null != _oldElement)
			{
				webClient.sceneLayer.removeElement(_oldElement);
			}
		}
		/**
		 * 监听消息
		 */
		private function addJokeEventListener():void{
			socketService.send(new mx.rpc.Responder(jokeHandler,faultHandler),10000,null,false);
		}
	
		private function jokeHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JokeMessage = new JokeMessage();
			responseData.readExternal(byteArray);	
			var animation:AnimationOnceManager = new AnimationOnceManager("assets/ghost.swf");
			animation.addToParent();
			animation.setPosition(150,50);
			animation.play();
		}
		/**
		 * 版本号
		 */
		private function onAddEventListenerVersion():void{
			socketService.send(new mx.rpc.Responder(versionHandler,faultHandler),10001,null,false);
		}
		/**
		 * 服务器返回的版本号
		 */
		private function versionHandler(data:Object):void{
			var versionByteArray:ByteArray  = data as ByteArray;
			var versionResponseData:getVersionResponse = new getVersionResponse();
			versionResponseData.readExternal(versionByteArray);
			webClient.versionLab.text = "appVer:"+AppVersion.appVersionStr+" -- resVer:"+AppVersion.versionStr+"\r\n"+versionResponseData.version;
		}
		/**
		 * 
		 * 添加服务器推送的消息
		 */
		private function addInjectEventListener():void{
			socketService.send(new Responder(resultRejectServerGroupHandler,faultHandler),URLConst.REJECT_SERVERINFO_COMMANDID,null,false);
		}
		/**
		 * 
		 */
		private function resultRejectServerGroupHandler(data:Object):void{
			var serverInfoByteArray:ByteArray =data as ByteArray;
			var otherInfo:OtherMessage = new OtherMessage();
			otherInfo.readExternal(serverInfoByteArray);
			CrotaCommonAlert.createCrotaBasicAlert(otherInfo.msg);
//			WindowManager.createWindow(NCorpAlert.NAME,{msg:otherInfo.msg,tips:"tips"},null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
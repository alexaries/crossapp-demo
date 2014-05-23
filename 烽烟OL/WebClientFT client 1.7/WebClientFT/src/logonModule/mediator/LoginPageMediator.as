package logonModule.mediator
{
	import event.ChangeModuleEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import logonModule.LogonModule;
	import logonModule.command.LoginMessage;
	import logonModule.event.LoginPageEvent;
	import logonModule.event.NLoginEvent;
	import logonModule.view.ConserverAlert;
	import logonModule.view.LoginPageView;
	
	import managers.WindowManager;
	
	import model.GuideInfo;
	import model.ServerConfig;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guide.guide1603.beginnersLoginReponse;
	import proto.guide.guide1603.beginnersLoginRequest;
	import proto.login.login101.loginToServerRequest;
	import proto.login.login101.loginToServerResponse;
	import proto.login.login101.roleInfo;
	import proto.login.login103.roleLoginRequest;
	import proto.login.login103.roleLoginResponse;
	import proto.scene.scene601.enterPlaceRequest;
	import proto.scene.scene601.enterPlaceResponse;
	
	import resource.CrotaResourceConfig;
	import resource.ModuleList;
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.DefaultTokenHandler;
	import service.ISocketServer;
	
	import util.ByteArrayUtil;
	import util.xtrace;
	
	public class LoginPageMediator extends Mediator
	{
		public function LoginPageMediator()
		{
			super();
		}
		
		[Inject]
		public var loginPageView:LoginPageView;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var moduleList:ModuleList;
		
		[Inject]
        public var serverConfig:ServerConfig;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		override public function onRegister():void{
//			this.addViewListener(RegPageEvent.SWITCH_TO_REGPAGEVIEW,switchToRegPageView);2012.3.1
			this.addViewListener(LoginPageEvent.ENTER_GAME,con_to_server);
			this.addViewListener(ChangeModuleEvent.CHANGE_MODULE_EVENT, onChangeModule);
			
			LoginMessage.getInstance().addEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_CON, show_con2server_alert);
			LoginMessage.getInstance().addEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER, close_con2server_alert);
		}
		override public function preRemove():void {
			LoginMessage.getInstance().removeEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_CON, show_con2server_alert);
			LoginMessage.getInstance().removeEventListener(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER, close_con2server_alert);
		}
		/**
		 * 
		 * @param e 响应切换到注册页面事件 switchToRegPageView
		 * 
		 */		
//		private function switchToRegPageView(e:RegPageEvent):void{      2012.3.1
//			trace("点击立即注册后，切换到注册页面");
//			dispatch(new ChangeModuleEvent(moduleList.REGIST_MODULE));
//		}
		/**
		 * HomePage
		 * HomePage
		 */
		private function onFirstEnter(evt:MouseEvent):void{
			//从服务器获取临时id
			getTempIdFrmoServer();
		}
		/**
		 * 从服务器获取临时id
		 */
		private function getTempIdFrmoServer():void{
			var guideRequest:beginnersLoginRequest = new beginnersLoginRequest();
			var guideByteArray:ByteArray = new ByteArray();
			guideRequest.writeExternal(guideByteArray);
			socketServer.send(new mx.rpc.Responder(guideHandler,faultHandler),URLConst.GETTEMPID_FROMSERVER_COMMANDID,guideByteArray);
		}
		/**
		 * 获取临时id返回处理
		 */
		private function guideHandler(data:Object):void{
			var guideByte:ByteArray = data as ByteArray;
			var guideResponse:beginnersLoginReponse = new beginnersLoginReponse();
			guideResponse.readExternal(guideByte);
			if(guideResponse.result){
				SystemDataModel.guideTempId = guideResponse.data;
				SystemDataModel.isGuideFlag = true;
				dispatch(new ChangeModuleEvent(moduleList.CREATE_ROLE_MODULE));
			}else{
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('logonModule','lpM_sxllq'));
			}
		}
		/**
		 * 
		 */
		private function onChangeModule(evt:ChangeModuleEvent):void{
		    dispatch(evt);
		}
		
		
		private function con_to_server(e:LoginPageEvent):void {
			onEnterGame();
//			socketServer.connect(onEnterGame);
		}
		
		private function show_con2server_alert(e:NLoginEvent):void {
			xtrace("显示连接到服务器提示框");
			WindowManager.createWindow(ConserverAlert.NAME, { msg:CrotaResourceConfig.getInstance().getTextByModuleAndId('logonModule','lpM_ljfwq') }, null, false, false, false, null, this.mediatorMap, popUpWindowLayer);
			SystemDataModel.is_logining = true;
		}
		private function close_con2server_alert(e:NLoginEvent):void {
			xtrace("关闭连接到服务器提示框");
			SystemDataModel.is_logining = false;
			WindowManager.closeWindow(ConserverAlert.NAME);
		}
		
		/**
		 * 
		 * @param e 响应进入游戏事件 enterGame
		 * 
		 */		
		private function onEnterGame():void{
			var request:loginToServerRequest = new loginToServerRequest();
			request.user= loginPageView.usernameTxt.text;
			request.password = loginPageView.passwordTxt.text;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(resultHandler,faultHandler),URLConst.LOGIN_REQUEST_COMMANDID,byteArray);
			
		}
		
		/**
		 * 返回值处理
		 * 
		 */
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
//				dispatch(new ChangeModuleEvent(moduleList.CREATE_ROLE_MODULE));
			}else{
				popUpShow.show(responseData.message);
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
			socketServer.send(new Responder(resultEnterGameHandler, faultHandler), URLConst.ENTER_GAME_COMMANDID, byteArray);
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
				socketServer.send(new mx.rpc.Responder(resultEnterPlaceHandler,faultHandler),URLConst.ENTER_PLACE_COMMANDID,byteArrayEnterPlace);		
			}else{
				popUpShow.show(responseData.message);
				
			}
			SystemDataModel.is_loading = false;
			
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
//				trace('EnterPlaceResponseCommand'+SystemDataModel.placeId);
				dispatch(new ChangeModuleEvent(moduleList.SCENE_MODULE));
			}else{
				
			} 
		}
		private function faultHandler(fe:FaultEvent, token:Object=null):void
		{
			popUpShow.show(fe.fault.faultDetail);
			
		}
			
	}
}
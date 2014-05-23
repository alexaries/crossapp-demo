package createRoleModule.mediator
{
	import createRoleModule.view.CreateRoleView;
	
	import event.ChangeModuleEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guide.guide1606.getRandomNameRequest;
	import proto.guide.guide1606.getRandomNameResponse;
	import proto.login.login102.activeNewPlayerRequest;
	import proto.login.login102.activeNewPlayerResponse;
	import proto.login.login103.roleLoginRequest;
	import proto.login.login103.roleLoginResponse;
	import proto.scene.scene601.enterPlaceRequest;
	import proto.scene.scene601.enterPlaceResponse;
	
	import resource.ModuleList;
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class CreateRoleViewMediator extends Mediator
	{
		[Inject]
		public var comp:CreateRoleView;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var moduleList:ModuleList;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		private var _is_enter_ing:Boolean;
		public function CreateRoleViewMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submit,MouseEvent.CLICK,onCreateRole);
			this.eventMap.mapListener(comp.radomName,MouseEvent.CLICK,onRadomName);
			//随即名称
			onRadomName();
		}
		
		private function onRadomName(evt:MouseEvent = null):void{
			var requestRandomName:getRandomNameRequest = new getRandomNameRequest();
			var byteArray:ByteArray = new ByteArray();
			requestRandomName.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(randomNameHandler,faultHandler),URLConst.GETRANDOMNAME_GUIDE_COMMANDID,byteArray);
		}
		private var randomCount:int;
		private function randomNameHandler(data:Object):void{
			var byteArrayRes:ByteArray = data as ByteArray;
			var responseData:getRandomNameResponse = new getRandomNameResponse();
			responseData.readExternal(byteArrayRes);
			if(responseData.result){
				
				comp.roleName.text = responseData.name;
				if(randomCount==0){
					comp.roleName.setFocus();
					comp.roleName.selectRange(0,comp.roleName.text.length );//
				}else{
					comp.roleName.setFocus();
					comp.roleName.selectRange(0,0 );//
				}
				randomCount++;
				comp._subBtnCanClick = true;
			}else{
				popUpShow.show(responseData.message);
			}
		}
		
		/**
		 * 创建角色进入游戏
		 */
		private function onCreateRole(evt:MouseEvent):void{
			if (_is_enter_ing) {
				return;
			}
			//收集所创建的角色信息，发送至服务器
			var request:activeNewPlayerRequest = new activeNewPlayerRequest();
			request.userId = SystemDataModel.userInfo.userId;
			request.nickName = comp.roleName.text;
			request.profession = comp.preWorkType;
			var byteArray:ByteArray = new ByteArray();
			request.writeExternal(byteArray);
			socketService.send(new Responder(resultHandler, faultHandler), URLConst.CREATE_ROLE_COMMANDID, byteArray);
			_is_enter_ing = true;
		}
		/**
		 * 返回值处理
		 * 
		 */
		private function resultHandler(data:Object):void {
			try 
			{
				var byteArray:ByteArray = data as ByteArray;
				var responseData:activeNewPlayerResponse = new activeNewPlayerResponse();
				responseData.readExternal(byteArray);
				if(responseData.result == false){
					_is_enter_ing = false;
					popUpShow.show(responseData.message);
					return;
				}
				SystemDataModel.roleId = responseData.data.newCharacterId;
				onEnterGameSendCommand(responseData.data.newCharacterId);
			}
			catch (err:Error)
			{
				_is_enter_ing = false;
				throw err;
			}
			//				createRolePageView.onCancelAndSubmit();
			//创建角色成功后直接进入场景
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
			socketService.send(new Responder(resultEnterGameHandler, faultHandler), URLConst.ENTER_GAME_COMMANDID, byteArray);
			_is_enter_ing = true;
		}
		/**
		 *进入游戏Result 
		 */	
		private function resultEnterGameHandler(data:Object):void {
			_is_enter_ing = false;
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
			trace(fe.fault.faultDetail);
			_is_enter_ing = false;
		}
	}
}
package sceneModule.view.corps.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1305.AppliOrUnsubscribeRequest;
	import proto.corps.corps1305.AppliOrUnsubscribeResponse;
	import proto.corps.corps1308.CrusadeCorpsRequest;
	import proto.corps.corps1308.CrusadeCorpsResponse;
	
	import sceneModule.view.corps.view.CorpsInfoComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class CorpsInfoComponentMediator extends Mediator
	{
		[Inject]
		public var comp:CorpsInfoComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function CorpsInfoComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.contactChief,MouseEvent.CLICK,onContactChief);
			this.eventMap.mapListener(comp.functionBtn,MouseEvent.CLICK,onFunctionClick);
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onClokeClick);
		}
		/**
		 * 联系军团长 
		 */		
		private function onContactChief(evt:MouseEvent):void{
			//TODO
			
			onCloseWindowAndRemoveListener();
		}
		/**
		 * 讨伐，申请，取消申请，联系军团长功能按钮
		 */		
		private function onFunctionClick(evt:MouseEvent):void{
			if(SystemDataModel.roleInfo.roleCorpsInfo.joinCorpsFlag){
				//如果是军团长
				if(SystemDataModel.roleInfo.roleCorpsInfo.corpsPosition == ProConst.CORPSCHIEFMEMBERS){
					//立即讨伐;
					onCrusadeCorps();
				}else{
					//TODO联系团长;
				}
			}else{
				if(comp.data.onApplication){
					//取消申请;
					appliOrUnsubsribe(1);
				}else{
					//申请入团;
					appliOrUnsubsribe(0);
				}
			}
		}
		/**
		 * 申请或取消申请加入军团 
		 * @param operType 操作类型 0申请加入军团1取消申请加入军团
		 */
		private function appliOrUnsubsribe(operType:int):void{
			var appliOrUnSubSribeReq:AppliOrUnsubscribeRequest = new AppliOrUnsubscribeRequest();
			appliOrUnSubSribeReq.id = SystemDataModel.roleId;
			appliOrUnSubSribeReq.corpsId = comp.data.corpsId;
			appliOrUnSubSribeReq.operType = operType;
			var appliByte:ByteArray = new ByteArray();
			appliOrUnSubSribeReq.writeExternal(appliByte);
			socketService.send(new mx.rpc.Responder(appliOrUnSubHandler,faultHandler),URLConst.CORPS_APPLIORUNSUBSCRIBE_COMMANDID,appliByte);
		}
		private function appliOrUnSubHandler(data:Object):void{
			var appliResByte:ByteArray = data as ByteArray;
			var appliResponse:AppliOrUnsubscribeResponse = new AppliOrUnsubscribeResponse();
			appliResponse.readExternal(appliResByte);
			if(!appliResponse.result){
				popUpShow.show(appliResponse.message);
			}else{
				//改变申请入团字段状态
				onChangeDataOnApplication();
			}
		}
		/**
		 * 立即讨伐军团 
		 */	   
		private function onCrusadeCorps():void{
			var crusadeCorpsRequest:CrusadeCorpsRequest = new CrusadeCorpsRequest();
			crusadeCorpsRequest.id = SystemDataModel.roleId;
			crusadeCorpsRequest.corpsId = comp.data.corpsId;
			var crusadeByte:ByteArray = new ByteArray();
			crusadeCorpsRequest.writeExternal(crusadeByte);
			socketService.send(new mx.rpc.Responder(crusadeCorpsHandler,faultHandler),URLConst.CORPS_CROSADE_COMMANDID,crusadeByte);
		}
		private function crusadeCorpsHandler(data:Object):void{
			var crusadeResByte:ByteArray = data as ByteArray;
			var crusadeResponse:CrusadeCorpsResponse = new CrusadeCorpsResponse();
			crusadeResponse.readExternal(crusadeResByte);
			if(!crusadeResponse.result){
				popUpShow.show(crusadeResponse.message);
			}
		}
		/**
		 * 申请或取消申请操作成功后改变该条数据onApplication字段值
		 * 此功能现在客户端实现
		 */
		private function onChangeDataOnApplication():void{
			var l:int = SystemDataModel.mainCorpsInfo.corpsListInfo.length;
			for(var i:int=0;i<l;i++){
				if(SystemDataModel.mainCorpsInfo.corpsListInfo[i].corpsId == comp.data.corpsId){
					if(SystemDataModel.mainCorpsInfo.corpsListInfo[i].onApplication){
						SystemDataModel.mainCorpsInfo.corpsListInfo[i].onApplication = false;
					}else{
						SystemDataModel.mainCorpsInfo.corpsListInfo[i].onApplication = true;
					}
				}
			}
		}
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}	
		private function onClokeClick(evt:MouseEvent):void{
			onCloseWindowAndRemoveListener();
		}
		/**
		 * 关闭军团信息窗口 
		 */		
		private function onCloseWindowAndRemoveListener():void{
			this.eventMap.unmapListener(comp.contactChief,MouseEvent.CLICK,onContactChief);
			this.eventMap.unmapListener(comp.functionBtn,MouseEvent.CLICK,onFunctionClick);
			WindowManager.closeWindow(CorpsInfoComponent.NAME,false,false,null,popUpWindowLayer);
			
		}
	}
}
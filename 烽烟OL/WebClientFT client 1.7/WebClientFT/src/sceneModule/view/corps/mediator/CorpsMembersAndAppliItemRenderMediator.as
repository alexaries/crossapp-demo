package sceneModule.view.corps.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.corps.corps1303.GetCorpsMemberOrAppliListInfoRequest;
	import proto.corps.corps1304.AcceptOrRefuseAppliRequest;
	import proto.corps.corps1304.AcceptOrRefuseAppliResponse;
	
	import sceneModule.view.corps.event.GetMembersAndAppliListResponseEvent;
	import sceneModule.view.corps.view.CorpsMembersAndAppliItemRender;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.systemInfo.event.SystemInfoEvent;
	
	import service.ISocketServer;

	public class CorpsMembersAndAppliItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:CorpsMembersAndAppliItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function CorpsMembersAndAppliItemRenderMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.eventMap.mapListener(comp.refuseBtn,MouseEvent.CLICK,onRefuseAppli);
			this.eventMap.mapListener(comp.approveBtn,MouseEvent.CLICK,onApproveAppli);
		}
		/**
		 * 拒绝入团请求
		 */
		private function onRefuseAppli(evt:MouseEvent):void{
			onRefuseAndApprove(1);
		}
		/**
		 * 批准入团请求
		 */
		private function onApproveAppli(evt:MouseEvent):void{
			onRefuseAndApprove(0);
		}
		/**
		 * 拒绝或批准入团请求 
		 */		
		private function onRefuseAndApprove(type:int):void{
			var acceptOrRefuseReq:AcceptOrRefuseAppliRequest = new AcceptOrRefuseAppliRequest();
			acceptOrRefuseReq.id = SystemDataModel.roleId;
			acceptOrRefuseReq.appliId = comp.data.memberliId;
			acceptOrRefuseReq.operType = type;
			var byteArray:ByteArray = new ByteArray();
			acceptOrRefuseReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(acceptOrRefuseHandler,faultHandler),URLConst.CORPS_ACCEPTORREFUSE_COMMANDID,byteArray);
		}
		private function acceptOrRefuseHandler(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:AcceptOrRefuseAppliResponse = new AcceptOrRefuseAppliResponse();
			responseData.readExternal(acceptByte);
			if(responseData.result){
				getCorpsMembersAndAppliList(2,SystemDataModel.mainCorpsInfo.curPage);
			}else{
				popUpShow.show(responseData.message);
			}
			if(responseData.message){
				this.dispatch(new SystemInfoEvent(SystemInfoEvent.SYSTEMINFOEVENT,responseData.message));
			}
		}
		/**
		 * 获取军团成员列表和申请列表
		 */
		private function getCorpsMembersAndAppliList(type:int,page:int=1):void{
			var getCorpsMembersAndAppliReq:GetCorpsMemberOrAppliListInfoRequest = new GetCorpsMemberOrAppliListInfoRequest();
			getCorpsMembersAndAppliReq.id = SystemDataModel.roleId;
			getCorpsMembersAndAppliReq.getType = type;
			getCorpsMembersAndAppliReq.curPage = page;
			var byteArray:ByteArray = new ByteArray();
			getCorpsMembersAndAppliReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(getCorpsMemberHandler,faultHandler),URLConst.CORPS_MEMBERORAPPLI_COMMANDID,byteArray);
		}
		private function getCorpsMemberHandler(data:Object):void{
			this.dispatch(new GetMembersAndAppliListResponseEvent(GetMembersAndAppliListResponseEvent.GETMEMBERSANDAPPLILISTRESPONSE,data));
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
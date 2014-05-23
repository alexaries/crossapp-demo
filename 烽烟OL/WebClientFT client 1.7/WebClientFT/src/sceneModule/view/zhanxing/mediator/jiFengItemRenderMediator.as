package sceneModule.view.zhanxing.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.zhanxing.jifengExchange3610.QueRenExchangeRequest;
	import proto.zhanxing.jifengExchange3610.QueRenExchangeResponse;
	import proto.zhanxing.jifenginfo3609.GetJiFengListInfoRequest;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.zhanxing.event.JiFengEvent;
	import sceneModule.view.zhanxing.view.JiFengExchangeItemRender;
	
	import service.ISocketServer;

	public class jiFengItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:JiFengExchangeItemRender;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socketServer:ISocketServer;

		[Inject]
		public var popUpShow:IPopUpShow;


		public function jiFengItemRenderMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			this.eventMap.mapListener(comp.exchaBtn, MouseEvent.CLICK, onExchange);
		}


		private function faultHandler(evt:FaultEvent):void
		{

		}

		private function onExchange(evt:MouseEvent):void
		{
			if(comp.data){
				var querenExReq:QueRenExchangeRequest=new QueRenExchangeRequest();
				querenExReq.id=SystemDataModel.roleId;
				querenExReq.wId=comp.data.xingYun.xytemId;
				var byteArray:ByteArray=new ByteArray();
				querenExReq.writeExternal(byteArray);
				socketServer.send(new mx.rpc.Responder(exChangeHandler, faultHandler), URLConst.QUERENEXCHANGE_COMMANDID, byteArray);
			}
		}

		private function exChangeHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:QueRenExchangeResponse=new QueRenExchangeResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
//				CrotaCommonAlert.createCrotaBasicAlert("兑换成功！");
				getJiFengExcInfo(SystemDataModel.jifengInfo.curpage);
			}
			else
			{
//				popUpShow.show(responseData.message);
			}
		}

		
		private function getJiFengExcInfo(page:int=1):void
		{
			var getJiFenReq:GetJiFengListInfoRequest=new GetJiFengListInfoRequest();
			getJiFenReq.id=SystemDataModel.roleId;
			getJiFenReq.nowpage=page;
			var byteArray:ByteArray=new ByteArray();
			getJiFenReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(jiFengHandler, faultHandler), URLConst.JIFENGEXCHANGE_COMMANDID, byteArray);
		}
		
		private function jiFengHandler(data:Object):void
		{
			dispatch(new JiFengEvent(JiFengEvent.JIFENGINFOCOMP_EVENT, data));
		}
	}
}

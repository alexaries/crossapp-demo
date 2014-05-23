package sceneModule.view.guanjue.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guanjue.GetZuan3306.GetZuanInfoRequest;
	import proto.guanjue.GetZuan3306.GetZuanInfoResponse;
	import proto.guanjue.guanjue3300.GetGuanJueInfoRequest;
	import proto.guanjue.guanjue3303.GetWeiWangInfoRequest;
	import proto.guanjue.guanjue3303.Wupin;
	import proto.guanjue.guanjue3304.GetShangJiaoInfoRequest;
	import proto.guanjue.guanjue3304.GetShangJiaoInfoResponse;
	import proto.guanjue.guanjue3305.GetGongXianZuanRequest;
	import proto.guanjue.guanjue3305.GetGongXianZuanResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.guanjue.event.GuanjueEvent;
	import sceneModule.view.guanjue.event.ShengWangEvent;
	import sceneModule.view.guanjue.view.ShengWangItemRender;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class ShengWangItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:ShengWangItemRender;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socketServer:ISocketServer;

		[Inject]
		public var popUpShow:IPopUpShow;

		private var wupinginfo:Wupin=new Wupin();

		public function ShengWangItemRenderMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			this.eventMap.mapListener(comp.sjBtn, MouseEvent.CLICK, onShangjiao);
			this.eventMap.mapListener(comp.gxBtn, MouseEvent.CLICK, onGongxian);
		}

		private function getShengWangInfo():void
		{
			var getGuanjueReq:GetWeiWangInfoRequest=new GetWeiWangInfoRequest();
			getGuanjueReq.id=SystemDataModel.roleId;
			var byteArray:ByteArray=new ByteArray();
			getGuanjueReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(shengWangHandler, faultHandler), URLConst.GETSHNEGWANG_COMMANDID, byteArray);
		}
		
		private function shengWangHandler(data:Object):void
		{
			dispatch(new ShengWangEvent(ShengWangEvent.SHNEGWANGCOMPONMENT_EVENT, data));
		}
		
		private function getGuanjueInfo(page:int=1):void
		{
			var getGuanjueReq:GetGuanJueInfoRequest=new GetGuanJueInfoRequest();
			getGuanjueReq.id=SystemDataModel.roleId;
			getGuanjueReq.curpage=page; //SystemDataModel..curpage;
			if(page>=1)
			{
				SystemDataModel.guanJueInfo.tempStr="";
			}
			var byteArray:ByteArray=new ByteArray();
			getGuanjueReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(guanJueHandler, faultHandler), URLConst.GUANJUEINFO_COMMANDID, byteArray);
		}
		
		private function guanJueHandler(data:Object):void
		{
			dispatch(new GuanjueEvent(GuanjueEvent.GUANJUE_EVENT, data));
		}
		
		private function onGongxian(evt:MouseEvent):void
		{
			var request:GetZuanInfoRequest=new GetZuanInfoRequest();
			request.id=SystemDataModel.roleId;
			request.wy=comp.data.wy; //wupinginfo.wy; 
			var byteArray:ByteArray=new ByteArray();
			request.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(gongxianHandler, faultHandler), URLConst.GETGONGXIANZHUAN_COMMANDID, byteArray);
		}

		public function request_gongxian(wy:String):void
		{
			if(comp.gxBtn.enabled)
			{
				var request:GetGongXianZuanRequest=new GetGongXianZuanRequest();
				request.id=SystemDataModel.roleId;
				request.wy=comp.data.wy;
				var byteArray:ByteArray=new ByteArray();
				request.writeExternal(byteArray);
				socketServer.send(new mx.rpc.Responder(queRenHandler, faultHandler), URLConst.QUERENGONGXIAN_COMMANDID, byteArray);
			}else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_yjgx'));
			}
			
		}


		public function gongxianHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:GetZuanInfoResponse=new GetZuanInfoResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				MallMessage.getInstance().popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_sfgx') + responseData.count + CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_ljsw'),
					null, null, null, null, request_gongxian, null, [comp.data.wy]);
			}
		}

		private function queRenHandler(data:Object):void
		{
				var responseByte:ByteArray=data as ByteArray;
				var responseData:GetGongXianZuanResponse=new GetGongXianZuanResponse();
				responseData.readExternal(responseByte);
				if (responseData.result)
				{
					//CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_gxcg'));
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_gxcg')+comp.data.weiwang);
					getGuanjueInfo();
					getShengWangInfo();
				}
				else
				{
					popUpShow.show(responseData.message);
				}
			
		}

		private function faultHandler(evt:FaultEvent):void
		{

		}

		private function onShangjiao(evt:MouseEvent):void
		{
			if(comp.sjBtn.enabled)
			{
				var getShangjiaoReq:GetShangJiaoInfoRequest=new GetShangJiaoInfoRequest();
				getShangjiaoReq.id=SystemDataModel.roleId;
				getShangjiaoReq.wy=comp.data.wy;
				var byteArray:ByteArray=new ByteArray();
				getShangjiaoReq.writeExternal(byteArray);
				socketServer.send(new mx.rpc.Responder(getShangJiaoHandler, faultHandler), URLConst.SHANGJIAO_COMMANDID, byteArray);
			}else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_yjsj'));
			}
			
		}

		private function getShangJiaoHandler(data:Object):void
		{
				var byteArray:ByteArray=data as ByteArray;
				var responseData:GetShangJiaoInfoResponse=new GetShangJiaoInfoResponse();
				responseData.readExternal(byteArray);
				if (responseData.result)
				{
					//CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_sjcg'));
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','swIR_sjcg')+comp.data.weiwang);
					getGuanjueInfo();
					getShengWangInfo();
					new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_GUANJUE)]);
				}else
				{
					popUpShow.show(responseData.message);
				}
		}
	}
}

package sceneModule.view.guanjue.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guanjue.guanjue3300.GetGuanJueInfoRequest;
	import proto.guanjue.guanjue3301.GetFenluRequest;
	import proto.guanjue.guanjue3301.GetFenluResponse;
	import proto.guanjue.guanjue3303.GetWeiWangInfoRequest;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.guanjue.event.GuanjueEvent;
	import sceneModule.view.guanjue.event.ShengWangEvent;
	import sceneModule.view.guanjue.view.GuanjueWindow;
	import sceneModule.view.guanjue.view.ShengWangComponent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class GuanjueWindowMediator extends Mediator
	{

		[Inject]
		public var comp:GuanjueWindow;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socketServer:ISocketServer;

		public function GuanjueWindowMediator()
		{
			super();
		}

		override public function onRegister():void
		{
			getGuanjueInfo();
			this.eventMap.mapListener(comp.clokeBtn, MouseEvent.CLICK, onCloseWindow);
			this.eventMap.mapListener(comp.jxBtn, MouseEvent.CLICK, onJuanXian);
			this.eventMap.mapListener(comp.sjBtn, MouseEvent.CLICK, onShengJue);
			this.eventMap.mapListener(comp.lingquBtn, MouseEvent.CLICK, onLingQuJuelu);

			this.eventMap.mapListener(comp.pre_btn, MouseEvent.CLICK, onPrePageData);
			this.eventMap.mapListener(comp.next_btn, MouseEvent.CLICK, onNextPageData);

		}

		private function onPrePageData(evt:MouseEvent):void
		{
			getGuanjueInfo(SystemDataModel.guanJueInfo.curpage - 1);
		}

		private function onNextPageData(evt:MouseEvent):void
		{
			getGuanjueInfo(SystemDataModel.guanJueInfo.curpage + 1);
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

		private function getGuanjueInfo2(page:int=1):void
		{
			var getGuanjueReq:GetGuanJueInfoRequest=new GetGuanJueInfoRequest();
			getGuanjueReq.id=SystemDataModel.roleId;
			getGuanjueReq.curpage=page; //SystemDataModel..curpage;
			var byteArray:ByteArray=new ByteArray();
			getGuanjueReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(shengJueHandler, faultHandler), URLConst.SHENGJUE_COMMANDID, byteArray);
			CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjWM_gx'));
		}

		private function shengJueHandler(data:Object):void
		{
			getGuanjueInfo();
		}
		
		private function faultHandler(evt:FaultEvent):void
		{

		}

		private function onJuanXian(evt:MouseEvent):void
		{
//			AssetCenter.getInstance().load_package("ui_guanjue",to_shengWang,null,true);
			to_shengWang();
		}

		private function to_shengWang():void{
			var obj:Object=new Object();
			WindowManager.createWindow(ShengWangComponent.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer, true);
			getShengWangInfo();
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_WEIWANG)]);

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

		private function onShengJue(evt:MouseEvent):void
		{
			getGuanjueInfo2();
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_GUANJUE)]);	
		}

		private function onLingQuJuelu(evt:MouseEvent):void
		{
			var getFenluReq:GetFenluRequest=new GetFenluRequest();
			getFenluReq.id=SystemDataModel.roleId;
			var byteArray:ByteArray=new ByteArray();
			getFenluReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(getFenluHandler, faultHandler), URLConst.GETJUELU_COMMANDID, byteArray);
		}

		private function getFenluHandler(data:Object):void
		{
			var byteArray:ByteArray=data as ByteArray;
			var responseData:GetFenluResponse=new GetFenluResponse();
			responseData.readExternal(byteArray);
			if (responseData.result)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjWM_jlcg'));
				comp.lingquBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjWM_ylq');
				SystemDataModel.guanJueInfo.hasGetSalary=false;
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_GUANJUE)]);

			}
		}

		private function onCloseWindow(evt:MouseEvent=null):void
		{
			WindowManager.closeWindow(GuanjueWindow.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer, mediatorMap);
		}
	}
}

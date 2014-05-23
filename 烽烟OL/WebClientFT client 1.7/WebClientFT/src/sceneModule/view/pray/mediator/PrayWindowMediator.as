package sceneModule.view.pray.mediator
{
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.IVisualElement;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.osmf.events.TimeEvent;
	import org.robotlegs.mvcs.Mediator;
	
	import proto.qidao.qidao4100.GetPrayInfoRequest;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.pray.event.PrayEvent;
	import sceneModule.view.pray.view.PrayWindow;
	
	import service.ISocketServer;

	public class PrayWindowMediator extends Mediator
	{

		[Inject]
		public var comp:PrayWindow;

		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;

		[Inject]
		public var socketServer:ISocketServer;

		public function PrayWindowMediator()
		{
			super();
		}

		private var ldr:Loader = new Loader(); 
		private var mc:MovieClip = new MovieClip();
		private var t:Timer=new Timer(3000);
		
		override public function onRegister():void
		{
			getPrayInfo();
			this.eventMap.mapListener(comp.closeBtn, MouseEvent.CLICK, onCloseWindow);
			this.eventMap.mapListener(comp.praybtn, MouseEvent.CLICK, onClickPray);
		}

		
		private function getPrayInfo(page:int=1):void
		{
			var getPrayReq:GetPrayInfoRequest=new GetPrayInfoRequest();
			getPrayReq.id=SystemDataModel.roleId;
			getPrayReq.qd=SystemDataModel.praybool; 
			var byteArray:ByteArray=new ByteArray();
			getPrayReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(prayHandler, faultHandler), URLConst.PRAYINFO_COMMANDID, byteArray);
		}

		private function prayHandler(data:Object):void
		{
			dispatch(new PrayEvent(PrayEvent.Pray_EVENT, data));
		}

		private function faultHandler(evt:FaultEvent):void
		{

		}

		private function onClickPray(evt:MouseEvent):void
		{
			if(SystemDataModel.roleInfo.gold>=SystemDataModel.prayInfoVo.needDiamond)
			{
				var getClicPrayReq:GetPrayInfoRequest=new GetPrayInfoRequest();
				getClicPrayReq.id=SystemDataModel.roleId;
				getClicPrayReq.qd=true;
				var byteArray:ByteArray=new ByteArray();
				getClicPrayReq.writeExternal(byteArray);
				if(SystemDataModel.prayInfoVo.tempStr!="")
				{
					SystemDataModel.prayInfoVo.tempStr="";
				}
				socketServer.send(new mx.rpc.Responder(getFenluHandler, faultHandler), URLConst.PRAYINFO_COMMANDID, byteArray);
			}else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('pray','pWM_zbz'));
			}
			
		}
		
		
		private function getFenluHandler(data:Object):void
		{
			dispatch(new PrayEvent(PrayEvent.Pray_EVENT, data));
			ldr.load(new URLRequest('assets/pray/playpray.swf')); 
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, finishLoad);
		}

		private function finishLoad(e:Event):void
		{ 
			comp.uic.x = 150; 
			comp.uic.y = 88; 
			
			mc = e.target.content as MovieClip;
			comp.uic.addChild(mc);
			
			t.addEventListener(TimerEvent.TIMER,onTimer);
			t.start();
		}	
		
		private function onTimer(evt:Event):void
		{
			t.stop();
			comp.uic.removeChild(mc);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void
		{
			WindowManager.closeWindow(PrayWindow.NAME, false, false, WindowManager.CACHE_POLICY_NOT_CACHE, popUpWindowLayer, mediatorMap);
		}
	}
}

package sceneModule.view.calendar.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.calendar.Bound;
	import proto.calendar.GetCalendarTaskInfoResponse;
	import proto.calendar.GetCalendarTaskListInfoRequest;
	import proto.calendar.ReceivedCalendarBoundRequest;
	import proto.calendar.ReceivedCalendarBoundResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.calendar.event.CalendarEvent;
	import sceneModule.view.calendar.view.CalendarInfoComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.skill.view.MainMenuSkillTooltip;
	
	import service.ISocketServer;

	public class CalendarInfoMediator extends Mediator
	{
		[Inject]
		public var comp:CalendarInfoComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _toolTip:MainMenuSkillTooltip;
		
		public function CalendarInfoMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			socketService.send(new mx.rpc.Responder(calendarInfoHandler,faultHandler),URLConst.CALENDAR_REWARD_NEW_COMMANDID,null,false);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.rewardBox1,MouseEvent.CLICK,onMouseClick1);
			this.eventMap.mapListener(comp.rewardBox2,MouseEvent.CLICK,onMouseClick2);
			this.eventMap.mapListener(comp.rewardBox3,MouseEvent.CLICK,onMouseClick3);
			this.eventMap.mapListener(comp.rewardBox4,MouseEvent.CLICK,onMouseClick4);
			
			getCalendarTaskInfo();
		}
		
		override public function onRemove():void{
//			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_MOVE,onMouseMove);
//			this.eventMap.unmapListener(comp.skillImg,MouseEvent.MOUSE_OUT,onMouseOut);
			this.eventMap.unmapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			
			this.eventMap.unmapListener(comp.rewardBox1,MouseEvent.CLICK,onMouseClick1);
			this.eventMap.unmapListener(comp.rewardBox2,MouseEvent.CLICK,onMouseClick2);
			this.eventMap.unmapListener(comp.rewardBox3,MouseEvent.CLICK,onMouseClick3);
			this.eventMap.unmapListener(comp.rewardBox4,MouseEvent.CLICK,onMouseClick4);
//			_toolTip = null;
		}
		
		private function getCalendarTaskInfo():void{
			var getCalendarTasklistReq:GetCalendarTaskListInfoRequest = new GetCalendarTaskListInfoRequest();
			getCalendarTasklistReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getCalendarTasklistReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(calendarInfoHandler,faultHandler),URLConst.CALENDAR_REWARD_NEW_COMMANDID,byteArray);
		}
		
		private function calendarInfoHandler(data:Object):void{
			dispatch(new CalendarEvent(CalendarEvent.CalendarEvent_INFO_CHANGE,data));
		}
//		private function onMouseMove(evt:MouseEvent):void{
//		    if(!_toolTip){
//				_toolTip = new MainMenuSkillTooltip();
//				popUpWindowLayer.addElement(_toolTip);
//			}
//			if(!_toolTip.visible)_toolTip.visible = true;
//			popUpWindowLayer.setElementIndex(_toolTip,popUpWindowLayer.numElements - 1);
//			_toolTip.curDataInfo = comp.data as SkillBasicInfoVo;
//			setToolTipPos();
//		}
//		private function onMouseOut(evt:MouseEvent):void{
//			if(_toolTip && _toolTip.visible)_toolTip.visible = false;
//		}
//		private function setToolTipPos():void{
//			if(_toolTip){
//				if((FlexGlobals.topLevelApplication.mouseX + _toolTip.width + 5) > FlexGlobals.topLevelApplication.width){
//					_toolTip.x = FlexGlobals.topLevelApplication.mouseX - _toolTip.width - 5;
//				}else{
//					_toolTip.x = FlexGlobals.topLevelApplication.mouseX + 5;
//				}
//				if((FlexGlobals.topLevelApplication.mouseY + _toolTip.height + 5) > FlexGlobals.topLevelApplication.height){
//					_toolTip.y = FlexGlobals.topLevelApplication.height - _toolTip.height;
//				}else{
//					_toolTip.y = FlexGlobals.topLevelApplication.mouseY + 5;
//				}
//				
//			}
//		}
		
		
		private function onMouseClick1(evt:MouseEvent):void{
				var getReceivedCalendarBoundtReq:ReceivedCalendarBoundRequest = new ReceivedCalendarBoundRequest();
				getReceivedCalendarBoundtReq.id = SystemDataModel.roleId;
				getReceivedCalendarBoundtReq.step=1;
				var byteArray:ByteArray = new ByteArray();
				getReceivedCalendarBoundtReq.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(receivedCalendarHandler,faultHandler),URLConst.RECEIVED_CALENDAR_BOUNDS_NEW_COMMANDID,byteArray);
		}
		
		private function onMouseClick2(evt:MouseEvent):void{
			var getReceivedCalendarBoundtReq:ReceivedCalendarBoundRequest = new ReceivedCalendarBoundRequest();
			getReceivedCalendarBoundtReq.id = SystemDataModel.roleId;
			getReceivedCalendarBoundtReq.step=2;
			var byteArray:ByteArray = new ByteArray();
			getReceivedCalendarBoundtReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(receivedCalendarHandler,faultHandler),URLConst.RECEIVED_CALENDAR_BOUNDS_NEW_COMMANDID,byteArray);
		}
		private function onMouseClick3(evt:MouseEvent):void{
			var getReceivedCalendarBoundtReq:ReceivedCalendarBoundRequest = new ReceivedCalendarBoundRequest();
			getReceivedCalendarBoundtReq.id = SystemDataModel.roleId;
			getReceivedCalendarBoundtReq.step=3;
			var byteArray:ByteArray = new ByteArray();
			getReceivedCalendarBoundtReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(receivedCalendarHandler,faultHandler),URLConst.RECEIVED_CALENDAR_BOUNDS_NEW_COMMANDID,byteArray);
		}
		private function onMouseClick4(evt:MouseEvent):void{
			var getReceivedCalendarBoundtReq:ReceivedCalendarBoundRequest = new ReceivedCalendarBoundRequest();
			getReceivedCalendarBoundtReq.id = SystemDataModel.roleId;
			getReceivedCalendarBoundtReq.step=4;
			var byteArray:ByteArray = new ByteArray();
			getReceivedCalendarBoundtReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(receivedCalendarHandler,faultHandler),URLConst.RECEIVED_CALENDAR_BOUNDS_NEW_COMMANDID,byteArray);
		}
		private function receivedCalendarHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ReceivedCalendarBoundResponse = new ReceivedCalendarBoundResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('calendar','ciM_lqdes'));
				
			}else{
				popUpShow.show(responseData.message);
			}
		}
		
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			WindowManager.closeWindow(CalendarInfoComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
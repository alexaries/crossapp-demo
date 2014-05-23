package sceneModule.view.tavern.mediator
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
	
	import proto.tavern.tavern3501.Get3501Request;
	import proto.tavern.tavern3501.Get3501Response;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.tavern.view.WOWItemRender;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	/**
	 * 
	 * 
	 */	
	public class WOWItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:WOWItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		public function WOWItemRenderMediator()
		{
			super();
		}
		
		override public function preRegister():void{

			this.eventMap.mapListener(comp.employBtn,MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseClick(evt:MouseEvent,typeId:int=1):void{
			if(int(comp.jb.text)<=SystemDataModel.roleInfo.coin)
			{
				var employReq:Get3501Request=new Get3501Request();
				employReq.id=SystemDataModel.roleId;
				employReq.petid=comp.data.id;//SystemDataModel.taverInfo.id; //宠物模板id
				employReq.typeid=typeId;
				var byteArray:ByteArray=new ByteArray();
				employReq.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(guYongHandler, faultHandler), URLConst.GUYONGCONGWU_COMMANDID, byteArray);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_PET)]);
			}else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','zyC_jbbz'));
			}
			
		}
		
		
		private function guYongHandler(data:Object):void{
			var responseData:Get3501Response=new Get3501Response();
			var byteArray:ByteArray=data as ByteArray;
			responseData.readExternal(byteArray);
			if(responseData.result)
			{
			}
			else
			{
//				popUpShow.show(responseData.message);注释此行是为了新手指引指向正确关闭按钮
				CrotaCommonAlert.createCrotaBasicAlert(responseData.message);

			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		
	}
}
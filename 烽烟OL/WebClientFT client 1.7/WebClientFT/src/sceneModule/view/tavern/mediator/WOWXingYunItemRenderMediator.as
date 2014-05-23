package sceneModule.view.tavern.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
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
	import sceneModule.view.tavern.view.WOWXingYunItemRender;
	
	import service.ISocketServer;

	/**
	 * 
	 * 
	 */	
	public class WOWXingYunItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:WOWXingYunItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		public function WOWXingYunItemRenderMediator()
		{
			super();
		}
		
		override public function preRegister():void{

			this.eventMap.mapListener(comp.employBtn,MouseEvent.CLICK,onMouseClick);
		}
		
		private function onMouseClick(evt:MouseEvent,typeId:int=2):void{
			if(int(comp.xyz.text)<=SystemDataModel.wow.xingyunzhi)
			{
				var employReq:Get3501Request=new Get3501Request();
				employReq.id=SystemDataModel.roleId;
				employReq.petid=comp.data.id;//SystemDataModel.taverInfo.id; //宠物模板id
				employReq.typeid=typeId;
				var byteArray:ByteArray=new ByteArray();
				employReq.writeExternal(byteArray);
				socketService.send(new mx.rpc.Responder(guYongHandler, faultHandler), URLConst.GUYONGCONGWU_COMMANDID, byteArray);
			}else
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('tavern','wxyIR_xyzbz'));
			}
			
		}
		
		private function guYongHandler(data:Object):void{
			var responseData:Get3501Response=new Get3501Response();
			var byteArray:ByteArray=data as ByteArray;
			responseData.readExternal(byteArray);
			if(responseData.result)
			{
//				CrotaCommonAlert.createCrotaBasicAlert("雇佣宠物成功！");
			}else
			{
				popUpShow.show(responseData.message);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		
	}
}
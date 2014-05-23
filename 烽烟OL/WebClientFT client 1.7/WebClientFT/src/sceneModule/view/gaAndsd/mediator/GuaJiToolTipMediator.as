package sceneModule.view.gaAndsd.mediator
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guaji.guaji3201.GetGuaJiInfoRequest;
	import proto.guaji.guaji3201.GetGuaJiInfoResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.gaAndsd.view.GuaJiToolTip;
	
	import service.ISocketServer;

	public class GuaJiToolTipMediator extends Mediator
	{
		[Inject]
		public var tips:GuaJiToolTip;
		
		[Inject]
		public var socket:ISocketServer;
		public function GuaJiToolTipMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			getGuaJiInfo();
		}
		
		private function getGuaJiInfo():void{
			var getInfoReq:GetGuaJiInfoRequest = new GetGuaJiInfoRequest();
			getInfoReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getInfoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(getInfoHandler,faultHandler),URLConst.GUAJI_GETINFO_COMMANDID,byteArray);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function getInfoHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetGuaJiInfoResponse = new GetGuaJiInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				tips.expTxt.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('gaAndsd','gjTTM_hd')+responseData.expStr+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy');
				tips.zhanliTxt.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('gaAndsd','gjTTM_zl')+responseData.zhanliStr;
				tips.setReTime(responseData.gujiTime);
			}
		}
	}
}
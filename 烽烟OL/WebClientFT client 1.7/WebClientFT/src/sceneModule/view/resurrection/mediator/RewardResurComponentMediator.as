package sceneModule.view.resurrection.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.system.system2701.ResurPetRequest;
	import proto.system.system2701.ResurPetResponse;
	
	import sceneModule.view.popupWin.PopUpShow;
	import sceneModule.view.resurrection.view.RewardResurComponent;
	
	import service.ISocketServer;

	public class RewardResurComponentMediator extends Mediator
	{
		[Inject]
		public var comp:RewardResurComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function RewardResurComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.subBtn,MouseEvent.CLICK,onSubClick);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCancel);
		}
		
		private function onSubClick(evt:MouseEvent):void{
			onCloseWindow();
			//复活
			var resurReq:ResurPetRequest = new ResurPetRequest();
			resurReq.id = SystemDataModel.roleId;
			resurReq.petId = comp.data.petId;
			var byteArray:ByteArray = new ByteArray();
			resurReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(resurHandler,faultHandler),URLConst.RESUR_PET_COMMANDID,byteArray);
		}
		
		private function resurHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ResurPetResponse = new ResurPetResponse();
			responseData.readExternal(byteArray);
			if(!responseData.result && responseData.failType == 1){
				
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onCancel(evt:MouseEvent):void{
			//关闭
			onCloseWindow();
		}
		
		private function onCloseWindow():void{
			WindowManager.closeWindow(RewardResurComponent.NAME);
		}
	}
}
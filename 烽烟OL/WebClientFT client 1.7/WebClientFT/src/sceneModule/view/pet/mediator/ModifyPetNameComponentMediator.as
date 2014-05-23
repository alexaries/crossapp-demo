package sceneModule.view.pet.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pet.pet2300.GetPetListInfoRequest;
	import proto.pet.pet2303.ModifyPetNameRequest;
	import proto.pet.pet2303.ModifyPetNameResponse;
	
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.view.ModifyPetNameComponent;
	
	import service.ISocketServer;

	/**
	 * ModifyPetNameComponentMediator 
	 * @author Dream-Y
	 * 
	 */	
	public class ModifyPetNameComponentMediator extends Mediator
	{
		[Inject]
		public var comp:ModifyPetNameComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function ModifyPetNameComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.submitBtn,MouseEvent.CLICK,onModifyName);
			this.eventMap.mapListener(comp.cancelBtn,MouseEvent.CLICK,onCloseWindow);
		}
		
		private function onRemoveRegister():void{
			this.eventMap.unmapListener(comp.submitBtn,MouseEvent.CLICK,onModifyName);
			this.eventMap.unmapListener(comp.cancelBtn,MouseEvent.CLICK,onCloseWindow);
		}
		
		/**
		 * 确认修改宠物名称 
		 */		
		private function onModifyName(evt:MouseEvent):void{
			var modifyNameReq:ModifyPetNameRequest = new ModifyPetNameRequest();
			modifyNameReq.id = SystemDataModel.roleId;
			modifyNameReq.petId = comp.data.petId;
			modifyNameReq.petName = comp.newNameText.text;
			var byteArray:ByteArray = new ByteArray();
			modifyNameReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(modifyNameHandler,faultHandler),URLConst.PET_MODIFYNAME_COMMANDID,byteArray);
			
			onCloseWindow();
		}
		private function modifyNameHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ModifyPetNameResponse = new ModifyPetNameResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				PetMessage.getInstance().getOnePetInfo(comp.data.petId,SystemDataModel.roleId);
			}
		}
		
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			onRemoveRegister();
			WindowManager.closeWindow(ModifyPetNameComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
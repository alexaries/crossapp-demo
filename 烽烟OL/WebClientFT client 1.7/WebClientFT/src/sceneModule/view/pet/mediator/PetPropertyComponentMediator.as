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
	
	import proto.pet.pet2305.DropPetRequest;
	import proto.pet.pet2305.DropPetResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.view.ModifyPetNameComponent;
	import sceneModule.view.pet.view.PetPropertyComponent;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class PetPropertyComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PetPropertyComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function PetPropertyComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.modifyNameBtn,MouseEvent.CLICK,onModifyName);
			this.eventMap.mapListener(comp.dropBtn,MouseEvent.CLICK,onDropPet);
		}
		
		
		
		/**
		 * 宠物改名
		 */
		private function onModifyName(evt:MouseEvent):void{
			var obj:Object = new Object();
			obj.petId = SystemDataModel.otherPetInfoVo.petId;
			WindowManager.createWindow(ModifyPetNameComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
		}
		/**
		 * 丢弃宠物 
		 */		
		private function onDropPet(evt:MouseEvent):void{
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','mpiCM_qddq')+SystemDataModel.otherPetInfoVo.petName+"！", null, null, null, null, submitDropPet,null, null);
		}
		private function submitDropPet(evt:MouseEvent):void{
			var dropPetReq:DropPetRequest = new DropPetRequest();
			dropPetReq.id = SystemDataModel.roleId;
			dropPetReq.petId = SystemDataModel.otherPetInfoVo.petId;
			var byteArray:ByteArray = new ByteArray();
			dropPetReq.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(dropPetHandler,faultHandler),URLConst.PET_DROP_COMMANDID,byteArray);
		}
		private function dropPetHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:DropPetResponse = new DropPetResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				PetMessage.getInstance().getPetInfo();
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
	}
}
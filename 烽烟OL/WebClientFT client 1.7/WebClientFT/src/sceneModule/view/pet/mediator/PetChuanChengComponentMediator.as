package sceneModule.view.pet.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pet.pet2314.PetChuanChengRequest;
	import proto.pet.pet2314.PetChuanChengResponse;
	
	import sceneModule.view.pet.view.PetChuanChengComponent;
	import sceneModule.view.pet.vo.PetInfoVO;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class PetChuanChengComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PetChuanChengComponent;
		
		[Inject]
		public var socket:ISocketServer;
		public function PetChuanChengComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.trBtn,MouseEvent.CLICK,onTrBtn);
			this.eventMap.mapListener(comp.iComBoBox,Event.CHANGE,onIcombox);
		}
		
		private function onIcombox(evt:Event):void{
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_TUJIAN)]);

		}
		
		private function onTrBtn(evt:MouseEvent):void{
			var ccReq:PetChuanChengRequest = new PetChuanChengRequest();
			ccReq.id = SystemDataModel.roleId;
			ccReq.petId = SystemDataModel.otherPetInfoVo.petId;
			ccReq.bjcPetId = comp.iComBoBox.selectedItem.petId;
			var byteArray:ByteArray = new ByteArray();
			ccReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(ccHandler,faultHandler),URLConst.PET_CHUANGCHENG_COMMANDID,byteArray);
		}
		private function ccHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:PetChuanChengResponse = new PetChuanChengResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				SystemDataModel.otherPetInfoVo = new PetInfoVO();
				SystemDataModel.bjcList = new ArrayCollection();
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_PEIYANG)]);

			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
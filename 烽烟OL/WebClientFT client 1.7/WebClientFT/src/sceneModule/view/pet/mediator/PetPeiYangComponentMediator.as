package sceneModule.view.pet.mediator
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
	
	import proto.pet.pet2304.TrainingPetRequest;
	import proto.pet.pet2304.TrainingPetResponse;
	import proto.pet.pet2312.WeiChiAndTiHuanRequest;
	import proto.pet.pet2312.WeiChiAndTiHuanResponse;
	
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.view.PetPeiYangComponent;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class PetPeiYangComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PetPeiYangComponent;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function PetPeiYangComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.trBtn,MouseEvent.CLICK,onTrainPet);
			this.eventMap.mapListener(comp.weiBtn,MouseEvent.CLICK,onWeiChi);
			this.eventMap.mapListener(comp.tiBtn,MouseEvent.CLICK,onTiBtn);
		}
		
		private function onWeiChi(evt:MouseEvent):void{
			setBtnState();
			onClearResult();
			var weiReq:WeiChiAndTiHuanRequest = new WeiChiAndTiHuanRequest();
			weiReq.id = SystemDataModel.roleId;
			weiReq.petId = SystemDataModel.otherPetInfoVo.petId;
			var byteArray:ByteArray = new ByteArray();
			weiReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(weiHandler,faultHandler),URLConst.PET_WEI_TI_COMMANDID,byteArray);
		}
		
		private function weiHandler(data:Object):void{
			
		}
		
		private function onTiBtn(evt:MouseEvent):void{
			var tiReq:WeiChiAndTiHuanRequest = new WeiChiAndTiHuanRequest();
			tiReq.id = SystemDataModel.roleId;
			tiReq.petId = SystemDataModel.otherPetInfoVo.petId;
			tiReq.type = 1;
			var byteArray:ByteArray = new ByteArray();
			tiReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(tiHandler,faultHandler),URLConst.PET_WEI_TI_COMMANDID,byteArray);
		}
		
		private function tiHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:WeiChiAndTiHuanResponse = new WeiChiAndTiHuanResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				PetMessage.getInstance().getOnePetInfo(SystemDataModel.otherPetInfoVo.petId,SystemDataModel.roleId);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.CLOSE_PEIYANG)]);

				setBtnState();
				onClearResult();
			}
		}
		
		private function onClearResult():void{
			comp.tLi.htmlText='';
			comp.tZhi.htmlText='';
			comp.tNai.htmlText='';
			comp.tMin.htmlText='';
		}
		
		private function setBtnState():void{
			comp.trBtn.visible = true;
			comp.weiBtn.visible = false;
			comp.tiBtn.visible = false;
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onTrainPet(evt:MouseEvent):void{
			var trainReq:TrainingPetRequest = new TrainingPetRequest();
			trainReq.id = SystemDataModel.roleId;
			switch(comp.cardtype.selectedValue){
				case 'no1':
					trainReq.trainingType = 1;
					break;
				case 'no2':
					trainReq.trainingType = 2;
					break;
				case 'no3':
					trainReq.trainingType = 3;
					break;
				case 'no4':
					trainReq.trainingType = 4;
					break;
			}
			trainReq.petId = SystemDataModel.otherPetInfoVo.petId;
			var byteArray:ByteArray = new ByteArray();
			trainReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(trainHandler,faultHandler),URLConst.PET_TRAINING_COMMANDID,byteArray);
		}
		
		private function trainHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:TrainingPetResponse = new TrainingPetResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.PEI_TIHUAN)]);

				comp.trBtn.visible = false;
				comp.weiBtn.visible = true;
				comp.tiBtn.visible = true;
				if(responseData.trainInfo.changeLiLiang >=0){
					comp.tLi.htmlText = responseData.trainInfo.baseLiLiang+"(<font color='#26C900'>+"+responseData.trainInfo.changeLiLiang+"</font>)";
				}else{
					comp.tLi.htmlText = responseData.trainInfo.baseLiLiang+"(<font color='#ff0000'>"+responseData.trainInfo.changeLiLiang+"</font>)";
				}
				if(responseData.trainInfo.changeMinJie >=0){
					comp.tMin.htmlText = responseData.trainInfo.baseMinJie+"(<font color='#26C900'>+"+responseData.trainInfo.changeMinJie+"</font>)";
				}else{
					comp.tMin.htmlText = responseData.trainInfo.baseMinJie+"(<font color='#ff0000'>"+responseData.trainInfo.changeMinJie+"</font>)";
				}
				if(responseData.trainInfo.changeNaiLi >=0){
					comp.tNai.htmlText = responseData.trainInfo.baseNaiLi+"(<font color='#26C900'>+"+responseData.trainInfo.changeNaiLi+"</font>)";
				}else{
					comp.tNai.htmlText = responseData.trainInfo.baseNaiLi+"(<font color='#ff0000'>"+responseData.trainInfo.changeNaiLi+"</font>)";
				}
				if(responseData.trainInfo.changeZhiLi >=0){
					comp.tZhi.htmlText = responseData.trainInfo.baseZhiLi+"(<font color='#26C900'>+"+responseData.trainInfo.changeZhiLi+"</font>)";
				}else{
					comp.tZhi.htmlText = responseData.trainInfo.baseZhiLi+"(<font color='#ff0000'>"+responseData.trainInfo.changeZhiLi+"</font>)";
				}
				
			}
		}
	}
}
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
	
	import mx.events.ItemClickEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pet.pet2317.ZhaoHuanRequest;
	import proto.pet.pet2317.ZhaoHuanResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.view.PetTuJianComponent;
	import sceneModule.view.pet.vo.PetInfoVO;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class PetTuJianComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PetTuJianComponent;
		
		[Inject]
		public var socket:ISocketServer;
		public function PetTuJianComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.pre_btn,MouseEvent.CLICK,onPrePage);
			this.eventMap.mapListener(comp.next_btn,MouseEvent.CLICK,onNextPage);
			this.eventMap.mapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onCardType);
			this.eventMap.mapListener(comp.trBtn,MouseEvent.CLICK,onZhaoHuan);
			this.eventMap.mapListener(comp.petList,IndexChangeEvent.CHANGE,onIndexChange);
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
			PetMessage.getInstance().getOneTuJianInfo(comp.petList.selectedItem.petId);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_TUJIAN)]);

		}
		
		private function onZhaoHuan(evt:MouseEvent):void{
			if(comp.petList.selectedItem){
				var zhReq:ZhaoHuanRequest = new ZhaoHuanRequest();
				zhReq.id = SystemDataModel.roleId;
				zhReq.petId = comp.petList.selectedItem.petId;
				var byteArray:ByteArray = new ByteArray();
				zhReq.writeExternal(byteArray);
				socket.send(new mx.rpc.Responder(zhHandler,faultHandler),URLConst.PET_ZHAOHUAN_COMMANDID,byteArray);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_TUJIAN)]);

			}
		}
		private function zhHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ZhaoHuanResponse = new ZhaoHuanResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				PetMessage.getInstance().getTuJianListInfo(SystemDataModel.ptjListInfo.curPage,getCurPetType());
				PetMessage.getInstance().getPetInfo();
			}
		}
		
		private function onPrePage(evt:MouseEvent):void{
			PetMessage.getInstance().getTuJianListInfo(SystemDataModel.ptjListInfo.curPage-1,getCurPetType());
		}
		
		private function onNextPage(evt:MouseEvent):void{
			PetMessage.getInstance().getTuJianListInfo(SystemDataModel.ptjListInfo.curPage+1,getCurPetType());
		}
		
		private function onCardType(evt:ItemClickEvent):void{
			PetMessage.getInstance().getTuJianListInfo(1,getCurPetType());
			comp.petList.selectedIndex = -1;
			SystemDataModel.otherPetInfoVo = new PetInfoVO();
		}
		
		private function getCurPetType():int{
			var index:int=1;
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','ptjC_fyl'):
					index = 1;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','ptjC_wgl'):
					index = 2;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','ptjC_mgl'):
					index = 3;
					break;
			}
			return index;
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
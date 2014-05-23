package sceneModule.view.pet.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.pet.pet2300.GetPetListInfoResponse;
	import proto.pet.pet2300.PetInfo;
	import proto.pet.pet2300.PetSkillInfo;
	
	import sceneModule.view.pet.event.GetPetListInfoResponseEvent;
	import sceneModule.view.pet.vo.PetInfoVO;
	import sceneModule.view.pet.vo.PetJianInfoVO;
	import sceneModule.view.pet.vo.PetSkillInfoVO;

	/**
	 * GetPetListInfoResponseCommand 
	 * @author Dream-Y
	 * 
	 */	
	public class GetPetListInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetPetListInfoResponseEvent;
		public function GetPetListInfoResponseCommand()
		{
			super();
		}
		
		override public function execute():void{
			var byteArray:ByteArray = evt.obj as ByteArray;
			var responseData:GetPetListInfoResponse = new GetPetListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.petInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var petInfo:PetInfo = responseData.petInfo[i] as PetInfo;
					var petInfoVo:PetJianInfoVO = new PetJianInfoVO();
					petInfoVo.petId = petInfo.petId;//宠物id
					petInfoVo.resPetId = petInfo.resPetId;//宠物资源id
					petInfoVo.petName = petInfo.petName;//宠物名称
					petInfoVo.petLevel=petInfo.petLevel;//宠物等级
					petInfoVo.type=petInfo.type;//暴击加成
					petInfoVo.icon=petInfo.icon;//暴击加成
					arr.addItem(petInfoVo);
				}
				SystemDataModel.curPetNum = responseData.curPetNum;
				SystemDataModel.maxPetNum = responseData.maxPetNum;
				SystemDataModel.petList.source = arr.toArray();
			}
		}
	}
}
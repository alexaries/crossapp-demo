package sceneModule.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.scene.getItemsInTempPackage.getItemsInTempPackageResponse;
	
	import sceneModule.event.GetItemsInTempPackageResponseEvent;

	/**
	 * 获取玩家临时包裹栏中的物品 Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetItemsInTempPackageResponseCommand extends Command
	{
		[Inject]
		public var evt:GetItemsInTempPackageResponseEvent;
		public function GetItemsInTempPackageResponseCommand()
		{
			super();
		}
		override public function execute():void{
			var arr:ArrayCollection = new ArrayCollection();
			var byteArray:ByteArray = evt.result as ByteArray;
			var responseData:getItemsInTempPackageResponse = new getItemsInTempPackageResponse();
			responseData.readExternal(byteArray);
			arr.source = responseData.data;
			SystemDataModel.tempPackageInfo.source = arr.toArray();
//			SystemDataModel.tempPackageInfo.bindType = evt.result.result.data.bindType;
//			SystemDataModel.tempPackageInfo.extraAttributeList=evt.result.result.data.extraAttributeList;
//			SystemDataModel.tempPackageInfo.from=evt.result.result.data.from;
//			SystemDataModel.tempPackageInfo.idInPackage=evt.result.result.data.idInPackage;
//			SystemDataModel.tempPackageInfo.isBound =evt.result.result.data.isBound;
//			SystemDataModel.tempPackageInfo.isBoundDesc=evt.result.result.data.isBoundDesc;
//			SystemDataModel.tempPackageInfo.isEquiped=evt.result.result.data.isEquiped;
//			SystemDataModel.tempPackageInfo.itemId=evt.result.result.data.itemId;
//			SystemDataModel.tempPackageInfo.itemLevel=evt.result.result.data.itemLevel;
//			SystemDataModel.tempPackageInfo.itemTemplateInfo=evt.result.result.data.itemTemplateInfo;
//			SystemDataModel.tempPackageInfo.name=evt.result.result.data.name;
//			SystemDataModel.tempPackageInfo.position=evt.result.result.data.position;
//			SystemDataModel.tempPackageInfo.professionRequireName=evt.result.result.data.professionRequireName;
//			SystemDataModel.tempPackageInfo.sellPrice=evt.result.result.data.sellPrice;
//			SystemDataModel.tempPackageInfo.stack=evt.result.result.data.stack;
		}
	}
}
package sceneModule.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.ItemsInfo;
	import proto.Suite;
	import proto.scene.scene203.PackageInfo;
	import proto.scene.scene203.getItemsInEquipSlotResponse;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.event.GetRoleItemResponseEvent;
	import sceneModule.model.vo.itemsVo.AttributeEffectVo;
	import sceneModule.model.vo.itemsVo.AttributeVo;
	import sceneModule.model.vo.itemsVo.ExtraAttributeVo;
	import sceneModule.model.vo.itemsVo.PackageSuite;
	import sceneModule.model.vo.itemsVo.PackgeInfoVo;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.role.event.NRoleEvent;
	
	import util.PackageIitemInfoSettingUtil;

	/**
	 * 获取角色装备信息成功事件 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleItemResponseCommand extends Command
	{
		[Inject]
		public var evt:GetRoleItemResponseEvent;
		public function GetRoleItemResponseCommand()
		{
			super();
		}
		
		override public function execute():void{
			var arr:ArrayCollection = new ArrayCollection();
			var byteArray:ByteArray = evt.result as ByteArray;
			var responseData:getItemsInEquipSlotResponse = new getItemsInEquipSlotResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
//			    arr.source = responseData.data;
//				var l:int = responseData.data.length;
				var EquipArrayCollection:ArrayCollection = new ArrayCollection();
				var l:int = responseData.data.packageItemInfo.length;
				for(var i:int = 0;i<l;i++){
					var packageInfoItem:PackageInfo = responseData.data.packageItemInfo[i];
					var itemInfo:proto.ItemsInfo = packageInfoItem.itemInfo;//生成的
					var packageInfoVo:PackageItem;
					if(itemInfo){
						packageInfoVo = CrotaItemConfig.getItemInfoByTempleteId(itemInfo.templateId);
						PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageInfoVo,itemInfo);
					}else{
						packageInfoVo = new PackageItem();
					}
					
					EquipArrayCollection.addItem(packageInfoVo);
				}
			    SystemDataModel.peopleItemInfo.source = EquipArrayCollection.toArray();
			}else{
				SystemDataModel.peopleItemInfo.source = (new ArrayCollection).toArray();
			}
			this.dispatch(new NRoleEvent(NRoleEvent.NRoleEvent_EQUIP_CHANGE));
			
		}
	}
}
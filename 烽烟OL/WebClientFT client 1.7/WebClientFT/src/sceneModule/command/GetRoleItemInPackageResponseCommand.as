package sceneModule.command
{
	
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.ItemsInfo;
	import proto.Suite;
	import proto.scene.scene204.PackageInfo;
	import proto.scene.scene204.getItemsInPackageResponse;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.event.GetRoleItemInPackageResponseEvent;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.model.vo.packageVo.PackageSuite;
	import sceneModule.view.pack.event.PackageInfoChangeEvent;
	
	import util.PackageIitemInfoSettingUtil;
	import util.xtrace;
	

	/**
	 * 获取角色物品信息ResponseEvent 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleItemInPackageResponseCommand extends Command
	{
		[Inject]
		public var evt:GetRoleItemInPackageResponseEvent;
		public function GetRoleItemInPackageResponseCommand()
		{
			super();
		}
		override public function execute():void {
			var arr:ArrayCollection = new ArrayCollection();
			var byteArray:ByteArray = evt.result as ByteArray;
			var responseData:getItemsInPackageResponse=new getItemsInPackageResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data){
			   var l:int = responseData.data.packageItemInfo.length;
			   SystemDataModel.packageinfoVo.canUseTileCount = responseData.data.packageSize;
			   SystemDataModel.packageinfoVo.curPage = responseData.data.curpage;
			   SystemDataModel.packageinfoVo.maxPage = responseData.data.maxpage;
			   SystemDataModel.packageinfoVo.curOpenMaxCount = responseData.data.totalsize;
			   var packageArr:ArrayCollection = new ArrayCollection();
			   for(var i:int = 0;i<l;i++){
//				   var packageInfoItem:PackageInfo = responseData.data.packageItemInfo[i];
				   var packageInfoItem:PackageInfo = responseData.data.packageItemInfo[i];
				   var itemInfo:ItemsInfo = packageInfoItem.itemInfo;//生成的
				   var packageInfoVo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(itemInfo.templateId);//VO
				   PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageInfoVo,itemInfo);
				   packageInfoVo.position = responseData.data.packageItemInfo[i].position;
				   packageArr.addItem(packageInfoVo);
			   }

			   SystemDataModel.packageinfoVo.packageInfoColl.source = packageArr.toArray();
			   
			   this.dispatch(new PackageInfoChangeEvent(PackageInfoChangeEvent.PACKAGEINFOCHANGEEVENT));
			}
		}
	}
}
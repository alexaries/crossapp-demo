package sceneModule.view.shop.command
{
	import flash.events.Event;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.ItemsInfo;
	import proto.Suite;
	import proto.shop.shop206.PackageInfo;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.vo.itemsVo.AttributeEffectVo;
	import sceneModule.model.vo.itemsVo.AttributeVo;
	import sceneModule.model.vo.itemsVo.ExtraAttributeVo;
	import sceneModule.model.vo.itemsVo.PackgeInfoVo;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.model.vo.packageVo.PackageSuite;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	
	import util.CommonTools;
	import util.PackageIitemInfoSettingUtil;

	/**
	 * 获取商店信息返回值Command 
	 * @author Yaolx
	 * 
	 */	
	public class GetShopInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:GetShopInfoResponseEvent;
		public function GetShopInfoResponseCommand()
		{
			super();
		}
		override public function execute():void{
				var l:int = evt.result.packageItemInfo.length;
//				SystemDataModel.shopInfoVo.remainTime = evt.result.refreshShopTime;
				SystemDataModel.shopInfoVo.curPage = evt.result.curPage;
				SystemDataModel.shopInfoVo.maxPage = evt.result.maxPage;
				var packageArr:ArrayCollection = new ArrayCollection();
				for(var i:int = 0;i<l;i++){
					var packageInfoItem:PackageInfo = evt.result.packageItemInfo[i];
					var itemInfo:ItemsInfo = packageInfoItem.itemInfo;//生成的
					var packageInfoVo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(itemInfo.templateId);//VO
					PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageInfoVo,itemInfo);
					packageArr.addItem(packageInfoVo);
				}
				SystemDataModel.shopInfoVo.weaponryShopInfo.source = packageArr.toArray();
			}
	}
}
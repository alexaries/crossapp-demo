package sceneModule.model.vo.blacksmithVO
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 祭炼信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class BlacksmithCastingInfoVO
	{
		public var curGrowing:int;//当前成长度
		public var maxGrowing:int;//最大成长度
		public var curStrengthen:int;//当前强化等级
		public var maxStrengthen:int;//最大强化等级
		public var curSuccessRate:int;//当前成功率
		public var maxSuccessRate:int;//最大成功率
		public var castingItemInfo:PackageItem = new PackageItem();//祭炼对象信息
		public var consumeItemInfo:PackageItem = new PackageItem();//消耗装备信息
		public function BlacksmithCastingInfoVO()
		{
		}
	}
}
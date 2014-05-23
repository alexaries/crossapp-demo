package sceneModule.model.vo.blacksmithVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 强化背包信息 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class BlacksmithStrengthenPackageInfoVO
	{
		public var curPage:int;//背包当前页
		public var maxPage:int;//背包最大页
		public var itemEquipInfoList:ArrayCollection = new ArrayCollection();//装备集合
		public function BlacksmithStrengthenPackageInfoVO()
		{
		}
	}
}
package sceneModule.model.vo.blacksmithVO
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 合成信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class BlacksmithSynthesisInfoVo
	{
		public var itemInfo1:PackageItem = new PackageItem();//装备1信息
		public var itemInfo2:PackageItem = new PackageItem();//装备2信息
		public var targetItemInfo:PackageItem = new PackageItem();//目标装备信息
		public function BlacksmithSynthesisInfoVo()
		{
		}
	}
}
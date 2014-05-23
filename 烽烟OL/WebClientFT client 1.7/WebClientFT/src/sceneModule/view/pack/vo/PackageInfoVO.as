package sceneModule.view.pack.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 包裹信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class PackageInfoVO
	{
		public var curPage:int;//当前页
		public var maxPage:int;//最大页数
		//包裹信息集合
		public var packageInfoColl:ArrayCollection = new ArrayCollection();
		//当前解锁的格子shu
		public var canUseTileCount:int;
		//当前背包总共开的格子数
		public var curOpenMaxCount:int;
		public function PackageInfoVO()
		{
		}
	}
}
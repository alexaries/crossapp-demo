package sceneModule.view.blacksmith.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class XQStoreInfoVO
	{
		public var curPage:int;
		public var maxPage:int;
		public var storeList:ArrayCollection = new ArrayCollection();
		public function XQStoreInfoVO()
		{
		}
	}
}
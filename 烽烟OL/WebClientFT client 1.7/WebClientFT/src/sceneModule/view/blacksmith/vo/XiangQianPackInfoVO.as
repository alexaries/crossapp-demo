package sceneModule.view.blacksmith.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class XiangQianPackInfoVO
	{
		public var curPage:int;//当前页
		public var maxPage:int;//最大页
		public var itemList:ArrayCollection = new ArrayCollection();//XQItemInfoVO
		public function XiangQianPackInfoVO()
		{
		}
	}
}
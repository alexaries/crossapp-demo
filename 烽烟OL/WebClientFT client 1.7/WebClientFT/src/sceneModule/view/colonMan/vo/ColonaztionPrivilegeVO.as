package sceneModule.view.colonMan.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ColonaztionPrivilegeVO
	{
		public var curPage:int;//当前页
		public var maxPage:int;//总页数
		public var colonizationList:ArrayCollection = new ArrayCollection();//殖民特权副本组ColonaztionFuBenGroupVO
		public function ColonaztionPrivilegeVO()
		{
		}
	}
}
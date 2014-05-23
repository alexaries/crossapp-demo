package sceneModule.view.blacksmith.vo
{
	import sceneModule.model.vo.packageVo.PackageItem;

	[Bindable]
	public class XQItemInfoVO
	{
		public var inBody:int;//是否在身上1在身上
		public var itemsInfo:PackageItem;
		public function XQItemInfoVO()
		{
		}
	}
}
package sceneModule.view.nmall.model
{
	import sceneModule.model.vo.packageVo.PackageItem;

	[Bindable]
	public class MallInfoVo
	{
		public var itemInfo:PackageItem = new PackageItem(); 	//物品id
		public var type:int;		//物品类型
		public var price:int;		//钻价格
		public var count:int;		//可购买数量
		public var itemID:int;		//商品id
		public function MallInfoVo()
		{
		}
	}
}
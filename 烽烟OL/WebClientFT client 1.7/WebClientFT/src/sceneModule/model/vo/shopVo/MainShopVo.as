package sceneModule.model.vo.shopVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 商城物品分类信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class MainShopVo
	{
		public var categories:int;//商城分类
		public var curPage:int;//当前页数
		public var maxPage:int;//最大页数
		public var itemCollection:ArrayCollection = new ArrayCollection()//商品信息集合 MainShopInfoVo
		public function MainShopVo()
		{
		}
	}
}
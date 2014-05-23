package sceneModule.view.shop.model.vo
{
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.vo.shopVo.ShopNpcInfoVo;

	/**
	 * 商店信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class ShopInfoVo
	{
		//商店武器类信息
		public var weaponryShopInfo:ArrayCollection = new ArrayCollection(); 
		//npc
		public var npcInfoVo:ShopNpcInfoVo = new ShopNpcInfoVo();
		//物品类型
		public var itemType:int=-1;//0购买1出售
		public var curPage:int=1;//当前页数
		public var maxPage:int;//总页数
		public function ShopInfoVo()
		{
		}
	}
}
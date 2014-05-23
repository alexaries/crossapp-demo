package sceneModule.model.vo.blacksmithVO
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 铁匠铺中强化信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class BlacksmithStrengthenInfoVO
	{
		public var strengthenSuccRate:int;//强化成功率
		public var itemsInfo:PackageItem = new PackageItem();//要强化的装备信息
		public var itemType:int;//强化物品类型0装备1强化石
		public var strLevel:int;//等级
		public var param1Name:String;//属性名称
		public var param1:int;//属性值
		public var param2Name:String;
		public var param2:int;
		public var requiredCoin:String;//所需金币
		public var failDes:String;//失败惩罚
		public function BlacksmithStrengthenInfoVO()
		{
		}
	}
}
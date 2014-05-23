package sceneModule.view.target.vo
{
	[Bindable]
	public class RewardInfoVO
	{
		public var itemId:int;//奖励物品id
		public var icon:int;//物品的图标
		public var stack:int;//物品的层叠数
		public var type:int;//物品的类型
		public var rewardType:int;//奖励类型 0物品1金币2钻3体力
		public function RewardInfoVO()
		{
		}
	}
}
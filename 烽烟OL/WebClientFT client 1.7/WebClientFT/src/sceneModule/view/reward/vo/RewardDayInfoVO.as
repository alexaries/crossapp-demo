package sceneModule.view.reward.vo
{
	import sceneModule.model.vo.packageVo.PackageItem;

	[Bindable]
	public class RewardDayInfoVO
	{
		public var type:int;//奖励类型0物品1金币2钻3体力
		public var rewardNum:int;//当type为1,2,3时。需要用到此值
		public var itemsBonus:PackageItem = new PackageItem(); //角色获得的物品奖励 
		public function RewardDayInfoVO()
		{
		}
	}
}
package sceneModule.view.reward.vo
{
	import mx.collections.ArrayCollection;
	[Bindable]
	public class RewardListInfo
	{
		public var curPage:int;//当前页数
		public var maxPage:int;//最大页数
		public var rewardInfoArr:ArrayCollection = new ArrayCollection();//奖励信息 RewardInfoVO
		public function RewardListInfo()
		{
		}
	}
}
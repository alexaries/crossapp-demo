package sceneModule.view.reward.vo
{
	import mx.collections.ArrayCollection;
	[Bindable]
	public class RewardBattleVO
	{
		public var r_id:int;//奖励id
		public var curPage:int;//当前页数
		public var maxPage:int;//最大页数
		public var battleInfoVoArr:ArrayCollection = new ArrayCollection();//战斗信息RewardBattleInfoVO
		public function RewardBattleVO()
		{
		}
	}
}
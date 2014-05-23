package sceneModule.view.groupBattle.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class GroupBattleInfoVO
	{
		public var roundCount:int;//轮数 当前进行第几轮
		public var remainTime:int;//剩余时间
		public var jishaCount:int;//击杀人数
		public var obtainCoin:int;//获得金币
		public var failCount:int;//战败次数
		public var obtainSw:int;//获得声望
		public var battleInfoList:ArrayCollection = new ArrayCollection();//战斗信息BattleInfoVO
		public var group1Info:GroupInfoVO = new GroupInfoVO();//一方军团信息
		public var group2Info:GroupInfoVO = new GroupInfoVO();//另一方军团信息
		public function GroupBattleInfoVO()
		{
		}
	}
}
package sceneModule.view.reward.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * RewardBattleInfoVO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class RewardBattleInfoVO
	{
		public var battleName:String;//城镇或副本名称
		public var battleResult:Boolean;//战斗是否成功 true成功false失败
		public var sucRoleInfoArr:ArrayCollection = new ArrayCollection();//成功者信息  RewardBattleRoleInfoVO
		public var failRoleInfoArr:ArrayCollection = new ArrayCollection();//失败者信息RewardBattleRoleInfoVO
		public var refreshTime:String;//刷新时间
		public function RewardBattleInfoVO()
		{
		}
	}
}
package sceneModule.view.groupBattle.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class GroupLingDiInfoVO
	{
		public var ldType:int;//默认0无领地1克罗村2雷格镇3塞拉恩特王城4皇城5纱布西6塔斯蒂落皇宫7布多克部落8魔蓝迪域9众神之域
		public var groupName:String;//军团名称
		public var groupLevel:int;//军团等级
		public var groupLeader:String;//军团长
		public var obtainJL:Boolean;//是否获取奖励默认flase
		public var icon:int;//军徽
		public var battleInfo:ArrayCollection = new ArrayCollection();
		public var battleTime:int;//距离战斗时间
		public function GroupLingDiInfoVO()
		{
		}
	}
}
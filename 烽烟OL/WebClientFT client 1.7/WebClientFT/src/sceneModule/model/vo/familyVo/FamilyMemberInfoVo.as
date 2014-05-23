package sceneModule.model.vo.familyVo
{
	/**
	 * 行会会员信息VO
	 */
	[Bindable]
	public class FamilyMemberInfoVo
	{
		public var memberId:int;//族员id
		public var memberName:String;//族员名称
		public var memberJobs:int;//族员职位
		public var memberLevel:int;//族员等级
		public var memberContribution:int;//贡献值
		public var lastOnLineTime:String;//最后一次上线时间
		public var isOnLine:int;//是否在线  0 不在线 1 在线
		public function FamilyMemberInfoVo()
		{
		}
	}
}
package sceneModule.model.vo.corpsVO
{
	/**
	 * 军团成员列表和申请入团列表VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class CorpsMembersAndAppliInfoVO
	{
		public var memberliId:int;//申请列表id
		public var memberName:String;//名称
		public var memberLevel:int;//等级
		public var memberProfession:String;//职业
		public var memberRank:String;//军衔
		public var memberTime:String;//申请时间 
		public var memberContributio:int;//贡献
		public var memberType:int;//0获取军团成员列表1按条件查找军团成员2获取申请列表3按条件查找申请成员
		public function CorpsMembersAndAppliInfoVO()
		{
		}
	}
}
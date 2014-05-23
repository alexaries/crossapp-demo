package sceneModule.model.vo.familyVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 家族信息VO
	 */
	[Bindable]
	public class FamilyInfoVo
	{
		public var familyMemberCollection:ArrayCollection = new ArrayCollection();//行会成员集合
		public var familyMemberPageCount:int;//行会成员总页数
		public var familyRankingCollection:ArrayCollection = new ArrayCollection();//排行榜  FamilyRankingInfoVo
		public var familyRankingPageCount:int;//排行榜总页数
		public var myFamilyInfo:FamilyBasicInfoVo = new FamilyBasicInfoVo();//自己家族基本信息
		public var allianceFlag:Boolean = false;//是否有同盟家族
		public var allianceFamilyInfo:FamilyBasicInfoVo = new FamilyBasicInfoVo();//同盟家族基本信息
		public var hostilityFlag:Boolean = false;//是否有敌对家族
		public var hostilityFamilyInfo:FamilyBasicInfoVo = new FamilyBasicInfoVo();//敌对家族基本信息
		public var familyMoney:int;//家族资金
		public var familyState:int;//家族状态 0正常1被殖民
		public var familyStrategierLeft:String;//左参谋
		public var familyStrategierRight:String;//右参谋
		public var familyMonitorLeft:String;//左队长
		public var familyMonitorCenter:String;//中队长
		public var familyMonitorRight:String;//右队长
		public var myContribution:int;//我的贡献
		public var isCanUpLevel:Boolean;//是否可以升级
		public function FamilyInfoVo()
		{
		}
	}
}
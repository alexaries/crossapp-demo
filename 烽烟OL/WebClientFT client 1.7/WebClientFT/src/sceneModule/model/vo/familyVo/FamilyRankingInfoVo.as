package sceneModule.model.vo.familyVo
{
	/**
	 * 行会排行信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class FamilyRankingInfoVo
	{
		public var familyRank:int;//名次
		public var familyId:int;//行会id
		public var familyName:String;//行会名称
		public var familyLevel:int;//行会等级
		public var familyScale:int;//行会规模
		public function FamilyRankingInfoVo()
		{
		}
	}
}
package sceneModule.model.vo.familyVo
{
	/**
	 * 家族基本信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class FamilyBasicInfoVo
	{
		public var familyId:int;//家族id
		public var familyName:String;//家族名称
		public var familyLevel:int;//家族等级
		public var familyLeader:String;//族长
		public var curFamilyNum:int;//家族当前人数
		public var maxFamilyNum:int;//家族人数上限
		public function FamilyBasicInfoVo()
		{
		}
	}
}
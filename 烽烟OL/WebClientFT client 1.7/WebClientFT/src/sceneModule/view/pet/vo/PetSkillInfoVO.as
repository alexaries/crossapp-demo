package sceneModule.view.pet.vo
{
	/**
	 * 宠物技能信息VO 
	 * @author Dream-Y
	 * 
	 */
	[Bindable]
	public class PetSkillInfoVO
	{
		public var hasActivationFlag:Boolean;//是否激活
		public var petSkillId:int;//宠物技能id
		public var icon:int;//物品的图标
		public var type:int;//物品类型
		public var petSkillName:String;//技能名称
		public var petSkillLevel:int;//技能等级
		public var petSkillDes:String;//技能描述
		public var petSkillMaxLevel:int;//技能最高级
		//
		public var skillPos:int;//当前技能在技能列表中的位置
		public function PetSkillInfoVO()
		{
		}
	}
}
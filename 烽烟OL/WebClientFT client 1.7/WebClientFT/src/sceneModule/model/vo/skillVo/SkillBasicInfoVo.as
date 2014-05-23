package sceneModule.model.vo.skillVo
{
	/**
	 * 技能信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class SkillBasicInfoVo
	{
		public var skillId:int;//技能id
		public var skillName:String;//技能名称
		public var skillLevel:int;//技能等级
		public var remainRoleLevel:int;//需求人物等级
		public var skillDes:String;//技能说明
		public var releasePreEnergy:int;//释放所需能量值
		public var levelUpEffect:String;//升级后效果
		public var levelUpProps:String;//升级所需道具
		public var levelUpMoney:int;//升级所需金币
		public var levelUpRoleLevel:int;//升级所需角色等级
		public var skillStatus:int;//角色状态 0 激活 1未激活
		public var icon:int;//物品的图标
		public var type:int;//物品类型
		public var skillType:int;//0主动技能1被动技能2应用技能3战斗技能
		public function SkillBasicInfoVo()
		{
		}
	}
}
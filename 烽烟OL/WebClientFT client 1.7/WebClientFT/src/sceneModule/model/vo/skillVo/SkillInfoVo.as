package sceneModule.model.vo.skillVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 技能信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class SkillInfoVo
	{
		public var skillList:ArrayCollection = new ArrayCollection();//SkillBasicInfoVo主动列表
		public var pasSkillList:ArrayCollection = new ArrayCollection();//SkillBasicInfoVo被动技能列表
		public var appSkillList:ArrayCollection = new ArrayCollection();//SkillBasicInfoVo应用技能列表
		public var battleSkillList:ArrayCollection = new ArrayCollection();//SkillBasicInfoVo战斗技能
		public function SkillInfoVo()
		{
		}
	}
}
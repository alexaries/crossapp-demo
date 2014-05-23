package sceneModule.model.vo.groupVo
{
	/**
	 * 组队的队伍中的成员信息 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class TeamMemberInfoVo
	{
		public var id:int;
		public var nickName:String;
		public var profession:int;
		public var maxHp:int;
		public var hp:int;
		public var maxMp:int;
		public var mp:int;
		public var level:int;
		public function TeamMemberInfoVo()
		{
		}
	}
}
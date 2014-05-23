package sceneModule.model.vo.groupVo
{
	/**
	 * 房间角色列表中的角色信息VO 
	 * @author Yaolx
	 * 
	 */	
	
	[Bindable]
	public class RoomRoleListRoleInfoVo
	{
		public var roleId:int;//角色id
		public var roleLevel:int;//角色等级
		public var roleName:String;//角色名称
		public var roleWork:int;//角色职业
//		public var roleSkillInfo;//角色技能RoleSkillInfo
		public var isRoomOwner:Boolean;//是否是房主
		public var isReady:Boolean;//是否准备
		
		public function RoomRoleListRoleInfoVo()
		{
		}
	}
}
package sceneModule.model.vo.corpsVO
{
	/**
	 * 角色身上的军团信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class RoleCorpsInfoVO
	{
		public var joinCorpsFlag:Boolean;//是否进入军团
		public var corpsPosition:int;//军团职位 0普通成员1议事2参谋3元老4军团长
		public var corpsName:String;//军团名
		public var corpsLevel:int;//军团等级 
		public function RoleCorpsInfoVO()
		{
		}
	}
}
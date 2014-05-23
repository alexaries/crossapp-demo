package sceneModule.view.friend.model.vo
{
	/**
	 * 好友信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class FriendInfoVo
	{
		public var roleId:int;//角色id
		public var roleName:String;//角色名称
		public var roleProfession:int;//角色职业
		public var level:int;//等级
		public var comp:String;//行会
		public var lastLoadTime:String;//最后登录时间
		public var showMesFlag:int;//好友上线是否提示  0不提示  1提示
		public var isLine:int;//好友是否在线  0不在线  2在线
		public function FriendInfoVo()
		{
		}
	}
}
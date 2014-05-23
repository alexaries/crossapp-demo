package sceneModule.view.groupBattle.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class GroupInfoVO
	{
		public var groupName:String;//军团名称
		public var groupCount:int;//积分
		public var icon:int;//军徽
		public var groupMemberArr:ArrayCollection = new ArrayCollection();//GroupMemberVO
		public function GroupInfoVO()
		{
		}
	}
}
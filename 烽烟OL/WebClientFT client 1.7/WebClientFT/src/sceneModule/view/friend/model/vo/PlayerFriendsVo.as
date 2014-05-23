package sceneModule.view.friend.model.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 好友信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class PlayerFriendsVo
	{
		public var friendsCollection:ArrayCollection = new ArrayCollection();
		public var blacklistCollection:ArrayCollection = new ArrayCollection();//黑名单
		public function PlayerFriendsVo()
		{
		}
	}
}
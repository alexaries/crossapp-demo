package sceneModule.view.friend.event
{
	import flash.events.Event;

	/**
	 * 添加好友Event 
	 * @author Yaolx
	 * 
	 */	
	public class AddPlayerFriendEvent extends Event
	{
		public static const ADDPLAYERFRIEND:String = "addPlayerFriend";
		public var friendsName:String;
		public function AddPlayerFriendEvent(type:String,fName:String)
		{
			friendsName = fName;
			super(type);
		}
		
	}
}
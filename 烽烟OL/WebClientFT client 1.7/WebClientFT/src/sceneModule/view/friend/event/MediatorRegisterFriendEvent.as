package sceneModule.view.friend.event
{
	import flash.events.Event;

	public class MediatorRegisterFriendEvent extends Event
	{
		public static const MR_FRIEND_VIEW:String = "mr_friend_view";
		public static const MR_FRIEND_ITEMRENDER:String = "mr_friend_itemRender";
		public static const MR_FRIEND_LEVELUP:String = "mr_friend_levelUp";
		public static const MR_FRIEND_STATE:String = "mr_friend_state";
		public static const MR_FRIEND_ALERT:String = "mr_friend_alert";
		public static const MR_FRIEND_INPUT:String = "mr_friend_input";
		public var view:Object;
		public function MediatorRegisterFriendEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterFriendEvent(type, view, bubbles, cancelable);
		}
	}
}
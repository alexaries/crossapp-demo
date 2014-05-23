package sceneModule.view.friend.event
{
	import flash.events.Event;

	public class MainMenuFriendLoadGameIsShowMessageEvent extends Event
	{
		public static const MAINMENUFRIENDLOADGAMEISSHOWMESSAGE:String = "mainMenuFriendLoadGameIsShowMessage";
		public var isShowMesgFlag:Boolean;
		public var roleId:int;
		public function MainMenuFriendLoadGameIsShowMessageEvent(type:String,value1:Boolean,value2:int)
		{
			isShowMesgFlag = value1;
			roleId = value2;
			super(type);
		}
	}
}
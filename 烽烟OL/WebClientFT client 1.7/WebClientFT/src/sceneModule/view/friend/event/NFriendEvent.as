package sceneModule.view.friend.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NFriendEvent extends Event 
	{
		
		public static const NFriendEvent_SEND_MAIL:String = "NFriendEvent_SEND_MAIL";
		public static const NFriendEvent_LOOK_INFO:String = "NFriendEvent_LOOK_INFO";
		public static const NFriendEvent_INVIDE_TO_UNION:String = "NFriendEvent_INVIDE_TO_UNION";
		public static const NFriendEvent_CHAT:String = "NFriendEvent_CHAT";
		public static const NFriendEvent_BLOCK:String = "NFriendEvent_BLOCK";
		public static const NFriendEvent_REMOVE:String = "NFriendEvent_REMOVE";
		
		public static const NFriendEvent_REFRESH_LIST:String = "NFriendEvent_REFRESH_LIST";
		
		public static const NFriendEvent_OPEN:String = "NFriendEvent_OPEN";
		
		
		private var _obj:Object;
		
		public function NFriendEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = obj;
			super(type, bubbles, cancelable);
		}
		
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}
package logonModule.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NLoginEvent extends Event 
	{
		public static const NLoginEvent_SHOW_SOCKET_CON:String = "NLoginEvent_SHOW_SOCKET_CON";
		public static const NLoginEvent_SHOW_SOCKET_ON_SERVER:String = "NLoginEvent_SHOW_SOCKET_ON_SERVER";
		
		private var _obj:Object;
		
		public function NLoginEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
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
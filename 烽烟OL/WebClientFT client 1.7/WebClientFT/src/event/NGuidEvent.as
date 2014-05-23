package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NGuidEvent extends Event 
	{
		public static const NGuidEvent_XML_LOADED:String = "NGuidEvent_XML_LOADED";
		public static const NGuidEvent_SHOW_LEFT_GO:String = "NGuidEvent_SHOW_LEFT_GO";
		public static const NGuidEvent_SHOW_RIGHT_GO:String = "NGuidEvent_SHOW_RIGHT_GO";
		public static const NGuidEvent_CLEAR_GO:String = "NGuidEvent_CLEAR_GO";
		private var _obj:Object;
		public function NGuidEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
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
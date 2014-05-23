package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class UILoadEvent extends Event 
	{
		public static const UILoadEvent_SHOW:String = "UILoadEvent_SHOW";
		public static const UILoadEvent_HIDE:String = "UILoadEvent_HIDE";
		public static const UILoadEvent_PROGRESS:String = "UILoadEvent_PROGRESS";
		
		
		private var _obj:Object;
		public function UILoadEvent(type:String, obj:Object = null,bubbles:Boolean=false, cancelable:Boolean=false) 
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
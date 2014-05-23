package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class KeyFuncEvent extends Event 
	{
		//显示或者隐藏世界地图
		public static const KeyFuncEvent_MAP_CHANGE:String = "KeyFuncEvent_MAP_CHANGE";
		
		
		public function KeyFuncEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}
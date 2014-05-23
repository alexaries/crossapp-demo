package sceneModule.view.ui.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NMainUIEvent extends Event 
	{
		public static const NMainUIEvent_REFRESH_TRIPS_INFO:String = "NMainUIEvent_REFRESH_TRIPS_INFO";
		
		public function NMainUIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}
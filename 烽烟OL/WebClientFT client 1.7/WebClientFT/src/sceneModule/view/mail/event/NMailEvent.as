package sceneModule.view.mail.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NMailEvent extends Event 
	{
		public static const NMailEvent_NEW_MAIL:String = "NMailEvent_NEW_MAIL";
		public function NMailEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}
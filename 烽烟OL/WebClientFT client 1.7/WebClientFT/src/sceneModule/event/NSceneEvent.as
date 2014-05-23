package sceneModule.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class NSceneEvent extends Event 
	{
		public static const NSceneEvent_HEARO_MOVE:String = "NSceneEvent_HEARO_MOVE";
		
		private var _obj:Object;
		
		public function NSceneEvent(type:String, obj:Object, bubbles:Boolean=false, cancelable:Boolean=false) 
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
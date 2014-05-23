package resource 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class SceneResLoadEvent extends Event 
	{
		public static const SceneResLoadEvent_SINGLE_LOADED:String = "SceneResLoadEvent_SINGLE_LOADED";
		
		private var _obj:Object;
		
		public function SceneResLoadEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
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
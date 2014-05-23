package sceneModule.view.copyScene.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NCopySceneEvent extends Event 
	{
	
		public static const NCopySceneEvent_ENTER:String = "NCopySceneEvent_ENTER";
		public static const NCopySceneEvent_ITEM_CLICK:String = "NCopySceneEvent_ITEM_CLICK";
		public static const NCopySceneEvent_CHAT:String = "NCopySceneEvent_CHAT";
		
		
		public static const NCopySceneEvent_SHOW_NO_IN:String = "NCopySceneEvent_SHOW_NO_IN";
		
		private var _obj:Object;
		public function NCopySceneEvent(type:String, obj:Object, bubbles:Boolean=false, cancelable:Boolean=false) 
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
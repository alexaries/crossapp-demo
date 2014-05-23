package event
{
	import flash.events.EventDispatcher;

	public class SceneInitCompleteManager extends EventDispatcher
	{
		private static var _instance:SceneInitCompleteManager;
		public function SceneInitCompleteManager()
		{
			
		}
		
		public static function getInstance():SceneInitCompleteManager{
			if(null == _instance){
				_instance = new SceneInitCompleteManager();
			}
			
			return _instance;
		}
	}
}
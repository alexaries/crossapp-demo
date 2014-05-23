package sceneModule.view.announ
{
	import flash.events.EventDispatcher;

	public class AddWindowEventDispatcher extends EventDispatcher
	{
		private static var _instance:AddWindowEventDispatcher;
		public function AddWindowEventDispatcher()
		{
		}
		
		public static function getInstance():AddWindowEventDispatcher{
			if(null == _instance){
				_instance = new AddWindowEventDispatcher();
			}
			
			return _instance;
		}
	}
}
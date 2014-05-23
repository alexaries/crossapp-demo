package event
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class GuidEventCenter extends EventDispatcher
	{
		private static var _instance:GuidEventCenter;
		public function GuidEventCenter(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function getInstance():GuidEventCenter {
			if (null == _instance) {
				_instance = new GuidEventCenter();
			}
			return _instance;
		}
	}
}
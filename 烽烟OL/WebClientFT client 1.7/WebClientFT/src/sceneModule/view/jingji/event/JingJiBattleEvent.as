package sceneModule.view.jingji.event
{
	import flash.events.Event;

	public class JingJiBattleEvent extends Event
	{
		public static const JINGJIBATTLE:String = 'jingJiBattle';
		private var _obj:int;
		public function JingJiBattleEvent(type:String, obj:int = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_obj = obj;
			super(type, bubbles, cancelable);
		}
		
		public function get obj():int 
		{
			return _obj;
		}
	}
}
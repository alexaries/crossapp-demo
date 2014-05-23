package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class SwitchMaskEvent extends Event 
	{
		public static const SwitchMaskEvent_SHOW:String = "SwitchMaskEvent_SHOW";
		public static const SwitchMaskEvent_HIDE:String = "SwitchMaskEvent_HIDE";
		
		private var _func:Function;
		private var _args:Array;
		
		public function SwitchMaskEvent(type:String, func:Function = null, args:Array = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_func = func;
			_args = args;
			super(type, bubbles, cancelable);
		}
		
		public function get func():Function 
		{
			return _func;
		}
		
		public function get args():Array 
		{
			return _args;
		}
		
	}

}
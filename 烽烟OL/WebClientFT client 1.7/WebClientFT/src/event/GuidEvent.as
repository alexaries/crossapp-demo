package event
{
	import flash.events.Event;
	
	public class GuidEvent extends Event
	{
		public static const GuidEvent_EVENT:String = "GuidEvent_EVENT";
		private var _etype:int;
		private var _arg1:int;
		private var _arg2:*;
		private var _arg3:int;
		public function GuidEvent(etype:int , arg1:int = 0, arg2:*= null, arg3:int = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_etype = etype;
			_arg1 = arg1;
			_arg2 = arg2;
			_arg3 = arg3;
			super(GuidEvent_EVENT, bubbles, cancelable);
		}
		
		public function get etype():int 
		{
			return _etype;
		}
		
		public function get arg1():int 
		{
			return _arg1;
		}
		
		public function get arg2():* 
		{
			return _arg2;
		}
		
		public function get arg3():int 
		{
			return _arg3;
		}
	}
}
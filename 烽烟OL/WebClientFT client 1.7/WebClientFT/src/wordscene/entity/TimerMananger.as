package wordscene.entity 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author hao
	 */
	public class TimerMananger 
	{
		public static const GAP_TIME:int = 80;
		private static var _instance:TimerMananger;
		
		private var _timer:Timer;
		private var _funcs:Vector.<Function>;
		private var _pareFuncs:Vector.<PareFunc>;
		
		public static function getInstance():TimerMananger {
			if (null == _instance) {
				_instance = new TimerMananger();
			}
			return _instance;
		}
		public function TimerMananger() 
		{
			_funcs = new Vector.<Function>();
			_pareFuncs = new Vector.<PareFunc>();
			_timer = new Timer(GAP_TIME);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
		}
		
		public function add(func:Function):void {
			_pareFuncs.push(new PareFunc(1, func));
		}
		public function remove(func:Function):void {
			_pareFuncs.push(new PareFunc(0, func));
		}
		public function haveFunc(func:Function):Boolean {
			return -1 != _funcs.indexOf(func);
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			while(_pareFuncs.length > 0)
			{
				var pare:PareFunc = _pareFuncs.shift();
				var index:int = _funcs.indexOf(pare.func);
				if (0 == pare.type) {
					if (-1 != index) {
						_funcs.splice(index, 1);
					}
				}
				else {
					if (-1 == index) {
						_funcs.push(pare.func);
					}
				}
			}
			
			var len:int = _funcs.length;
			for (var i:int = 0; i < len; i++) 
			{
				_funcs[i].apply();
			}
		}
	}
}
class PareFunc {
	private var _type:int;
	private var _func:Function;
	public function PareFunc(type:int, func:Function) {
		_type = type;
		_func = func;
	}
	
	public function get type():int 
	{
		return _type;
	}
	
	public function get func():Function 
	{
		return _func;
	}
}
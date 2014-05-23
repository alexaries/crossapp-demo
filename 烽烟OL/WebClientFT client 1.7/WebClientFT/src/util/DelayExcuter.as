package util 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * 延迟执行函数
	 * @author hao
	 */
	public class DelayExcuter
	{
		private var _func:Function;
		private var _args:Array;
		private var _timer:Timer;
		public function DelayExcuter(time:Number,func:Function,args:Array) 
		{
			_func = func;
			_args = args;
			_timer = new Timer(time, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, over);
			_timer.start();
			//Debug.trace("注册间隔执行函数 : " + func + " args is : " + new ObjectToString(args).getString());
		}
		private function over(e:TimerEvent):void {
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, over);
			_timer.stop();
			_timer = null;
			//Debug.trace("执行间隔执行函数 : " + _func + " args is : " + new ObjectToString(_args).getString());
			_func.apply(null, _args);
			_args = null;
			_func = null;
		}
		
	}

}
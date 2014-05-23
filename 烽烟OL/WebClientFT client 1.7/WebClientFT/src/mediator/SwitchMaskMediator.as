package mediator
{	
	import com.greensock.TweenLite;
	
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import util.DelayExcuter;
	import util.xtrace;

	/**
	 * 整个应用的mediator，用来处理应用的Module关系。 
	 * @author mutou
	 * 
	 */	
	public class SwitchMaskMediator extends Mediator
	{
		public static const CHANGE_TIME_HIDE:Number = 3;
		public static const CHANGE_TIME_SHOW:Number = 0.5;
		
		private var _show_func:Function;
		private var _show_args:Array;
		
		public function SwitchMaskMediator()
		{
			super();
		}
		
		override public function onRegister():void {
			GuidEventCenter.getInstance().addEventListener(SwitchMaskEvent.SwitchMaskEvent_SHOW, show);
			GuidEventCenter.getInstance().addEventListener(SwitchMaskEvent.SwitchMaskEvent_HIDE, hide);
		}
		
		
		private function show(e:SwitchMaskEvent):void {
//			xtrace("显示切换遮罩");
			view.alpha = 0;
			var obj:Object = { };
			obj.alpha = 1;
			//obj.onComplete = show_over;
			
			//if (null != e.func) {
				//obj.onComplete = e.func;
				//obj.onCompleteParams  = e.args;
			//}
			_show_func = e.func;
			_show_args = e.args;
			
			view.mouseEnabled = true;
			TweenLite.to(view, CHANGE_TIME_SHOW, obj);
			new DelayExcuter(CHANGE_TIME_SHOW * 1000, show_over, null);
		}
		
		private function hide(e:SwitchMaskEvent):void {
//			xtrace("隐藏切换遮罩");
			view.alpha = 1;
			var obj:Object = { };
			obj.alpha = 0;
			if (null != e.func) {
				obj.onComplete = e.func;
				obj.onCompleteParams  = e.args;
			}
			TweenLite.to(view, CHANGE_TIME_HIDE, obj );
		}
		
		private function show_over():void {
			view.mouseEnabled = false;
			if (null != _show_func ) {
				_show_func.apply(null, _show_args);
			}
		}
		
		public function get view():SwitchMaskLayer {
			return viewComponent as SwitchMaskLayer;
		}
	}
}

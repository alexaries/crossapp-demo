package wordscene.helper {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import wordscene.entity.BitmapPlayer;
	import wordscene.entity.EntitySprite;
	

	/**
	 * @author CYPL
	 */
	public class QHitTestManager {

		private static var __instance : QHitTestManager;

		private static var $scope : Object = (function():Object {
			return this;
		})();
		
		
		public function QHitTestManager($global : Object) : void {
			if($global != $scope) {
				throw new Error("请使用静态方法 'getInstance()'创建实例!");
			}
		}

		public static function getInstance() : QHitTestManager {
		
			return __instance ||= new QHitTestManager($scope);
		}

		////////////////////////////////////////////////////////////////

		public static const Q_MOUSE_OVER : String = "Q_MOUSE_OVER";
		public static const Q_MOUSE_OUT : String = "Q_MOUSE_OUT";
		public static const Q_MOUSE_DOWN : String = "Q_MOUSE_DOWN";

		private var _timer : Timer;

		private var _oht : IHitTester;
		
		private var _index:int;
		
		private var _stage:Stage;

		public function init(stage:Stage) : void {
		
			_timer = new Timer(100);
			
			_timer.addEventListener(TimerEvent.TIMER, __onTimerHandler);
			
			_stage = stage;
			_oht = new GGOverlayHitTester(stage, BitmapPlayer);
		}

		private var kk : EntitySprite;

		private var _charMap : Dictionary = new Dictionary;

		private function __onTimerHandler(e : TimerEvent) : void {
			
			var currDisplay : EntitySprite = _oht.getDisplay(_stage.mouseX, _stage.mouseY) as EntitySprite;
			
			
			
			//存在对象
			if (currDisplay) {
				
				
				if (kk && kk!=currDisplay) {
					
					dispatchMouseOut(kk);

				}
				

				var disObj:Object = _charMap[currDisplay];
				
				if (disObj && !disObj.over) {

					dispatchMouseOver(currDisplay);
				}
				
				
			}else {
				if (kk) {
					
					dispatchMouseOut(kk);
					
					
				}
					
			}
		}

		
		private function clearCharObj(char:EntitySprite):void {
			if(_charMap[char]){
				_charMap[char].over = false;
				
				_charMap[char].out = false;
			}
		}
		
		public function register(char : EntitySprite) : void {
			
			
			_charMap[char] = {over:false, out:false};
			//char.isHitTest = true;
			Sprite(char).addEventListener(MouseEvent.MOUSE_OVER, __onMouseOver, false, 100);
			Sprite(char).addEventListener(MouseEvent.MOUSE_OUT, __onMouseOut, false, 101);
			Sprite(char).addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown, false, 102);
		}

		public function unregister(char : EntitySprite) : void {
			
			delete _charMap[char];
			Sprite(char).removeEventListener(MouseEvent.MOUSE_OVER, __onMouseOver);
			Sprite(char).removeEventListener(MouseEvent.MOUSE_OUT, __onMouseOut);
			Sprite(char).removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			if (kk == char) {
				stop();	
			}
		}
		private function __onMouseOver(e : MouseEvent) : void {
			
			__onTimerHandler(null);
			_timer.start();
		}

		private function __onMouseOut(e : MouseEvent) : void {
			
			

			_timer.stop();
			
			var target : EntitySprite = e.currentTarget as EntitySprite;

			var disObj:Object = _charMap[target];
			
			

			if (disObj && disObj.over && !disObj.out) {

				dispatchMouseOut(target);
				
			}
			
			
			
			
			if (kk && kk != target) {
				
				disObj = _charMap[kk];
				
				if(disObj && disObj.over && !disObj.out) {

					dispatchMouseOut(kk);
				}
			}
			

		}

		private function __onMouseDown(e : MouseEvent) : void {

			kk && _charMap[kk] && dispatchMouseDown(kk);
		}

		private function dispatchMouseOver(char : EntitySprite) : void {

			_charMap[char].over = true;
			
			kk = char;
			
			Sprite(char).dispatchEvent(new Event(Q_MOUSE_OVER));
		}

		private function dispatchMouseOut(char : EntitySprite) : void {

			clearCharObj(char);
			
			kk = null;
			
			Sprite(char).dispatchEvent(new Event(Q_MOUSE_OUT));
		}

		private function dispatchMouseDown(char : EntitySprite) : void {
			
			
			Sprite(char).dispatchEvent(new Event(Q_MOUSE_DOWN));
		}

		
		public function stop() : void {
			
			if (kk) {
				dispatchMouseOut(kk);
			}
			_timer.stop();
			kk = null;
			_oht.clear();
		}
	}
}

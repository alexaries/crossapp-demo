package wordscene.helper {
    import flash.display.DisplayObject;
    import flash.events.TimerEvent;
	import flash.geom.Rectangle;
    import flash.utils.Timer;    
	import wordscene.WordSceneSprite;

    public class Earthquake {
        private static const FRAME_RATE:int = 40;	

        private static var _timer:Timer;
        private static var _displayObject:WordSceneSprite;
        private static var _originalX:int;
        private static var _originalY:int;
        private static var _intensity:int;
        private static var _intensityOffset:int;

        /**
         * 对一个显示对象应用地震效果。
         * @param displayObject 图形
         * @param intensity 强度
         * @param seconds 持续时间
         */
        public static function go( displayObject:WordSceneSprite, intensity:Number = 10, seconds:Number = 1 ):void {
            if ( _timer ) {
                _timer.stop();
            }
			
            _displayObject = displayObject;
            _originalX = displayObject.x;
            _originalY = displayObject.y;
			
			
			if (_displayObject.bgSp.x + intensity > 0) {
				_originalX = -intensity / 2;
			}
			else if (-_displayObject.bgSp.x + _displayObject.stage.stageWidth + intensity > _displayObject.bgSp.width) {
				_originalX = intensity / 2;
			}
			if (_displayObject.bgSp.y + intensity > 0) {
				_originalY = -intensity / 2;
			}
			else if (-_displayObject.bgSp.y + _displayObject.stage.stageHeight + intensity > _displayObject.bgSp.height) {
				_originalY = intensity / 2;
			}
			
            _intensity = intensity;
            _intensityOffset = intensity / 2;
			
            var msPerUpdate:int = int(1000 / FRAME_RATE);
            var totalUpdates:int = int(seconds * 1000 / msPerUpdate);
			
            _timer = new Timer(msPerUpdate, totalUpdates);
            _timer.addEventListener(TimerEvent.TIMER, quake);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, resetImage);
			
            _timer.start();
        }

        private static function quake( event:TimerEvent ):void {
            var newX:int = _originalX + Math.random() * _intensity - _intensityOffset;
            var newY:int = _originalY + Math.random() * _intensity - _intensityOffset;
			
            _displayObject.x = newX;
            _displayObject.y = newY;
        }

        private static function resetImage( event:TimerEvent = null ):void {
            _displayObject.x = 0;
            _displayObject.y = 0;
			
            cleanup();
        }

        private static function cleanup():void {
            _timer = null;
            _displayObject = null;
        }
    }
}
package wordscene.entity {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import util.Logging;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BitmapPlayer extends Sprite {
		public static const STOP:String = "stop";
		public static const CHAR_PACKAGE_PRE:String = "char";
		
		private var _bitmap:Bitmap;
		
		private var _assetid:String;
		private var _direct:int;
		private var _action:String;
		
		private var _imgs:Vector.<BitmapData>;
		private var _curFrame:int;
		private var _issetpStop:Boolean;
		private var _overFunc:Function;
		private var _overArgs:Array;
		
		private var _defaultPackage:String;
		private var _defaultId:String;
		
		public function BitmapPlayer(defaultPackage:String = "default", defaultId:String = "char") {
			_defaultPackage = defaultPackage;
			_defaultId = defaultId;
			_bitmap = new Bitmap();
			this.addChild(_bitmap);
			clearOverFunc();
		}
		
		public function setAssetID(id:String, isAddPre:Boolean = true):void {
			_assetid = id;
			if (isAddPre) {
				_assetid = CHAR_PACKAGE_PRE + _assetid;
			}
			_direct = 4;
			_action = "";
		}
		
		public function playAction(action:String, direct:int = -1, force:Boolean = false, nextAction:String = null, isStop:Boolean = false):void {
			if (-1 == direct) {
				direct = _direct;
			}
			if (direct == _direct && action == _action && !force) {
				return;
			}
			_direct = direct;
			_action = action;
			_bitmap.scaleX = 1;
			if (1 == direct) {
				direct = 7;
				_bitmap.scaleX = -1;
			} else if (5 == direct) {
				direct = 3;
				_bitmap.scaleX = -1;
			} else if (6 == direct) {
				direct = 2;
				_bitmap.scaleX = -1;
			}
			var itemid:String = action + direct;
			if (-2 == direct) {
				itemid = action;
			}
			var fixpos:Array = SAssetManager.getInstance().getFixInfo(_assetid, itemid);
			var imgs:Vector.<BitmapData> = SAssetManager.getInstance().getImgs(_assetid, itemid);
			var isshowdefalut:Boolean = false;
			if (null == imgs) {
				if (force) {
					Logging.log('no char res', _assetid);
				}
				isshowdefalut = true;
				fixpos = SAssetManager.getInstance().getFixInfo(_defaultPackage, _defaultId);
				imgs = SAssetManager.getInstance().getImgs(_defaultPackage, _defaultId);
				_bitmap.scaleX = 1;
				SAssetManager.getInstance().addToList(_assetid, resetRes, [isStop]);
			}
			if (null == nextAction) {
				reset(imgs, null, null, isStop);
			} else {
				var args:Array = [];
				args.push(nextAction);
				reset(imgs, playAction, args, isStop);
			}
			_bitmap.x = fixpos[0];
			if (-1 == _bitmap.scaleX) {
				_bitmap.x = _bitmap.width + fixpos[0];
			}
			_bitmap.y = fixpos[1];
		}
		
		private function resetRes(isStop:Boolean):void {
			playAction(_action, _direct, true, null, isStop);
		}
		
		private function reset(imgs:Vector.<BitmapData>, overfunc:Function = null, overArgs:Array = null, isStop:Boolean = false):void {
			_overFunc = overfunc;
			_overArgs = overArgs;
			_imgs = imgs;
			_curFrame = 0;
			_issetpStop = isStop;
			TimerMananger.getInstance().add(enterFrame);
			showFrame();
		}
		
		private function enterFrame():void {
			if (null == _imgs) {
				return;
			}
			_curFrame++;
			if (_curFrame >= _imgs.length) {
				_curFrame = 0;
				if (null != _overFunc) {
					var tfunc:Function = _overFunc;
					var targs:Array = _overArgs;
					clearOverFunc();
					tfunc.apply(null, targs);
					return;
				}
				if (_issetpStop) {
					_issetpStop = false;
					TimerMananger.getInstance().remove(enterFrame);
					return;
				}
			}
			showFrame();
		}
		
		public function clear():void {
			TimerMananger.getInstance().remove(enterFrame);
		}
		
		private function showFrame():void {
			_bitmap.bitmapData = _imgs[_curFrame];
		}
		
		private function clearOverFunc():void {
			_overFunc = null;
			_overArgs = null;
		}
	}

}
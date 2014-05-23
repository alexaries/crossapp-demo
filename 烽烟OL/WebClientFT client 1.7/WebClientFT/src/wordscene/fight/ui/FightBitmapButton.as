package wordscene.fight.ui 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightBitmapButton extends Sprite 
	{
		private var _pack:String;
		private var _up:String;
		private var _touch:String;
		private var _over:String;
		private var _disable:String;
		
		private var _isTouch:Boolean;
		private var _isOver:Boolean;
		private var _isDisable:Boolean;
		private var _bitmap:Bitmap;
		
		private var _filterArray:Array;
		private var _soundString:String;
		
		
		public function FightBitmapButton(pack:String, up:String, touch:String, over:String = null, disable:String = null) 
		{
			_pack = pack;
			_up = up;
			_touch = touch;
			_disable = disable;
			if (null == over) {
				over = touch;
			}
			_over = over;
			this.buttonMode = true;
			
			_bitmap = new Bitmap();
			this.addChild(_bitmap);
			
			
			
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			this.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			
			refresh();
		}
		
		public function setDisable(isdisable:Boolean):void {
			_isDisable = isdisable;
			this.mouseEnabled = !isdisable;
			refresh();
		}
		
		public function setFilter(filter:Array):void {
			_filterArray = filter;
		}
		
		public function setSound(sound:String):void {
			_soundString = sound;
		}
		
		private function mouseOut(e:MouseEvent):void {
			_isTouch = false;
			_isOver = false;
			refresh();
			e.target.filters = null;
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			_isTouch = false;
			refresh();
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			_isTouch = true;
			refresh();
		}
		
		private function mouseOver(e:MouseEvent):void {
			_isOver = true;
			refresh();
			if (_filterArray) {
				e.target.filters = _filterArray;
			}
		}
		
		
		private function refresh():void {
			if (_isDisable) {
				_bitmap.bitmapData = SAssetManager.getInstance().getBitmapData(_pack, _disable);
			}
			else {
				if (_isTouch) {
					_bitmap.bitmapData = SAssetManager.getInstance().getBitmapData(_pack, _touch);
				}
				else{
					if (_isOver) {
						_bitmap.bitmapData = SAssetManager.getInstance().getBitmapData(_pack, _over);
					}
					else {
						_bitmap.bitmapData = SAssetManager.getInstance().getBitmapData(_pack, _up);
					}
				}
			}
		}
		
		
		public function getW():int {
			return SAssetManager.getInstance().getBitmapData(_pack, _up).width;
		}
		public function getH():int {
			return SAssetManager.getInstance().getBitmapData(_pack, _up).height;
		}
		
	}

}
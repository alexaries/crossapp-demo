package wordscene.loader 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author hao
	 */
	public class EffectSp extends Sprite 
	{
		public static const EFFECTOVER_EVENT:String = "EFFECTOVER_EVENT";
		public static const EFFECTACTIVE_EVENT:String = "EFFECTACTIVE_EVENT";
		private var _loader:Loader;
		private var _bytes:ByteArray;
		private var _fixx:int;
		private var _fixy:int;
		public function EffectSp(bytes:ByteArray) 
		{
			_bytes = bytes;
			_fixx = 0;
			_fixy = 0;
			//test();
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		private function test():void {
			this.graphics.beginFill(0xFFFF00);
			this.graphics.drawRect( -10, -10, 20, 20);
			this.graphics.endFill();
		}
		
		private function loaded(e:Event):void 
		{
			_loader.content.addEventListener("movieEnd", onOver);
			_loader.content.addEventListener("movieActive", onActive);
			_loader.x = _fixx - _loader.contentLoaderInfo.width / 2;
			_loader.y = _fixy - _loader.contentLoaderInfo.height;
			_loader.mouseEnabled = false;
			_loader.mouseChildren = false;
			this.addChild(_loader);
		}
		
		private function onActive(e:Event):void 
		{
			this.dispatchEvent(new Event(EFFECTACTIVE_EVENT));
		}
		
		private function onOver(e:Event):void {
			this.dispatchEvent(new Event(EFFECTOVER_EVENT));
		}
		
		public function play():void {
			if (null == _loader) {
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
				_loader.loadBytes(_bytes);
			}
			else {
				(_loader.content as MovieClip).gotoAndPlay(0);
				_loader.x = _fixx - _loader.contentLoaderInfo.width / 2;
				_loader.y = _fixy - _loader.contentLoaderInfo.height;
			}
		}
		
		public function setPos(tx:int, ty:int):void {
			_fixx = tx;
			_fixy = ty;
		}
		
		public function clear():void {
			_bytes = null;
			if (null != _loader) {
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);
				if (null != _loader.content ) {
					_loader.content.removeEventListener("over", onOver);
				}
				if (null != _loader.parent) {
					_loader.parent.removeChild(_loader);
				}
				_loader.unloadAndStop();
			}
		}
		
	}

}
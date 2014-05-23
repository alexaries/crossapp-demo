package util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	/**
	 */
	public class BitmapText extends UIComponent
	{
		private var _map:Array;
		private var _chars:String = "0123456789+-.";
		private var _bitmapData:BitmapData;
		private var _height:Number;
		private var _width:Number;
		private var _blank:Boolean;
		private var _gap:Number;
		
		[Embed(source="../assets/blacksmith/strNum.png")]
		private var BitmapTextClass:Class;
		
		/**
		 * @param bitmapData    位图的bitmapData对象
		 * @param width         单个字符的宽
		 * @param height        单个字符的高
		 * @param gap           输出的文字间隔
		 * @param blank         是否忽略空白
		 * @param chars         位图的字符集
		 *
		 */
		public function BitmapText(width:Number=27,height:Number=35,
								   gap:Number=0,blank:Boolean=false,chars:String="0123456789+-.")
		{
			super();
			_bitmapData = (new BitmapTextClass as Bitmap).bitmapData.clone();
			_width = width;
			_height = height;
			_blank = blank;
			_gap = gap;
			_map = [];
			if(chars)_chars = chars;
			for(var i:uint=0;i<_chars.length;i++)
			{
				var bit:BitmapData = new BitmapData(width,height,true,0);
				bit.copyPixels(_bitmapData,new Rectangle(i*width,0,width,height),new Point(0,0));
				var rect:Rectangle = bit.getColorBoundsRect(0xFF000000,0x00000000,false);
				rect.x = rect.x + i*width;
				_map[_chars.charAt(i)] = rect;
				bit.dispose();
			}
		}
		private var _text:String;
		public function get text():String
		{
			return _text;
		}
		public function set text(value:String):void
		{
			_text = value;
			_draw();
		}
		
		private function _draw():void
		{
			graphics.clear();
			var x:Number = 0;
			for(var i:uint=0;i<text.length;i++)
			{
				var char:String = text.charAt(i);
				var index:int = _chars.indexOf(char);
				var rect:Rectangle = _map[char];
				if(!_blank)x+=rect.x%_width;
				x += _gap;
				graphics.beginBitmapFill(_bitmapData,new Matrix(1,0,0,1,x-rect.x,0),false);
				graphics.drawRect(x,rect.y,rect.width,rect.height);
				x+=rect.width;
				if(!_blank)x = (i+1)*_width;
			}
			graphics.endFill();
		}
		
		public function destroy():void
		{
			graphics.clear();
			_map = [];
			_bitmapData.dispose();
			_bitmapData = null;
		}
	}
}
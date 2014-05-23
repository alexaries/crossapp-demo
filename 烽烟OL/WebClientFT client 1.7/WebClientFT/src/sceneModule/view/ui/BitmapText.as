package sceneModule.view.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import model.ProConst;
	
	import mx.core.UIComponent;
	
	/**
	 * 图片数字转换类
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
		private var isLoadedRes:Boolean = false;
		/**
		 * 设置等级图片显示的相关信息
		 */
		[Embed(source="/embed/ui/lvNumber.png")]
		private var BitmapTextClass:Class;
		
		[Embed(source="/embed/ui/battleNumber.png")]
		private var BattleBitmapTextClass:Class;
		
		/**
		 * @param bitmapData    位图的bitmapData对象
		 * @param width         单个字符的宽
		 * @param height        单个字符的高
		 * @param gap           输出的文字间隔
		 * @param blank         是否忽略空白
		 * @param chars         位图的字符集
		 *
		 */
		public function BitmapText()
		{
			super();
			
		}
		/**
		 * 设置图片源
		 */
		public function onSetImageResource(bitmapData:BitmapData,width:Number,height:Number,
										   gap:Number,blank:Boolean=false,chars:String="0123456789+-."):void{
			_bitmapData = bitmapData.clone();
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
		public function set numType(value:int):void{
			switch(value){
				case ProConst.ROLELEVEL_TYPE:
					onSetImageResource((new BitmapTextClass as Bitmap).bitmapData,17,20,0,false,"0123456789");
					break;
				case ProConst.BATTLECOIN_TYPE:
					onSetImageResource((new BattleBitmapTextClass as Bitmap).bitmapData,20,27,0,false,"0123456789");
					break;
			}
			isLoadedRes = true;
			_draw();
		}
		private var _text:String;
		public function get text():String
		{
			return _text;
		}
		public function set text(value:String):void
		{
			_text = value;
			if(isLoadedRes){
				_draw();
			}			
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
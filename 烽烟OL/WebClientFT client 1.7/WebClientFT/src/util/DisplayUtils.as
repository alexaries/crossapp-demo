package util 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author hao
	 */
	public class DisplayUtils 
	{
		
		public static var TextBorderFilte:GlowFilter = new GlowFilter(0x000000,0.7,2,2,5,1);
		
		public static function createLabel(size:int, color:uint = 0xFFFF00, bold:Boolean = false):TextField {
			var t:TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			t.mouseEnabled = false;
			t.mouseWheelEnabled = false;
			
			var tf:TextFormat = new TextFormat();
			tf.size = size;
			tf.bold = bold;
			tf.color = color;
			
			t.defaultTextFormat = tf;
			
			return t;
		}
		
		public static function createBitmapTxt(txt:TextField):BitmapData {
			var b:BitmapData = new BitmapData(txt.width, txt.height, true, 0);
			b.draw(txt);
			return b;
		}
		
		public static function refreshImgText(s:String, bitmap:Bitmap, txt:TextField):void {
			if (s != txt.text) {
				if (bitmap.bitmapData) {
					bitmap.bitmapData.dispose();
				}
				txt.text = s;
				bitmap.bitmapData = createBitmapTxt(txt);
			}
		}
	}

}
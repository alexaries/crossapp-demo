package wordscene.entity 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import util.DisplayUtils;
	import wordscene.helper.StaticProperty;
	
	/**
	 * ...
	 * @author hao
	 */
	public class EntityWordSprite extends Sprite 
	{
		private var _txt:TextField;
		
		private var _txtImg:Bitmap;
		
		public function EntityWordSprite() 
		{
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.width = StaticProperty.CHAR_WORD_WIDTH;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.filters = [DisplayUtils.TextBorderFilte];
			var format:TextFormat = new TextFormat();
			format.size = StaticProperty.CHAR_WORD_SIZE;
			format.color = StaticProperty.CHAR_WORD_COLOR;
			_txt.defaultTextFormat = format;
			
			
			_txtImg = new Bitmap();
			this.addChild(_txtImg);
		}
		
		public function setTxt(str:String):void {
			if (_txt.htmlText != str) {
				if (_txtImg.bitmapData) {
					_txtImg.bitmapData.dispose();
				}
				_txt.htmlText = str;
				var b:BitmapData = new BitmapData(_txt.width, _txt.height, true, 0);
				b.draw(_txt);
				_txtImg.bitmapData = b;
				this.graphics.clear();
				this.graphics.beginFill(0x0, 0.5);
				this.graphics.drawRoundRect(0, 0, _txtImg.width, _txtImg.height, 5);
				this.graphics.endFill();
			}
		}
		
	}

}
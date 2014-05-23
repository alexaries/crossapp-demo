package sceneModule.view.pata.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.pata.command.PaTaMessage;

	public class BlockLayer extends Sprite
	{
		private var _bg_bitmap:Bitmap;
		private var _blockLev:int;
		private var _city_name_text:TextField;
		public function BlockLayer()
		{
			_bg_bitmap = new Bitmap();
			this.addChild(_bg_bitmap);
			
			_city_name_text = createCityTF();
			_city_name_text.width = 105;
			_city_name_text.x = 40;
			this.addChild(_city_name_text);
			_city_name_text.mouseEnabled = false;
			
			this.useHandCursor = true;
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.CLICK,onClickBlock);
		}
		
		private function onClickBlock(evt:MouseEvent):void{
			PaTaMessage.getInstance().onPaTaBattle();
		}
		
		private function createCityTF():TextField {
			var tf:TextField = new TextField();
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			tf.filters = [growFilte];
			tf.autoSize = TextFieldAutoSize.LEFT;
			var f:TextFormat = new TextFormat();
			f.size = 14;
			f.font = '宋体';
			f.bold = true;
			f.color = 0xffff00;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		public function set bg_bitmap(value:BitmapData):void{
			_bg_bitmap.bitmapData = value;
		}
		
		public function set blockLev(value:int):void{
			_blockLev = value;
			_city_name_text.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ppw_di')+value+CrotaResourceConfig.getInstance().getTextByModuleAndId('text_pata','ppw_ceng');
		}
		
		public function get blockLev():int{
			return _blockLev;
		}
	}
}
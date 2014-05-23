package sceneModule.view.wordmap.view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import resource.AssetCenter;
	
	/**
	 * ...
	 * @author hao
	 */
	public class InstancePlaceTip extends Sprite 
	{
		
		private var _bg:Bitmap;
		
		private var _text_x:int = 15;
		
		private var _city_y:int = 6;
		private var _union_y:int = 36;
		private var _tax_y:int = 56;
		private var _income_y:int = 76;
		
		private var _city_name_text:TextField;
		private var _union_name_text:TextField;
		private var _tax_text:TextField;
		private var _income_text:TextField;
		
		public function InstancePlaceTip() 
		{
			_bg = new Bitmap();
			_bg.bitmapData = AssetCenter.getInstance().get_img_form_pacakge(
				'map_scene_base',
				'instance_tip_bg'
			);
			this.addChild(_bg);
			
			_city_name_text = createCityTF();
			_city_name_text.x = _text_x;
			_city_name_text.y = _city_y;
			this.addChild(_city_name_text);
			
			_union_name_text = createTF();
			_union_name_text.x = _text_x;
			_union_name_text.y = _union_y;
			this.addChild(_union_name_text);
			
			_tax_text = createTF();
			_tax_text.x = _text_x;
			_tax_text.y = _tax_y;
			this.addChild(_tax_text);
			
			_income_text = createTF();
			_income_text.x = _text_x;
			_income_text.y = _income_y;
			this.addChild(_income_text);
			
		}
		
		private function createTF():TextField {
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			var f:TextFormat = new TextFormat();
			f.size = 12;
			f.color = 0xFFFFFF;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		private function createCityTF():TextField {
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			var f:TextFormat = new TextFormat();
			f.size = 12;
			f.bold = true;
			f.color = 0xFFFFFF;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		public function refresh(city:String, union:String, tax:String, income:String):void {
			_city_name_text.text = city;
			_union_name_text.text = union;
//			_tax_text.text = tax;
//			_income_text.text = income;
		}
		
	}

}
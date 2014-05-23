package sceneModule.view.wordmap.view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import resource.AssetCenter;
	import sceneModule.view.wordmap.model.MapMessage;
	import util.HashMap;
	
	/**
	 * 切换颜色视图
	 * @author hao
	 */
	public class ChangeColorSp extends Sprite 
	{
		
		public static const COLORS:Array = [
			0xFF0000, 0xFFFF00, 0xFF0033, 0x00FF00,
			0x00FF66, 0x00FFFF, 0x9900FF, 0x99FF99,
			0xCC9966, 0xFFFF99, 0x336699, 0xFF9933
		];
		
		
		private var _bg:Bitmap;
		
		private var per_len:int = 6;
		
		private var _base_x:int = 15;
		private var _base_y:int = 43;
		
		private var _block_w:int = 46;
		private var _block_h:int = 14;
		
		private var _gap_w:int = 4;
		private var _gap_h:int = 9;
		
		private var _colors:HashMap;
		
		public function ChangeColorSp() 
		{
			
			_bg = new Bitmap();
			this.addChild(_bg);
			
			_bg.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('map_scene_base', 'chose_color_bg');
			
			_colors = new HashMap();
			
			var len:int = COLORS.length;
			for (var i:int = 0; i < len; i++) 
			{
				var t:uint = COLORS[i];
				
				var sp:Sprite = new Sprite();
				sp.graphics.beginFill(t);
				sp.graphics.drawRoundRect(0, 0, _block_w, _block_h, 1, 1);
				sp.graphics.endFill();
				sp.x = _base_x + i % per_len * (_block_w + _gap_w);
				sp.y = _base_y + int(i / per_len) * (_block_h + _gap_h);
				sp.addEventListener(MouseEvent.CLICK, change_color);
				sp.buttonMode = true;
				this.addChild(sp);
				
				_colors.put(sp, t);
			}
		}
		
		private function change_color(e:MouseEvent):void {
			var t:Sprite = e.currentTarget as Sprite;
			var color:uint = _colors.get(t);
			MapMessage.getInstance().requese_union_color(color);
		}
		
	}

}
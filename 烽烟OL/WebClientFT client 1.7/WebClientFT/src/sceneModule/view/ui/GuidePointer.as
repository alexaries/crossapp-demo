package sceneModule.view.ui 
{
	import Animation.ResourceLoadManager;
	
	import adobe.utils.CustomActions;
	
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import resource.AssetCenter;
	
	import util.CommonTools;
	import util.xtrace;
	
	/**
	 * ...
	 * @author hao
	 */
	public class GuidePointer extends Sprite 
	{
		public static const GuidePointer_LEFT:int = 1;
		public static const GuidePointer_RIGHT:int = 2;
		public static const GuidePointer_DOWN:int = 3;
		
		public static const SELF_W:int = 220;
		public static const SELF_H:int = 75;
		
		public static const RIGHT_CENTER_X:int = 240;
		public static const CENTER_Y:int = 63;
		public static const LEFT_CENTER_X:int = 70;
		
		public static const RIGHT_WORD_CENTER:int = 85;
		public static const WORD_CENTER_Y:int = 23;
		public static const LEFT_WORD_CENTER:int = 132;
		
		//00ff33
		
		private var _text_base_x:int = 10;
		private var _text_base_y:int = 37;
		
		
		private var _move_time:Number = 0;
		private var _move_dis:int = 1;
		
		private var _contain:Sprite;
		
		private var _point_bg:BitmapScale9Grid;
		private var _tf:TextField;
		private var _tf_bitmap:Bitmap;
		
		private var _tips_contain:Sprite;
		private var _tips_bg:Bitmap;
		private var _tips_tf:TextField;
		private var _tips_bitmap:Bitmap;
		
		private var _type:int;
		
		public static const LABEL_PATH:String = "assets/guid/";
		
		public function GuidePointer(type:int, speed:int) 
		{
			_move_time = 1000//Number(speed) / Number(1000);
			
			_contain = new Sprite();
			this.addChild(_contain);
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('guide', 'guide_point');
			_point_bg = new BitmapScale9Grid(bitmap,5,6,55,60);
			_contain.addChild(_point_bg);
			
			_tf = CommonTools.createFTF();
			var tff:TextFormat = new TextFormat();
			tff.color = 0x00ff33;
			tff.size = 12;
			_tf.defaultTextFormat = tff;
			_tf.multiline = false;
			_tf.wordWrap = false;
			
			_tf_bitmap = new Bitmap();
			_contain.addChild(_tf_bitmap);
			//_contain.addChild(_tf);
			
			
			_tips_contain = new Sprite();
			_contain.cacheAsBitmap = true;
			
			this.addChild(_tips_contain);
			
			_tips_bg = new Bitmap();
			_tips_bg.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('friend', 'guide_tips_bg');
			_tips_contain.addChild(_tips_bg);
			
			_tips_tf = CommonTools.createFTF();
			_tips_tf.multiline = true;
			_tips_tf.wordWrap = true;
			_tips_tf.width = 205;
			_tips_tf.x = 10;
			_tips_tf.y = 20;
			//_tips_contain.addChild(_tips_tf);
			
			_tips_bitmap = new Bitmap();
			_tips_bitmap.x = 10;
			_tips_bitmap.y = 20;
			_tips_contain.addChild(_tips_bitmap);
			
//			_point_bg.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('guide', 'guide_point');
			_tf.x = _text_base_x;
			_tf.y = _text_base_y;
			
			_type = type;
			switch (type) 
			{
				case GuidePointer_LEFT:
//					to_right();
					break;
				case GuidePointer_RIGHT:
//					_point_bg.rotation = 180;
//					_point_bg.x = _point_bg.width;
//					_point_bg.y = _point_bg.height;
//					to_right();
					break;
				case GuidePointer_DOWN:
					_point_bg.rotation = 180;
					_point_bg.y = _point_bg.height+5;
//					_tf.x = _text_base_y-10-_point_bg.width-160;
//					to_up();
					break;
				default:
					throw new Error("no type GUidePointer " + type);
			}
			
			//this.graphics.beginFill(0xFF0000);
			//this.graphics.drawRect(0, 0, 10, 10);
			//this.graphics.endFill();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
			
		}
		
		private function addToStage(e:Event):void {
			switch (_type) 
			{
				case GuidePointer_LEFT:
					to_right();
					break;
				case GuidePointer_RIGHT:
					to_right();
					break;
				case GuidePointer_DOWN:
					to_up();
					break;
				default:
					throw new Error("no type GUidePointer " + _type);
			}
		}
		private function removeFromStage(e:Event):void {
			TweenLite.killTweensOf(_contain);
			_contain.x = 0;
			_contain.y = 0;
		}
		
		private function to_right():void {
			TweenLite.to(_contain, _move_time, { x:_move_dis, onComplete:to_left} );
		}
		private function to_left():void {
			TweenLite.to(_contain, _move_time, { x:0, onComplete:to_right} );
		}
		
		private function to_up():void {
			TweenLite.to(_contain, _move_time, { y:-_move_dis, onComplete:to_down} );
		}
		private function to_down():void {
			TweenLite.to(_contain, _move_time, { y:0, onComplete:to_up} );
		}
		
		public function change_label(info:String, tips:String, tipx:int, tipy:int):void {
			//tips = "sadfaslkdfjalsjflasjflasjlasjflasjfalsjflasjfalsjfalsjfalsjflasjf";
			
			_tf.text = "";
			_tf.text = info;
			_point_bg.width = _tf.width + 10;
			if (_type == GuidePointer_DOWN) {
//				var len:int = info.length;
//				for (var i:int = 0; i < len; i++) 
//				{
//					_tf.appendText(info.charAt(i));
//					_tf.appendText("\n");
//				}
//				_tf.y = _point_bg.height - _text_base_x - _tf.height;
				_tf.x = _point_bg.width - _text_base_x - _tf.width- _point_bg.width;
				_tf.y = (_point_bg.height - _tf.height) / 2+20;
			}
			else if (_type == GuidePointer_RIGHT) {
				_tf.x = _point_bg.width - _text_base_x - _tf.width;
				_tf.y = (_point_bg.height - _tf.height) / 2;
			}
			else {
				_tf.y = (_point_bg.height - _tf.height) / 2;
			}
			
			if (_tf_bitmap.bitmapData) {
				_tf_bitmap.bitmapData.dispose();
			}
			var ntf_bitmapdata:BitmapData = new BitmapData(_tf.width, _tf.height, true, 0);
			ntf_bitmapdata.draw(_tf);
			_tf_bitmap.x = _tf.x-5;
			_tf_bitmap.y = _tf.y-9;//文本的座標
			_tf_bitmap.bitmapData = ntf_bitmapdata;
			
			if ("" != tips) {
				_tips_tf.text = tips;
				
				if (_tips_bitmap.bitmapData) {
					_tips_bitmap.bitmapData.dispose();
				}
				var tipsd:BitmapData = new BitmapData(_tips_tf.width, _tips_tf.height, true, 0);
				tipsd.draw(_tips_tf);
				_tips_bitmap.bitmapData = tipsd;
				
				_tips_contain.x = tipx;
				_tips_contain.y = tipy;
				this.addChild(_tips_contain);
			}
			else {
				_tips_contain.parent && _tips_contain.parent.removeChild(_tips_contain);
			}
			
		}
		
		private function loader_err(e:IOErrorEvent):void {
			xtrace("新手指引图片加载错误" + e.toString());
		}
	}

}
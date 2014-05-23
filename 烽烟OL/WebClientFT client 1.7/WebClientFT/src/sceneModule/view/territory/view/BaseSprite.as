package sceneModule.view.territory.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.core.UIComponent;
	
	import spark.components.Label;
	
	import util.FilterTool;
	import util.HitAreaSprite;

	public class BaseSprite extends HitAreaSprite
	{
		protected var _funType:int;//功能类型
		protected var _name:String;//功能名称
		private var bitMap:Bitmap;
		private var _shape:Sprite = new Sprite();
		private var _city_name_text:TextField;
		private var _text_x:int = 15;
		
		private var _city_y:int = 6;
		public function BaseSprite()
		{
			bitMap = new Bitmap();
			this.addChild(bitMap);
			
			_city_name_text = createCityTF();
			_city_name_text.x = _text_x;
			_city_name_text.y = _city_y;
			_city_name_text.width = 190;
			this.addChild(_city_name_text);
			
//			this.addChild(_shape);
//			_shape.mouseEnabled = false;
//			_shape.visible = false;
//			
//		    this.hitArea = _shape;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		private function createCityTF():TextField {
			var tf:TextField = new TextField();
			var growFilte:GlowFilter = new GlowFilter(0x34332d ,0.7,2,2,5);
			tf.filters = [growFilte];
			tf.autoSize = TextFieldAutoSize.CENTER;
			var f:TextFormat = new TextFormat();
			f.size = 14;
			f.font = '宋体';
			f.bold = true;
			f.color = 0xffff00;
			tf.defaultTextFormat = f;
			return tf;
		}
		
		public function set bitMap_sou(bitMapData:BitmapData):void{
			bitMap.bitmapData = bitMapData;
//			if(bitMapData){
//				createHitArea(bitMap);
//			}
		}
		
		override protected function getSpriteBounds():Rectangle
		{
			return bitMap.bitmapData == null ? null : bitMap.bitmapData.rect;
		}
		
		override protected function inHitArea(mouseX:Number, mouseY:Number):Boolean
		{
			return bitMap.bitmapData == null ? false : bitMap.bitmapData.getPixel32(mouseX, mouseY) >>> 24 != 0x00;
		}
		
		public function set textInfo(des:String):void{
			_city_name_text.htmlText = des;
		}
		
		/**
		 * onMouseOver EventHandler
		 */
		private function onMouseOver(event:MouseEvent):void
		{
//			this.filters = FilterTool.glowFilter(0xff0000,0.8,2,2,4,1);
			transform.colorTransform=new ColorTransform(1, 1, 1, 1, 54, 54, 54);
		}
		
		/**
		 * onMouseOut EventHandler
		 */
		private function onMouseOut(event:MouseEvent):void
		{
			this.filters = [];
			transform.colorTransform=new ColorTransform();
		}
		
		public function clear():void
		{
			_shape.graphics.clear();
		}
		
		/**
		 * Create hit area with alpha.
		 *
		 */
		
		private function createHitArea(content:DisplayObject):void
		{
			
			var bit:BitmapData = new BitmapData(content.width,content.height,true,0x00000000);
			bit.draw(content);
			//重绘图象到bit
			clear();
			_shape.graphics.beginFill(0);
			for(var x:uint=0;x<bit.width;x++)
			{
				for(var y:uint=0;y<bit.height;y++)
				{
					if(bit.getPixel32(x,y))_shape.graphics.drawRect(x,y,1,1);
				}
			}
			//以graphics画出bit的无透明区域
			_shape.graphics.endFill();
			
		}
		
		public function set fun_type(t:int):void{
			this._funType = t;
		}
		public function get fun_type():int{
			return this._funType;
		}
		
		public function set name_(n:String):void{
			this._name = n;
		}
		
		public function get name_():String{
			return this._name;
		}
		
		public function settextPos(tpx:int,tpy:int):void{
			_city_name_text.x = tpx;
			_city_name_text.y = tpy;
		}
	}
}
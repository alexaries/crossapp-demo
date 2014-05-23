package createRoleModule.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import util.HitAreaSprite;

	public class RoleBaseSprite extends HitAreaSprite
	{
		private var _mc:MovieClip;
		private var _funType:int;
		private var bitMap:Bitmap;
		private var _shape:Sprite = new Sprite();
		public function RoleBaseSprite()
		{
			bitMap = new Bitmap();
			this.addChild(bitMap);
			
			this.addChild(_shape);
			_shape.mouseEnabled = false;
			_shape.visible = false;
						
			this.hitArea = _shape;
			
			this.useHandCursor = true;
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		public function set bitmap_sou(bitMapData:BitmapData):void{
			bitMap.bitmapData = bitMapData;
			if(bitMapData){
				createHitArea(bitMap);
			}
		}
		
		public function set mc_sou(mc:MovieClip):void{
			_mc = mc;
			this.addChild(_mc);
			mc.mouseEnabled = false;
			mc.mouseChildren = false;
		}
		
		override protected function getSpriteBounds():Rectangle
		{
			return bitMap.bitmapData == null ? null : bitMap.bitmapData.rect;
		}
		
		override protected function inHitArea(mouseX:Number, mouseY:Number):Boolean
		{
			return bitMap.bitmapData == null ? false : bitMap.bitmapData.getPixel32(mouseX, mouseY) >>> 24 != 0x00;
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
		
	}
}
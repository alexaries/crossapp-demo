package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	
	import mx.controls.Menu;
	import mx.core.IButton;
	
	public class PrviMenu extends Menu implements IButton
	{
		private var _w:int;
		private var _h:int;
		private var _skin:Bitmap;
		
		public var down:Bitmap=new Bitmap([Embed(source="assets/button/commonBtn42.png")]);
		public var over:Bitmap=new Bitmap([Embed(source="assets/button/commonBtn42.png")]);
		public var up:Bitmap=new Bitmap([Embed(source="assets/button/commonBtn42.png")]);
		public var disable:Bitmap=new Bitmap([Embed(source="assets/button/commonBtn42.png")]);
		
		public function PrviMenu(width:int, height:int)
		{
			super();
			_w=width;
			_h=height;
		}
		
		public function set selected(value:Boolean):void
		{
			if (value)
			{
				addChild(down);
			}
			else
			{
				//				_frame.graphics.clear();
				removeChild(down);
			}
		}
		
		public function set uped(value:Boolean):void
		{
			if (value)
			{
				addChild(down);
			}
			else
			{
				removeChild(down);
			}
		}
		
		public function set overed(value:Boolean):void
		{
			if (value)
			{
				addChild(disable);
			}
			else
			{
				removeChild(disable);
			}
		}
		
		public function set disabled(value:Boolean):void
		{
			if (value)
			{
				addChild(down);
			}
			else
			{
				removeChild(down);
			}
		}
	}
}
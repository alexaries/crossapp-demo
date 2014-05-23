package sceneModule.rcommand.scene.scroll
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.IAnimatedObject;
	import com.pblabs.rendering2D.BitmapRenderer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	/**
	 * PBE component 
	 * @author mutou
	 * 
	 */	
	public class ScrollingBitmapRenderer extends BitmapRenderer
	{

		//-------------------------------------------------------------------------
		// public variable declarations
		//-------------------------------------------------------------------------		
		public var scroll:Point = new Point(0,0);
		public var scrollSpeed:Point = new Point(0,0);
					
		//-------------------------------------------------------------------------
		// public methods
		//-------------------------------------------------------------------------				
		/**
		 * constructor
		 * 
		 * @param bitmap:Bitmap is provided bitmap for repeating background
		 * @param width:int is Scrolling Bitmap width dimension
		 * @param height:int is Scrolling Bitmap height dimension
		 */
		public function ScrollingBitmapRenderer()
		{
			// call inherited constructor
			super();
		}
		public function updateScrollBitmapRender(bitmap:Bitmap, width:int, height:int):void{
			// store bitmap that will be used to fill the scrolling bitmap
			this.srcBitmap = bitmap;
			// create a bitmapdata object for the scrolling bitmap
			this.bitmapData =  new BitmapData(width,height);
			// determine how many times the bitmap has to be drawn horizontal and vertical
			// to fill the scrolling bitmap.
			// We add an aditional so that we have enough display to scroll in any direction			
			var cx:int = Math.ceil(width/srcBitmap.width)+1;
			var cy:int = Math.ceil(height/srcBitmap.height)+1;
			// the scrollrect variable will be used to draw a specific area to the scrolling bitmap			
			scrollRect = new Rectangle(0,0,width,height);
			// create a bitmapData object for clearing purposes			
			emptyBitmapData = new BitmapData(width,height, true, 0);
			// create a bitmapData object that will contain all display info that will
			// be used when copying pixels to the scrolling bitmap
			scrollBitmapData = new BitmapData(cx*srcBitmap.width, cy*srcBitmap.height, true, 0x000000);
			// fill the bitmapData object with all display info with the provided bitmap 
			for (var ix:int = 0; ix<cx; ix++)
				for (var iy:int = 0; iy<cy; iy++)
				{
					scrollBitmapData.copyPixels(srcBitmap.bitmapData,srcBitmap.bitmapData.rect, new Point(ix*srcBitmap.width,iy*srcBitmap.height));
				}	
		}

		public override function onFrame(deltaTime:Number):void
		{
			// call onFrame of the extended BitmapRenderer
			super.onFrame(deltaTime);
			// adjust scroll offset using the scrollSpeed
			scroll.x += scrollSpeed.x * deltaTime; 
			scroll.y += scrollSpeed.y * deltaTime;			
			// determine the right drawing rectangle area of the bitmapData object with all display info 
			// for the copyPixel command
			// determine x offset of rectangle draw area 
			var dx:int = scroll.x - (Math.floor(scroll.x/srcBitmap.width)*srcBitmap.width);
			scrollRect.x = dx;
			// determine y offset of rectangle draw area 
			var dy:int = (scroll.y) - (Math.floor((scroll.y)/srcBitmap.height)*srcBitmap.height);
			scrollRect.y = dy;			
			// lock the bitmapData object so no changes will be displayed until it is unlocked 
			bitmapData.lock();
			// clear the bitmapData using a emptyBitmapData copy
			bitmapData.copyPixels(emptyBitmapData, emptyBitmapData.rect, new Point(0,0), null, null, false);
			// draw the right area of the bitmapData object with all display info onto the scrolling bitmap 
			bitmapData.copyPixels(scrollBitmapData, scrollRect, new Point(0,0), null, null, true);
			// unlock the bitmapData object so it can be displayed 
			bitmapData.unlock();			
		}
		
		//-------------------------------------------------------------------------
		// private variable declarations
		//-------------------------------------------------------------------------		
		private var srcBitmap:Bitmap;				// will hold provided bitmap to fill
		private var scrollBitmapData:BitmapData;	// will hold all display data
		private var emptyBitmapData:BitmapData;		// will hold clear data
		private var scrollRect:Rectangle = null;	// will hold the drawing area
		
	}
}
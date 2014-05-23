package createRoleModule.view
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	import mx.flash.UIMovieClip;
	
	/**
	 * PNGLoader,主要解决png图片透明像素处事件的问题
	 * @author L4cd.Net
	 *
	 */
	public class RoleStaticSwfComponent extends UIComponent
	{
		private var loader:Loader = new Loader();
		private var hit:Sprite = new Sprite();
		public var mc:MovieClip;
		private var url:String;
		public function RoleStaticSwfComponent()
		{    
				addChild(loader);
				addChild(hit);
				hit.visible = false;
				hit.mouseEnabled = false;
//				mouseChildren = false;
//				this.buttonMode=true;
				hitArea = hit;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,complete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,error);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,progress);
				
//				this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
//				this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
				
		}
		private function onMouseOver(evt:MouseEvent):void{
			this.transform.colorTransform=new ColorTransform(1, 1, 1, 1, 54, 54, 54);
		}
		private function onMouseOut(evt:MouseEvent):void{
			this.transform.colorTransform=new ColorTransform();
		}
		public function set _url(s:String):void{
			url = s;
			loadSwf();
		}
		private function complete(e:Event):void
		{        
			    mc = loader.contentLoaderInfo.content as MovieClip;
				dispatchEvent(e);
				update();
		}
		private function error(e:IOErrorEvent):void
		{
				dispatchEvent(e);
		}
		private function progress(e:ProgressEvent):void
		{
				dispatchEvent(e);
		}
		public function loadSwf():void
		{
				loader.load(new URLRequest(url));
				clear();
		}
		public function loadBytes(bytes:ByteArray,context:LoaderContext=null):void
		{
				loader.loadBytes(bytes,context);
				clear();
		}
		public function unload():void
		{
				loader.unload();
				clear();
		}
		public function close():void
		{
				loader.close();
				clear();
		}
		private function clear():void
		{
				hit.graphics.clear();
		}
		private function update():void
		{
			if(!loader.content)return;
			var bit:BitmapData = new BitmapData(loader.width,loader.height,true,0x00000000);
				bit.draw(loader);
			//重绘图象到bit
				clear();
				hit.graphics.beginFill(0);
			for(var x:uint=0;x<bit.width;x++)
			{
				for(var y:uint=0;y<bit.height;y++)
				{
					if(bit.getPixel32(x,y))hit.graphics.drawRect(x,y,1,1);
				}
			}
			//以graphics画出bit的无透明区域
				hit.graphics.endFill();
		}
	}
}
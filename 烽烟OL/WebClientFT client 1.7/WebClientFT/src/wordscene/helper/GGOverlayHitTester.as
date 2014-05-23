package wordscene.helper {
	/**
	 * author:CYPL
	 * descript:叠加物体精确选择检测
	 * date:2009-09-21修改
	 */
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import spark.primitives.Rect;
	import wordscene.entity.BitmapPlayer;
	import wordscene.entity.EntitySprite;


	public class GGOverlayHitTester extends EventDispatcher implements IHitTester {

		private var _container : Stage;

		private var _bd : BitmapData;

		private var _map : Object;

		private var _handler : Function;
		//正确的类型
		private var _tureType : Class;

		//private var _test:Bitmap=new Bitmap;


		
		/**
		 * @param : container 被检测内容的容器对象
		 * @tureType:正确的类型
		 */
		public function GGOverlayHitTester(container : Stage,tureType : Class = null) {
			_container = container;
			_tureType = tureType;
			_map = {};
			if (_container.width == 0 || _container.height == 0) {
				throw new Error("容器的范围大小不正确");
			}
			
			//_container.addChild(_test);
		}

		/**
		 * @param : posX,posY 为容器内鼠标的位置
		 * @return : 返回显示对象
		 */
		public function getDisplay(posX : Number, posY : Number) : DisplayObject {
			//var time : int = getTimer();
			clear();
			var targets : Array = _container.getObjectsUnderPoint(new Point(posX, posY));
		
			if (targets) {
				_bd = new BitmapData(_container.stageWidth, _container.stageHeight, true, 0);
				_bd.lock();
				var len:int = targets.length;
				for(var j : int;j < len; j++) {
					
					var target : DisplayObject = targets[j] as DisplayObject;
					var entitysp:DisplayObject = target;
					while (null != entitysp && !(entitysp is EntitySprite)) {
						entitysp = entitysp.parent;
					}
					if (null == entitysp) {
						continue;
					}
					var entitybound:Rectangle = entitysp.getBounds(entitysp);
					
					var tmpBD : BitmapData = new BitmapData(entitybound.width, entitybound.height, true, 0);
					var m:Matrix = new Matrix(1, 0, 0, 1, -entitybound.x, -entitybound.y);
					tmpBD.draw(entitysp, m);
					var color : uint = 0xff000001 + j * 10;
					tmpBD.threshold(tmpBD, tmpBD.rect, new Point, ">", 0, color, 0xffffffff);
					
					_map[color] = entitysp;
					
					var osBounds : Rectangle = entitysp.getBounds(_container);
					_bd.copyPixels(tmpBD, tmpBD.rect, new Point(osBounds.x, osBounds.y), tmpBD, new Point, true);
					tmpBD.dispose();
				}
				_bd.unlock();
				//_test.bitmapData=_bd;
				var hitColor : uint = _bd.getPixel32(_container.mouseX, _container.mouseY);
				_bd.dispose();
				
				if (hitColor != 0) {
					return _map[hitColor];
				}
			}
			
			return null;
		}

		public function clear() : void {
			if(_map){
			for (var p:String in _map) {
				_map[p] = null;
				}
			_map = { }; }
			_bd = null;
			
		}

	/* public function destroy():void{
	   _container=null;
	   _map={};
	   _bd=null;
	 } */
	}
}


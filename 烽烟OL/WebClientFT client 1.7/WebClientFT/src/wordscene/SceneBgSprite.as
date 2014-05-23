package wordscene {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import sceneModule.model.rvo.RSwitchVo;
	import sceneModule.rcommand.revent.RSwitchEvent;
	import util.HashMap;
	import wordscene.entity.TripEntiySprite;
	import wordscene.loader.EffectSp;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class SceneBgSprite extends Sprite {
		private var _bgSprite:Sprite;
		private var _tripContain:Sprite;
		private var _npcContain:Sprite;
		private var _moveEffContain:Sprite;
		private var _moveEff:EffectSp;
		
		private var _id:int;
		private var _mapw:int;
		private var _maph:int;
		private var _curx:int;
		private var _cury:int;
		private var _startx:int;
		private var _endx:int;
		private var _starty:int;
		private var _endy:int;
		private var _tileMap:HashMap;
		private var _loadedIDs:Vector.<Point>;
		private var _loaders:Vector.<Loader>;
		private var _isEnterTipPos:Boolean;
		private var _exSize:int;
		private var _isactive:Boolean;
		
		public function SceneBgSprite() {
			_tileMap = new HashMap();
			_loadedIDs = new Vector.<Point>();
			_loaders = new Vector.<Loader>();
			_exSize = WordSceneSprite.MAP_TITL_SIZE * WordSceneSprite.MAP_EXPORT_SIZE;
			_isactive = false;
			
			_bgSprite = new Sprite();
			_bgSprite.mouseEnabled = false;
			_bgSprite.mouseChildren = false;
			this.addChild(_bgSprite);
			
			_tripContain = new Sprite();
			_tripContain.mouseEnabled = false;
			_tripContain.mouseChildren = false;
			this.addChild(_tripContain);
			
			_npcContain = new Sprite();
			this.addChild(_npcContain);
			
			_moveEffContain = new Sprite();
			_moveEffContain.mouseEnabled = false;
			_moveEffContain.mouseChildren = false;
			this.addChild(_moveEffContain);
			
			this.mouseEnabled = false;
		}
		
		private function test():void {
			this.graphics.beginFill(0xFFFF00);
			this.graphics.drawRect(0, 0, 100, 100);
		}
		
		public function resetScene(id:int):void {
			_id = id;
			_isEnterTipPos = false;
			_tileMap.clear();
			_loadedIDs.length = 0;
			_loaders.length = 0;
			_curx = -1;
			_cury = -1;
			_startx = -1;
			_starty = -1;
			_endx = -1;
			_endy = -1;
			_isactive = false;
			
			var bmd:BitmapData = SAssetManager.getInstance().getBitmapData(SAssetManager.ASSET_SCENE_ID + id, 'tiles');
			var m:Matrix = new Matrix();
			m.scale(WordSceneSprite.TILE_SCALE, WordSceneSprite.TILE_SCALE);
			var bigBmd:BitmapData = new BitmapData(bmd.width * WordSceneSprite.TILE_SCALE, bmd.height * WordSceneSprite.TILE_SCALE);
			bigBmd.draw(bmd, m);
			
			var xcount:int = Math.ceil(Number(bigBmd.width) / WordSceneSprite.MAP_TITL_SIZE);
			var ycount:int = Math.ceil(Number(bigBmd.height) / WordSceneSprite.MAP_TITL_SIZE);
			
			for (var i:int = 0; i < xcount; i++) {
				for (var j:int = 0; j < ycount; j++) {
					var startx:int = i * WordSceneSprite.MAP_TITL_SIZE;
					var starty:int = j * WordSceneSprite.MAP_TITL_SIZE;
					var tw:int = Math.min(bigBmd.width - startx, WordSceneSprite.MAP_TITL_SIZE);
					var th:int = Math.min(bigBmd.height - starty, WordSceneSprite.MAP_TITL_SIZE);
					var r:Rectangle = new Rectangle(startx, starty, tw, th);
					var tbmd:BitmapData = new BitmapData(tw, th);
					tbmd.copyPixels(bigBmd, r, new Point());
					var str:String = j + "_" + i;
					var tbm:Bitmap = new Bitmap(tbmd);
					tbm.x = startx;
					tbm.y = starty;
					_tileMap.put(str, tbm);
					_loadedIDs.push(new Point(i, j));
				}
			}
			_mapw = bigBmd.width;
			_maph = bigBmd.height;
			
			bigBmd.dispose();
		}
		
		public function enterFrame(detention:int, force:Boolean = false):void {
			if (_isactive || force) {
				if (force) {
					this.x = -_curx;
					this.y = -_cury;
					WordSceneSprite.getInstance().mapContain.x = this.x;
					WordSceneSprite.getInstance().mapContain.y = this.y;
					_isactive = false;
				} else {
					var speed:int = detention / WordSceneSprite.FRAME_MAP_SPEED;
					
					var targetx:int = -_curx;
					var targety:int = -_cury;
					var desx:int = targetx - this.x;
					var desy:int = targety - this.y;
					var absdesx:int = Math.abs(desx);
					var absdesy:int = Math.abs(desy);
					if (0 == absdesx && 0 == absdesy) {
						_isactive = false;
						return;
					}
					desx = Math.min(speed, absdesx) * (absdesx / desx);
					desy = Math.min(speed, absdesy) * (absdesy / desy);
					this.x += desx;
					this.y += desy;
					WordSceneSprite.getInstance().mapContain.x = this.x;
					WordSceneSprite.getInstance().mapContain.y = this.y;
				}
				
				var sw:int = this.stage.stageWidth;
				var sh:int = this.stage.stageHeight;
				var xindex:int = -this.x / WordSceneSprite.MAP_TITL_SIZE;
				var yindex:int = -this.y / WordSceneSprite.MAP_TITL_SIZE;
				var endxindex:int = Math.min(-this.x + sw, _mapw) / WordSceneSprite.MAP_TITL_SIZE;
				var endyindex:int = Math.min(-this.y + sh, _maph) / WordSceneSprite.MAP_TITL_SIZE;
				
				if (_startx <= xindex && _endx > endxindex && _starty <= yindex && _endy > endyindex) {
					return;
				}
				
				var ntx:int = -this.x - _exSize;
				var nty:int = -this.y - _exSize;
				var ntendx:int = -this.x + sw + _exSize;
				var ntendy:int = -this.y + sh + _exSize;
				ntx = Math.max(0, ntx);
				nty = Math.max(0, nty);
				ntendx = Math.min(_mapw, ntendx);
				ntendy = Math.min(_maph, ntendy);
				
				_startx = ntx / WordSceneSprite.MAP_TITL_SIZE;
				_starty = nty / WordSceneSprite.MAP_TITL_SIZE;
				_endx = Math.ceil(Number(ntendx) / WordSceneSprite.MAP_TITL_SIZE);
				_endy = Math.ceil(Number(ntendy) / WordSceneSprite.MAP_TITL_SIZE);
				
				loadPiece();
				resetBG();
			}
		}
		
		public function resize():void {
			setCenter(_curx, _cury, true);
		}
		
		public function setCenter(tx:int, ty:int, force:Boolean = false):void {
			var sw:int = this.stage.stageWidth;
			var sh:int = this.stage.stageHeight;
			
			if (tx == _curx && ty == _cury && !force) {
				return;
			}
			_curx = tx;
			_cury = ty;
			
			enterFrame(WordSceneSprite.FRAME_TIME, true);
		}
		
		public function showMoveEff(tx:int, ty:int):void {
			if (null == _moveEff) {
				_moveEff = SAssetManager.getInstance().getEffect('default', 'click');
				_moveEff.addEventListener(EffectSp.EFFECTOVER_EVENT, function(e:Event):void {
						_moveEff.parent && _moveEff.parent.removeChild(_moveEff);
					});
			}
			while (_moveEffContain.numChildren > 0) {
				_moveEffContain.removeChildAt(0);
			}
			_moveEff.setPos(tx, ty + 35);
			_moveEffContain.addChild(_moveEff);
			_moveEff.play();
		}
		
		private function resetBG():void {
			var showindex:int = 0;
			for (var i:int = _startx; i < _endx; i++) {
				for (var j:int = _starty; j < _endy; j++) {
					var str:String = j + "_" + i;
					var bm:Bitmap = _tileMap.get(str);
					_bgSprite.addChildAt(bm, showindex);
					showindex++;
				}
			}
			while (_bgSprite.numChildren > showindex) {
				_bgSprite.removeChildAt(_bgSprite.numChildren - 1);
			}
		}
		
		private function resetLoaded(bm:Bitmap):void {
			var tx:int = _startx * WordSceneSprite.MAP_TITL_SIZE;
			var txend:int = _endx * WordSceneSprite.MAP_TITL_SIZE;
			var ty:int = _starty * WordSceneSprite.MAP_TITL_SIZE;
			var tyend:int = _endy * WordSceneSprite.MAP_TITL_SIZE;
			if (bm.x >= tx && bm.x <= txend && bm.y >= ty && bm.y <= tyend) {
				_bgSprite.addChild(bm);
			}
		}
		
		private function loadPiece():void {
			if (0 == _loadedIDs.length) {
				return;
			}
			
			var len:int = _loadedIDs.length;
			var nids:Vector.<Point> = new Vector.<Point>();
			for (var i:int = 0; i < len; i++) {
				var tp:Point = _loadedIDs[i];
				var str:String = tp.y + "_" + tp.x;
				var index_x:int = tp.x;
				var index_y:int = tp.y;
				if (index_x >= _startx && index_x <= _endx && index_y >= _starty && index_y <= _endy) {
					var path:String = "res/scene" + _id + "/tiles/" + str + ".jpg";
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
					loader.load(new URLRequest(path));
					loader.x = index_x * WordSceneSprite.MAP_TITL_SIZE;
					loader.y = index_y * WordSceneSprite.MAP_TITL_SIZE;
					_loaders.push(loader);
				} else {
					nids.push(tp);
				}
			}
			_loadedIDs = nids;
		}
		
		private function loaded(e:Event):void {
			var loader:Loader = (e.currentTarget as LoaderInfo).loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaded);
			if (-1 != _loaders.indexOf(loader)) {
				var bmd:BitmapData = (loader.content as Bitmap).bitmapData.clone();
				var tx:int = loader.x / WordSceneSprite.MAP_TITL_SIZE;
				var ty:int = loader.y / WordSceneSprite.MAP_TITL_SIZE;
				var str:String = ty + "_" + tx;
				var bm:Bitmap = new Bitmap(bmd);
				bm.x = loader.x;
				bm.y = loader.y;
				_tileMap.put(str, bm);
			}
			loader.unloadAndStop();
			resetLoaded(bm);
		}
		
		public function addTrips(entitys:Array):void {
			var len:int = entitys.length;
			for (var i:int = 0; i < len; i++) {
				var d:RSwitchVo = entitys[i] as RSwitchVo;
				var v:TripEntiySprite = new TripEntiySprite(d);
				v.x = d.position.x;
				v.y = d.position.y;
				_tripContain.addChild(v);
			}
		}
		
		public function clear():void {
			clearTrips();
			while (_bgSprite.numChildren > 0) {
				_bgSprite.removeChildAt(0);
			}
			var bms:Array = _tileMap.values();
			var len:int = bms.length;
			for (var i:int = 0; i < len; i++) {
				var bm:Bitmap = bms[i] as Bitmap;
				bm.bitmapData.dispose();
			}
			_tileMap.clear();
		}
		
		public function checkTrip(tx:int, ty:int):Boolean {
			var len:int = _tripContain.numChildren;
			var isout:Boolean = true;
			var isfind:Boolean = false;
			for (var i:int = 0; i < len; i++) {
				var v:TripEntiySprite = _tripContain.getChildAt(i) as TripEntiySprite;
				var isx:Boolean = Math.abs(v.vo.position.x - tx) <= WordSceneSprite.GRID_SIZE * WordSceneSprite.TRIP_AREA;
				var isy:Boolean = Math.abs(v.vo.position.y - ty) <= WordSceneSprite.GRID_SIZE * WordSceneSprite.TRIP_AREA;
				if (isx && isy) {
					if (!_isEnterTipPos) {
						_isEnterTipPos = true;
						isfind = true;
						WordSceneSprite.getInstance().dispatchEvent(new RSwitchEvent(RSwitchEvent.SWITCH_EVENT, v.vo.id, v.vo.functionType));
					}
					isout = false;
					break;
				}
			}
			if (isout) {
				_isEnterTipPos = false;
			}
			return isfind;
		}
		
		public function getTripPos(id:int):Vector.<int> {
			var len:int = _tripContain.numChildren;
			for (var i:int = 0; i < len; i++) {
				var v:TripEntiySprite = _tripContain.getChildAt(i) as TripEntiySprite;
				if (v.vo.id == id) {
					return new <int>[v.x, v.y];
				}
			}
			return null;
		}
		
		private function clearTrips():void {
			while (_tripContain.numChildren > 0) {
				var v:TripEntiySprite = _tripContain.removeChildAt(0) as TripEntiySprite;
				v.clear();
			}
		}
		
		public function get mapw():int {
			return _mapw;
		}
		
		public function get maph():int {
			return _maph;
		}
		
		public function get npcContain():Sprite {
			return _npcContain;
		}
	
	}

}
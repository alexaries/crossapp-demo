package wordscene.loader 
{
	import adobe.utils.CustomActions;
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderItem;
	import com.greensock.loading.display.ContentDisplay;
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import sceneModule.rcommand.revent.RLoadEvent;
	import util.HashMap;
	import util.Logging;
	/**
	 * ...
	 * @author hao
	 */
	public class SAssetManager extends EventDispatcher
	{
		//////////////////////////////////////////////////////////////////////
		private static var _instance:SAssetManager;
		public static function getInstance():SAssetManager {
			if (null == _instance) {
				_instance = new SAssetManager();
			}
			return _instance;
		}
		public function SAssetManager() 
		{
			_loader = new BulkLoader("loader_");
			_loader.addEventListener(BulkProgressEvent.COMPLETE, on_all_loaded);
			_loader.addEventListener(BulkProgressEvent.PROGRESS, on_progress);
			_loader.addEventListener(ErrorEvent.ERROR, on_error);
			
			_queueloader = new BulkLoader("queueloader_");
			_queueloader.addEventListener(BulkProgressEvent.COMPLETE, on_queue_loaded);
			_queueloader.addEventListener(ErrorEvent.ERROR, on_queue_error);
			
			_asset_map = new HashMap();
			_fixinfo_map = new HashMap();
			_loadList = [];
		}
		//////////////////////////////////////////////////////////////////////
		public static const ASSET_XML_PATH:String = "res/res.xml";
		public static const ASSET_XML_ID:String = "ASSET_XML_ID";
		public static const ASSET_SCENE_ID:String = "scene";
		public static const ASSET_EFFECT_ID:String = "effect";
		public static const XML_TYPE:String = "xml";
		public static const GAP_CHAR:String = "_";
		
		public static const HEARO_ACTION_arise:String = "arise";
		public static const HEARO_ACTION_run:String = "run";
		public static const HEARO_ACTION_attacked:String = "attacked";
		public static const HEARO_ACTION_magicattack:String = "magicattack";
		public static const HEARO_ACTION_physicalattack:String = "physicalattack";
		public static const HEARO_ACTION_death:String = "death";
		
		//public static const TEST_HTTP:String = "http://127.0.0.1/"
		public static const TEST_HTTP:String = ""
		
		public static const LOAD_TYPE_ASSETXML:int = 0;
		public static const LOAD_TYPE_SCENERES:int = 1;
		public static const LOAD_TYPE_QUEUE:int = 2;
		//////////////////////////////////////////////////////////////////////
		private var _loader:BulkLoader;
		private var _queueloader:BulkLoader;
		private var _load_type:int;
		private var _progress:String;
		
		private var _asset_xml:XML;
		
		private var _loadList:Array;
		
		private var _asset_map:HashMap;
		private var _fixinfo_map:HashMap;
		
		
		private var _loadResCallBack:Function;
		private var _loadResArgs:Array;
		
		private var _sceneid:int;
		//////////////////////////////////////////////////////////////////////
		public function addToList(name:String, func:Function = null, args:Array = null):void {
			_loadList.push(name, func, args);
			loadQueue();
		}
		
		private function loadQueue():void {
			if (!_queueloader.isRunning) {
				if (_loadList.length > 0) {
					var tname:String = _loadList[0] as String;
					if (addPack(tname, _queueloader)) {
						Logging.log("开始加载队列", tname);
						_queueloader.start();
					}
					else {
						Logging.log("配置文件中没有素材id", tname);
						_loadList.splice(0, 3);
						
						loadQueue();
					}
				}
			}
		}
		
		private function assetQueueLoaded():void {
			readLoader(_queueloader);
			var targetname:String = _loadList[0] as String;
			Logging.log("队列资源加载完成", targetname);
			var len:int = _loadList.length;
			var n:Array = [];
			for (var i:int = 0; i < len; i += 3) 
			{
				var tname:String = _loadList[i];
				var tfunc:Function = _loadList[i + 1];
				var targs:Array = _loadList[i + 2];
				if (tname == targetname) {
					if (null != tfunc) {
						tfunc.apply(null, targs);
					}
				}
				else {
					n.push(tname, tfunc, targs);
				}
			}
			_loadList = n;
			Logging.log("剩余队列", _loadList);
			loadQueue();
		}
		
		public function setAssetXML(xml:XML):void {
			_asset_xml = xml;
		}
		
		public function loadRes(sceneid:int, func:Function = null, args:Array = null):void {
			_sceneid = sceneid;
			_loadResCallBack = func;
			_loadResArgs = args;
			loadSceneRes();
		}
		
		public function hasRes(packID:String, itemID:String):Boolean {
			return _asset_map.containsKey(packID + GAP_CHAR + itemID);
		}
		
		public function getBitmapData(packID:String, itemID:String):BitmapData {
			var b:BitmapData = _asset_map.get(packID + GAP_CHAR + itemID) as BitmapData;
			if (null == b) {
				Logging.log('no img ', packID, itemID);
			}
			return b;
		}
		
		public function getText(packID:String, itemID:String):String {
			var b:String = _asset_map.get(packID + GAP_CHAR + itemID) as String;
			if (null == b) {
			}
			return b;
		}
		
		public function getByteArray(packID:String, itemID:String):ByteArray {
			var b:ByteArray = _asset_map.get(packID + GAP_CHAR + itemID) as ByteArray;
			if (null == b) {
			}
			return b;
		}
		
		public function getEffect(packID:String, itemID:String):EffectSp {
			var bytes:ByteArray = getByteArray(packID, itemID);
			return new EffectSp(bytes);
		}
		
		public function getMC(packID:String, itemID:String):MovieClip {
			return _asset_map.get(packID + GAP_CHAR + itemID) as MovieClip;
		}
		
		public function getXML(itemID:String):XML {
			return _asset_map.get(XML_TYPE + GAP_CHAR + itemID) as XML;
		}
		
		public function getFixInfo(packID:String, itemID:String):Array {
			return _fixinfo_map.get(packID + GAP_CHAR + itemID) as Array;
		}
		
		public function isPackageHere(packageID:String):Boolean {
			var keys:Array = _asset_map.keys();
			var len:int = keys.length;
			for (var i:int = 0; i < len; i++) 
			{
				var key:String = keys[i] as String;
				if (-1 != key.indexOf(packageID)) {
					return true;
				}
			}
			return false;
		}
		
		///////////////////////////////////////////////////////////////////////
		//加载素材配置文件
		private function loadAssetXML():void {
			_load_type = LOAD_TYPE_ASSETXML;
			var ver:String = "2012-11-23 21:19:20".replace(/ /g, "_");
			ver = ver.replace(/:/g, "_");
			ver = ver.replace(/-/g, "_");
			_loader.add(TEST_HTTP + ASSET_XML_PATH + "?ver=" + ver, { id:ASSET_XML_ID } );
			_loader.start();
		}
		
		private function clearQueue():void {
			_loadList = [];
			_queueloader.removeAll();
		}
		
		private function clearScene():void {
			var keys:Array = _asset_map.keys();
			var len:int = keys.length;
			for (var i:int = 0; i < len; i++) 
			{
				var key:String = keys[i] as String;
				if (-1 != key.indexOf(ASSET_SCENE_ID + "_")) {
					var content:* = _asset_map.remove(key);
					if (content && content is BitmapData) {
						(content as BitmapData).dispose();
					}
				}
			}
		}
		
		private function loadSceneRes():void {
			clearQueue();
			clearScene();
			_load_type = LOAD_TYPE_SCENERES;
			if (!isPackageHere('default')) {
				addPack('default');
				addPack('fight');
			}
			addPack(ASSET_SCENE_ID + _sceneid);
			_loader.start();
		}
		
		private function addPack(xname:String, loader:BulkLoader = null):Boolean {
			var pack:XMLList = _asset_xml.assetpackage.(@id == xname);
			if (0 == pack.attributes().length()) {
				return false;
			}
			var p:AssetPackageVo = new AssetPackageVo();
			p.readXML(pack);
			addPackage(p, loader);
			return true;
		}
		
		private function getAssetPackageVo(itemid:String):AssetItemVo {
			var charindex:int = itemid.lastIndexOf(GAP_CHAR);
			var packageid:String = itemid.slice(0, charindex);
			var id:String = itemid.slice(charindex + 1);
			var pack:XMLList = _asset_xml.assetpackage.(@id == packageid);
			var itemxml:* = pack.asset.(@id == id);
			var i:AssetItemVo = new AssetItemVo();
			i.readXML(itemxml);
			return i;
		}
		
		
		private function assetXMLLoaded():void {
			_asset_xml = _loader.getXML(ASSET_XML_ID, true);
			loadSceneRes();
		}
		
		private function assetSceneLoaded():void {
			readLoader();
			if (null != _loadResCallBack) {
				var tf:Function = _loadResCallBack;
				var ta:Array = _loadResArgs;
				_loadResCallBack = null;
				_loadResArgs = null;
				tf.apply(null, ta);
			}
		}
		
		private function addPackage(pack:AssetPackageVo, loader:BulkLoader = null):void {
			for each (var item:AssetItemVo in pack.assetItems) 
			{
				var obj:Object = { };
				obj.id = item.id;
				//1 text
				if (1 == item.type) {
					obj.type = BulkLoader.TYPE_TEXT;
				}
				//2 eff swf
				else if (2 == item.type) {
					obj.type = BulkLoader.TYPE_BINARY;
				}
				//3 char swf
				else if (3 == item.type) {
					obj.type = BulkLoader.TYPE_MOVIECLIP;
				}
				if (null == loader) {
					loader = _loader;
				}
				var qitem:LoadingItem = loader.add(TEST_HTTP + item.path + "?ver=" + item.ver, obj );
			}
		}
		
		private function readLoader(loader:BulkLoader = null):void {
			if (null == loader) {
				loader = _loader;
			}
			for each (var item:LoadingItem in loader.items) 
			{
				var content:* = null;
				switch(item.type) {
					case BulkLoader.TYPE_IMAGE:
						pareImgs(item, loader);
						break;
					case BulkLoader.TYPE_TEXT:
						content = loader.getText(item.id, true);
						_asset_map.put(item.id, content);
						break;
					case BulkLoader.TYPE_BINARY:
						content = loader.getBinary(item.id, true);
						_asset_map.put(item.id, content);
						break;
					case BulkLoader.TYPE_MOVIECLIP:
						pareCharSwf(item, loader);
						break;
					default:
						Logging.log("unknow type " + item.type);
						throw new Error("unknow type " + item.type);
				}
			}
		}
		
		
		private function pareImgs(item:LoadingItem, loader:BulkLoader = null):void {
			if (null == loader) {
				loader = _loader;
			}
			var id:String = item.id;
			var reg:RegExp = /(.+)_(\d+)_(\d+)_(\d+)_(\d+)/;
			var r:Object = reg.exec(id);
			if (null == r) {
				var content:* = loader.getBitmapData(item.id, true);
				_asset_map.put(item.id, content);
			}
			else {
				var xcount:int = parseInt(r[2]);
				var ycount:int = parseInt(r[3]);
				var xfix:int = parseInt(r[4]);
				var yfix:int = parseInt(r[5]);
				if (0 == xcount || 0 == ycount) {
					Logging.log("error asset id " + id);
					throw new Error("error asset id " + id);
				}
				else {
					var bmd:BitmapData = loader.getBitmapData(id, true);
					var pw:int = bmd.width / xcount;
					var ph:int = bmd.height / ycount;
					var imgs:Vector.<BitmapData> = new Vector.<BitmapData>();
					for (var i:int = 0; i < xcount; i++) 
					{
						for (var j:int = 0; j < ycount; j++) 
						{
							var tbmd:BitmapData = new BitmapData(pw, ph, true, 0x0);
							var tRec:Rectangle = new Rectangle( i * pw, j * ph, pw, ph);
							tbmd.copyPixels(bmd, tRec, new Point());
							imgs.push(tbmd);
						}
					}
					imgs.fixed = true;
					_asset_map.put(r[1], imgs);
					_fixinfo_map.put(r[1], [-xfix, -yfix]);
					bmd.dispose();
				}
			}
		}
		
		private function pareCharSwf(item:LoadingItem, loader:BulkLoader = null):void {
			if (null == loader) {
				loader = _loader;
			}
			var content:* = loader.getContent(item.id, true);
			var packid:String = item.id.split(GAP_CHAR)[0] as String;
			var infos:Array = content.infos;
			var len:int = infos.length;
			for (var m:int = 0; m < len; ++m) 
			{
				var id:String = infos[m] as String;
				var reg:RegExp = /(.+)_(\d+)_(\d+)_(\d+)_(\d+)/;
				var r:Object = reg.exec(id);
				if (null == r) {
					Logging.log('char swf type error', id);
				}
				else {
					var xcount:int = parseInt(r[2]);
					var ycount:int = parseInt(r[3]);
					var xfix:int = parseInt(r[4]);
					var yfix:int = parseInt(r[5]);
					if (0 == xcount || 0 == ycount) {
						throw new Error("error asset id " + id);
					}
					else {
						var cls:* = content[id];
						var bm:*= new cls;
						var bmd:BitmapData = bm.bitmapData;
						var pw:int = bmd.width / xcount;
						var ph:int = bmd.height / ycount;
						var imgs:Vector.<BitmapData> = new Vector.<BitmapData>();
						for (var i:int = 0; i < xcount; i++) 
						{
							for (var j:int = 0; j < ycount; j++) 
							{
								var tbmd:BitmapData = new BitmapData(pw, ph, true, 0x0);
								var tRec:Rectangle = new Rectangle( i * pw, j * ph, pw, ph);
								tbmd.copyPixels(bmd, tRec, new Point());
								imgs.push(tbmd);
							}
						}
						imgs.fixed = true;
						_asset_map.put(packid + GAP_CHAR + r[1], imgs);
						_fixinfo_map.put(packid + GAP_CHAR + r[1], [-xfix, -yfix]);
						bmd.dispose();
					}
				}
			}
		}
		
		
		private function pareZip(item:LoadingItem):void {
			var f:FZip = new FZip();
			f.loadBytes(_loader.getBinary(item.id, true));
			var len:int = f.getFileCount();
			for (var i:int = 0; i < len; i++) 
			{
				var sf:FZipFile = f.getFileAt(i);
				var fname:String = sf.filename;
				fname = fname.replace(".xml", "");
				try{
					var xmlstr:String = sf.getContentAsString();
					var xml:XML = XML(xmlstr);
					_asset_map.put(XML_TYPE + GAP_CHAR + fname, xml);
				}
				catch (err:Error)
				{
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////
		private function on_all_loaded(e:BulkProgressEvent):void {
			switch (_load_type) 
			{
				case LOAD_TYPE_SCENERES:
					assetSceneLoaded();
					break;
				default:
					Logging.log("unknow load type " + _load_type);
					throw new Error("unknow load type " + _load_type);
			}
		}
		
		private function on_queue_loaded(e:Event):void {
			assetQueueLoaded();
		}
		
		private function on_progress(e:BulkProgressEvent):void {
			this.dispatchEvent(new RLoadEvent(RLoadEvent.PERCENT_LOADED_EVENT, e.weightPercent));
		}
		private function on_error(e:ErrorEvent):void {
			Logging.log("no scene res", _sceneid);
		}
		
		private function on_queue_error(e:ErrorEvent):void {
			var targetname:String = _loadList[0] as String;
			Logging.log("load queue error", targetname);
			var len:int = _loadList.length;
			var n:Array = [];
			for (var i:int = 0; i < len; i += 3) 
			{
				var tname:String = _loadList[i];
				var tfunc:Function = _loadList[i + 1];
				var targs:Array = _loadList[i + 2];
				if (tname == targetname) {
					
				}
				else {
					n.push(tname, tfunc, targs);
				}
			}
			_loadList = n;
			loadQueue();
		}
		
		public function get progress():String 
		{
			return null == _progress?"0%":_progress;
		}
		
		public function getImgs(packID:String, itemID:String):Vector.<BitmapData>{
			var b:Vector.<BitmapData> = _asset_map.get(packID + GAP_CHAR + itemID) as Vector.<BitmapData>;
			if (null == b) {
				var img:BitmapData = _asset_map.get(packID + GAP_CHAR + itemID) as BitmapData;
				if (null != img) {
					b = new Vector.<BitmapData>();
					b.push(img);
					b.fixed = true;
				}
			}
			if (null == b) {
				Logging.log("no imgs ", packID, itemID);
			}
			return b;
		}
		
	}

}
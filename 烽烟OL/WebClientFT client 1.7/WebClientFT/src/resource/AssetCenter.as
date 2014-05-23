package resource 
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;
	
	import com.adobe.utils.StringUtil;
	
	import event.UILoadEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.TriangleCulling;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	
	import sceneModule.rcommon.RLoadHelper;
	import sceneModule.view.copyScene.mediator.NCopySceneChoseMediator;
	
	import util.AppVersion;
	import util.HashMap;
	import util.xtrace;
	
	/**
	 * ...
	 * @author hao
	 */
	public class AssetCenter extends EventDispatcher 
	{
		private static var _instance:AssetCenter;
		private var _version:String;
		
		public function AssetCenter() 
		{
			if (null != _instance) {
				throw new Error("AssetCenter should be singleton");
			}
			
			_img_package_map = new HashMap();
			_bLoader = new BulkLoader("ui_asset");
			_bLoader.logLevel = BulkLoader.LOG_ERRORS;
			_bLoader.addEventListener(BulkProgressEvent.COMPLETE, on_all_loaded);
			_bLoader.addEventListener(BulkProgressEvent.PROGRESS, on_progress);
			_bLoader.addEventListener(ErrorEvent.ERROR, on_error);
			
			_preLoader = new BulkLoader("pre_asset");
			_preLoader.logLevel = BulkLoader.LOG_ERRORS;
			_preLoader.addEventListener(BulkProgressEvent.COMPLETE, on_preRes_all_loaded);
			_preLoader.addEventListener(BulkProgressEvent.PROGRESS, on_preRes_progress);
			_preLoader.addEventListener(ErrorEvent.ERROR, on_error);
			
			_is_loading = false;
			
			_list_package_map = new HashMap();
			_list_loader = new BulkLoader("ui_list_loader");
			_list_loader.logLevel = BulkLoader.LOG_ERRORS;
			_list_loader.addEventListener(ErrorEvent.ERROR, on_error);
		}
		public static function getInstance():AssetCenter {
			if (null == _instance) {
				_instance = new AssetCenter();
			}
			return _instance;
		}
		/////////////////////////////////////////////////////////////////
		private var _bLoader:BulkLoader;
		private var _preLoader:BulkLoader;
		private var _list_loader:BulkLoader;
		
		private var _info_xml:XML;
		
		//奖励描述XML
		private var _rewardDes_xml:XML;
		
		private var _img_package_map:HashMap;
		private var _list_package_map:HashMap;
	
		private var _is_loading:Boolean;
		private var _is_perload:Boolean;
		private var _cur_package_id:String;
		private var _cur_func:Function;
		private var _cur_args:Array;
		private var _fail_func:Function;
		private var _fail_args:Array;
		private var _cur_img_infos:Array;
		private var _loading_des:String;
		
		/////////////////////////////////////////////////////////////////
		//初始化配置文件
		public function init_xml(xml:XML):void {
			_info_xml = xml;
		}
		
		public function set rewardDes_xml(xml:XML):void{
			_rewardDes_xml = xml;
		}
		
		public function get rewardDes_xml():XML{
			return _rewardDes_xml;
		}
		
		private function getVersionStr():String {
			var vArr:Array = AppVersion.versionStr.split(' ');
			return "?v=" + vArr[vArr.length - 1];
		}
		
		//加载预加载资源
		public function pre_load(func:Function = null):void {
			var img_infos:Array = [];
			for each (var item:XML in _info_xml.enter_game.asset_package) 
			{
				var package_path:String = item.@path;
				var package_id:String = item.@id;
				for each (var item_asset:XML in item.asset) 
				{
					var img_info:AssetItemInfo = new AssetItemInfo();
					img_info.id = item_asset.@id;
					img_info.package_id = package_id;
					img_info.path = item_asset.@path;
					img_info.path = package_path + img_info.path;
					img_info.type = item_asset.@type;
					
					var t_obj:Object = { };
					t_obj['id'] = img_info.id;
					if (AssetItemInfo.AssetItemInfo_TYPE_SWF == img_info.type) {
						t_obj['type'] = BulkLoader.TYPE_BINARY;
					}
					
					_preLoader.add(RLoadHelper.TEST_HTTP + img_info.path + getVersionStr(), t_obj );
					img_infos.push(img_info);
				}

			}
			
			_cur_img_infos = img_infos;
			_is_perload = true;
			_is_loading = true;
			_cur_func = func;
			_cur_package_id = package_id;
			_loading_des = get_package_des(package_id);
			
			_preLoader.start();
		}
		
		/**
		 * 查询资源包是否存在
		 * @param	id
		 * @return
		 */
		public function is_package_here(id:String):Boolean {
			return _img_package_map.containsKey(id);
		}
		
		/**
		 * 查询图片所在资源包是否存在
		 * @param	id
		 * @return
		 */
		public function is_img_here(id:String):Boolean {
			var package_id:String = get_packageid_by_imgid(id);
			if (null == package_id) {
				throw new Error("no img here " + id);
			}
			return is_package_here(package_id);
			
		}
		
		public function is_img_in_package(package_id:String, img_id:String):Boolean {
			var is_here:Boolean = false;
			if (_img_package_map.containsKey(package_id)) {
				var package_info:AssetPackage = _img_package_map.get(package_id) as AssetPackage;
				is_here = package_info.imgs.containsKey(img_id);
			}
			return is_here;
		}
		
		
		/**
		 * 加载资源包
		 * @param	id			资源包的id
		 * @param	func		加载完成回调函数
		 * @param	args		加载完成回调函数的参数
		 * @param	auto_call	如果资源包已经加载完成是否调用回调函数
		 */
		public function load_package(
			id:String, 
			func:Function = null, args:Array = null, 
			auto_call:Boolean = false, 
			fail_func:Function = null, fail_args:Array = null, 
			appendimgs:Array = null,
			appendpackage:Array = null
		):void {
			var need_packages:Array = [];
			if (!is_package_here(id)) {
				need_packages.push(id);
			}
			if (null != appendpackage && appendpackage.length > 0) {
				for each (var item:String in appendpackage) 
				{
					if (!is_package_here(item)) {
						need_packages.push(item);
					}
				}
			}
			if (need_packages.length > 0) {
				//需要加载
				in_load_package(id, func, args, null, fail_func, fail_args, appendimgs, need_packages);
			}
			else {
				//不需要加载
				if (auto_call && null != func) {
					func.apply(null, args);
				}
			}
			
			
			/*
			var need_loade_packages:Array = [];
			if (is_package_here(id)) {
				//已经存在这个包了
				
				//查看是否有额外的包需要加载
				if (null == appendimgs) {
					appendimgs = [];
				}
				
				var is_all_ok:Boolean = true;
				
				for each (var item:String in appendimgs) 
				{
					if (!is_package_here(item)) {
						is_all_ok = false;
						need_loade_packages.push(item);
					}
				}
				
				if (auto_call && null != func && is_all_ok) {
					func.apply(null, args);
					return;
				}
			}
			if (is_package_here(id)) {
				id = null
			}
			if(null != id || need_loade_packages.length > 0) {
				//还没有存在这个包
				in_load_package(id, func, args, null, fail_func, fail_args, appendimgs, need_loade_packages);
			}*/
		}
		
		/**
		 * 加载一个创建的素材包
		 * @param	package_id
		 * @param	imgs
		 */
		public function add_and_load_package(package_id:String, imgs:Array, func:Function, args:Array = null, fail_func:Function = null, fail_args:Array = null):void {
			in_load_package(package_id, func, args, imgs, fail_func, fail_args);
		}
		
		/**
		 * 根据资源包id和资源id获取图片
		 * @param	package_id
		 * @param	img_id
		 * @return
		 */
		public function get_img_form_pacakge(package_id:String, img_id:String):BitmapData {
			var bd:BitmapData = null;
			if (is_package_here(package_id)) {
				bd = (_img_package_map.get(package_id) as AssetPackage).imgs.get(img_id) as BitmapData;
			}
			return bd;
		}
		
		/**
		 * 根据图片id获取图片
		 * @param	img_id
		 * @return
		 */
		public function get_img(img_id:String):BitmapData{
			var package_id:String = get_packageid_by_imgid(img_id);
			if (null == package_id) {
				return null;
			}
			return get_img_form_pacakge(package_id, img_id);
		}
		
		public function get_mc_form_pacakge(package_id:String, img_id:String, func:Function = null, args:Array = null):MovieClip {
			var bd:Loader = new Loader();
			var mc:MovieClip = new MovieClip();
			if (is_package_here(package_id)) {
				var bytes:ByteArray = (_img_package_map.get(package_id) as AssetPackage).imgs.get(img_id) as ByteArray;
				if (null != func) {
					bd.contentLoaderInfo.addEventListener(Event.COMPLETE,
						function(e:Event):void {
								if (null == args) {
									args = [];
								}
								args.unshift(bd.content);
								func.apply(null, args);
						}
					);
				}
				bd.loadBytes(bytes);
				bd.name = "bdMc";
				mc.addChild(bd);
			}
			return mc;
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//加载完成
		private function on_all_loaded(e:BulkProgressEvent):void {
			//xtrace("加载完成");
			if (!_is_perload) {
				this.dispatchEvent(new UILoadEvent(UILoadEvent.UILoadEvent_HIDE));
			}
				
			for each (var item:AssetItemInfo in _cur_img_infos) 
			{
				var package_id:String = item.package_id;
				var img_package:AssetPackage = null;
				if (!is_package_here(package_id)) {
					img_package = new AssetPackage();
					img_package.id = package_id;
					_img_package_map.put(package_id, img_package);
				}
				else {
					img_package = _img_package_map.get(package_id) as AssetPackage;
				}
				if (AssetItemInfo.AssetItemInfo_TYPE_IMG == item.type) {
					img_package.imgs.put(item.id, _bLoader.getBitmapData(item.id, true));
				}
				else if (AssetItemInfo.AssetItemInfo_TYPE_SWF == item.type) {
					var bytes:ByteArray = new ByteArray();
					var sourcebytes:ByteArray = _bLoader.getBinary(item.id, true);
					sourcebytes.position = 0;
					bytes.writeBytes(sourcebytes);
					img_package.imgs.put(item.id, bytes);
				}
				else {
					xtrace("wrong load type ", item.type);
					throw new Error("wrong load type " + item.type);
				}
				
			}
			
			xtrace("素材包加载完成 ", _cur_package_id);
			
			var t_ok_func:Function = _cur_func;
			var t_ok_args:Array = _cur_args;
			
			clear_cur_load_info();
			
			if (null != t_ok_func) {
				t_ok_func.apply(null, t_ok_args);
			}
		}
		//预加载资源
		private function on_preRes_all_loaded(e:BulkProgressEvent):void {
			//xtrace("加载完成");
			if (!_is_perload) {
				this.dispatchEvent(new UILoadEvent(UILoadEvent.UILoadEvent_HIDE));
			}
			
			for each (var item:AssetItemInfo in _cur_img_infos) 
			{
				var package_id:String = item.package_id;
				var img_package:AssetPackage = null;
				if (!is_package_here(package_id)) {
					img_package = new AssetPackage();
					img_package.id = package_id;
					_img_package_map.put(package_id, img_package);
				}
				else {
					img_package = _img_package_map.get(package_id) as AssetPackage;
				}
				if (AssetItemInfo.AssetItemInfo_TYPE_IMG == item.type) {
					img_package.imgs.put(item.id, _preLoader.getBitmapData(item.id, true));
				}
				else if (AssetItemInfo.AssetItemInfo_TYPE_SWF == item.type) {
					var bytes:ByteArray = new ByteArray();
					var sourcebytes:ByteArray = _preLoader.getBinary(item.id, true);
					sourcebytes.position = 0;
					bytes.writeBytes(sourcebytes);
					img_package.imgs.put(item.id, bytes);
				}
				else {
					xtrace("wrong load type ", item.type);
					throw new Error("wrong load type " + item.type);
				}
				
			}
			
			xtrace("素材包加载完成 ", _cur_package_id);
			
			var t_ok_func:Function = _cur_func;
			var t_ok_args:Array = _cur_args;
			
			clear_cur_load_info();
			
			if (null != t_ok_func) {
				t_ok_func.apply(null, t_ok_args);
			}
		}
		//加载过程中
		import event.PreLoadResProgressEvent;
		
		import resource.CrotaResourceConfig;
		
		import sceneModule.rcommon.RLoadHelper;

		private function on_progress(e:BulkProgressEvent):void {
			//xtrace("加载过程中");
			//xtrace("加载进度 ", e.loadingStatus());
			var percent:Number = e.percentLoaded;
			if (0 == percent) {
				var loaded:int = e.itemsLoaded;
				if (0 == loaded) {
					loaded = 1;
				}
				percent = e.weightPercent / e.itemsTotal * loaded; 
				if (isNaN(percent)) {
					percent = 1;
				}
			}
			this.dispatchEvent(new UILoadEvent(UILoadEvent.UILoadEvent_PROGRESS, {percent_loaded:percent, cur:e.bytesLoaded , total:e.bytesTotal } ));
		}
		private function on_preRes_progress(e:BulkProgressEvent):void {
			//xtrace("加载过程中");
			//xtrace("加载进度 ", e.loadingStatus());
			var percent:Number = e.percentLoaded;
			if (0 == percent) {
				var loaded:int = e.itemsLoaded;
				if (0 == loaded) {
					loaded = 1;
				}
				percent = e.weightPercent / e.itemsTotal * loaded; 
				if (isNaN(percent)) {
					percent = 1;
				}
			}
			this.dispatchEvent(new PreLoadResProgressEvent(PreLoadResProgressEvent.PRELOADPRERESPROGRESS,e.weightPercent));
			//			this.dispatchEvent(new UILoadEvent(UILoadEvent.UILoadEvent_PROGRESS, {percent_loaded:percent, cur:e.bytesLoaded , total:e.bytesTotal } ));
		}
		
		//加载出错
		private function on_error(e:ErrorEvent):void {
			//xtrace("加载出错");
			xtrace("加载出错", e.toString());
		}
		
		
		private function clear_cur_load_info():void {
			_cur_func = null;
			_cur_args = null;
			_fail_func = null;
			_fail_args = null;
			_cur_img_infos = null;
			_cur_package_id = null;
			_is_loading = false;
			_is_perload = false;
		}
		
		
		private function in_load_package(
			package_id:String, 
			func:Function, args:Array, 
			imgs:Array = null, 
			fail_func:Function = null, fail_args:Array = null, 
			append_imgs:Array = null,
			append_package:Array = null
		):void {
			if (_is_loading) {
				//throw new Error("asset is loading " + package_id);
				//return;
				//清除已加载的素材,加载新资源
				xtrace("clear loadding resource");
				if (null != _fail_func) {
					_fail_func.apply(null, _fail_args);
				}
				_bLoader.removeAll();
				clear_cur_load_info();
			}
			xtrace("开始加载素材包 ", package_id);
			var img_infos:Array = [];
			if (null == imgs) {
				//if (is_package_here(package_id)) {
					img_infos = []; 
				//}
				//else{
				//	img_infos = get_package_info_list(package_id);
				//}
				//test
				//if("ui_friend" == package_id){
					//var t:AssetItemInfo = new AssetItemInfo();
					//t.id = "test";
					//t.package_id = package_id;
					//t.path = "assets/test.mkv";
					//img_infos.push(t);
				//}
				//test end
			}
			else{
				img_infos = imgs;
			}
			
			if (null != append_imgs) {
				img_infos = img_infos.concat(append_imgs);
			}
			
			if (null != append_package) {
				var app_package_len:int = append_package.length;
				for (var i:int = 0; i < app_package_len; i++) 
				{
					var t_p:String = append_package[i];
					var t_imgs:Array = get_package_info_list(t_p);
					img_infos = img_infos.concat(t_imgs);
				}
			}
			
			for each (var item:AssetItemInfo in img_infos) 
			{
				var type:int = item.type;
				var t_obj:Object = { };
				t_obj['id'] = item.id;
				if (AssetItemInfo.AssetItemInfo_TYPE_SWF == type) {
					t_obj['type'] = BulkLoader.TYPE_BINARY;
				}
				_bLoader.add(RLoadHelper.TEST_HTTP + item.path + getVersionStr(), t_obj);
			}
			
			_cur_img_infos = img_infos;
			_cur_package_id = package_id;
			_cur_func = func;
			_cur_args = args;
			_fail_func = fail_func;
			_fail_args = fail_args;
			_is_loading = true;
			_loading_des = get_package_des(package_id);
			this.dispatchEvent(new UILoadEvent(UILoadEvent.UILoadEvent_SHOW));
			_bLoader.start();
		}
		
		
		private function get_package_info_list(package_id:String):Array {
			var package_xml:XMLList = _info_xml.real_time.asset_package.(@id == package_id);
			
			//如果没有这个包返回null
			if (package_xml.attributes().length() <= 0 ) {
				throw new Error("no package config info " + package_id);
				return null;
			}
			
			var package_path:String = package_xml.@path;
			var package_id:String = package_xml.@id;
			var img_infos:Array = [];
			for each (var item:XML in package_xml.asset) 
			{
				var img_info:AssetItemInfo = new AssetItemInfo();
				img_info.id = item.@id;
				img_info.package_id = package_id;
				img_info.path = item.@path;
				img_info.path = package_path + img_info.path;
				img_info.type = item.@type;
				img_infos.push(img_info);
			}
			return img_infos;
		}
		
		private function get_package_des(id:String):String {
			var str:String = null;
			switch (id) 
			{
				case NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE:
					str = CrotaResourceConfig.getInstance().getTextByModuleAndId('resource','ac_jzfb');
					break;
				default:
			}
			if (null == str) {
				var package_xml:XMLList = _info_xml.real_time.asset_package.(@id == id);
				str = package_xml.@des;
			}
			if (null == str || "" == str) {
				str = CrotaResourceConfig.getInstance().getTextByModuleAndId('resource','ac_jzsc') + id;
			}
			return str;
		}
		
		private function get_packageid_by_imgid(img_id:String):String {
			var img_xml:XMLList = _info_xml.real_time..asset.(@id == img_id);
			if (img_xml.attributes().length() <= 0) {
				return null;
			}
			return img_xml.parent().@id;
		}
		
		private function get_perload_packageid(img_id:String):String {
			var img_xml:XMLList = _info_xml.enter_game..asset.(@id == img_id);
			if (img_xml.attributes().length() <= 0) {
				return null;
			}
			return img_xml.parent().@id;
		}
		
		public function get loading_des():String 
		{
			return _loading_des;
		}
		
		//////////////////////////////////////////////////////////////////////
		//判断是否存在临时加载素材
		public function is_list_res_here(id:String):Boolean {
			return _list_package_map.containsKey(id);
		}
		//获取临时加载的图片
		public function get_list_res_img(id:String, func:Function = null, args:Array = null):Boolean{
			var r:Boolean = is_list_res_here(id);
			if (r) {
				if (null != func) {
					if (null == args) {
						args = [];
					}
					args.unshift(_list_package_map.get(id));
					func.apply(null, args);
				}
			}
			else {
				var path:String = get_list_res_path(id);
				var item:LoadingItem = _list_loader.add( RLoadHelper.TEST_HTTP + path + getVersionStr(), { id:id} );
				item.addEventListener(
					Event.COMPLETE, 
					function(e:Event):void {
						var img:BitmapData = _list_loader.getBitmapData(id);
						_list_package_map.put(id, img);
						if (null != func) {
							if (null == args) {
								args = [];
							}
							args.unshift(img);
							func.apply(null, args);
						}
					}
				);
				if (!_list_loader._isRunning) {
					_list_loader.start();
				}
			}
			return r;
		}
		//获取临时加载图片的路径
		public function get_list_res_path(id:String):String {
			var path:String = _info_xml.tmp.asset.(@id == id).@path;
			return path;
		}
		
	}

}
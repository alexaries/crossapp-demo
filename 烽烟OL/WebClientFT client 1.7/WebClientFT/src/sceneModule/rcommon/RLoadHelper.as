package sceneModule.rcommon
{	
	import com.deadreckoned.assetmanager.Asset;
	import com.deadreckoned.assetmanager.AssetManager;
	import com.deadreckoned.assetmanager.AssetQueue;
	import com.deadreckoned.assetmanager.events.AssetEvent;
	import com.deadreckoned.assetmanager.events.AssetProgressEvent;
	
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.net.LocalConnection;
	
	import sceneModule.model.rvo.RBattleInitChaVo;
	import sceneModule.rcommand.revent.RLoadEvent;
	import sceneModule.rresource.RBattleConst;
	import sceneModule.rresource.RCharacterConst;
	
	import util.AppVersion;
	import com.adobe.serialization.json.JSON;

	/**
	 * 资源加载辅助类 
	 * @author sxmad
	 * 
	 */	
	public class RLoadHelper
	{
		public function RLoadHelper()
		{
		}
		
		//GLOBAL ====================================
		private var firstLoadDefaultRes:Boolean = false;//是否是第一次加载，用来判断是否要重新加载DEFAULT配置文件
		public static const TEST_HTTP:String = "";//资源路径前缀，比如".."或"http://www.domain.com"
		public static const SWF_EXTENSION_NAME:String = ".swf";
		public static const PNG_EXTENSION_NAME:String = ".png";
		public static const JPG_EXtENSION_NAME:String = ".jpg";
		
		//NORMAL CONST =============================
		private const CONN_STR:String = "_";//id和type之间的连接符
		private const LAYER_CLASS_NAME_PRE:String = "L";//swf中默认场景图片类的ID前缀，具体类如：L1,L2,L3,L4
		private const SCENE_PRE_ID:String = "SCENE_PRE_ID";//场景资源文件ID前缀
		
		private const IMG_BMD_CLS_NAME:String = "ActionImg";//角色，NPC，NPC ICON，怪物SWF中BitmapData类名
		public static const MC_ACTION_CLS:String = "ActionMc";//战斗，swf中，动作MC的类名
		public static const MC_EFFECT_CLS:String = "EffectMc";//战斗，swf中，特效MC的类名
		
		private const NPC_ICON_FILE_NAME_PRE:String = "npcIcon";//NPC ICON 资源文名件前缀
		public static const NPC_ICON_ID:String = "NPC_ICON_ID";//NPC ICON 资源前缀
		public static const NPC_RES_ID:String = "NPC_RES_ID";//NPC RES资源前缀
		
		public static const SWITCH_RES_ID:String = "SWITCH_RES_ID";//SWITCH RES资源前缀
		public static const CHA_RES_ID:String = "CHA_RES_ID";//CHA RES资源前缀
		public static const MONSTER_RES_ID:String = "MONSTER_RES_ID";//MONSTER RES资源前缀
		public static const BATTLE_RES_ID:String = "BATTLE_RES_ID";//战斗资源前缀
		
		public static const SCENE_NAME_RES_ID:String = "SCENE_NAME_RES_ID";//场景名称资源ID前缀
		public static const SKY_IMG:String = "SKY_IMG";//场景雾所资源前缀
		
		//JSON ======================================
		private const JSON_BG_PRE_ID:String = "JSON_BG_ID";//场景配置文件ID前缀
		private const JSON_BG_EXTENSION_NAME:String = ".gs-bg";//场景背景图配置文件类型
		private const JSON_BATTLE_PRE_ID:String = "JSON_BATTLE_PRE_ID";//战斗配置文件前缀
		private const JSON_BATTLE_EXTENSION_NAME:String = ".gs-battle";//战斗配置文件类型
		
		//PATH ========================================
		private const SCENE_NAME_RES_PATH:String = "assets/Image/SceneName/";//场景名称资源路径
		private const SKY_RES_PATH:String = "assets/Images/sky/";//雾气资源路径
		
		private const SCENE_RES_PATH:String = "assets/scene/";//场景背景路径
		private const SCENE_THUMB_RES_PATH:String = "assets/scene/sceneThumb/";//场景缩略图路径
		
		private const CHA_RES_PATH:String = "assets/swf/sceneRes/";//场景资源路径：角色，NPC，传送门，怪物
		
		private const BATTLE_RES_PATH:String = "assets/swf/battleRes/";//战斗资源路径：角色，怪物
		
		//DEFAULT =====================================
		private const DEFAULT_MOUSE_ID:String = "DEFAULT_MOUSE_ID";
		private const DEFAULT_MOUSE_PATH:String = "assets/swf/mouseRes/click.swf";//默认鼠标点击效果
		
		private const DEFAULT_CHA_POS_ID:String = "DEFAULT_CHA_POS_ID";//默认场景角色偏移坐标ID
		private const DEFAULT_CHA_POS_CONFIG_PATH:String = "assets/swf/sceneRes/pos.gs-cha";//默认场景角色偏移点配置文件
		
		private const DEFAULT_CHA_INFO_ID:String = "DEFAULT_CHA_INFO_ID";//默认角色基础信息配置文件ID
		private const DEFAULT_CHA_INFO_CONFIG_PATH:String = "assets/swf/sceneRes/char_config.gs-cha";//默认角色基础信息配置文件
		
		private const DEFAULT_BATTLE_POS_ID:String = "DEFAULT_BATTLE_POS_ID";//默认战斗POS点配置文件ID
		private const DEFAULT_BATTLE_POS_PATH:String = "assets/swf/battleRes/pos.gs-battle";//默认战斗POS点配置文件
		
		public static const BATTLE_RING_ID:String = "BATTLE_RING_ID";//战斗敌人脚下光圈资源路径ID
		private const BATTLE_RING_PATH:String = "assets/swf/battleRes/ring.swf";//战斗敌人脚下光圈资源路径
		
		public static const BATTLE_MASK_ID:String = "BATTLE_MASK_ID";//战斗红血遮罩资源路径ID
		private const BATTLE_MASK_PATH:String = "assets/swf/battleRes/battleMask.swf";//战斗红血遮罩资源路径
		
		private const DEFAULT_SKY_CONFIG_ID:String = "DEFAULT_SKY_CONFIG_ID";
		private const DEFAULT_SKY_CONFIG_PATH:String = "assets/scene/sky_config.gs-bg";//雾气配置文件
		
		private const DEFAULT_BLANK_CHA_ID:String = "DEFAULT_BLANK_CHA_ID";//默认角色ID
		private const DEFAULT_BLANK_CHA_PATH:String = "assets/swf/sceneRes/blankCha.swf";//默认空白角色路径
		
		private const DEFAULT_BLANK_CHA_JSON_ID:String = "DEFAULT_BLANK_CHA_JSON_ID";//默认角色配置文件ID
		private const DEFAULT_BLANK_CHA_JSON_PATH:String = "assets/swf/sceneRes/blankCha.gs-cha";//默认角色配置文件
		
		private const DEFAULT_BLANK_RES_ID:String = "DEFAULT_BLANK_RES_ID";//默认空白资源路径ID
		private const DEFAULT_BLANK_RES_PATH:String = "assets/swf/sceneRes/blankRes.swf";//默认空白资源路径
		
		private const DEFAULT_BLANK_RES_JSON_ID:String = "DEFAULT_BLANK_RES_JSON_ID";//默认空白资源配置文件
		private const DEFAULT_BLANK_RES_JSON_PATH:String = "assets/swf/sceneRes/blankRes.gs-cha";//默认空白资源配置文件
		
		private const DEFAULT_BLANK_SWITCH_ID:String = "DEFAULT_BLANK_SWITCH_ID";//默认传送门资源
		private const DEFAULT_BLANK_SWITCH_PATH:String = "assets/swf/sceneRes/blankSwitch.swf";//默认传送门资源
		
		private const DEFAULT_BLANK_SWITCH_JSON_ID:String = "DEFAULT_BLANK_SWITCH_JSON_ID";//默认传送门资源配置文件
		private const DEFAULT_BLANK_SWITCH_JSON_PATH:String = "assets/swf/sceneRes/blankSwitch.gs-cha";//默认传送门资源配置文件
		
		public static const DEFAULT_SCENE_BG_NAME:String = "DEFAULT_SCENE_BG_NAME";//场景名称背景资源名称
		private const DEFAULT_SCENE_BG_PATH:String = "assets/Image/SceneName/comBgEff.swf";//场景名称背景资源路径
		
		//INIT =====================================
		public var sceneNameBg:MovieClip;//场景名称背景资源
		public var blankChaBmd:BitmapData;//角色空白默认资源，小黑人
		public var blankResBmd:BitmapData;//纯空白默认资源，全空白，用于NPC图标等通用空白资源
		public var blankSwitchBmd:BitmapData;//传送门默认空白资源，目前是小黑人，可以独立
		
		public var blankChaObj:Object;//角色默认空白资源JSON文件对应对象
		public var blankResObj:Object;//NPC默认空白资源JSON文件对应对象
		public var blankSwitchObj:Object;//传送门默认空白资源JSON文件对应对象
		
		public var chaInfoObj:Object;//角色信息JSON文件对应的对象
		public var chaPosObj:Object;//角色POS点的JSON文件对应的对象
		public var battlePosObj:Object;//战斗POS的JSON文件对应的对象
		
		//INSTANCE ====================================
		private static var _instance:RLoadHelper;
		public static function getInstance():RLoadHelper{
			if(_instance == null){
				_instance = new RLoadHelper();
			}
			return _instance;
		}
		private function getVersionStr():String {
			var vArr:Array = AppVersion.versionStr.split(' ');
			//return "";
			return "?v=" + vArr[vArr.length - 1];
		}
		public function gc():void {
			try {
				new LocalConnection().connect("gaKao");
				new LocalConnection().connect("gaKao");
			} catch (error:Error) {
				//trace("GC OK!");
			}
		}
		/**
		 * 把资源ID转换成数组 
		 * @param id 要转换的资源ID，如NPC_RES_ID110012_100007
		 * @param replaceStr 要消除的字符，如NPC_RES_ID
		 * @return 返回数组[110012,100007]
		 * 
		 */		
		private function idToArray(id:String,replaceStr:String):Array{
			var arr:Array;
			var myPattern:RegExp = new RegExp(replaceStr);
			var tempStr:String = id.replace(myPattern,"");
			arr = tempStr.split(CONN_STR);
			return arr;
		}
		private function chaIdToArray(id:String,replaceStr:String):Array{
			var arr:Array = [];
			var myPattern:RegExp = new RegExp(replaceStr);
			var tempStr:String = id.replace(myPattern,"");
			arr.push(tempStr);
			return arr;
		}
		/**
		 *================================================================================
		 *============= 场景资源加载处理
		 *================================================================================
		 */		
		
		public var sceneAM:AssetQueue = new AssetQueue("sceneAM");//资源加载管理器
		private var sceneCBFun:Function;//场景背景回调函数
		private var sceneCBArgs:Array;//场景回调函数参数
		private var sceneId:int;//要处理的场景资源ID
		/**
		 * 加载场景资源 
		 * @param sceneId 场景ID
		 * @param func 回调函数
		 * @param args 需传参数
		 */		
		public function loadSceneRes(sceneId:int,func:Function,args:Array = null):void{
			if(this.sceneId>0){
				sceneAM.purge(JSON_BG_PRE_ID+this.sceneId);//清除场景JSON资源
				sceneAM.purge(SCENE_PRE_ID+this.sceneId);//清除场景背景资源
				sceneAM.purge(SCENE_NAME_RES_ID+this.sceneId);//清除场景背景资源
			}
			
			this.sceneId = sceneId;
			this.sceneCBFun = func;
			this.sceneCBArgs = args;
			
			sceneAM.addEventListener(AssetProgressEvent.PROGRESS,sceneProgressHandler);
			sceneAM.addEventListener(AssetEvent.QUEUE_START,sceneStartHandler);
			sceneAM.addEventListener(AssetEvent.QUEUE_COMPLETE,sceneCompleteHandler);
			
			var bgJsonUrl:String = TEST_HTTP + SCENE_RES_PATH + sceneId + JSON_BG_EXTENSION_NAME + getVersionStr();//场景配置文件
			var bgUrl:String = TEST_HTTP + SCENE_RES_PATH + sceneId + SWF_EXTENSION_NAME + getVersionStr();//背景资源文件
			sceneAM.add(bgJsonUrl, {type:AssetManager.TYPE_BINARY,id:JSON_BG_PRE_ID+sceneId});//添加场景配置文件
			sceneAM.add(bgUrl, {type:AssetManager.TYPE_SWF,id:SCENE_PRE_ID+sceneId});//添加场景文件
			
			sceneAM.add(TEST_HTTP + SCENE_NAME_RES_PATH + sceneId + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:SCENE_NAME_RES_ID+sceneId});//添加场景资源名称文件
			
			if(!firstLoadDefaultRes){//加载默认文件
				firstLoadDefaultRes = true;
				sceneAM.add(TEST_HTTP + DEFAULT_MOUSE_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:DEFAULT_MOUSE_ID});//鼠标
				sceneAM.add(TEST_HTTP + DEFAULT_CHA_POS_CONFIG_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_CHA_POS_ID});//默认场景角色偏移点配置文件
				sceneAM.add(TEST_HTTP + DEFAULT_CHA_INFO_CONFIG_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_CHA_INFO_ID});//默认角色基础信息配置文件
				sceneAM.add(TEST_HTTP + DEFAULT_BATTLE_POS_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_BATTLE_POS_ID});//默认战斗POS点配置文件
				sceneAM.add(TEST_HTTP + BATTLE_RING_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:BATTLE_RING_ID});//战斗敌人脚下光圈资源路径
				sceneAM.add(TEST_HTTP + BATTLE_MASK_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:BATTLE_MASK_ID});//战斗红血遮罩资源路径
				sceneAM.add(TEST_HTTP + DEFAULT_SKY_CONFIG_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_SKY_CONFIG_ID});//雾气配置文件
				sceneAM.add(TEST_HTTP + DEFAULT_BLANK_CHA_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:DEFAULT_BLANK_CHA_ID});//默认空白角色路径
				sceneAM.add(TEST_HTTP + DEFAULT_BLANK_CHA_JSON_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_BLANK_CHA_JSON_ID});//默认角色配置文件
				sceneAM.add(TEST_HTTP + DEFAULT_BLANK_RES_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:DEFAULT_BLANK_RES_ID});//默认空白资源路径
				sceneAM.add(TEST_HTTP + DEFAULT_BLANK_RES_JSON_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_BLANK_RES_JSON_ID});//默认空白资源配置文件
				sceneAM.add(TEST_HTTP + DEFAULT_BLANK_SWITCH_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:DEFAULT_BLANK_SWITCH_ID});//默认传送门资源
				sceneAM.add(TEST_HTTP + DEFAULT_BLANK_SWITCH_JSON_PATH + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:DEFAULT_BLANK_SWITCH_JSON_ID});//默认传送门资源配置文件
				sceneAM.add(TEST_HTTP + DEFAULT_SCENE_BG_PATH + getVersionStr(), {type:AssetManager.TYPE_SWF,id:DEFAULT_SCENE_BG_NAME});//默认场景名称背景
			}
		}
		private function sceneCompleteHandler(evt:AssetEvent):void{
			trace("complete scene...");
			defaultResInit();
			if(this.sceneCBFun != null){
				this.sceneCBFun.apply(null,this.sceneCBArgs);
			}
		}
		private function sceneStartHandler(evt:AssetEvent):void{
			trace("start scene...");
		}
		private function sceneProgressHandler(evt:AssetProgressEvent):void{
			var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//PBE.mainClass.dispatchEvent(new RLoadEvent(RLoadEvent.PERCENT_LOADED_EVENT, per));
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- scene loaded: "+evt.bytesLoaded + " --- scene total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		public function getSceneNameMc(sceneId:String):MovieClip{
			var resObj:Asset = sceneAM.get(SCENE_NAME_RES_ID+sceneId);
			if(resObj == null){
				trace("场景名称ID："+sceneId+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("场景名称MC ID："+sceneId+" 出错！");
				return null;
			}
			return mc;
		}
		/**
		 * 获取场景BitmapData 
		 * @param sceneId 要获取的场景ID
		 * @param layer 要获取的场景层
		 * @return 
		 * 
		 */		
		public function getSceneBmdByLayer(sceneId:int,layer:int):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = sceneAM.get(SCENE_PRE_ID+sceneId);
			if(resObj == null){
				trace("场景ID："+sceneId+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(LAYER_CLASS_NAME_PRE+layer) as Class;
			if(Cls == null){
				trace("场景ID："+sceneId+" 取值 -- "+LAYER_CLASS_NAME_PRE+layer+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		/**
		 * 解析场景JSON配置文件 
		 * @param sceneId 要解析的配置文件 ID
		 */		
		public function getSceneInfoById(sceneId:int):Object{
			var jsonObj:Object;
			var jsonStr:String = sceneAM.get(JSON_BG_PRE_ID+sceneId).asset;
			jsonObj = JSON.decode(jsonStr);
			return jsonObj;
		}
		/**
		 * 解析场景JSON配置文件 
		 * @param sceneId 要解析的配置文件 ID
		 */		
		private function getSkyInfo():Object{
			var jsonObj:Object;
			var jsonStr:String = sceneAM.get(DEFAULT_SKY_CONFIG_ID).asset;
			jsonObj = JSON(jsonStr);
			return jsonObj;
		}
		/**
		 *================================================================================
		 *============= 雾气资源加载处理
		 *================================================================================
		 */		
		
		public var skyAM:AssetQueue = new AssetQueue("skyAM");//资源加载管理器
		private var skyCBFun:Function;//雾气回调函数
		private var skyCBArgs:Array;//雾气回调函数参数
		public function loadSkyRes(func:Function,args:Array = null,resize:Boolean = false):void{
			if(resize){
				return;
			}
			skyAM.purge(SKY_IMG);
			this.skyCBFun = func;
			this.skyCBArgs = args;
			skyAM.addEventListener(AssetProgressEvent.PROGRESS,skyProgressHandler);
			skyAM.addEventListener(AssetEvent.QUEUE_START,skyStartHandler);
			skyAM.addEventListener(AssetEvent.QUEUE_COMPLETE,skyCompleteHandler);
			
			var skyObj:Object = getJsonObj(DEFAULT_SKY_CONFIG_ID);
			for each (var skyInfo:Object in skyObj) 
			{
				var scene_ids:Array = skyInfo.scene_ids as Array;
				var id_index:int = scene_ids.indexOf(this.sceneId);
				if ( -1 != id_index) {
					skyAM.add(TEST_HTTP + SKY_RES_PATH + skyInfo.img_path + getVersionStr(), {type:AssetManager.TYPE_IMAGE,id:SKY_IMG});
					break;
				}
			}
		}
		private function skyCompleteHandler(evt:AssetEvent):void{
			trace("complete sky...");
			if(this.skyCBFun != null){
				this.skyCBFun.apply(null,this.skyCBArgs);
			}
		}
		private function skyStartHandler(evt:AssetEvent):void{
			trace("start sky...");
		}
		private function skyProgressHandler(evt:AssetProgressEvent):void{
			//var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- sky loaded: "+evt.bytesLoaded + " --- sky total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		public function needSky():Boolean{
			var needSky:Boolean = false;
			var skyObj:Object = getJsonObj(DEFAULT_SKY_CONFIG_ID);
			for each (var skyInfo:Object in skyObj) 
			{
				var scene_ids:Array = skyInfo.scene_ids as Array;
				var id_index:int = scene_ids.indexOf(this.sceneId);
				if ( -1 != id_index) {
					skyAM.purge(SKY_IMG);
					skyAM.add(TEST_HTTP + SKY_RES_PATH + skyInfo.img_path + getVersionStr(), {type:AssetManager.TYPE_IMAGE,id:SKY_IMG});
					needSky = true;
					break;
				}
			}
			if(needSky){
				return true;
			}else{
				return false;
			}
		}
		public function getSkyBmd():BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = skyAM.get(SKY_IMG);
			if(resObj == null){
				//trace("雾气obj："+SKY_IMG+" 出错！");
				return null;
			}
			bmd = resObj.asset;
			if(bmd == null){
				trace("雾气bmd："+SKY_IMG+"出错！");
				return null;
			}
			return bmd;
		}
		/**
		 *================================================================================
		 *============= 默认资源加载后处理
		 *================================================================================
		 */	
		private function defaultResInit():void{//默认资源初始化
			chaInfoObj = getJsonObj(DEFAULT_CHA_INFO_ID);
			chaPosObj = getJsonObj(DEFAULT_CHA_POS_ID);
			battlePosObj = getJsonObj(DEFAULT_BATTLE_POS_ID);
			blankChaObj = getJsonObj(DEFAULT_BLANK_CHA_JSON_ID);
			blankResObj = getJsonObj(DEFAULT_BLANK_RES_JSON_ID);
			blankSwitchObj = getJsonObj(DEFAULT_BLANK_RES_JSON_ID);
			
			blankChaBmd = getBmdByType(DEFAULT_BLANK_CHA_ID);
			blankResBmd = getBmdByType(DEFAULT_BLANK_RES_ID);
			blankSwitchBmd = getBmdByType(DEFAULT_BLANK_SWITCH_ID);
			sceneNameBg = getSceneNameBgMc();
		}
		public function getSceneNameBgMc():MovieClip{
			var resObj:Asset = sceneAM.get(DEFAULT_SCENE_BG_NAME);
			if(resObj == null){
				trace("默认场景名称ID："+DEFAULT_SCENE_BG_NAME+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("默认场景名称MC ID："+DEFAULT_SCENE_BG_NAME+" 出错！");
				return null;
			}
			return mc;
		}
		private function getJsonObj(resId:String):Object{
			var jsonObj:Object;
			var jsonStr:String = sceneAM.get(resId).asset;
			jsonObj = JSON.decode(jsonStr);
			if(jsonObj == null){
				trace("获取默认JSON资源："+resId+" 出错！");
			}
			return jsonObj;
		}
		private function getBmdByType(id:String):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset;
			resObj = sceneAM.get(id);
			if(resObj == null){
				trace("获取资源："+id+" -- "+" 出错！");
				return null;
			}
			var mc:MovieClip = MovieClip(resObj.asset);
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(IMG_BMD_CLS_NAME) as Class;
			if(Cls == null){
				trace("获取资源："+id+" --"+" 取值 -- "+IMG_BMD_CLS_NAME+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		public function getChaInfoByType(type:int,gemStr:String = ""):Object{
			if(chaInfoObj[String(gemStr+type)] != null){
				return chaInfoObj[String(gemStr+type)].chaAction;
			}
			return null
		}
		
		/**
		 *================================================================================
		 *============= NPC ICON加载处理
		 *================================================================================
		 */	
		
		public var npcIconAM:AssetQueue = new AssetQueue("npcIconAM");//NPC ICON加载管理器
		private var npcIconCBFun:Function;//NPC ICON回调函数
		public function loadNpcIconByType(func:Function,args:Array):void{//加载NPC图标资源
			var npcId:int = args[0];
			var npcIconType:int = args[1];
			this.npcIconCBFun = func;
			
			if(checkNpcIconRes(npcId,npcIconType)){
				npcIconCBHandler(args);
			}
			
			npcIconAM.addEventListener(AssetProgressEvent.PROGRESS,npcIconProgressHandler);
			npcIconAM.addEventListener(AssetEvent.QUEUE_START,npcIconStartHandler);
			npcIconAM.addEventListener(AssetEvent.ASSET_COMPLETE,npcIconCompleteHandler);
			
			var npcIconId:String = NPC_ICON_ID+npcId+CONN_STR+npcIconType;//拼接成NPC_ICON_ID110012_2的ID形式，加载完成后方便拆成[id,type]形式
			npcIconAM.add(TEST_HTTP + CHA_RES_PATH + NPC_ICON_FILE_NAME_PRE + npcIconType + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:npcIconId});
		}
		private function npcIconCompleteHandler(evt:AssetEvent):void{
			trace("complete npcIcon...");
			var resId:String = evt.asset.id;
			var arr:Array = idToArray(resId,NPC_ICON_ID);
			npcIconCBHandler(arr);
		}
		private function npcIconStartHandler(evt:AssetEvent):void{
			trace("start npcIcon...");
		}
		private function npcIconProgressHandler(evt:AssetProgressEvent):void{
			var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- npcIcon loaded: "+evt.bytesLoaded + " --- npcIcon total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		private function npcIconCBHandler(arr:Array):void{
			if(this.npcIconCBFun != null){
				this.npcIconCBFun.apply(null,arr);
			}
		}
		public function checkNpcIconRes(id:int,type:int):Boolean{//检查NPC ICON是否已存在
			var resObj:Asset = npcIconAM.get(NPC_ICON_ID+id+CONN_STR+type);
			if(resObj == null){
				return false;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				return false;
			}
			return true;
		}
		public function getNpcIconBmdByType(id:int,type:int):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = npcIconAM.get(NPC_ICON_ID+id+CONN_STR+type);
			if(resObj == null){
				trace("NPC ICON TYPE："+type+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(IMG_BMD_CLS_NAME) as Class;
			if(Cls == null){
				trace("NPC ICON TYPE："+type+" 取值 -- "+IMG_BMD_CLS_NAME+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		public function getNpcIconInfoByType(type:int):Object{
			var npcIconStr:String = NPC_ICON_FILE_NAME_PRE+type;
			if(chaInfoObj[npcIconStr] != null){
				return chaInfoObj[npcIconStr].chaAction;
			}
			return null
		}
		
		/**
		 *================================================================================
		 *============= NPC RES加载处理
		 *================================================================================
		 */	
		public var npcAM:AssetQueue = new AssetQueue("npcAM");//NPC RES加载管理器
		private var npcCBFun:Function;//NPC RES回调函数
		public function loadNpcResByType(func:Function,args:Array):void{//加载NPC资源
			var npcId:int = args[0];
			var npcType:int = args[1];
			this.npcCBFun = func;
			
			if(checkNpcRes(npcId,npcType)){
				npcResCBHandler(args);
			}
			
			npcAM.addEventListener(AssetProgressEvent.PROGRESS,npcProgressHandler);
			npcAM.addEventListener(AssetEvent.QUEUE_START,npcStartHandler);
			npcAM.addEventListener(AssetEvent.ASSET_COMPLETE,npcCompleteHandler);
			
			var npcResId:String = NPC_RES_ID+npcId+CONN_STR+npcType;//拼接成NPC_RES_ID110012_100007的ID形式，加载完成后方便拆成[id,type]形式
			npcAM.add(TEST_HTTP + CHA_RES_PATH + npcType + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:npcResId});
		}
		private function npcCompleteHandler(evt:AssetEvent):void{
			trace("complete npc...");
			var resId:String = evt.asset.id;
			var arr:Array = idToArray(resId,NPC_RES_ID);
			npcResCBHandler(arr);
		}
		private function npcStartHandler(evt:AssetEvent):void{
			trace("start npc...");
		}
		private function npcProgressHandler(evt:AssetProgressEvent):void{
			var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- npc loaded: "+evt.bytesLoaded + " --- npc total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		private function npcResCBHandler(arr:Array):void{
			if(this.npcCBFun != null){
				this.npcCBFun.apply(null,arr);
			}
		}
		public function checkNpcRes(id:int,type:int):Boolean{//检查NPC RES是否已存在
			var resObj:Asset = npcAM.get(NPC_RES_ID+id+CONN_STR+type);
			if(resObj == null){
				return false;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				return false;
			}
			return true;
		}
		public function getNpcResBmdByType(id:int,type:int):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = npcAM.get(NPC_RES_ID+id+CONN_STR+type);
			if(resObj == null){
				trace("NPC RES TYPE："+type+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("NPC RES resObj："+resObj+" resObj.asset-- "+resObj.asset+" 出错！");
				return null
			}
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(IMG_BMD_CLS_NAME) as Class;
			if(Cls == null){
				trace("NPC RES TYPE："+type+" 取值 -- "+IMG_BMD_CLS_NAME+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		
		/**
		 *================================================================================
		 *============= 传送门资源加载处理
		 *================================================================================
		 */	
		
		public var switchAM:AssetQueue = new AssetQueue("switchAM");//switch加载管理器
		private var switchCBFun:Function;//switch回调函数
		public function loadSwitchResByType(func:Function,args:Array):void{//加载NPC资源
			var id:int = args[0];
			var type:int = args[1];
			this.switchCBFun = func;
			
			if(checkSwitchRes(id,type)){
				switchResCBHandler(args);
			}
			
			switchAM.addEventListener(AssetProgressEvent.PROGRESS,switchProgressHandler);
			switchAM.addEventListener(AssetEvent.QUEUE_START,switchStartHandler);
			switchAM.addEventListener(AssetEvent.ASSET_COMPLETE,switchCompleteHandler);
			
			var resId:String = SWITCH_RES_ID+id+CONN_STR+type;//拼接成SWITCH_RES_ID110012_100007的ID形式，加载完成后方便拆成[id,type]形式
			switchAM.add(TEST_HTTP + CHA_RES_PATH + type + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:resId});
		}
		private function switchCompleteHandler(evt:AssetEvent):void{
			trace("complete switch...");
			var resId:String = evt.asset.id;
			var arr:Array = idToArray(resId,SWITCH_RES_ID);
			switchResCBHandler(arr);
		}
		private function switchStartHandler(evt:AssetEvent):void{
			trace("start switch...");
		}
		private function switchProgressHandler(evt:AssetProgressEvent):void{
			//var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- switch loaded: "+evt.bytesLoaded + " --- switch total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		private function switchResCBHandler(arr:Array):void{
			if(this.switchCBFun != null){
				this.switchCBFun.apply(null,arr);
			}
		}
		public function checkSwitchRes(id:int,type:int):Boolean{//检查NPC RES是否已存在
			var resObj:Asset = switchAM.get(SWITCH_RES_ID+id+CONN_STR+type);
			if(resObj == null){
				return false;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				return false;
			}
			return true;
		}
		public function getSwitchResBmdByType(id:int,type:int):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = switchAM.get(SWITCH_RES_ID+id+CONN_STR+type);
			if(resObj == null){
				trace("SWITCH RES TYPE："+type+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("SWITCH RES resObj："+resObj+" resObj.asset-- "+resObj.asset+" 出错！");
				return null
			}
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(IMG_BMD_CLS_NAME) as Class;
			if(Cls == null){
				trace("SWITCH RES TYPE："+type+" 取值 -- "+IMG_BMD_CLS_NAME+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		
		/**
		 *================================================================================
		 *============= 角色资源加载处理
		 *================================================================================
		 */	
		
		private var chaAM:AssetQueue = new AssetQueue("chaAM");//角色资源加载管理器
		private var chaCBFun:Function;//角色回调函数
		private var chaResTypArr:Array=[];//角色资源类型数组
		public function loadChaResByType(func:Function,args:Array):void{//加载NPC资源
			//var id:int = args[0];
			var type:int = args[1];
			this.chaCBFun = func;
			
			if(chaResTypArr.indexOf(type) == -1){//验证是否已在加载列表中
				chaResTypArr.push(type);
			}else{
				return;
			}
			if(checkChaRes(type)){
				chaResCBHandler(args);
			}
			
			chaAM.addEventListener(AssetProgressEvent.PROGRESS,chaProgressHandler);
			chaAM.addEventListener(AssetEvent.QUEUE_START,chaStartHandler);
			chaAM.addEventListener(AssetEvent.ASSET_COMPLETE,chaCompleteHandler);
			
			var gemStr:String = "";
			if(args.length==3){
				gemStr = RCharacterConst.GEM_STR;
			}
			var resId:String = CHA_RES_ID+gemStr+type;//拼接成CHA_RES_ID1501的ID形式，加载完成后方便拆成[id,type]形式
			chaAM.add(TEST_HTTP + CHA_RES_PATH + gemStr + type + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:resId});
		}
		private function chaCompleteHandler(evt:AssetEvent):void{
			trace("complete cha...");
			var resId:String = evt.asset.id;
			var arr:Array = chaIdToArray(resId,CHA_RES_ID);
			chaResCBHandler(arr);
		}
		private function chaStartHandler(evt:AssetEvent):void{
			trace("start cha...");
		}
		private function chaProgressHandler(evt:AssetProgressEvent):void{
			//var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- cha loaded: "+evt.bytesLoaded + " --- cha total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		private function chaResCBHandler(arr:Array):void{
			if(this.chaCBFun != null){
				this.chaCBFun.apply(null,arr);
			}
		}
		public function checkChaRes(type:int,gemStr:String=""):Boolean{//检查NPC RES是否已存在
			var resObj:Asset = chaAM.get(CHA_RES_ID+gemStr+type);
			if(resObj == null){
				return false;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				return false;
			}
			return true;
		}
		public function getChaResBmdByType(type:int,gemStr:String = ""):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = chaAM.get(CHA_RES_ID+gemStr+type);
			if(resObj == null){
				trace("CHA RES TYPE："+type+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("CHA RES resObj："+resObj+" resObj.asset-- "+resObj.asset+" 出错！");
				return null
			}
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(IMG_BMD_CLS_NAME) as Class;
			if(Cls == null){
				trace("CHA RES TYPE："+type+" 取值 -- "+IMG_BMD_CLS_NAME+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		
		/**
		 *================================================================================
		 *============= 怪物资源加载处理
		 *================================================================================
		 */	
		
		public function purgeMonsterRes():void{
			monsterAM.purge();
			monsterResTypArr.length = 0;
		}
		private var monsterAM:AssetQueue = new AssetQueue("monsterAM");//角色资源加载管理器
		private var monsterCBFun:Function;//角色回调函数
		private var monsterResTypArr:Array=[];//角色资源类型数组
		public function loadMonsterResByType(func:Function,args:Array):void{//加载NPC资源
			//var id:int = args[0];
			var type:int = args[1];
			this.monsterCBFun = func;
			
			if(monsterResTypArr.indexOf(type) == -1){//验证是否已在加载列表中
				monsterResTypArr.push(type);
			}else{
				return;
			}
			if(checkMonsterRes(type)){
				monsterResCBHandler(args);
			}
			
			monsterAM.addEventListener(AssetProgressEvent.PROGRESS,monsterProgressHandler);
			monsterAM.addEventListener(AssetEvent.QUEUE_START,monsterStartHandler);
			monsterAM.addEventListener(AssetEvent.ASSET_COMPLETE,monsterCompleteHandler);
			
			var resId:String = MONSTER_RES_ID+type;//拼接成MONSTER_RES_ID5004501的ID形式，加载完成后方便拆成[id,type]形式
			monsterAM.add(TEST_HTTP + CHA_RES_PATH + type + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:resId});
		}
		private function monsterCompleteHandler(evt:AssetEvent):void{
			trace("complete monster...");
			var resId:String = evt.asset.id;
			var arr:Array = chaIdToArray(resId,MONSTER_RES_ID);
			monsterResCBHandler(arr);
		}
		private function monsterStartHandler(evt:AssetEvent):void{
			trace("start monster...");
		}
		private function monsterProgressHandler(evt:AssetProgressEvent):void{
			//var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			//trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- monster loaded: "+evt.bytesLoaded + " --- monster total: "+evt.bytesTotal+" file: "+evt.asset);
		}
		private function monsterResCBHandler(arr:Array):void{
			if(this.monsterCBFun != null){
				this.monsterCBFun.apply(null,arr);
			}
		}
		public function checkMonsterRes(type:int):Boolean{//检查NPC RES是否已存在
			var resObj:Asset = monsterAM.get(MONSTER_RES_ID+type);
			if(resObj == null){
				return false;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				return false;
			}
			return true;
		}
		public function getMonsterResBmdByType(type:int):BitmapData{
			var bmd:BitmapData;
			var resObj:Asset = monsterAM.get(MONSTER_RES_ID+type);
			if(resObj == null){
				trace("MONSTER RES TYPE："+type+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("MONSTER RES resObj："+resObj+" resObj.asset-- "+resObj.asset+" 出错！");
				return null
			}
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(IMG_BMD_CLS_NAME) as Class;
			if(Cls == null){
				trace("MONSTER RES TYPE："+type+" 取值 -- "+IMG_BMD_CLS_NAME+" 出错！");
				return null;
			}
			bmd = new Cls();
			return bmd;
		}
		
		/**
		 *================================================================================
		 *============= 场景资源加载处理
		 *================================================================================
		 */		
		
		public var battleAM:AssetQueue = new AssetQueue("battleAM");//资源加载管理器
		private var battleCBFun:Function;//场景背景回调函数
		private var battleCBArgs:Array;//场景回调函数参数
		/**
		 * 加载战斗资源 
		 */		
		public function loadBattleRes(resArr:Array,chaArr:Array,func:Function,args:Array = null):void{
			this.battleCBFun = func;
			this.battleCBArgs = args;
			
			battleAM.addEventListener(AssetProgressEvent.PROGRESS,battleProgressHandler);
			battleAM.addEventListener(AssetEvent.QUEUE_START,battleStartHandler);
			battleAM.addEventListener(AssetEvent.QUEUE_COMPLETE,battleCompleteHandler);
			
			for each(var resId:int in resArr){
				battleAM.add(TEST_HTTP + BATTLE_RES_PATH + resId + SWF_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_SWF,id:BATTLE_RES_ID+resId});//战斗全部资源，除配置文件
				
				if(resId >= RBattleConst.BATTLE_EFFECT_MIN_ID && resId < RBattleConst.BATTLE_MONSTER_MIN_ACTION_ID){//战斗特效配置文件
					battleAM.add(TEST_HTTP + BATTLE_RES_PATH + resId + JSON_BATTLE_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:JSON_BATTLE_PRE_ID+resId});
				}
			}
			for each(var vo:RBattleInitChaVo in chaArr){//战斗攻击动作配置文件550,560
				var attackNormalId:String = String(vo.chaProfessionType)+RBattleConst.ID_ATTACK_NORMAL;
				var attackSkillId:String = String(vo.chaProfessionType)+RBattleConst.ID_ATTACK_SKILL;
				battleAM.add(TEST_HTTP + BATTLE_RES_PATH + attackNormalId + JSON_BATTLE_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:JSON_BATTLE_PRE_ID+attackNormalId});
				battleAM.add(TEST_HTTP + BATTLE_RES_PATH + attackSkillId + JSON_BATTLE_EXTENSION_NAME + getVersionStr(), {type:AssetManager.TYPE_BINARY,id:JSON_BATTLE_PRE_ID+attackSkillId});
			}
		}
		private function battleCompleteHandler(evt:AssetEvent):void{
			trace("complete battle...");
			GuidEventCenter.getInstance().dispatchEvent(new SwitchMaskEvent(SwitchMaskEvent.SwitchMaskEvent_HIDE));
			if(this.battleCBFun != null){
				this.battleCBFun.apply(null,this.battleCBArgs);
			}
		}
		private function battleStartHandler(evt:AssetEvent):void{
			trace("start battle...");
		}
		private function battleProgressHandler(evt:AssetProgressEvent):void{
			var per:Number = int(evt.bytesLoaded/evt.bytesTotal*100)*0.01;
			var currentCount:int = (evt.target as AssetQueue).assetsLoaded+1;
			var totalCount:int = (evt.target as AssetQueue).assetsTotal;
			var countRate:String = currentCount+"/"+totalCount;
			//PBE.mainClass.dispatchEvent(new RLoadEvent(RLoadEvent.PERCENT_BATTLE_LOADED_EVENT,per,countRate));
			/*trace(countRate+" ----------------");
			trace((evt.target as AssetQueue).assetsLoaded+"/"+(evt.target as AssetQueue).assetsTotal+"--- battle loaded: "+evt.bytesLoaded + " --- battle total: "+evt.bytesTotal+" file: "+evt.asset);*/
		}
		/**
		 * 获取战斗MC资源 
		 * @param resId
		 * @param clsName
		 * @param defaultLoaded 资源是否已在初始时默认加载，如ring,mask等
		 * @return 
		 * 
		 */		
		public function getBattleResMc(resId:*,clsName:String,defaultLoaded:Boolean=false):MovieClip{
			var resMc:MovieClip;
			var resObj:Asset;
			if(defaultLoaded == false){
				resId = BATTLE_RES_ID+resId;
				resObj = battleAM.get(resId);
			}else{
				resObj = sceneAM.get(resId);
			}
			
			if(resObj == null){
				trace("BATTLE RES TYPE："+resId+" 出错！");
				return null;
			}
			var mc:MovieClip = resObj.asset;
			if(mc == null){
				trace("BATTLE RES resObj："+resObj+" resObj.asset-- "+resObj.asset+" 出错！");
				return null
			}
			var Cls:Class = mc.loaderInfo.applicationDomain.getDefinition(clsName) as Class;
			if(Cls == null){
				trace("BATTLE RES TYPE："+resId+" 取值 -- "+clsName+" 出错！");
				return null;
			}
			resMc = new Cls();
			return resMc;
		}
		/**
		 * 解析战斗JSON配置文件 
		 * @param sceneId 要解析的配置文件 ID
		 */		
		public function getBattleInfoById(id:int):Object{
			var jsonObj:Object;
			if(battleAM.get(JSON_BATTLE_PRE_ID+id) == null){
				trace("不存在资源："+JSON_BATTLE_PRE_ID+id);
				return null;
			}
			var jsonStr:String = battleAM.get(JSON_BATTLE_PRE_ID+id).asset;
			jsonObj = JSON.decode(jsonStr);
			return jsonObj;
		}
	}
}
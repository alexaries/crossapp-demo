package wordscene {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import model.SceneData;
	import proto.battle.battle703.FightResponse;
	import sceneModule.event.NSceneEvent;
	import sceneModule.model.rvo.RNpcVo;
	import sceneModule.model.SceneMessage;
	import sceneModule.rcommand.revent.RCharacterEvent;
	import sceneModule.rcommand.revent.RNpcEvent;
	import sceneModule.rcommand.revent.RSceneEvent;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.task.command.TaskMessage;
	import util.Logging;
	import wordscene.event.PlusEvent;
	import wordscene.helper.Earthquake;
	import wordscene.helper.FindPathPlus;
	import wordscene.helper.QHitTestManager;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class WordSceneSprite extends Sprite {
		private static var _instance:WordSceneSprite;
		//马赛克地图缩放率
		public static const TILE_SCALE:int = 6;
		//阻挡格子大小
		public static const GRID_SIZE:int = 32;
		//大地图分块大小
		public static const MAP_TITL_SIZE:int = 256;
		//激活trip点的距离
		public static const TRIP_AREA:int = 2;
		//玩家移动速度
		public static const MOVE_LINE_DES:int = 4;
		public static var MOVE_Oblique_DES:int;
		//3*3间距
		public static const MATRIXS_DES_X:int = 22;
		public static const MATRIXS_DES_Y:int = 22;
		//把方向转换矩阵
		public static var CHANGEPOS_MATRIX:Vector.<Matrix>;
		
		public static const MAP_MOVE_SPEED:int = 5;
		//地图夸大范围
		public static const MAP_EXPORT_SIZE:int = 1;
		//刷新层级关系时间
		public static const REFRESH_CHILD_INDEX_TIME:int = 2000;
		//长按鼠标间隔时间
		public static const LONG_PRESS_TIME:int = 1000;
		//frame time
		public static const FRAME_TIME:int = 21;
		//frame map speed
		public static var FRAME_MAP_SPEED:Number;
		
		//自身名字颜色
		public static const HEARO_SELF_COLOR:uint = 0x00C801
		//其他名字颜色
		public static const HEARO_NAME_COLOR:uint = 0x0076C8;
		//NPC名字颜色
		public static const NPC_NAME_COLOR:int = 0xFFFFFF;
		//战斗自身名字颜色
		public static const FIGHT_NAME_COLOR:int = 0x00FFFF;
		//怪物
		public static const FIGHT_MONSTER_NAME:int = 0xC80000;
		
		//物品tips
		private var _itemtips:MainMenuEquipmentTooltip;
		
		private var _mapContain:Sprite;
		private var _bgSp:SceneBgSprite;
		private var _playerCoutainSp:PlayerContainSprite;
		private var _fightSceneSp:FightSceneSprite;
		
		private var _sceneID:int;
		private var _entityData:SceneData;
		private var _npcData:Array;
		private var _switchData:Array;
		private var _pathTool:FindPathPlus;
		private var _pathinfo:Array;
		
		private var _longpressMoveTimer:Timer;
		private var _islongpressing:Boolean;
		
		private var _curCenterX:int;
		private var _curCenterY:int;
		private var _curScreenW:int;
		private var _curScreenH:int;
		private var _showPlayerInfoFlag:Boolean;
		private var _frameTime:int;
		
		public static function getInstance():WordSceneSprite {
			if (null == _instance) {
				_instance = new WordSceneSprite();
			}
			return _instance;
		}
		
		public function WordSceneSprite() {
			MOVE_Oblique_DES = Math.round(MOVE_LINE_DES / 1.4142135623730951);
			FRAME_MAP_SPEED = Number(WordSceneSprite.FRAME_TIME) / WordSceneSprite.MAP_MOVE_SPEED;
			CHANGEPOS_MATRIX = new Vector.<Matrix>();
			for (var i:int = 0; i < 8; i++) {
				var m:Matrix = new Matrix();
				m.rotate(Math.PI / 180 * (i * 45 - 45));
				CHANGEPOS_MATRIX[i] = m;
			}
			CHANGEPOS_MATRIX[8] = CHANGEPOS_MATRIX[0];
			
			if (null == stage) {
				this.addEventListener(Event.ADDED_TO_STAGE, addToStage);
			} else {
				addToStage();
			}
			
			_islongpressing = false;
			_entityData = new SceneData();
			_npcData = [];
			_switchData = [];
			
			_longpressMoveTimer = new Timer(LONG_PRESS_TIME);
			_longpressMoveTimer.addEventListener(TimerEvent.TIMER, onLongPress);
			
			_bgSp = new SceneBgSprite();
			this.addChild(_bgSp);
			
			_mapContain = new Sprite();
			this.addChild(_mapContain);
			
			_playerCoutainSp = new PlayerContainSprite();
			_mapContain.addChild(_playerCoutainSp);
			
			_fightSceneSp = new FightSceneSprite();
			this.addChild(_fightSceneSp);
		}
		
		private function addToStage(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, addToStage);
			Logging.init(this);
			QHitTestManager.getInstance().init(this.stage);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onSceneMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, onSceneMouseUp);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(Event.RESIZE, resize);
		}
		
		private function resize(e:Event):void {
			setWordCenter(new Point(-_bgSp.x, -_bgSp.y), true);
		}
		
		private function resetDefaultTag():void {
			_curCenterX = 1;
			_curCenterY = 1;
			_curScreenW = 0;
			_curScreenH = 0;
		}
		
		//鼠标点击处理
		private function stageClick(e:MouseEvent):void {
			Logging.log("\n\n\n\n\n\nclick pare");
			var par:DisplayObjectContainer = e.target as DisplayObjectContainer;
			while (null != par) {
				Logging.log(par, par.name);
				par = par.parent;
			}
			Logging.log("end click pare\n\n\n\n\n\n");
		}
		
		
		private function onSceneMouseDown(e:MouseEvent):void {
			_islongpressing = false;
			_longpressMoveTimer.start();
		}
		
		
		private function onSceneMouseUp(e:MouseEvent):void {
			if (_islongpressing) {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onSceneMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, onSceneMouseUp);
			} else {
				_islongpressing = false;
				_longpressMoveTimer.stop();
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, onSceneMouseDown);
				stage.removeEventListener(MouseEvent.MOUSE_UP, onSceneMouseUp);
				moveHearo();
			}
			TaskMessage.getInstance().clear_find_path();
		}
		
		private function onLongPress(e:TimerEvent):void {
			_islongpressing = true;
			moveHearo(-1, -1);
		}
		
		//调用playercontain和mapcontain的步进函数
		private function enterFrame(e:Event):void {
			var now:int = getTimer();
			var detention:int;
			if (0 == _frameTime) {
				detention = FRAME_TIME;
			} else {
				detention = now - _frameTime;
			}
			_frameTime = now;
			_playerCoutainSp.enterFrame(detention);
		}
		
		
		//进入场景,开始加载场景素材
		public function enterScene(id:int):void {
			//加载完成资源,并初始化完成场景
			Logging.log("进入场景", id);
			SAssetManager.getInstance().loadRes(id, sceneLoaded, [id]);
		}
		
		//处理服务器的场景实体更新消息
		public function upDataEntityProperty():void {
			_playerCoutainSp.checkEntityProperty(_entityData.entitys);
		}
		
		//删除场景实体
		public function removeChar(id:int):void {
			_entityData.rm_entity(id);
			_playerCoutainSp.removeChar(id);
		}
		
		//移动主角
		public function moveHearo(tx:int = -1, ty:int = -1):void {
			if (null == _playerCoutainSp) {
				return;
			}
			if (null == _playerCoutainSp.hearo) {
				return;
			}
			if (_fightSceneSp.isfighting) {
				return;
			}
			if (-1 == tx) {
				tx = _mapContain.mouseX;
				ty = _mapContain.mouseY;
			}
			
			_bgSp.showMoveEff(tx, ty);
			
			_playerCoutainSp.hearo.setTarget(new Point(tx, ty));
			var isclearnearfunc:Boolean = !_playerCoutainSp.hearo.isTargetEqueNear();
			if (isclearnearfunc) {
				_playerCoutainSp.hearo.clearNearFunc();
			}
			SceneMessage.getInstance().dispatchEvent(new NSceneEvent(NSceneEvent.NSceneEvent_HEARO_MOVE, {x: tx, y: ty}));
			if (_showPlayerInfoFlag) {
				_showPlayerInfoFlag = false;
			} else {
				this.dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_HIDE_PLAYER_INFO));
			}
		}
		
		
		//实体聊天头顶显示
		public function say(id:int, str:String):void {
			_playerCoutainSp.say(id, str);
		}
		
		
		//进入战斗
		public function enterFight(vo:FightResponse):void {
			_fightSceneSp.enterFight(vo);
		}
		
		//更新地图中心函数
		public function setWordCenter(p:Point, force:Boolean = false):void {
			var sw:int = this.stage.stageWidth;
			var sh:int = this.stage.stageHeight;
			if (p.x == _curCenterX && p.y == _curCenterY && sw == _curScreenW && sh == _curScreenH) {
				return;
			}
			var tx:int = -p.x + sw / 2;
			var ty:int = -p.y + sh / 2;
			tx = Math.min(0, tx);
			ty = Math.min(0, ty);
			tx = Math.max(this.stage.stageWidth - _bgSp.mapw, tx);
			ty = Math.max(this.stage.stageHeight - _bgSp.maph, ty);
			_curCenterX = p.x;
			_curCenterY = p.y;
			_curScreenW = sw;
			_curScreenH = sh;
			_bgSp.setCenter(-tx, -ty, force);
		}
		
		//显示场景实体,用于战斗结束
		public function showPlayerSprite():void {
			if (null == _playerCoutainSp.parent) {
				_mapContain.addChild(_playerCoutainSp);
			}
		}
		
		//移出场景实体,用于战斗开始
		public function rmPlayerSprite():void {
			if (null != _playerCoutainSp.parent) {
				_playerCoutainSp.parent.removeChild(_playerCoutainSp);
			}
		}
		
		//移动到指定的Trip点
		public function gotoTrip(id:int):void {
			var pos:Vector.<int> = _bgSp.getTripPos(id);
			moveHearo(pos[0], pos[1]);
		}
		
		//移动到指定npc
		public function gotoNPC(id:int):void {
			var d:RNpcVo = _playerCoutainSp.getNPCVo(id);
			if (null == d) {
				Logging.log("未找到要接近的npc", id);
				return;
			}
			_playerCoutainSp.hearo.setNearFunc(
				new Point(d.position.x, d.position.y), 
				WordSceneSprite.getInstance().dispatchEvent, 
				[new RCharacterEvent(RCharacterEvent.CHAT_WITH_NPC_EVENT, d.id, d.name, d.functionType)]
			);
			moveHearo(d.position.x, d.position.y);
		}
		
		//更新npc人物状态
		public function updataNPCState(entitys:Array):void {
			_playerCoutainSp.updataNPCState(entitys);
		}
		
		//震屏
		public function shock():void {
			Earthquake.go(this, 10, 0.3);
		}
		
		private function clear():void {
			_entityData.clear_entity();
			_bgSp.clear();
			_playerCoutainSp.clear();
		}
		
		//场景素材加载完成
		private function sceneLoaded(id:int):void {
			clear();
			_showPlayerInfoFlag = false;
			resetDefaultTag();
			
			_sceneID = id;
			
			showPlayerSprite();
			_fightSceneSp.resetWhenEnterScene();
			
			var txtinfo:String = SAssetManager.getInstance().getText(SAssetManager.ASSET_SCENE_ID + _sceneID, 'path');
			var linestxt:Array = txtinfo.split(',');
			var linelen:int = linestxt.length;
			_pathinfo = [];
			for (var i:int = 0; i < linelen; i++) {
				var curlinetxt:String = linestxt[i] as String;
				var pointtxt:Array = curlinetxt.split('-');
				var pointlen:int = pointtxt.length;
				var pointsline:Array = [];
				for (var j:int = 0; j < pointlen; j++) {
					pointsline.push(int(pointtxt[j]));
				}
				_pathinfo.push(pointsline);
			}
			_pathTool = new FindPathPlus(_pathinfo);
			_bgSp.resetScene(_sceneID);
			
			_playerCoutainSp.addNpcs(_npcData);
			_bgSp.addTrips(_switchData);
			
			this.dispatchEvent(new RSceneEvent(RSceneEvent.SCENE_INIT_COMPLETED_EVENT));
			this.dispatchEvent(new RNpcEvent(RNpcEvent.ALL_NPC_CREATED_EVENT));
		}
		
		public function get sceneID():int {
			return _sceneID;
		}
		
		public function get entityData():SceneData {
			return _entityData;
		}
		
		public function get pathTool():FindPathPlus {
			return _pathTool;
		}
		
		public function set npcData(value:Array):void {
			_npcData = value;
		}
		
		public function set switchData(value:Array):void {
			_switchData = value;
		}
		
		public function get playerCoutainSp():PlayerContainSprite {
			return _playerCoutainSp;
		}
		
		public function get fightSceneSp():FightSceneSprite {
			return _fightSceneSp;
		}
		
		public function get bgSp():SceneBgSprite {
			return _bgSp;
		}
		
		public function get showPlayerInfoFlag():Boolean {
			return _showPlayerInfoFlag;
		}
		
		public function set showPlayerInfoFlag(value:Boolean):void {
			_showPlayerInfoFlag = value;
		}
		
		public function get mapContain():Sprite {
			return _mapContain;
		}
		
		public function get pathinfo():Array {
			return _pathinfo;
		}
		
		public function get itemtips():MainMenuEquipmentTooltip {
			return _itemtips;
		}
		
		public function set itemtips(value:MainMenuEquipmentTooltip):void {
			_itemtips = value;
		}
	
	}

}
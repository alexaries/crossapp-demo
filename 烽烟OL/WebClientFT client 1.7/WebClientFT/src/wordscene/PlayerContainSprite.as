package wordscene {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import proto.task.task1408.NPCQuestStatus;
	import sceneModule.model.rvo.RNpcVo;
	import sceneModule.model.rvo.RUpdateCharacterVo;
	import sceneModule.rcommand.revent.RCharacterEvent;
	import sceneModule.rcommand.revent.RMonsterEvent;
	import sceneModule.rcommand.revent.RMousePosEvent;
	import sceneModule.view.task.command.TaskMessage;
	import util.HashMap;
	import wordscene.entity.EntitySprite;
	import wordscene.helper.QHitTestManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class PlayerContainSprite extends Sprite {
		//实体键值对
		private var _vcharterMap:HashMap;
		//实体数组
		private var _entitys:Vector.<EntitySprite>;
		//待检测碰撞怪物
		private var _vmonsters:Vector.<EntitySprite>;
		//主角实体
		private var _hearo:EntitySprite;
		//当前碰撞怪物id
		private var _fightMonsterID:int;
		//层级刷新累计时间
		private var _refreshIndexTime:int;
		
		public function PlayerContainSprite() {
			_fightMonsterID = -1;
			_refreshIndexTime = 0;
			_vcharterMap = new HashMap();
			_entitys = new Vector.<EntitySprite>();
			_vmonsters = new Vector.<EntitySprite>();
			this.mouseEnabled = false;
		}
		
		//层级排序函数
		private function posSort(tx:EntitySprite, ty:EntitySprite):Number {
			return tx.y - ty.y;
		}
		
		//步进函数
		public function enterFrame(detention:int):void {
			if (null == this.stage) {
				return;
			}
			var isrefreshindex:Boolean = false;
			_refreshIndexTime += detention;
			if (_refreshIndexTime >= WordSceneSprite.REFRESH_CHILD_INDEX_TIME) {
				_entitys.sort(posSort);
				isrefreshindex = true;
				_refreshIndexTime = 0;
			}
			_vmonsters.length = 0;
			var ishearomov:Boolean = false;
			for (var i:int = _entitys.length - 1; i > -1; i--) {
				var curv:EntitySprite = _entitys[i];
				if (isrefreshindex) {
					if (this.getChildIndex(curv) != i) {
						this.setChildIndex(curv, i);
					}
				}
				var curd:RUpdateCharacterVo = curv._hearoVo;
				if (null != curd) {
					if (2 == curd.chaType) {
						_vmonsters.push(curv);
					}
					//只有这些实体移动
					var oldx:int = curv.x;
					var oldy:int = curv.y;
					curv.move(detention);
					if (curd.isMySelf) {
						if (oldx != curv.x || oldy != curv.y) {
							ishearomov = true;
						} else {
							continue;
						}
						WordSceneSprite.getInstance().setWordCenter(new Point(curv.x, curv.y));
						var isfind:Boolean = WordSceneSprite.getInstance().bgSp.checkTrip(_hearo.x, _hearo.y);
						if (isfind) {
							_hearo.stopMove();
						}
					}
				}
			}
			if (-1 != _fightMonsterID || !ishearomov) {
				return;
			}
			var vmonsterlen:int = _vmonsters.length;
			for (var j:int = _vmonsters.length - 1; j > -1; j--) {
				var tv:EntitySprite = _vmonsters[j];
				var td:RUpdateCharacterVo = tv.hearoVo;
				var isxok:Boolean = Math.abs(tv.x - _hearo.x) < WordSceneSprite.GRID_SIZE * 3;
				var isyok:Boolean = Math.abs(tv.y - _hearo.y) < WordSceneSprite.GRID_SIZE * 3;
				if (isxok && isyok) {
					if (td.campid != _hearo._hearoVo.campid) {
						_fightMonsterID = td.id;
						_hearo.stopMove();
						WordSceneSprite.getInstance().dispatchEvent(new RMonsterEvent(RMonsterEvent.NORMAL_MONSTER_EVENT, td.id));
						break;
					}
				}
			}
		
		}
		
		//检测更新实体属性
		public function checkEntityProperty(entitys:Array):void {
			var len:int = entitys.length;
			for (var i:int = 0; i < len; i++) {
				var d:RUpdateCharacterVo = entitys[i] as RUpdateCharacterVo;
				var v:EntitySprite;
				if (_vcharterMap.containsKey(d.id)) {
					v = _vcharterMap.get(d.id);
					v.setHp(d.curHp, d.maxHp);
					if (v.resid != d.professionType) {
						v.resetRes(d.professionType, true);
					}
					if (!d.isMySelf) {
						v.setTarget(d.position);
					}
				} else {
					v = new EntitySprite(d.position.x, d.position.y, EntitySprite.TYPE_HEARO, d);
					v.setName(d.name);
					v.setHp(d.curHp, d.maxHp);
					this.addChild(v);
					QHitTestManager.getInstance().register(v);
					v.addEventListener(QHitTestManager.Q_MOUSE_DOWN, onPlayerClick);
					_vcharterMap.put(d.id, v);
					_entitys.push(v);
					if (d.isMySelf) {
						_hearo = v;
						WordSceneSprite.getInstance().setWordCenter(new Point(v.x, v.y), true);
						TaskMessage.getInstance().find_path();
					}
				}
			}
		}
		
		//添加npc实体
		public function addNpcs(entitys:Array):void {
			var len:int = entitys.length;
			for (var i:int = 0; i < len; i++) {
				var d:RNpcVo = entitys[i] as RNpcVo;
				var v:EntitySprite = new EntitySprite(d.position.x, d.position.y, EntitySprite.TYPE_NPC, d);
				v.setName(d.name);
				v.setNpcHeadType(d.functionType);
				WordSceneSprite.getInstance().bgSp.npcContain.addChild(v);
				QHitTestManager.getInstance().register(v);
				v.addEventListener(QHitTestManager.Q_MOUSE_DOWN, onNpcClick);
				_vcharterMap.put(d.id, v);
			}
		}
		
		//更新npc任务状态
		public function updataNPCState(entitys:Array):void {
			var len:int = entitys.length;
			for (var i:int = 0; i < len; i++) {
				var d:NPCQuestStatus = entitys[i] as NPCQuestStatus;
				var v:EntitySprite = _vcharterMap.get(d.npcID);
				if (null != v) {
					v.setNPCHeadState(d.statu);
				}
			}
		}
		
		//实体头顶说话
		public function say(id:int, str:String):void {
			var v:EntitySprite = _vcharterMap.get(id);
			if (null != v) {
				v.say(str);
			}
		}
		
		//重置战斗monster id
		public function resetFightMonsterID():void {
			_fightMonsterID = -1;
		}
		
		//删除实体
		public function removeChar(id:int):void {
			var v:EntitySprite = _vcharterMap.remove(id);
			var index:int = _entitys.indexOf(v);
			if (-1 != index) {
				_entitys.splice(index, 1);
			}
			if (null != v) {
				var curd:RUpdateCharacterVo = v.vo as RUpdateCharacterVo;
				if (curd) {
					if (2 == curd.chaType) {
						if (curd.id == _fightMonsterID) {
							_fightMonsterID = -1;
						}
					}
				}
				v.removeEventListener(QHitTestManager.Q_MOUSE_DOWN, onNpcClick);
				v.removeEventListener(QHitTestManager.Q_MOUSE_DOWN, onPlayerClick);
				QHitTestManager.getInstance().unregister(v);
				if (v.parent) {
					v.parent.removeChild(v);
					v.clear();
				}
			}
		}
		
		public function clear():void {
			while (this.numChildren > 0) {
				var v:EntitySprite = this.removeChildAt(0) as EntitySprite;
				v.removeEventListener(QHitTestManager.Q_MOUSE_DOWN, onNpcClick);
				v.removeEventListener(QHitTestManager.Q_MOUSE_DOWN, onPlayerClick);
				v.clear();
			}
			while (WordSceneSprite.getInstance().bgSp.npcContain.numChildren > 0) {
				var npcv:EntitySprite = WordSceneSprite.getInstance().bgSp.npcContain.removeChildAt(0) as EntitySprite;
				npcv.removeEventListener(QHitTestManager.Q_MOUSE_DOWN, onNpcClick);
				npcv.removeEventListener(QHitTestManager.Q_MOUSE_DOWN, onPlayerClick);
				npcv.clear();
			}
			_fightMonsterID = -1;
			_vcharterMap.clear();
			_entitys.length = 0;
			_hearo = null;
		}
		
		//获取npc数据
		public function getNPCVo(id:int):RNpcVo {
			var v:EntitySprite = _vcharterMap.get(id);
			if (null == v) {
				return null;
			}
			return v.vo as RNpcVo;
		}
		
		//实体被点击
		private function onPlayerClick(e:Event):void {
			var v:EntitySprite = e.currentTarget as EntitySprite;
			var d:RUpdateCharacterVo = v._hearoVo;
			if (d.isMySelf) {
				return;
			}
			WordSceneSprite.getInstance().showPlayerInfoFlag = true;
			WordSceneSprite.getInstance().dispatchEvent(
				new RMousePosEvent(
					RMousePosEvent.MOUSE_SELECTED_EVENT, 
					d.id, 
					d.name, 
					d.chaType, 
					d.trueProfessionType, 
					d.masterId, 
					d.chaLevel,
					d.vipLevel, 
					d.campid
				)
			);
		}
		
		//npc被点击
		private function onNpcClick(e:Event):void {
			var v:EntitySprite = e.currentTarget as EntitySprite;
			var d:RNpcVo = v.npcVo;
			_hearo.setNearFunc(
				new Point(
					WordSceneSprite.getInstance().mapContain.mouseX, 
					WordSceneSprite.getInstance().mapContain.mouseY
				),
				WordSceneSprite.getInstance().dispatchEvent, 
				[new RCharacterEvent(RCharacterEvent.CHAT_WITH_NPC_EVENT, d.id, d.name, d.functionType)]
			);
		}
		
		
		public function get hearo():EntitySprite {
			return _hearo;
		}
	}

}
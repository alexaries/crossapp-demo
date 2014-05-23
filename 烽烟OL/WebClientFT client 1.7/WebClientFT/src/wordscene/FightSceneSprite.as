package wordscene 
{
	import adobe.utils.CustomActions;
	import com.greensock.TweenLite;
	import event.GuidEventCenter;
	import event.SwitchMaskEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import managers.WindowManager;
	import model.SystemDataModel;
	import mx.utils.HashUtil;
	import proto.battle.battle703.EnemyArray;
	import proto.battle.battle703.FightData;
	import proto.battle.battle703.FightResponse;
	import proto.battle.battle703.InitBattleData;
	import sceneModule.rcommand.revent.RBattleRoundEvent;
	import sceneModule.view.battle.event.BattleFlipEvent;
	import sceneModule.view.pata.view.PanPaWindow;
	import util.DelayExcuter;
	import util.HashMap;
	import util.Logging;
	import wordscene.entity.FightEntitySprite;
	import wordscene.event.PlusEvent;
	import wordscene.fight.FightAction;
	import wordscene.fight.FightActionGroup;
	import wordscene.fight.ui.FightHPBarView;
	import wordscene.loader.EffectSp;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightSceneSprite extends Sprite 
	{
		//双方阵营x分界线
		public static const SIDE_LINE:int = 550;
		//角色移动时间
		public static const CHAR_MOVE_TIME:int = 500;
		//角色攻击动作触发时间
		public static const CHAR_ATTACKACTION_TIME:int = 700;
		//角色被攻击动作时间
		public static const CHAR_ATTACKED_TIME:int = 700;
		//攻击结果显示时间
		public static const ATTACKRESULT_TIME:int = 300;
		//角色死亡动作触发时间
		public static const CHAR_DEATH_TIME:int = 100;
		//回合停留时间
		public static const ROUND_DELAY_TIME:int = 800;
		//添加buf时间
		public static const CHAR_ADDBUFF_TIME:int = 100;
		//删除角色时间
		public static const REMOVE_CHAR_TIME:int = 300;
		//更改power时间
		public static const CHANGE_POWER_TIME:int = 1;
		
		//遮挡层
		private var _maskSprite:Sprite;
		//战斗层背景
		private var _fightBgImg:Bitmap;
		//实体层
		private var _entityContainSprite:Sprite;
		//群攻特效层
		private var _grounpEffContainSprite:Sprite;
		//ui层
		private var _uisprite:FightUISprite;
		
		private var _isfighting:Boolean;
		private var _roundNo:int;
		private var _isroundDelayBlock:Boolean;
		
		private var _vo:FightResponse;
		//战斗实体键值对
		private var _entityMap:HashMap;
		//战斗动作
		private var _actionGroup:FightActionGroup;
		
		public function FightSceneSprite() 
		{
			_isfighting = false;
			_entityMap = new HashMap();
			_actionGroup = new FightActionGroup();
			
			_maskSprite = new Sprite();
			this.addChild(_maskSprite);
			
			_fightBgImg = new Bitmap();
			this.addChild(_fightBgImg);
			
			_entityContainSprite = new Sprite();
			this.addChild(_entityContainSprite);
			
			_grounpEffContainSprite = new Sprite();
			_grounpEffContainSprite.mouseEnabled = false;
			_grounpEffContainSprite.mouseChildren = false;
			this.addChild(_grounpEffContainSprite);
			
			_uisprite = new FightUISprite();
			this.addChild(_uisprite);
			
			if (stage) {
				addToStage();
			}
			else {
				addEventListener(Event.ADDED_TO_STAGE, addToStage);
			}
		}
		
		private function addToStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStage);
			stage.addEventListener(Event.RESIZE, resize);
		}
		
		private function resize(e:Event):void 
		{
			if (_isfighting) {
				showMask();
			}
		}
		
		//进入战斗
		public function enterFight(vo:FightResponse):void {
			Logging.log("enter fight in view");
			_isfighting = true;
			_vo = vo;
			_roundNo = 0;
			_entityMap.clear();
			_actionGroup.clear();
			//隐藏玩家层
			WordSceneSprite.getInstance().rmPlayerSprite();
			//初始化战斗遮挡
			showMask();
			//初始化战斗角色
			initEntitys();
			//设置标识
			SystemDataModel.isBattleStatusFlag = true;
			GuidEventCenter.getInstance().dispatchEvent(new SwitchMaskEvent(SwitchMaskEvent.SwitchMaskEvent_HIDE, maskHideOver));
		}
		
		//绘制遮罩
		private function showMask():void {
			_maskSprite.graphics.clear();
			_maskSprite.graphics.beginFill(0x0, 0.4);
			_maskSprite.graphics.drawRect(-20, -20, stage.stageWidth + 20, stage.stageHeight + 20);
			_maskSprite.graphics.endFill();
			
			_fightBgImg.bitmapData = SAssetManager.getInstance().getBitmapData('default', 'fightbg');
		}
		
		//清理遮罩
		private function clearMask():void {
			_maskSprite.graphics.clear();
			_fightBgImg.bitmapData = null;
		}
		
		//战斗实体层级排序
		private function sortpos(a:InitBattleData, b:InitBattleData):Number {
			return a.chaPos[1] - b.chaPos[1];
		}
		
		//初始化战斗实体
		public function initEntitys():void {
			var chars:Array = _vo.data.startData;
			chars = chars.sort(sortpos);
			var len:int = chars.length;
			for (var i:int = 0; i < len; i++) 
			{
				var d:InitBattleData = chars[i] as InitBattleData;
				var v:FightEntitySprite = new FightEntitySprite(d);
				var direct:int = 1;
				if (1 == d.chaDirection) {
					//向右
				}
				else {
					direct = 5;
				}
				v.enititySprite.playAction(SAssetManager.HEARO_ACTION_arise, direct);
				v.enititySprite.setName(d.chaName);
				v.x = d.chaPos[0];
				v.y = d.chaPos[1];
				v.addEventListener(FightEntitySprite.EVENT_MOUSE_OVER, charMouseOver);
				v.addEventListener(FightEntitySprite.EVENT_MOUSE_OUT, charMouseOut);
				v.resetPos();
				_entityMap.put(d.chaBattleId, v);
				_entityContainSprite.addChild(v);
				Logging.log("初始化战斗实体");
			}
			_uisprite.showHeads(chars);
		}
		
		//解析回合数据
		public function pareRound():void {
			Logging.log("解析回合数据");
			_roundNo++;
			_isroundDelayBlock = false;
			var rounds:Array = _vo.data.stepData;
			if (rounds.length > 0) {
				//有剩余的回合
				var roundVo:FightData = rounds.shift();
				var action:FightAction;
				var fatherID:int = -1;
				
				//判断是否是buf回合
				if (-1 == roundVo.chaBattleId) {
					//buf回合
				}
				else {
					if (1 == roundVo.chaAttackType) {
						//近程攻击,添加移动动作
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Move;
						action.arg1 = roundVo.chaBattleId;
						action.arg2 = roundVo.chaTargetPos[0];
						action.arg3 = roundVo.chaTargetPos[1];
						action.arg4 = CHAR_MOVE_TIME;
						_actionGroup.addAction(action);
					}
					
					//添加攻击动作
					if (null != action) {
						fatherID = action.id;
					}
					action = new FightAction();
					action.fatherID = fatherID;
					action.actionType = FightAction.Action_Type_Char_Action;
					action.arg1 = roundVo.chaBattleId;
					if (0 == roundVo.actionId) {
						//普通
						action.arg2 = SAssetManager.HEARO_ACTION_physicalattack;
					}
					else {
						//魔法
						action.arg2 = SAssetManager.HEARO_ACTION_magicattack;
					}
					action.arg3 = CHAR_ATTACKACTION_TIME;
					_actionGroup.addAction(action);
					
					//添加power变化
					action = new FightAction();
					action.fatherID = fatherID;
					action.actionType = FightAction.Action_Type_MP_DEC;
					action.arg1 = roundVo.chaBattleId;
					action.arg4 = roundVo.chaCurrentPower;
					action.arg5 = roundVo.chaTotalPower;
					_actionGroup.addAction(action);
					
					
					
					if (0 != roundVo.chaEffectId) {
						//有1号特效
						fatherID = action.id;
						//添加角色攻击特效
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Skill_Eff_Single;
						action.arg1 = roundVo.chaBattleId;
						action.arg2 = SAssetManager.ASSET_EFFECT_ID + 1000;
						_actionGroup.addAction(action);
						
						fatherID = action.id;
					}
				}
				
				var isgroupeff:Boolean = 0 != roundVo.chaAoeEffectId;
				if (isgroupeff) {
					//添加区域攻击特效
					action = new FightAction();
					action.fatherID = fatherID;
					action.actionType = FightAction.Action_Type_Skill_Eff_Group;
					var tem:EnemyArray = roundVo.enemyChaArr[0] as EnemyArray;
					var targetpos:Array;
					if (tem.enemyStartPos[0] < SIDE_LINE) {
						//己方
						targetpos = [100, 400];
					}
					else {
						targetpos = [600, 400];
					}
					action.arg1 = targetpos;
					action.arg2 = SAssetManager.ASSET_EFFECT_ID + 1002;
					_actionGroup.addAction(action);
					
					fatherID = action.id;
				}
				
				pareAttackedEntitys(roundVo, roundVo.enemyChaArr, fatherID, !isgroupeff);
				
				//开始播放动作
				showAction();
			}
			else {
				//没有剩余的回合
				showFightRes();
			}
		}
		
		public function clear():void {
			_isfighting = false;
			_vo = null;
			_entityMap.clear();
			_actionGroup.clear();
			clearEntitys();
			_uisprite.clear();
			WordSceneSprite.getInstance().showPlayerSprite();
		}
		
		private function clearEntitys():void {
			while (_entityContainSprite.numChildren > 0) {
				var v:FightEntitySprite = _entityContainSprite.removeChildAt(0) as FightEntitySprite;
				v.removeEventListener(FightEntitySprite.EVENT_MOUSE_OVER, charMouseOver);
				v.removeEventListener(FightEntitySprite.EVENT_MOUSE_OUT, charMouseOut);
				v.clear();
			}
		}
		
		
		private function showFightRes():void {
			Logging.log("所有战斗动画完成");
			if (1 == _vo.data.battleResult) {
				//胜利
				_uisprite.showWin(_vo.data.setData);
			}
			else if (2 == _vo.data.battleResult) {
				//失败
				_uisprite.showFailure(_vo.data.setData);
			}
		}
		
		public function forceOver():void {
			_actionGroup.clear();
			_vo.data.stepData = [];
		}
		
		public function showResOver():void {
			if (4 == _vo.data.fightType) {
				//出现翻牌子
				WordSceneSprite.getInstance().dispatchEvent(new BattleFlipEvent(BattleFlipEvent.BATTLEFLIPEVENT));
			}
			else{
				fightOver();
			}
		}
		
		
		//结束战斗
		public function fightOver():void {
			clearMask();
			WordSceneSprite.getInstance().playerCoutainSp.resetFightMonsterID();
			clear();
			WordSceneSprite.getInstance().dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_EXIT_FIGHT));
			
			if (SystemDataModel.panPaBattleFlag) {
				SystemDataModel.panPaBattleFlag = false;
				Logging.log("重新打开爬塔");
				WordSceneSprite.getInstance().dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_OPEN_PATA));
			}
			else if (SystemDataModel.jingjiBattleFlag) {
				SystemDataModel.jingjiBattleFlag = false;
				Logging.log("重新打开竞技");
				WordSceneSprite.getInstance().dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_OPEN_JINGJI));
			}
		}
		
		private function pareAttackedEntitys(roundVo:FightData,attackedEntitys:Array, fatherID:int, isShowSingleAttackEff:Boolean):void {
			var attackedEntitysLen:int = attackedEntitys.length;
			var action:FightAction;
			for (var i:int = 0; i < attackedEntitysLen; i++) 
			{
				var curAttackedEntity:EnemyArray = attackedEntitys[i] as EnemyArray;
				if (isShowSingleAttackEff) {
					if (0 != roundVo.chaEnemyEffectId) {
						//添加被攻击特效
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Skill_Eff_Single;
						action.arg1 = curAttackedEntity.enemyBattleId;
						//TODO 更改特效
						action.arg2 = SAssetManager.ASSET_EFFECT_ID + 1001;
						_actionGroup.addAction(action);
						
						fatherID = action.id;
					}
					
					
					var curhp:int = 1;
					if (0 != curAttackedEntity.enemyChangeHp) {
						//添加减血动作
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_HP_DEC;
						action.arg1 = curAttackedEntity.enemyBattleId;
						curhp = Math.max(0, curAttackedEntity.enemyCurrentHp + curAttackedEntity.enemyChangeHp);
						action.arg3 = curAttackedEntity.enemyChangeHp;
						action.arg4 = curhp;
						action.arg5 = curAttackedEntity.enemyTotalHp;
						_actionGroup.addAction(action);
					}
					if (curAttackedEntity.enemyChangeHp < 0) {
						//添加被攻击动作
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Char_Action;
						action.arg1 = curAttackedEntity.enemyBattleId;
						action.arg2 = SAssetManager.HEARO_ACTION_attacked;
						action.arg3 = CHAR_ATTACKED_TIME;
						_actionGroup.addAction(action);
						
						//只判断一次反弹
						if (0 == i) {
							if (0 != roundVo.chaExpendHp) {
								//被攻击动作
								action = new FightAction();
								action.fatherID = fatherID;
								action.actionType = FightAction.Action_Type_Char_Action;
								action.arg1 = roundVo.chaBattleId;
								action.arg2 = SAssetManager.HEARO_ACTION_attacked;
								action.arg3 = CHAR_ATTACKED_TIME;
								_actionGroup.addAction(action);
								
								fatherID = action.id;
								
								//减血动作
								action = new FightAction();
								action.fatherID = fatherID;
								action.actionType = FightAction.Action_Type_HP_DEC;
								action.arg1 = roundVo.chaBattleId;
								curhp = Math.max(0, roundVo.chaCurrentHp + roundVo.chaExpendHp);
								action.arg3 = roundVo.chaExpendHp;
								action.arg4 = curhp;
								action.arg5 = roundVo.chaTotalHp;
								_actionGroup.addAction(action);
							}
						}
					}
					if (0 != curAttackedEntity.enemyTxtEffectId) {
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Show_Attacked_Result;
						action.arg1 = curAttackedEntity.enemyBattleId;
						action.arg2 = curAttackedEntity.enemyTxtEffectId;
						action.arg3 = ATTACKRESULT_TIME;
						_actionGroup.addAction(action);
					}
					
					if (null != action) {
						fatherID = action.id;
					}
					
					//刷新buf动作
					action = new FightAction();
					action.fatherID = fatherID;
					action.actionType = FightAction.Action_Type_Buff_Eff_Add;
					action.arg1 = curAttackedEntity.enemyBattleId;
					action.arg5 = curAttackedEntity.enemyBuffShowList;
					_actionGroup.addAction(action);
					
					fatherID = action.id;
					
					//如果死亡,添加死亡动作
					if (0 == curhp) {
						//action = new FightAction();
						//action.fatherID = fatherID;
						//action.actionType = FightAction.Action_Type_Char_Action;
						//action.arg1 = curAttackedEntity.enemyBattleId;
						//action.arg2 = SAssetManager.HEARO_ACTION_death;
						//action.arg3 = CHAR_DEATH_TIME;
						//_actionGroup.addAction(action);
						
						fatherID = action.id;
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Char_Remove;
						action.arg1 = curAttackedEntity.enemyBattleId;
						_actionGroup.addAction(action);
					}
					
					//判断是否反击, 只能在一个人的时候
					/*if (0 != curAttackedEntity.enemyCounterHitActionId) {
						//添加攻击动作
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Char_Action;
						action.arg1 = curAttackedEntity.enemyBattleId;
						action.arg2 = SAssetManager.HEARO_ACTION_physicalattack;
						action.arg3 = CHAR_DEATH_TIME;
						_actionGroup.addAction(action);
						
						fatherID = action.id;
						//添加发技能特效
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Skill_Eff_Single;
						action.arg1 = curAttackedEntity.enemyBattleId;
						action.arg2 = SAssetManager.ASSET_EFFECT_ID + 1000;
						_actionGroup.addAction(action);
						
						fatherID = action.id;
						
						//添加被攻击特效
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Skill_Eff_Single;
						action.arg1 = roundVo.chaBattleId;
						//TODO 更改特效
						action.arg2 = SAssetManager.ASSET_EFFECT_ID + 1000;
						_actionGroup.addAction(action);
						
						fatherID = action.id;
					
						//添加被攻击动作
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_Char_Action;
						action.arg1 = roundVo.chaBattleId;
						action.arg2 = SAssetManager.HEARO_ACTION_attacked;
						action.arg3 = CHAR_ATTACKED_TIME;
						_actionGroup.addAction(action);
						
						//添加减血动作
						action = new FightAction();
						action.fatherID = fatherID;
						action.actionType = FightAction.Action_Type_HP_DEC;
						action.arg1 = roundVo.chaBattleId;
						var maincurhp:int = Math.max(0, roundVo.chaCurrentHp + roundVo.chaChangeHp);
						action.arg4 = maincurhp;
						action.arg5 = roundVo.chaTotalHp;
						_actionGroup.addAction(action);
						
						fatherID = action.id;
						
						//
						
						//如果死亡,添加死亡动作
						if (0 == maincurhp) {
							//首先回退到原始闻之
							var v:FightEntitySprite = _entityMap.get(roundVo.chaBattleId);
							action = new FightAction();
							action.fatherID = fatherID;
							action.actionType = FightAction.Action_Type_Move;
							action.arg1 = roundVo.chaBattleId;
							action.arg2 = v.staticX;
							action.arg3 = v.staticY;
							action.arg4 = CHAR_MOVE_TIME;
							_actionGroup.addAction(action);
							
							fatherID = action.id;
							
							//死亡动作
							action = new FightAction();
							action.fatherID = fatherID;
							action.actionType = FightAction.Action_Type_Char_Action;
							action.arg1 = roundVo.chaBattleId;
							action.arg2 = SAssetManager.HEARO_ACTION_death;
							action.arg3 = CHAR_DEATH_TIME;
							_actionGroup.addAction(action);
						}
				
					}*/
					
				}
			}
		}
		
		public function showAction():void {
			Logging.log("开始播放回合动画");
			_actionGroup.playNext(-1);
		}
		
		public function resetWhenEnterScene():void {
			_isfighting = false;
		}
		
		public function excuteAction(action:FightAction):void {
			Logging.log("执行动作", Logging.o2s(action));
			switch (action.actionType) 
			{
				case FightAction.Action_Type_Move:
					moveEntity(action);
					break;
				case FightAction.Action_Type_Char_Action:
					charAction(action);
					break;
				case FightAction.Action_Type_Skill_Eff_Single:
					playSingleEff(action);
					break;
				case FightAction.Action_Type_Skill_Eff_Group:
					playGrounpEff(action);
					break;
				case FightAction.Action_Type_HP_DEC:
					charHpChange(action);
					break;
				case FightAction.Action_Type_Buff_Eff_Add:
					refreshBuff(action);
					break;
				case FightAction.Action_Type_Show_Attacked_Result:
					showAttackRes(action);
					break;
				case FightAction.Action_Type_Char_Remove:
					removeChar(action);
					break;
				case FightAction.Action_Type_MP_DEC:
					changePower(action);
					break;
				default:
					Logging.log("no action type " + action.actionType);
					throw new Error("no action type " + action.actionType);
			}
		}
		
		public function checkCharMoveBack():void {
			if (_isroundDelayBlock) {
				return;
			}
			Logging.log("检测角色回到原始位置");
			_isroundDelayBlock = true;
			var entitys:Array = _entityMap.values();
			var len:int = entitys.length;
			var ismove:Boolean = false;
			for (var i:int = 0; i < len; i++) 
			{
				var v:FightEntitySprite = entitys[i] as FightEntitySprite;
				if (v.staticX != v.x || v.staticY != v.y) {
					ismove = true;
					TweenLite.to(v, CHAR_MOVE_TIME / 1000.0, {x:v.staticX, y:v.staticY} );
				}
			}
			var delayTime:int = ROUND_DELAY_TIME;
			if (ismove) {
				delayTime += CHAR_MOVE_TIME;
				
			}
			new DelayExcuter(delayTime, pareRound, null);
		}
		
		private function maskHideOver():void {
			Logging.log("换场结束,开始解析战斗动作");
			//解析第一个回合动作数据
			pareRound();
		}
		
		private function moveEntity(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			if (ventity.x != action.arg2 || ventity.y != action.arg3) {
				TweenLite.to(ventity, action.arg4 / 1000.0, { x:action.arg2, y:action.arg3, onComplete:_actionGroup.playNext, onCompleteParams:[action.id] });
			}
			else {
				new DelayExcuter(1, _actionGroup.playNext, [action.id]);
			}
			
		}
		
		private function charAction(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			var nextAction:String = null;
			var isStop:Boolean = false;
			if (SAssetManager.HEARO_ACTION_magicattack == action.arg2 || SAssetManager.HEARO_ACTION_physicalattack ==  action.arg2) {
				nextAction = SAssetManager.HEARO_ACTION_arise;
			}
			if (SAssetManager.HEARO_ACTION_attacked == action.arg2 || SAssetManager.HEARO_ACTION_death == action.arg2) {
				isStop = true;
			}
			ventity.enititySprite.playAction(action.arg2, -1, false, nextAction, isStop);
			
			if (SAssetManager.HEARO_ACTION_attacked == action.arg2) {
				//被攻击,恢复站立,然后执行下一个动作
				new DelayExcuter(action.arg3, attackedActionOver, [ventity, action]);
			}
			else{
				new DelayExcuter(action.arg3, _actionGroup.playNext, [action.id]);
			}
		}
		
		private function playSingleEff(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			ventity.addEffect(action.arg2, _actionGroup.playNext, [action.id]);
		}
		
		private function playGrounpEff(action:FightAction):void {
			var eff:EffectSp;
			if (SAssetManager.getInstance().hasRes(action.arg2, SAssetManager.ASSET_EFFECT_ID)) {
				eff = SAssetManager.getInstance().getEffect(action.arg2, SAssetManager.ASSET_EFFECT_ID);
			}
			else {
				eff = SAssetManager.getInstance().getEffect('default', 'sblank');
				SAssetManager.getInstance().addToList(action.arg2);
			}
			eff.setPos(action.arg1[0], action.arg1[1]);
			var activefunc:Function = function(e:Event):void {
				eff.removeEventListener(EffectSp.EFFECTACTIVE_EVENT, activefunc);
				_actionGroup.playNext(action.id);
			}
			eff.addEventListener(
				EffectSp.EFFECTACTIVE_EVENT, 
				activefunc
			);
			eff.addEventListener(EffectSp.EFFECTOVER_EVENT, effectOver);
			_grounpEffContainSprite.addChild(eff);
			eff.play();
		}
		private function effectOver(e:Event):void 
		{
			var effect:EffectSp = e.currentTarget as EffectSp;
			effect.removeEventListener(EffectSp.EFFECTOVER_EVENT, effectOver);
			effect.parent.removeChild(effect);
			effect.clear();
		}
		
		private function attackedActionOver(v:FightEntitySprite, action:FightAction):void {
			if (v.curhp > 0) {
				v.enititySprite.playAction(SAssetManager.HEARO_ACTION_arise);
			}
			_actionGroup.playNext(action.id);
		}
		
		private function charHpChange(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			ventity.changeHP(action);
			new DelayExcuter(FightHPBarView.Boold_Time * 1000, _actionGroup.playNext, [action.id]);
		}
		
		private function showAttackRes(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			ventity.showAttaceRes(action);
			new DelayExcuter(action.arg3, _actionGroup.playNext, [action.id]);
		}
		
		private function removeChar(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.remove(action.arg1);
			_uisprite.hideTips(ventity);
			TweenLite.to(ventity, 1, { alpha:0, onComplete:removeCharFromView, onCompleteParams:[ventity] } );
			new DelayExcuter(REMOVE_CHAR_TIME,  _actionGroup.playNext, [action.id]);
		}
		
		private function changePower(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			ventity.changepower(action);
			new DelayExcuter(CHANGE_POWER_TIME ,_actionGroup.playNext, [action.id]);
		}
		
		private function removeCharFromView(v:FightEntitySprite):void {
			_uisprite.removeChar(v.vo.chaBattleId);
			v.removeEventListener(FightEntitySprite.EVENT_MOUSE_OVER, charMouseOver);
			v.removeEventListener(FightEntitySprite.EVENT_MOUSE_OUT, charMouseOut);
			v.parent.removeChild(v);
			v.clear();
		}
		
		private function refreshBuff(action:FightAction):void {
			var ventity:FightEntitySprite = _entityMap.get(action.arg1);
			_uisprite.refreshPlayerBuf(ventity, action.arg5);
			ventity.refreshBuf(action.arg5, _actionGroup.playNext, [action.id]);
		}
		
		private function charMouseOver(e:Event):void {
			var v:FightEntitySprite = e.currentTarget as FightEntitySprite;
			_uisprite.showTips(v);
		}
		
		private function charMouseOut(e:Event):void {
			_uisprite.hideTips();
		}
		
		public function get isfighting():Boolean 
		{
			return _isfighting;
		}
		
		public function get uisprite():FightUISprite 
		{
			return _uisprite;
		}
		
	}

}
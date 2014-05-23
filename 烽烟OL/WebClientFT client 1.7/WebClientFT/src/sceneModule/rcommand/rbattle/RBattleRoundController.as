package sceneModule.rcommand.rbattle
{
	import br.com.stimuli.loading.BulkLoader;
	
	import com.adobe.utils.ArrayUtil;
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.box2D.PolygonCollisionShape;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.core.ObjectType;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.resource.SWFResource;
	import com.pblabs.rendering2D.DisplayObjectRenderer;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import managers.SoundConst;
	import managers.SoundManager;
	
	import model.SystemDataModel;
	
	import sceneModule.model.rvo.RBattleBossVo;
	import sceneModule.model.rvo.RBattleBuffVo;
	import sceneModule.model.rvo.RBattleEffectVo;
	import sceneModule.model.rvo.RBattleEnemyVo;
	import sceneModule.model.rvo.RBattleInitChaVo;
	import sceneModule.model.rvo.RBattleInitVo;
	import sceneModule.model.rvo.RBattlePowerVo;
	import sceneModule.model.rvo.RBattleRoundVo;
	import sceneModule.model.rvo.RBattleTipVo;
	import sceneModule.model.rvo.RDirectionVo;
	import sceneModule.model.rvo.RBattleRoundUIVo;
	import sceneModule.rcommand.rcharacter.RCharacterInfoComponent;
	import sceneModule.rcommand.revent.ActionEffectEvent;
	import sceneModule.rcommand.revent.ActionEvent;
	import sceneModule.rcommand.revent.RBattleRoundEvent;
	import sceneModule.rcommand.revent.RBattleSealPetEvent;
	import sceneModule.rcommand.revent.RBattleTipEvent;
	import sceneModule.rcommand.revent.RBattleToUIEvent;
	import sceneModule.rcommand.scene.bg.RepeatingRenderComponent;
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnly;
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnlyPre;
	import sceneModule.rcommon.RBattleChaMcRender;
	import sceneModule.rcommon.RCameraController;
	import sceneModule.rcommon.RCriticalMcRender;
	import sceneModule.rcommon.RHpMcRender;
	import sceneModule.rcommon.RLoadHelper;
	import sceneModule.rcommon.RMovieClipRenderer;
	import sceneModule.rcommon.RRingMcRender;
	import sceneModule.rcommon.SceneHelper;
	import sceneModule.rfactory.RBattleShow;
	import sceneModule.rfactory.RPBELevel;
	import sceneModule.rfactory.UtilityTemp;
	import sceneModule.rresource.RBattleConst;
	import sceneModule.rresource.RBattleRes;
	import sceneModule.rresource.RCharacterConst;
	
	import util.xtrace;
	
	public class RBattleRoundController extends EntityComponent
	{
		include "RBattleRoundIntervalIds.as";//所有回合用到的intervalId
		
		private var sceneCenterPoint:Point;//场景中心点
		
		private var vo:RBattleRoundVo;//回合数据
		private var enemyArr:Array;////敌人数组
		private var enemyCounterHitVo:RBattleEnemyVo;
		
		private var rAllRoundCount:int;//总回合数
		private var rCurrentRoundCount:int;//当前是第几回合
		
		/**
		 * 行动轨迹数组
		 */		
		private static var chaTrackPointArray:Array;
		private var moveCount:int = 0;//移动的次数计数器
		private var move_Count:int;//移动次数 = 移动时间/移动步长+1
		/**
		 * 投射特效轨迹数组
		 */		
		private static var throwEffectPointArray:Array;
		private var throwEffectMoveCount:int = 0;//移动的次数计数器
		private var throw_Effect_Move_Count:int;
		
		private var actionType:int;//动作类型，1：攻击，各种攻击，2：防御，3：死亡
		
		private var aJsonObj:Object;//A要设置的数据
		private var bJsonObj:Object;//B要设置的数据对象，由角色类型决定，格式为：{"1":{json对象},"5001":{json对象}}
		
		private var rBattleTipVo:RBattleTipVo;//战斗中的角色TIP数据对象
		private var rBattleTipVoArr:Array;//战斗中的角色TIP数据对象
		private var rBattleInitTipVoArrObj:Object;//初始化的tip数据对象，名字和等级不变
		
		private var throwEffectInitPos:Point;
		
		public function RBattleRoundController()
		{
			super();
		}
		
		/*public function onTick(deltaTime:Number):void
		{
			return;
			//trace(deltaTime);
		}*/
		
		public function setInitRBattleTipVo(rBattleInitVo:RBattleInitVo):void{
			rBattleInitTipVoArrObj = setInitRBattleTipVoArr(rBattleInitVo.rBattleInitChaVoArr);
		}
		private function setInitRBattleTipVoArr(rBattleInitChaVoArr:Array):Object{
			var o:Object = new Object();
			var len:int = rBattleInitChaVoArr.length;
			for(var i:int=0;i<len;i++){
				var rBattleInitChaVo:RBattleInitChaVo = rBattleInitChaVoArr[i];
				var rBattleTipVo:RBattleTipVo = new RBattleTipVo();
				rBattleTipVo.chaBattleId = rBattleInitChaVo.chaBattleId;
				rBattleTipVo.chaId = rBattleInitChaVo.chaId;
				rBattleTipVo.chaName = rBattleInitChaVo.chaName;
				rBattleTipVo.chaLevel = rBattleInitChaVo.chaLevel;
				rBattleTipVo.chaTotalHp = rBattleInitChaVo.chaTotalHp;
				rBattleTipVo.chaHp = rBattleInitChaVo.chaCurrentHp;
				if(rBattleTipVo.chaHp<0){
					rBattleTipVo.chaHp = 0;
				}
				rBattleTipVo.chaTotalPower = rBattleInitChaVo.chaTotalPower;
				rBattleTipVo.chaPower = rBattleInitChaVo.chaCurrentPower;
				if(rBattleTipVo.chaPower<0){
					rBattleTipVo.chaPower = 0;
				}
				rBattleTipVo.chaStateArr = [];
				o[String(rBattleInitChaVo.chaBattleId)] = rBattleTipVo;
			}
			return o;
		}
		/**
		 * 回合控制 
		 * @param rBattleCurrentRoundVo 要控制的VO
		 * @param loader 加载资源的bulkLoader
		 * 
		 */		
		public function roundControl(
			rBattleCurrentRoundVo:RBattleRoundVo,
			loader:BulkLoader,
			allCount:int,
			currentCount:int
		):void{
			trace("控制战斗回合数据"+rBattleCurrentRoundVo.chaBuffArr.toString());
			getBattleTipData();
			//this.loader = loader;
			this.vo = rBattleCurrentRoundVo;
			this.rAllRoundCount = allCount;
			this.rCurrentRoundCount = currentCount;
			this.enemyArr = rBattleCurrentRoundVo.enemyChaArr;//敌人数组
			
			rBattleTipVoArr = getRBattleTipVoArr(rBattleCurrentRoundVo);
			
			//解析此回合的JSON数据
			//var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			if(vo.actionId>0){
				/*var a_json_id:String = res.get_fight_config_id(vo.actionId);
				aJsonObj = res.get_fight_config_obj(a_json_id);*/
				aJsonObj = RLoadHelper.getInstance().getBattleInfoById(vo.actionId);
			}
			
			//解析敌人数组，并把对应的对象填到相应的新数组
			bJsonObj = {};
			for (var i:int = 0; i < enemyArr.length; i++) {
				/*var t_be:RBattleEnemyVo = enemyArr[i] as RBattleEnemyVo;
				var t_em_type:int = t_be.enemyProfessionType;
				var actionId:int = int("" + t_em_type + getAttackTypId(t_be.enemyActionId));
				var t_json_id:String = res.get_fight_config_id(actionId);
				bJsonObj[t_em_type.toString()] = res.get_fight_config_obj(t_json_id);*/
				
				var t_be:RBattleEnemyVo = enemyArr[i] as RBattleEnemyVo;
				var t_em_type:int = t_be.enemyProfessionType;
				var actionId:int = int("" + t_em_type + getAttackTypId(t_be.enemyActionId));
				bJsonObj[t_em_type.toString()] = RLoadHelper.getInstance().getBattleInfoById(actionId);
			}
			
			//如果有反击，肯定数组中只有一个元素，而且数组中至少会有一个元素，因为群攻无反击
			this.enemyCounterHitVo = rBattleCurrentRoundVo.enemyChaArr[0] as RBattleEnemyVo;
			if(rBattleCurrentRoundVo.isCriticalBlow){
				//addCriticalBgEnt();
				addCriticalEnt();
			}else{
				attackHandler();
			}
		}
		/**
		 * 获取战斗TIPVO数组
		 */		
		private function getRBattleTipVoArr(rBattleCurrentRoundVo:RBattleRoundVo):Array{
			var arr:Array = [];
			var rBattleTipVo:RBattleTipVo = new RBattleTipVo();
			rBattleTipVo.chaBattleId = rBattleCurrentRoundVo.chaBattleId;
			rBattleTipVo.chaId = rBattleCurrentRoundVo.chaId;
			rBattleTipVo.chaName = rBattleCurrentRoundVo.chaName;
			rBattleTipVo.chaLevel = rBattleCurrentRoundVo.chaLevel;
			rBattleTipVo.chaTotalHp = rBattleCurrentRoundVo.chaTotalHp;
			rBattleTipVo.chaHp = rBattleCurrentRoundVo.chaCurrentHp+rBattleCurrentRoundVo.chaChangeHp;
			if(rBattleTipVo.chaHp<0){
				rBattleTipVo.chaHp = 0;
			}
			rBattleTipVo.chaTotalPower = rBattleCurrentRoundVo.chaTotalPower;
			rBattleTipVo.chaPower = rBattleCurrentRoundVo.chaCurrentPower+rBattleCurrentRoundVo.chaPowerUp+rBattleCurrentRoundVo.chaPowerDown;
			if(rBattleTipVo.chaPower<0){
				rBattleTipVo.chaPower = 0;
			}
			rBattleTipVo.chaStateArr = rBattleCurrentRoundVo.chaBuffArr;
			arr.push(rBattleTipVo);
			if(rBattleCurrentRoundVo.enemyChaArr){
				var len:int = rBattleCurrentRoundVo.enemyChaArr.length;
				for(var i:int=0;i<len;i++){
					var tipVo:RBattleTipVo = new RBattleTipVo();
					var rBattleEnemyVo:RBattleEnemyVo = rBattleCurrentRoundVo.enemyChaArr[i] as RBattleEnemyVo;
					tipVo.chaBattleId = rBattleEnemyVo.enemyBattleId;
					tipVo.chaId = rBattleEnemyVo.enemyChaId;
					tipVo.chaName = rBattleEnemyVo.enemyName;
					tipVo.chaLevel = rBattleEnemyVo.enemyLevel;
					tipVo.chaTotalHp = rBattleEnemyVo.enemyTotalHp;
					tipVo.chaHp = rBattleEnemyVo.enemyCurrentHp+rBattleEnemyVo.enemyChangeHp;
					if(tipVo.chaHp<0){
						tipVo.chaHp = 0;
					}
					tipVo.chaTotalPower = rBattleEnemyVo.enemyTotalPower;
					tipVo.chaPower = rBattleEnemyVo.enemyCurrentPower+rBattleEnemyVo.enemyPowerUp+rBattleEnemyVo.enemyPowerDown;
					if(tipVo.chaPower<0){
						tipVo.chaPower = 0;
					}
					tipVo.chaStateArr = rBattleEnemyVo.enemyBuffArr;
					arr.push(tipVo);
				}
			}
			return arr;
		}
		/**
		 * 战斗中要获取的角色tipsVO 
		 * @param chaBattleId
		 * @return 
		 * 
		 */		
		private function getRbattleTipVo(chaBattleId:int):RBattleTipVo{
			var vo:RBattleTipVo = new RBattleTipVo();
			if(rBattleInitTipVoArrObj){
				if(rBattleTipVoArr){
					var len:int = rBattleTipVoArr.length;
					for(var i:int=0;i<len;i++){
						var rBattleTipVo:RBattleTipVo = rBattleTipVoArr[i] as RBattleTipVo;
						if(rBattleTipVo.chaBattleId == chaBattleId){
							vo = rBattleTipVo;
							return vo;
						}
					}
				}
				vo = rBattleInitTipVoArrObj[String(chaBattleId)] as RBattleTipVo;
				return vo;
			}
			return vo;
		}
		/**
		 * 获取攻击动作类型ID，有容错，最终有错则返回 ID_ATTACK_NORMAL
		 * @param actionId
		 * @return 
		 * 
		 */		
		private function getAttackTypId(actionId:int):int{
			var str:String = String(actionId);
			var attackType:int = int(str.substring(str.length-3,str.length));
			if(attackType == RBattleConst.ID_ATTACK_NORMAL || attackType == RBattleConst.ID_ATTACK_SKILL){
				return attackType;
			}
			return RBattleConst.ID_ATTACK_NORMAL;
		}
		/**
		 * 获取动作真实类型ID,530,540,550,560,570,580 
		 * @param actionId
		 * @return 
		 * 
		 */		
		private function getActionTypeId(actionId:int):int{
			var str:String = String(actionId);
			var actionType:int = int(str.substring(str.length-3,str.length));
			return actionType;
		}
		/**
		 * 添加暴击背景实体 
		 * 
		 */		
		private function addCriticalBgEnt():void{
			trace("add critical bg entity--");
			var criticalBgEnt:IEntity;
			if(getCriticalBgEnt()){
				criticalBgEnt = getCriticalBgEnt();
				return;
			}else{
				//创建角色实体
				criticalBgEnt = PBE.allocateEntity();
				criticalBgEnt.initialize(RBattleConst.CRITICAL_BG_ENTITI_NAME);// 添加Box2DSpatialComponent
				var spatial:Box2DSpatialComponent = new Box2DSpatialComponent();
				//基础属性
				spatial.position = sceneCenterPoint;
				spatial.size = new Point(5,5);
				spatial.canRotate = false;
				spatial.canSleep = false;
				spatial.collidesWithTypes = new ObjectType("canNotCollided");
				spatial.collisionType = new ObjectType("Critical");
				//特殊属性，碰撞检测形状
				var shape:PolygonCollisionShape = new PolygonCollisionShape();
				shape.vertices = new Array();
				shape.vertices.push( new Point( -1, -1) );
				shape.vertices.push( new Point( 1, -1) );
				shape.vertices.push( new Point( 1, 1) );
				shape.vertices.push( new Point( -1, 1) );
				//把shape添加到组件
				spatial.collisionShapes = new Array();
				spatial.collisionShapes.push(shape);
				spatial.linearVelocity = new Point(0,0);
				spatial.spatialManager = SceneHelper.getInstance().mySpatialManager;
				criticalBgEnt.addComponent(spatial,"Spatial");
				
				//背景
				var bgMcRender:RCriticalMcRender = new RCriticalMcRender();
				bgMcRender.positionProperty = new PropertyReference("@Spatial.position");
				PBE.resourceManager.load(RBattleRes.CRITICAL_BG, SWFResource,resOnloaded);
				bgMcRender.fileName = RBattleRes.CRITICAL_BG;
				bgMcRender.loop = true;
				bgMcRender.scene = SceneHelper.getInstance().myScene;
				bgMcRender.layerIndex = 16;//近景层以15层开始的，所以暴击背景以16层开始
				criticalBgEnt.addComponent(bgMcRender,"bgMcRender");
			}
		}
		/**
		 * 添加暴击实体，战斗场景中目前只添加一个 
		 * 
		 */		
		private function addCriticalEnt():void{
			trace("add critical entity--");
			var criticalEnt:IEntity;
			if(getCriticalEnt()){
				criticalEnt = getCriticalEnt();
				return;
			}else{
				//创建角色实体
				criticalEnt = PBE.allocateEntity();
				criticalEnt.initialize(RBattleConst.CRITICAL_ENTITI_NAME);// 添加Box2DSpatialComponent
				var spatial:Box2DSpatialComponent = new Box2DSpatialComponent();
				//基础属性
				spatial.position = sceneCenterPoint;
				spatial.size = new Point(5,5);
				spatial.canRotate = false;
				spatial.canSleep = false;
				spatial.collidesWithTypes = new ObjectType("canNotCollided");
				spatial.collisionType = new ObjectType("Critical");
				//特殊属性，碰撞检测形状
				var shape:PolygonCollisionShape = new PolygonCollisionShape();
				shape.vertices = new Array();
				shape.vertices.push( new Point( -1, -1) );
				shape.vertices.push( new Point( 1, -1) );
				shape.vertices.push( new Point( 1, 1) );
				shape.vertices.push( new Point( -1, 1) );
				//把shape添加到组件
				spatial.collisionShapes = new Array();
				spatial.collisionShapes.push(shape);
				spatial.linearVelocity = new Point(0,0);
				spatial.spatialManager = SceneHelper.getInstance().mySpatialManager;
				criticalEnt.addComponent(spatial,"Spatial");
				
			}
			
			//特写
			/*var closeUpMcRender:RCriticalMcRender = new RCriticalMcRender();
			closeUpMcRender.positionProperty = new PropertyReference("@Spatial.position");
			PBE.resourceManager.load(RBattleRes["CRITICAL_CHA_"+vo.chaProfessionType], SWFResource,resOnloaded);
			closeUpMcRender.fileName = RBattleRes["CRITICAL_CHA_"+vo.chaProfessionType];
			closeUpMcRender.loop = false;
			closeUpMcRender.scene = SceneHelper.getInstance().myScene;
			closeUpMcRender.layerIndex = 190;//眼睛以200层为准，所以特定在190
			criticalEnt.addComponent(closeUpMcRender,"closeUpMcRender"+vo.chaProfessionType);*/
			//特写
			var closeUpResId:int = vo.chaProfessionType;
			var closeUpMcRender:RCriticalMcRender = new RCriticalMcRender();
			closeUpMcRender.positionProperty = new PropertyReference("@Spatial.position");
			closeUpMcRender.clip = getResMc(closeUpResId,"CloseUpMc");
			if(closeUpMcRender.clip){
				closeUpMcRender.loop = false;
				closeUpMcRender.scene = SceneHelper.getInstance().myScene;
				closeUpMcRender.layerIndex = 190;//眼睛以200层为准，所以特定在190
				criticalEnt.addComponent(closeUpMcRender,"closeUpMcRender"+vo.chaProfessionType);
			}
			
			//眼睛
			var eyeResId:int = int(vo.chaProfessionType + String(vo.chaProfessionType));
			var eyeMcRender:RCriticalMcRender = new RCriticalMcRender();
			eyeMcRender.positionProperty = new PropertyReference("@Spatial.position");
			eyeMcRender.clip = getResMc(eyeResId,"EyeMc");
			if(eyeMcRender.clip){
				eyeMcRender.loop = false;
				eyeMcRender.scene = SceneHelper.getInstance().myScene;
				eyeMcRender.destroyOnEnd = true;
				eyeMcRender.layerIndex = 200;
				
				eyeMcRender.clip.addEventListener(EYE_PLAY_BACK_FINISH_EVENT,
					function clipRemoved(e:Event):void{
						eyeMcRender.clip.removeEventListener(EYE_PLAY_BACK_FINISH_EVENT,clipRemoved);
						//trace("监听到 eye 派发的 chaEyeEvent 事件 ---------播放完移除"+MovieClip(e.target));
						attackHandler();
					}
				);
				criticalEnt.addComponent(eyeMcRender,"eyeMcRender"+vo.chaProfessionType);
			}
			
		}
		/**
		 * 获取MC资源 
		 */		
		private function getResMc(resId:int,clsName:String):MovieClip{
			var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(resId,clsName);
			return mc;
		}
		
		//eye1.swf,eye2.swf...播放完成后派发的事件
		//此处由SWF派发事件来处理是为解决显示延时问题，提高流畅底
		private const EYE_PLAY_BACK_FINISH_EVENT:String = "eyePlayBackFinishEvent";
		
		//资源加载完成处理，其实资源已经提前加载完，之所以在这里处理是要重置并播放资源的内容
		private function resOnloaded(res:SWFResource):void{
			res.clip.gotoAndPlay(1);
		}
		/**
		 * 攻击处理 
		 */		
		private function attackHandler():void{
			if(vo.isCriticalBlow){
				vo.chaEffectId = RBattleConst["CRITICAL_CHA_1_"+vo.chaProfessionType];
				vo.chaEnemyEffectId = RBattleConst["CRITICAL_CHA_3_"+vo.chaProfessionType];
				vo.chaAttackType = RBattleConst.ATTACK_TYPE_FAR;
				trace("暴击 =============================== "+vo.chaEffectId);
			}
			if(vo.chaProfessionType == RBattleConst.CROTA_II_BUFF){
				buffHandler();//buff
			}else{//非BUFF回合处理
				if(vo.chaAttackType == RBattleConst.ATTACK_TYPE_FAR){//远程
					farAttackHandler();
				}else if(vo.chaAttackType == RBattleConst.ATTACK_TYPE_NEAR){//近程
					nearAttackHandler();
				}
			}
		}
		/**
		 * 处理系统发起的BUFF，当vo.actionId==-1时执行 
		 */		
		private function buffHandler():void{
			Logger.print(this,"本回合是buff回合,当前回合数："+rCurrentRoundCount);
			//攻击的同时B要受击，有延时，但是可同时处理
			//受击目录为数组，因为可能是群体攻击
			var len:int = vo.enemyChaArr.length;
			enemyChaCount = len;
			for(var i:int=0;i<len;i++){
				var rEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
				rEnemyVo = vo.enemyChaArr[i] as RBattleEnemyVo;
				setRingVisible(rEnemyVo.enemyBattleId,true);//设置挨打目标
				var bDefenseTP:int;
				var aEffect3TP:int;
				bDefenseTP = 500;
				aEffect3TP = 500;
				if(rEnemyVo.enemyChangeHp<0){
					defenseIntervalId1 = setTimeout(//挨打
						playFarEnemyAttackAction,
						bDefenseTP,
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyActionId,
						false,
						rEnemyVo.enemyProfessionType,
						rEnemyVo.enemyChaId,
						rEnemyVo.enemyCurrentHp,
						rEnemyVo.enemyChangeHp,
						rEnemyVo.enemyTotalHp
					);
				}else{
					trace("清BUFF目标待机:"+rEnemyVo.enemyBattleId);
					countInAoe += 1;
					idleHandler(rEnemyVo.enemyBattleId,rEnemyVo.enemyProfessionType);//受击方待机
					setRingVisible(rEnemyVo.enemyBattleId,false);
					if(countInAoe == enemyChaCount){
						standIntervalId1 = setTimeout(//回合结束
							oneRoundOverEventDispatch,getNextRoundTP(),rEnemyVo.enemyBattleId
						);
					}
					//if(rEnemyVo.enemyChangeHp>0){
						hpHandler(rEnemyVo.enemyBattleId,rEnemyVo.enemyChaId,rEnemyVo.enemyCurrentHp,rEnemyVo.enemyChangeHp,rEnemyVo.enemyTotalHp);
					//}
				}
				if(vo.chaEnemyEffectId>0){//承受特效
					effectIntervalId1 = setTimeout(
						playEffect,
						getEffectTP(vo.chaEnemyEffectId,aEffect3TP),
						rEnemyVo.enemyBattleId,
						vo.chaEnemyEffectId,
						RBattleConst.EFFECT_TYPE_3
					);
				}
				if(rEnemyVo.enemyTxtEffectId>0){//承受方的文字特效
					effectIntervalId2 = setTimeout(
						playEffect,
						getEffectTP(rEnemyVo.enemyTxtEffectId,aEffect3TP),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyTxtEffectId,
						RBattleConst.EFFECT_TYPE_4
					);
				}
				if(rEnemyVo.enemyPowerEffectId>0){//承受方的Power特效
					effectIntervalId3 = setTimeout(
						playEffect,
						getEffectTP(rEnemyVo.enemyPowerEffectId,aEffect3TP),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyPowerEffectId,
						RBattleConst.EFFECT_TYPE_5
					);
				}
				if(rEnemyVo.enemyPowerDown!=0 || rEnemyVo.enemyPowerUp!=0){//power 处理
					effectIntervalId4 = setTimeout(
						powerHandler,
						aEffect3TP,
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyChaId,
						rEnemyVo.enemyPowerDown,
						rEnemyVo.enemyPowerUp,
						rEnemyVo.enemyCurrentPower,
						rEnemyVo.enemyTotalPower
					);
				}
				var enemyBuffList:Array = new Array();
				var buffJsonObj:Object = bJsonObj[rEnemyVo.enemyProfessionType];
				var enemyBuffLen:int = rEnemyVo.enemyBuffShowList.length;
				for(var n:int=0;n<enemyBuffLen;n++){
					var rEnemybattleBuffVo:RBattleBuffVo = new RBattleBuffVo();
					rEnemybattleBuffVo = rEnemyVo.enemyBuffShowList[n] as RBattleBuffVo;
					buffIntervalId1 = setTimeout(
						playBuffEffect,
						aEffect3TP,
						rEnemyVo.enemyBattleId,
						rEnemybattleBuffVo.buffEffectId,
						buffJsonObj,
						n,
						enemyBuffLen
					);
					enemyBuffList.push(rEnemybattleBuffVo.buffEffectId);
				}
				setChaBuffListInfo(rEnemyVo.enemyBattleId,enemyBuffList);
			}
		}
		//如果是群体攻击，则计算是第几次攻击。挨打动作播放完成此数值+1，每回合结束，清0。
		//只有群体中的所有单体全部动作完成，才进行下一回合
		private var countInAoe:int;
		//群体攻击时，敌人数组里数量，
		private var enemyChaCount:int;
		/**
		 * 远程攻击处理 
		 */		
		private function farAttackHandler():void{
			if(!throwEffectPointArray){
				throwEffectPointArray = new Array();
			}
			trace("远程攻击处理");
			//--idleHandler(vo.chaBattleId,vo.chaProfessionType);
			//A待机后攻击
			standIntervalId2 = setTimeout(playFarChaAttackAction,int(aJsonObj.far.aAttackTP),vo.chaBattleId,vo.actionId,false,
				vo.chaId,vo.chaCurrentHp,vo.chaExpendHp,vo.chaTotalHp);
			if(vo.chaEffectId>0){//攻击释放特效
				effectIntervalId5 = setTimeout(
					playEffect,
					getEffectTP(vo.chaEffectId,int(aJsonObj.far.aEffect1TP)),
					vo.chaBattleId,
					vo.chaEffectId,
					RBattleConst.EFFECT_TYPE_1
				);
			}
			if(vo.txtEffectId>0){//文字特效
				effectIntervalId6 = setTimeout(
					playEffect,
					getEffectTP(vo.txtEffectId,int(aJsonObj.far.aEffect1TP)),
					vo.chaBattleId,
					vo.txtEffectId,RBattleConst.EFFECT_TYPE_4
				);
			}
			if(vo.powerEffectId>0){//power特效
				effectIntervalId7 = setTimeout(
					playEffect,
					getEffectTP(vo.powerEffectId,int(aJsonObj.far.aEffect1TP)),
					vo.chaBattleId,
					vo.powerEffectId,
					RBattleConst.EFFECT_TYPE_5
				);
			}
			if(vo.chaAoeEffectId>0){//群体攻击的全屏特效
				effectIntervalId8 = setTimeout(
					playAoeEffect,
					int(aJsonObj.far.aAoeEffectTp),
					vo.chaAoeEffectId
				);
			}
			if(vo.chaPowerDown!=0 || vo.chaPowerUp!=0){//power 处理
				effectIntervalId9 = setTimeout(
					powerHandler,
					int(aJsonObj.far.aEffect1TP),
					vo.chaBattleId,
					vo.chaId,
					vo.chaPowerDown,
					vo.chaPowerUp,
					vo.chaCurrentPower,
					vo.chaTotalPower
				);
			}
			//攻击的同时B要受击，有延时，但是可同时处理
			//受击目录为数组，因为可能是群体攻击
			var len:int = vo.enemyChaArr.length;
			enemyChaCount = len;
			if(len>1){
				trace("群体攻击");
			}else if(len==1){
				trace("单体攻击");
			}
			for(var i:int=0;i<len;i++){
				var rEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
				rEnemyVo = vo.enemyChaArr[i] as RBattleEnemyVo;
				setRingVisible(rEnemyVo.enemyBattleId,true);//设置挨打目标
				var bDefenseTP:int;
				var aEffect3TP:int;
				if(vo.isCriticalBlow){
					bDefenseTP = int(aJsonObj.far.bDefenseCriticalTP);
					aEffect3TP = int(aJsonObj.far.aEffect3CriticalTP);
				}else{
					bDefenseTP = int(aJsonObj.far.bDefenseTP);
					aEffect3TP = int(aJsonObj.far.aEffect3TP);
				}
				defenseIntervalId2 = setTimeout(//挨打
					playFarEnemyAttackAction,
					bDefenseTP,
					rEnemyVo.enemyBattleId,
					rEnemyVo.enemyActionId,
					false,
					rEnemyVo.enemyProfessionType,
					rEnemyVo.enemyChaId,
					rEnemyVo.enemyCurrentHp,
					rEnemyVo.enemyChangeHp,
					rEnemyVo.enemyTotalHp,
					rEnemyVo.chaEnemyEffectId
				);
				if(vo.chaEnemyEffectId>0){//承受特效
					effectIntervalId10 = setTimeout(
							playEffect,
							getEffectTP(vo.chaEnemyEffectId,aEffect3TP),
							rEnemyVo.enemyBattleId,
							vo.chaEnemyEffectId,
							RBattleConst.EFFECT_TYPE_3
						);
				}
				if(rEnemyVo.enemyTxtEffectId>0){//承受方的文字特效
					if(rEnemyVo.enemyTxtEffectId == RBattleConst.SEAL_PET_SUCCESS){
						dispatchSealPetEvent();
					}
					effectIntervalId11 = setTimeout(
						playEffect,
						getEffectTP(rEnemyVo.enemyTxtEffectId,aEffect3TP),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyTxtEffectId,
						RBattleConst.EFFECT_TYPE_4
					);
				}
				if(rEnemyVo.enemyPowerEffectId>0){//承受方的能量特效
					effectIntervalId12 = setTimeout(
						playEffect,
						getEffectTP(rEnemyVo.enemyPowerEffectId,aEffect3TP),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyPowerEffectId,
						RBattleConst.EFFECT_TYPE_5
					);
				}
				if(rEnemyVo.enemyPowerDown!=0 || rEnemyVo.enemyPowerUp!=0){//power 处理
					effectIntervalId13 = setTimeout(
						powerHandler,
						aEffect3TP,
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyChaId,
						rEnemyVo.enemyPowerDown,
						rEnemyVo.enemyPowerUp,
						rEnemyVo.enemyCurrentPower,
						rEnemyVo.enemyTotalPower
					);
				}
				var enemyBuffList:Array = new Array();
				var buffJsonObj:Object = bJsonObj[rEnemyVo.enemyProfessionType];
				var enemyBuffLen:int = rEnemyVo.enemyBuffShowList.length;
				for(var n:int=0;n<enemyBuffLen;n++){
					var rEnemybattleBuffVo:RBattleBuffVo = new RBattleBuffVo();
					rEnemybattleBuffVo = rEnemyVo.enemyBuffShowList[n] as RBattleBuffVo;
					buffIntervalId2 = setTimeout(
						playBuffEffect,
						aEffect3TP,
						rEnemyVo.enemyBattleId,
						rEnemybattleBuffVo.buffEffectId,
						buffJsonObj,
						n,
						enemyBuffLen
					);
					enemyBuffList.push(rEnemybattleBuffVo.buffEffectId);
				}
				setChaBuffListInfo(rEnemyVo.enemyBattleId,enemyBuffList);
				if(vo.chaThrowEffectId>0){//投射特效
					
					//var effect2JsonObj:Object = new Object();
					//effect2JsonObj = decodeJsonHandler(vo.chaThrowEffectId);
					
					/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
					var effect2JsonObj_id:String = res.get_fight_config_id(vo.chaThrowEffectId);
					var effect2JsonObj:Object = res.get_fight_config_obj(effect2JsonObj_id);*/
					var effect2JsonObj:Object = RLoadHelper.getInstance().getBattleInfoById(vo.chaThrowEffectId);
					//var effectLineSegmentCount:int = int(effect2JsonObj.effect.effectTD)/int(effect2JsonObj.effect.effectMoveStepTD);
					//throw_Effect_Move_Count = effectLineSegmentCount+1;
					throw_Effect_Move_Count = int(effect2JsonObj.effect.effectMoveCount);
					setEffectPoint2Offset(vo.chaThrowEffectId);
					var effectPoint2:Point;
					var effectDefensePoint2:Point;
					if(vo.chaDirection == RDirectionVo.RIGHT_DIRECTION){
						effectPoint2 = new Point(
							int(aJsonObj.battlePoint.effectPoint2[0])+vo.chaStartPos.x,
							int(aJsonObj.battlePoint.effectPoint2[1])+vo.chaStartPos.y
						);
						effectDefensePoint2 = new Point(
							int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.effectDefensePoint2[0])+rEnemyVo.enemyStartPos.x+effectPoint2End.x,
							int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.effectDefensePoint2[1])+rEnemyVo.enemyStartPos.y+effectPoint2End.y
						);
					}else{
						effectPoint2 = new Point(
							-int(aJsonObj.battlePoint.effectPoint2[0])+vo.chaStartPos.x,
							int(aJsonObj.battlePoint.effectPoint2[1])+vo.chaStartPos.y
						);
						effectDefensePoint2 = new Point(
							-int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.effectDefensePoint2[0])+rEnemyVo.enemyStartPos.x-effectPoint2End.x,
							int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.effectDefensePoint2[1])+rEnemyVo.enemyStartPos.y+effectPoint2End.y
						);
					}
					setThrowEffectAngle(effectPoint2,effectDefensePoint2);//设置投射特效的角度
					throwEffectPointArray = 
						UtilityTemp.getInstance().getPointsArr(effectPoint2,effectDefensePoint2,throw_Effect_Move_Count);
					throwEffectInitPos = throwEffectPointArray[0] as Point;
					moveIntervalId1 = setTimeout(throwEffectMoveHandler,int(effect2JsonObj.effect.effectMoveTP),int(effect2JsonObj.effect.effectMoveStepTD));//投射特效移动
					throwEffectIntervalId1 = 
						setTimeout(playThrowEffect,int(effect2JsonObj.effect.effectTP),vo.chaBattleId,rEnemyVo.enemyBattleId,vo.chaThrowEffectId,RBattleConst.EFFECT_TYPE_2);
					/*trace(throwEffectPointArray.toString()+" ** "+vo.chaDirection+" ** "+vo.chaBattleId);
					trace("-----------------------------------------------------------------------------");*/
				}
			}
			
		}
		/**
		 * 近程攻击处理 
		 */		
		private function nearAttackHandler():void{
			trace("近程攻击处理");
			//角色移动路点数组
			if(!chaTrackPointArray){
				chaTrackPointArray = new Array();
			};
			
			var chaLineSegmentCount:int = int(aJsonObj.near.aMoveTD)/int(aJsonObj.near.aMoveStepTD);
			move_Count = chaLineSegmentCount+1;
			var rEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
			rEnemyVo = vo.enemyChaArr[0] as RBattleEnemyVo;
			//目标坐标的挨打点偏移坐标
			var defensePoint:Point;
			if(bJsonObj){
				defensePoint = new Point(
					int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.defensePoint[0]),
					int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.defensePoint[1])
				);
			}else{
				defensePoint = new Point(0,0);
			}
			//攻击坐标的攻击点偏移坐标
			var attackPoint:Point;
			attackPoint = new Point(
				int(aJsonObj.battlePoint.attackPoint[0]),
				int(aJsonObj.battlePoint.attackPoint[1])
			);
			//求出最后近程角色立足点的坐标
			var tempTargetPos:Point;
			if(vo.chaDirection == RDirectionVo.RIGHT_DIRECTION){
				tempTargetPos = new Point(
					vo.chaTargetPos.x+defensePoint.x+attackPoint.x,
					vo.chaTargetPos.y+defensePoint.y+attackPoint.y
				);
			}else{
				tempTargetPos = new Point(
					vo.chaTargetPos.x+defensePoint.x-attackPoint.x,
					vo.chaTargetPos.y+defensePoint.y+attackPoint.y
				);
			}
			
			chaTrackPointArray = 
				UtilityTemp.getInstance().getPointsArr(vo.chaStartPos,tempTargetPos,chaLineSegmentCount);
			
			//近程先处理第一部分攻击
			nearAttackHandler1();
		}
		/**
		 * 近程攻击第一部分，待机，移动，攻击
		 * 攻击结束后为第二部分
		 */		
		private function nearAttackHandler1():void{
			trace("近程 第一部分攻击");
			//playAction(vo.chaBattleId,RBattleConst.ID_WALK,true);//移动动作
			moveCount = 0;
			moveHandler(vo.chaBattleId);//移动
			/*standIntervalId = setTimeout(//待机
				playAction,int(aJsonObj.near.aStandAfterMoveTP),vo.chaBattleId,RBattleConst.ID_STAND,true
			);*/
			attackIntervalId = setTimeout(//攻击
				playAction,int(aJsonObj.near.aAttackTP),vo.chaBattleId,vo.actionId,false,
				vo.chaId,vo.chaCurrentHp,vo.chaExpendHp,vo.chaTotalHp
			);
			if(vo.chaEffectId>0){//攻击释放特效 
				effectIntervalId14 = setTimeout(
					playEffect,
					getEffectTP(vo.chaEffectId,int(aJsonObj.near.aEffect1TP)),
					vo.chaBattleId,
					vo.chaEffectId,
					RBattleConst.EFFECT_TYPE_1
				);
			}
			if(vo.txtEffectId>0){//攻击方文字特效
				effectIntervalId15 = setTimeout(
					playEffect,
					getEffectTP(vo.txtEffectId,int(aJsonObj.near.aEffect1TP)),
					vo.chaBattleId,
					vo.txtEffectId,
					RBattleConst.EFFECT_TYPE_4
				);
			}
			if(vo.powerEffectId>0){//攻击方能量特效
				effectIntervalId16 = setTimeout(
					playEffect,
					getEffectTP(vo.powerEffectId,int(aJsonObj.near.aEffect1TP)),
					vo.chaBattleId,
					vo.powerEffectId,
					RBattleConst.EFFECT_TYPE_5
				);
			}
			if(vo.chaPowerDown!=0 || vo.chaPowerUp!=0){//power 处理
				effectIntervalId17 = setTimeout(
					powerHandler,
					int(aJsonObj.near.aEffect1TP),
					vo.chaBattleId,
					vo.chaId,
					vo.chaPowerDown,
					vo.chaPowerUp,
					vo.chaCurrentPower,
					vo.chaTotalPower
				);
			}
			//攻击的同时B要受击，有延时，但是可同时处理
			//受击目录为数组，因为可能是群体攻击
			var len:int = vo.enemyChaArr.length;
			enemyChaCount = len;
			for(var i:int=0;i<len;i++){
				var rEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
				rEnemyVo = vo.enemyChaArr[i] as RBattleEnemyVo;
				setRingVisible(rEnemyVo.enemyBattleId,true);//设置挨打目标
				defenseIntervalId3 = setTimeout(//挨打
					playEnemyAction,
					int(aJsonObj.near.bDefenseTP),
					rEnemyVo.enemyBattleId,
					rEnemyVo.enemyActionId,
					false,
					rEnemyVo.enemyProfessionType,
					rEnemyVo.enemyChaId,
					rEnemyVo.enemyCurrentHp,
					rEnemyVo.enemyChangeHp,
					rEnemyVo.enemyTotalHp
				);
				if(vo.chaEnemyEffectId>0){//承受特效
					effectIntervalId18 = setTimeout(
							playEffect,
							getEffectTP(vo.chaEnemyEffectId,int(aJsonObj.near.aEffect3TP)),
							rEnemyVo.enemyBattleId,
							vo.chaEnemyEffectId,
							RBattleConst.EFFECT_TYPE_3
						);
				}
				if(rEnemyVo.enemyTxtEffectId>0){//承受方的文字特效
					if(rEnemyVo.enemyTxtEffectId == RBattleConst.SEAL_PET_SUCCESS){
						dispatchSealPetEvent();
					}
					effectIntervalId19 = setTimeout(
						playEffect,
						getEffectTP(rEnemyVo.enemyTxtEffectId,int(aJsonObj.near.aEffect3TP)),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyTxtEffectId,
						RBattleConst.EFFECT_TYPE_4
					);
				}
				if(rEnemyVo.enemyPowerEffectId>0){//承受方的power
					effectIntervalId20 = setTimeout(
						playEffect,
						getEffectTP(rEnemyVo.enemyPowerEffectId,int(aJsonObj.near.aEffect3TP)),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyPowerEffectId,
						RBattleConst.EFFECT_TYPE_5
					);
				}
				if(rEnemyVo.enemyPowerDown!=0 || rEnemyVo.enemyPowerUp!=0){//power 处理
					effectIntervalId21 = setTimeout(
						powerHandler,
						int(aJsonObj.near.aEffect3TP),
						rEnemyVo.enemyBattleId,
						rEnemyVo.enemyChaId,
						rEnemyVo.enemyPowerDown,
						rEnemyVo.enemyPowerUp,
						rEnemyVo.enemyCurrentPower,
						rEnemyVo.enemyTotalPower
					);
				}
				var enemyBuffList:Array = new Array();
				var buffJsonObj:Object = bJsonObj[rEnemyVo.enemyProfessionType];
				var enemyBuffLen:int = rEnemyVo.enemyBuffShowList.length;
				for(var n:int=0;n<enemyBuffLen;n++){
					var rEnemybattleBuffVo:RBattleBuffVo = new RBattleBuffVo();
					rEnemybattleBuffVo = rEnemyVo.enemyBuffShowList[n] as RBattleBuffVo;
					buffIntervalId3 = setTimeout(
						playBuffEffect,
						int(aJsonObj.near.aEffect3TP),
						rEnemyVo.enemyBattleId,
						rEnemybattleBuffVo.buffEffectId,
						buffJsonObj,
						n,
						enemyBuffLen
					);
					enemyBuffList.push(rEnemybattleBuffVo.buffEffectId);
				}
				setChaBuffListInfo(rEnemyVo.enemyBattleId,enemyBuffList);
			}
			
		}
		/**
		 * 近程攻击第二部分，攻击结束，待机，返回移动，待机
		 * 攻击结束后为第二部分
		 */	
		private function nearAttackHandler2(chaBattleId:int):void{
			trace("近程 第二部分攻击");
			playAction(vo.chaBattleId,RBattleConst.ID_STAND,true);//待机
			//moveIntervalId = setTimeout(playAction,int(aJsonObj.near.aStandAfterAttackTP),vo.chaBattleId,RBattleConst.ID_WALK,true);//移动动作
			setTimeout(setRingVisible,int(aJsonObj.near.aStandAfterAttackTP),chaBattleId,false);
			moveCount = 0;
			moveIntervalId2 = setTimeout(moveHandler,int(aJsonObj.near.aStandAfterAttackTP),vo.chaBattleId);//移动，待机后移动，需要延时
			//moveHandler(vo.chaBattleId);//移动
			standIntervalId3 = setTimeout(//待机
				playAction,int(aJsonObj.near.aStandAfterReturnTP),vo.chaBattleId,RBattleConst.ID_STAND,true
			);
			
		}
		/**
		 * 移动角色 
		 */		
		private function moveHandler(chaBattleId:int):void{
			if(moveCount==move_Count){
				chaTrackPointArray = chaTrackPointArray.reverse();
				moveCount = 0;
				//clearMoveTimeout();
				return;
			}else{
				var chaEnt:IEntity = getCharacterEntity(chaBattleId);
				if(!chaEnt){
					return;
				}
				var chaSpatial:Box2DSpatialComponent = 
					chaEnt.lookupComponentByName("Spatial") as Box2DSpatialComponent;
				chaSpatial.position = chaTrackPointArray[moveCount] as Point;//取数组中的坐标
				moveIntervalId3 = setTimeout(moveHandler,int(aJsonObj.near.aMoveStepTD),chaBattleId);//递归
				moveCount++;//计数器加，先自增，再移动
			}
		}
		/**
		 * 待机 
		 */		
		private function idleHandler(chaBattleId:int, chaProfessionType:int):void {
			xtrace("播放待机动作 charid " + chaBattleId + " protype  " + chaProfessionType);
			trace("待机战场ID:"+chaBattleId);
			/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			var res_id:String = res.get_fight_action_res_id(chaProfessionType, RBattleConst.ID_STAND);
			var mc:MovieClip = res.get_fight_mc_bitmapdata(res_id, RBattleConst.C_Action_Name);*/
			
			var resId:String = String(chaProfessionType)+String(RBattleConst.ID_STAND);
			var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(resId,RLoadHelper.MC_ACTION_CLS);
			
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;

			chaRender.clip=mc;
			chaRender.updateTransform(true);
		}
		/**
		 * 播放远程攻击，攻击者动作
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 * 
		 */		
		private function playFarChaAttackAction(chaBattleId:int,actionId:int,needCombination:Boolean=false,
												chaId:int=0,currentHp:int=0,changeExpendHp:int=0,totalHp:int=0):void{
			
			var chaRender:RBattleChaMcRender = baseActionHandler(chaBattleId,actionId,needCombination);
			if(!chaRender){
				return;
			}
			/*========很重要，条件不要写反，此处曾经写反调了俩小时！！！！！！==========*/
			if(!needCombination){//不需要组合的ID，比如：攻击，防御，死亡
				//添加事件监听，对攻击，防御，死亡动作播放监听，播放完后以进行相关操作
				chaRender.clip.addEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,
					function actionPlayBackFinishHandler(event:Event):void{
						chaRender.clip.removeEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,actionPlayBackFinishHandler);
						trace("actionName:" + event.type + "--" + Object(event).actionType);
						var charpro:int = get_char_pro(chaBattleId);
						idleHandler(chaBattleId,charpro);//攻击完后待机
					}
				);
				chaRender.clip.gotoAndPlay(1);
			}
			//if(changeExpendHp != 0){//如果技能烧HP，播放动作时改变自身HP
				hpHandler(chaBattleId,chaId,currentHp,changeExpendHp,totalHp);
			//}
		}
		/**
		 * 播放远程攻击，受击者动作
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 * 
		 */		
		private function playFarEnemyAttackAction(chaBattleId:int,actionId:int,needCombination:Boolean=false,chaProfesstionType:int=-1,
												  chaId:int=0,currentHp:int=0,changeHp:int=0,totalHp:int=0,effectId:int=-1):void{
			
			var chaRender:RBattleChaMcRender = baseActionHandler(chaBattleId,actionId,needCombination);
			if(!chaRender){
				return;
			}
			/*========很重要，条件不要写反，此处曾经写反调了俩小时！！！！！！==========*/
			if(!needCombination){//不需要组合的ID，比如：攻击，防御，死亡
				//添加事件监听，对攻击，防御，死亡动作播放监听，播放完后以进行相关操作
				chaRender.clip.addEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,
					function actionPlayBackFinishHandler(event:Event):void{
						chaRender.clip.removeEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,actionPlayBackFinishHandler);
						trace("actionName:"+event.type+"--"+Object(event).actionType);
						this.actionType = int(Object(event).actionType);
						countInAoe+=1;
						if(this.actionType==RBattleConst.DEATH_PLAY_BACK_FINISH){//死亡动作
							trace("受击目标已挂掉");
							setRingVisible(chaBattleId,false);
							if(countInAoe == enemyChaCount){
								standIntervalId4 = setTimeout(//回合结束
									oneRoundOverEventDispatch,getNextRoundTP(),chaBattleId
								);
							}
							removeChaBuffEffect(chaBattleId);
						}else{//未死
							trace("受击目标待机:"+chaBattleId);
							idleHandler(chaBattleId,chaProfesstionType);//受击方待机
							setRingVisible(chaBattleId,false);
							if(countInAoe == enemyChaCount){
								standIntervalId5 = setTimeout(//回合结束
									oneRoundOverEventDispatch,getNextRoundTP(),chaBattleId
								);
							}
						}
					}
				);
				chaRender.clip.gotoAndPlay(1);
			}
			//if(changeHp != 0){
				hpHandler(chaBattleId,chaId,currentHp,changeHp,totalHp,effectId);
			//}
		}
		/**
		 * 播放攻击方动作 
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 * 
		 */		
		private function playAction(chaBattleId:int,actionId:int,needCombination:Boolean=false,
									chaId:int=0,currentHp:int=0,changeExpendHp:int=0,totalHp:int=0):void{
			var chaRender:RBattleChaMcRender = baseActionHandler(chaBattleId,actionId,needCombination);
			if(!chaRender){
				return;
			}
			/*if(isCritical){//暴击设置近程角色不可见
				chaRender.alpha=0;
			}else{
				chaRender.alpha=1;
			}*/
			/*========很重要，条件不要写反，此处曾经写反调了俩小时！！！！！！==========*/
			if(!needCombination){//不需要组合的ID，比如：攻击，防御，死亡
				//添加事件监听，对攻击，防御，死亡动作播放监听，播放完后以进行相关操作
				chaRender.clip.addEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,
					function actionPlayBackFinishHandler(event:Event):void{
						chaRender.clip.removeEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,actionPlayBackFinishHandler);
						trace("actionName:" + event.type + "--" + Object(event).actionType);
						var charpro:int = get_char_pro(chaBattleId);
						idleHandler(chaBattleId,charpro);//播放完动作以后待机
						//chaRender.alpha=1;//重新设置角色可见
					}
				);
				chaRender.clip.gotoAndPlay(1);
			}
			//if(changeExpendHp != 0){//如果技能烧HP，播放动作时改变自身HP
				hpHandler(chaBattleId,chaId,currentHp,changeExpendHp,totalHp);
			//}
		}
		/**
		 * 播放受击者动作
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param chaId 要播放的角色实际ID，可能会用来向外部传消息
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 * 
		 */		
		private function playEnemyAction(chaBattleId:int,actionId:int,needCombination:Boolean=false,chaProfesstionType:int=-1,
										 chaId:int=0,currentHp:int=0,changeHp:int=0,totalHp:int=0):void{
			
			var chaRender:RBattleChaMcRender = baseActionHandler(chaBattleId,actionId,needCombination);
			if(!chaRender){
				return;
			}
			/*========很重要，条件不要写反，此处曾经写反调了俩小时！！！！！！==========*/
			if(!needCombination){//不需要组合的ID，比如：攻击，防御，死亡
				//添加事件监听，对攻击，防御，死亡动作播放监听，播放完后以进行相关操作
				chaRender.clip.addEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,
					function actionPlayBackFinishHandler(event:Event):void{
						chaRender.clip.removeEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,actionPlayBackFinishHandler);
						trace("actionName:"+event.type+"--"+Object(event).actionType);
						this.actionType = int(Object(event).actionType);
						countInAoe+=1;
						if(this.actionType==RBattleConst.DEATH_PLAY_BACK_FINISH){//死亡动作
							trace("受击目标已挂掉");
							//setTimeout(nearAttackHandler2,getNextRoundTP());//主动方返回
							nearAttackHandler2(chaBattleId);
							if(countInAoe == enemyChaCount){
								standIntervalId6 = setTimeout(//待机
									oneRoundOverEventDispatch,getNextRoundTP(),chaBattleId
								);
							}
							removeChaBuffEffect(chaBattleId);
						}else{//未死
							//判断是否有反击
							trace("受击目标还活着");
							idleHandler(chaBattleId,chaProfesstionType);//受攻击目标先待机
							if(enemyCounterHitVo.enemyCounterHit == RBattleConst.ENEMY_COUNTER_HIT_0){//没有反击
								trace("受攻击目标无反击");
								//idleHandler(chaBattleId);//受攻击目标待机
								//setTimeout(nearAttackHandler2,getNextRoundTP());//主动方返回
								nearAttackHandler2(chaBattleId);
								if(countInAoe == enemyChaCount){
									standIntervalId7 = setTimeout(//待机
										oneRoundOverEventDispatch,getNextRoundTP(),chaBattleId
									);
								}
							}else if(enemyCounterHitVo.enemyCounterHit == RBattleConst.ENEMY_COUNTER_HIT_1){//反击
								trace("受攻击目标反击");
								//idleHandler(chaBattleId);//受攻击目标先待机
								setRingVisible(enemyCounterHitVo.enemyBattleId,false);//设置挨打目标
								setRingVisible(vo.chaBattleId,true);//设置挨打目标
								counterHitIntervalId1 = setTimeout(//受攻击目标反击
									playCounterHitChaAction,
									int(aJsonObj.near.bCounterHitTP),
									enemyCounterHitVo.enemyBattleId,
									enemyCounterHitVo.enemyCounterHitActionId,
									false,
									enemyCounterHitVo.enemyChaId,
									enemyCounterHitVo.enemyCurrentHp,
									enemyCounterHitVo.enemyChangeHp,
									enemyCounterHitVo.enemyTotalHp
								);
								//获取反击对象
								var counterHitObj:Object = getBattleJsonObj(enemyCounterHitVo.enemyCounterHitActionId);
								if(enemyCounterHitVo.chaEffectId>0){//反击特效
									effectIntervalId22 = setTimeout(
										playEffect,
										getEffectTP(enemyCounterHitVo.chaEffectId,int(counterHitObj.near.bCounterHitEffect1TP)),
										enemyCounterHitVo.enemyBattleId,
										enemyCounterHitVo.chaEffectId,
										RBattleConst.EFFECT_TYPE_1
									);
								}
								effectIntervalId23 = setTimeout(//反击文字特效，固定！
									playEffect,
									getEffectTP(RBattleConst.COUNTER_HIT_EFFECT_1,int(counterHitObj.near.bCounterHitEffect1TP)),
									enemyCounterHitVo.enemyBattleId,
									RBattleConst.COUNTER_HIT_EFFECT_1,
									RBattleConst.EFFECT_TYPE_4
								);
								counterHitIntervalId2 = setTimeout(//受攻击目标反击后，主动攻击的防御动作
									playCounterHitEnemyAction,
									int(aJsonObj.near.aDefenseTP),
									vo.chaBattleId,
									vo.counterHitActionId,
									false,
									vo.chaId,
									vo.chaCurrentHp,
									vo.chaChangeHp,
									vo.chaTotalHp
								);
								if(enemyCounterHitVo.chaEnemyEffectId>0){//反击承受特效
									effectIntervalId24 = setTimeout(
										playEffect,
										getEffectTP(enemyCounterHitVo.chaEnemyEffectId,int(counterHitObj.near.bCounterHitEffect3TP)),
										vo.chaBattleId,
										enemyCounterHitVo.chaEnemyEffectId,
										RBattleConst.EFFECT_TYPE_3
									);
								}
								if(enemyCounterHitVo.chaThrowEffectId>0){//反击投射特效，比如法师反击
									//var effect2JsonObj:Object = new Object();
									//effect2JsonObj = decodeJsonHandler(enemyCounterHitVo.chaThrowEffectId);
									
									/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
									var effect2JsonObj_id:String = res.get_fight_config_id(enemyCounterHitVo.chaThrowEffectId);
									var effect2JsonObj:Object = res.get_fight_config_obj(effect2JsonObj_id);*/
									
									var effect2JsonObj:Object = RLoadHelper.getInstance().getBattleInfoById(enemyCounterHitVo.chaThrowEffectId);
									
									//var effectLineSegmentCount:int = int(effect2JsonObj.effect.effectTD)/int(effect2JsonObj.effect.effectMoveStepTD);
									//throw_Effect_Move_Count = effectLineSegmentCount+1;
									throw_Effect_Move_Count = int(effect2JsonObj.effect.effectMoveCount);
									setEffectPoint2Offset(enemyCounterHitVo.chaThrowEffectId);
									var effectPoint2:Point;
									var effectDefensePoint2:Point;
									if(enemyCounterHitVo.enemyDirection == RDirectionVo.RIGHT_DIRECTION){
										effectPoint2 = new Point(
											int(bJsonObj[enemyCounterHitVo.enemyProfessionType].battlePoint.effectPoint2[0])+enemyCounterHitVo.enemyStartPos.x,
											int(bJsonObj[enemyCounterHitVo.enemyProfessionType].battlePoint.effectPoint2[1])+enemyCounterHitVo.enemyStartPos.y
										);
										effectDefensePoint2 = new Point(
											int(bJsonObj[vo.chaProfessionType].battlePoint.effectDefensePoint2[0])+enemyCounterHitVo.enemyTargetPos.x+effectPoint2End.x,
											int(bJsonObj[vo.chaProfessionType].battlePoint.effectDefensePoint2[1])+enemyCounterHitVo.enemyTargetPos.y+effectPoint2End.y
										);
									}else{
										effectPoint2 = new Point(
											-int(bJsonObj[enemyCounterHitVo.enemyProfessionType].battlePoint.effectPoint2[0])+enemyCounterHitVo.enemyStartPos.x,
											int(bJsonObj[enemyCounterHitVo.enemyProfessionType].battlePoint.effectPoint2[1])+enemyCounterHitVo.enemyStartPos.y
										);
										effectDefensePoint2 = new Point(
											-int(bJsonObj[vo.chaProfessionType].battlePoint.effectDefensePoint2[0])+enemyCounterHitVo.enemyTargetPos.x-effectPoint2End.x,
											int(bJsonObj[vo.chaProfessionType].battlePoint.effectDefensePoint2[1])+enemyCounterHitVo.enemyTargetPos.y+effectPoint2End.y
										);
									}
									setThrowEffectAngle(effectPoint2,effectDefensePoint2);//设置投射特效的角度
									throwEffectPointArray = 
										UtilityTemp.getInstance().getPointsArr(effectPoint2,effectDefensePoint2,throw_Effect_Move_Count);
									throwEffectInitPos = throwEffectPointArray[0] as Point;
									moveIntervalId4 = setTimeout(throwEffectMoveHandler,int(effect2JsonObj.effect.effectMoveTP),int(effect2JsonObj.effect.effectMoveStepTD));//投射特效移动
									throwEffectIntervalId2 = 
										setTimeout(playThrowEffect,int(effect2JsonObj.effect.effectTP),enemyCounterHitVo.enemyBattleId,vo.chaBattleId,enemyCounterHitVo.chaThrowEffectId,RBattleConst.EFFECT_TYPE_2);
								}
							}
						}
					}
				);
				chaRender.clip.gotoAndPlay(1);
			}
			//if(changeHp != 0){
				hpHandler(chaBattleId,chaId,currentHp,changeHp,totalHp);
			//}
		}
		/**
		 * 播放反击时的主动方动作 
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 */		
		private function playCounterHitChaAction(chaBattleId:int,actionId:int,needCombination:Boolean=false,
												 chaId:int=0,currentHp:int=0,changeHp:int=0,totalHp:int=0):void{
			
			var chaRender:RBattleChaMcRender = baseActionHandler(chaBattleId,actionId,needCombination);
			if(!chaRender){
				return;
			}
			/*========很重要，条件不要写反，此处曾经写反调了俩小时！！！！！！==========*/
			if(!needCombination){//不需要组合的ID，比如：攻击，防御，死亡
				//添加事件监听，对攻击，防御，死亡动作播放监听，播放完后以进行相关操作
				chaRender.clip.addEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,
					function actionPlayBackFinishHandler(event:Event):void{
						chaRender.clip.removeEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,actionPlayBackFinishHandler);
						trace("actionName:"+event.type+"--"+Object(event).actionType);
						this.actionType = int(Object(event).actionType);
						idleHandler(enemyCounterHitVo.enemyBattleId,enemyCounterHitVo.enemyProfessionType);
					}
				);
				chaRender.clip.gotoAndPlay(1);
			}
			/*if(changeHp != 0){//反击时不掉HP
				hpHandler(chaBattleId,chaId,currentHp,changeHp,totalHp);
			}*/
		}
		/**
		 * 播放反击时的受击者动作 
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 */		
		private function playCounterHitEnemyAction(chaBattleId:int,actionId:int,needCombination:Boolean=false,
												   chaId:int=0,currentHp:int=0,changeHp:int=0,totalHp:int=0):void{
			
			var chaRender:RBattleChaMcRender = baseActionHandler(chaBattleId,actionId,needCombination);
			if(!chaRender){
				return;
			}
			/*========很重要，条件不要写反，此处曾经写反调了俩小时！！！！！！==========*/
			if(!needCombination){//不需要组合的ID，比如：攻击，防御，死亡
				//添加事件监听，对攻击，防御，死亡动作播放监听，播放完后以进行相关操作
				chaRender.clip.addEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,
					function actionPlayBackFinishHandler(event:Event):void{
						chaRender.clip.removeEventListener(ActionEvent.ACTION_PLAY_BACK_FINISH_EVENT,actionPlayBackFinishHandler);
						trace("actionName:"+event.type+"--"+Object(event).actionType);
						this.actionType = int(Object(event).actionType);
						countInAoe+=1;
						if(this.actionType==RBattleConst.DEATH_PLAY_BACK_FINISH){//死亡动作
							trace("受反击目标已挂掉");
							//oneRoundOverEventDispatch();
							setRingVisible(chaBattleId,false);
							standIntervalId8 = setTimeout(//待机
								oneRoundOverEventDispatch,getNextRoundTP(),chaBattleId
							);
							removeChaBuffEffect(chaBattleId);
						}else{//未死
							//setTimeout(nearAttackHandler2,getNextRoundTP());//主动方返回
							nearAttackHandler2(chaBattleId);
							standIntervalId9 = setTimeout(//待机
								oneRoundOverEventDispatch,getNextRoundTP(),chaBattleId
							);
						}
					}
				);
				chaRender.clip.gotoAndPlay(1);
			}
			//if(changeHp != 0){
				hpHandler(chaBattleId,chaId,currentHp,changeHp,totalHp);
			//}
		}
		
		private function get_char_pro(charid:int):int {
			var chaEnt:IEntity = getCharacterEntity(charid);
			var charinfo:RCharacterInfoComponent = chaEnt.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			var pro:int = charinfo.chaProfessionType;
			return pro;
		}
		
		
		/**
		 * 基础动作处理 
		 * @param chaBattleId 要播放的角色战场ID，用来查找战场角色实体
		 * @param actionId 要播放的动作ID
		 * @param needCombination 动作ID是否需要组合,具体如下：
		 * 比如530需要组合成 "1"+"530"=1530。
		 * 而1530就不需要，目前只有待机，移动需要组合
		 */	
		private function baseActionHandler(chaBattleId:int,actionId:int,needCombination:Boolean=false):RBattleChaMcRender{
			actionSoundHandler(actionId);
			//var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			//var action_res_id:String
			var resId:String;
			if (needCombination) {
				resId = String(vo.chaProfessionType)+String(actionId);
				//action_res_id = res.get_fight_action_res_id(vo.chaProfessionType, actionId);
			}
			else {
				resId = String(actionId);
				//action_res_id = res.get_fight_res_id(actionId);
			}
			
			//var mc:MovieClip = res.get_fight_mc_bitmapdata(action_res_id, RBattleConst.C_Action_Name) as MovieClip;
			var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(resId,RLoadHelper.MC_ACTION_CLS);
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			if(chaEnt){
				var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;
				if(chaRender){
					chaRender.clip = mc;
					chaRender.updateTransform(true);
				}
			}
			return chaRender;
		}
		/**
		 * 特效播放类 
		 * @param chaBattleId 要播放的角色战场ID
		 * @param effectId 要播放的特效ID
		 */		
		private function playEffect(chaBattleId:int,effectId:int,effectType:int):void{
			if(effectId>0){
				var effectVo:RBattleEffectVo = new RBattleEffectVo();
				effectVo.effectId = effectId;
				dispatchEffectEvent(effectVo);
			}
			addEffect(chaBattleId,effectId,effectType);
		}
		/**
		 * 添加特效 
		 * @param chaBattleId 要添加特效的角色战场ID
		 * @param effectId 要添加特效的特效ID
		 */		
		private function addEffect(chaBattleId:int,effectId:int,effectType:int):void{
			var effectOffset:Point = new Point();
			//if(!vo.isCriticalBlow){
				effectOffset = getEffectOffsetPoint(effectId);
			//}
			//基本信息
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;
			var chaInfo:RCharacterInfoComponent = 
				chaEnt.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			
			var effectRenderName:String = "effectRender"+effectId;
			var effectRender:RBattleChaMcRender = chaEnt.lookupComponentByName(effectRenderName) as RBattleChaMcRender;
			if(effectRender){
				chaEnt.removeComponent(effectRender);
			}else{
				effectRender = new RBattleChaMcRender();
			}
			
			/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			var res_id:String = res.get_fight_res_id(effectId);
			var mc:MovieClip = res.get_fight_mc_bitmapdata(res_id, RBattleConst.C_Effect_Name);*/
			
			var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(effectId,RLoadHelper.MC_EFFECT_CLS);
			
			effectRender.clip = mc;
			effectRender.layerIndex = chaRender.layerIndex+1;
			effectRender.loop = false;
			var rEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
			rEnemyVo = vo.enemyChaArr[0] as RBattleEnemyVo;
			var posX:int;
			var posY:int;
			if(vo.isCriticalBlow && //暴击
				vo.chaAttackType == RBattleConst.ATTACK_TYPE_FAR//远程攻击
			){
				if(effectType==RBattleConst.EFFECT_TYPE_1){
					if(aJsonObj){
						posX = int(aJsonObj.battlePoint.criticalEffectPosOffset1[0] + effectOffset.x);
						posY = int(aJsonObj.battlePoint.criticalEffectPosOffset1[1] + effectOffset.y);
					}
				}
				if(effectType==RBattleConst.EFFECT_TYPE_3){
					//暴击目标，目前只设置一个人。而不是整个数组
					if(bJsonObj){
						posX = effectOffset.x + int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.criticalEffectPosOffset3[0]);
						posY = effectOffset.y + int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.criticalEffectPosOffset3[1]);
					}
				}
			}else if(effectType==RBattleConst.EFFECT_TYPE_1 && !vo.isCriticalBlow){//1号特效处理
				if(aJsonObj){
					posX = int(aJsonObj.battlePoint.effectPoint1[0]+effectOffset.x);
					posY = int(aJsonObj.battlePoint.effectPoint1[1]+effectOffset.y);
				}
			}else if(effectType==RBattleConst.EFFECT_TYPE_3 && !vo.isCriticalBlow){//3号特效处理
				if(bJsonObj){
					posX = int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.effectPoint3[0]+effectOffset.x);
					posY = int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.effectPoint3[1]+effectOffset.y);
				}
			}else if(effectType==RBattleConst.EFFECT_TYPE_4){
				if(bJsonObj){
					posX = int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.txtEffectPoint[0]+effectOffset.x);
					posY = int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.txtEffectPoint[1]+effectOffset.y);
				}
			}else if(effectType==RBattleConst.EFFECT_TYPE_5){
				if(bJsonObj){
					posX = int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.powerPoint[0]+effectOffset.x);
					posY = int(bJsonObj[rEnemyVo.enemyProfessionType].battlePoint.powerPoint[1]+effectOffset.y);
				}
			}
			//被攻击对象在左边，面向右。注意：是被攻击对象
			if(chaInfo.chaCurrentDirection == RDirectionVo.RIGHT_DIRECTION && effectType!=RBattleConst.EFFECT_TYPE_4){
				posX = -posX;
			}
			effectRender.positionOffset = new Point(posX,posY);
			
			effectRender.scene = SceneHelper.getInstance().myScene;
			effectRender.positionProperty = new PropertyReference("@Spatial.position");
			if(vo.chaDirection == RDirectionVo.LEFT_DIRECTION){
				if((effectType==RBattleConst.EFFECT_TYPE_1&&vo.isCriticalBlow) || effectType==RBattleConst.EFFECT_TYPE_3 || effectType==RBattleConst.EFFECT_TYPE_1){
					effectRender.scale = new Point(-Math.abs(effectRender.scale.x),effectRender.scale.y);
				}
			}
			chaEnt.addComponent(effectRender,effectRenderName);
			effectRender.clip.addEventListener(ActionEffectEvent.EFFECT_PLAY_BACK_FINISH_EVENT,
				function effectPlayBackFinishHandler(event:Event):void{
					effectRender.clip.removeEventListener(ActionEffectEvent.EFFECT_PLAY_BACK_FINISH_EVENT,effectPlayBackFinishHandler);
					if(effectRender.owner){
						trace("addEffect -- effectName:"+event.type+"-- 播放完特效，移除："+effectRender.owner+" -- "+chaEnt.name);
						effectRender.owner.removeComponent(effectRender);
					}
				}
			);
			
			//多次震屏效果
			var vibrateTPArr:Array = getVibrateArr(effectId);
			if(vibrateTPArr){
				var len:int = vibrateTPArr.length;
				for(var i:int=0;i<len;i++){
					vibrateIntervalId1 = setTimeout(screenVibrateHandler,int(vibrateTPArr[i]));
				}
			}
			
		}
		private function playAoeEffect(effectId:int):void{
			if(effectId>0){
				var effectVo:RBattleEffectVo = new RBattleEffectVo();
				effectVo.effectId = effectId;
				dispatchEffectEvent(effectVo);
			}
			addAoeEffect(effectId);
		}
		private function addAoeEffect(effectId:int):void{
			
			//var swfFileName:String = String(effectId);
			//var effectUrl:String = getSwfFileUrl(vo.chaProfessionType, effectId, false);
			
			/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			var res_id:String = res.get_fight_res_id(effectId);
			var mc:MovieClip = res.get_fight_mc_bitmapdata(res_id, RBattleConst.C_Effect_Name);*/
			
			var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(effectId,RLoadHelper.MC_EFFECT_CLS);
			
			
			var aoeEffectEnt:IEntity = getAoeEffectEntity();
			var effectRender:RBattleChaMcRender;
			effectRender = aoeEffectEnt.lookupComponentByName(RBattleConst.AOE_EFFECT_RENDER_NAME) as RBattleChaMcRender;
			if(effectRender){
				aoeEffectEnt.removeComponent(effectRender);
			}else{
				effectRender = new RBattleChaMcRender();
			}

			effectRender.clip = mc;
			effectRender.layerIndex = 180;//在角色特定的后面
			effectRender.loop = false;
			effectRender.scene = SceneHelper.getInstance().myScene;
			effectRender.positionProperty = new PropertyReference("@Spatial.position");
			if(vo.chaDirection == RDirectionVo.LEFT_DIRECTION){
				effectRender.scale = new Point(-Math.abs(effectRender.scale.x),effectRender.scale.y);
			}
			aoeEffectEnt.addComponent(effectRender,RBattleConst.AOE_EFFECT_RENDER_NAME);
			effectRender.clip.addEventListener(ActionEffectEvent.EFFECT_PLAY_BACK_FINISH_EVENT,
				function effectPlayBackFinishHandler(event:Event):void{
					effectRender.clip.removeEventListener(ActionEffectEvent.EFFECT_PLAY_BACK_FINISH_EVENT,effectPlayBackFinishHandler);
					if(effectRender.owner){
						trace("addAoeEffect -- effectName:"+event.type+"-- 播放完特效，移除："+effectRender.name);
						effectRender.owner.removeComponent(effectRender);
					}
				}
			)
		}
		/**
		 * 移动投射特效 
		 * @param effectMoveStepTD 移动的步长
		 * 
		 */				
		private function throwEffectMoveHandler(effectMoveStepTD:int):void{
			if(throwEffectMoveCount==throw_Effect_Move_Count+1){
				throwEffectPointArray = [];
				throwEffectMoveCount = 0;
				clearTimeout(throwMoveIntervalId);
				removeThrowEffect();
				return;
			}else{
				//trace(throwEffectMoveCount.toString());
				var throwEffectEnt:IEntity = getThrowEffectEntity();
				if(!throwEffectEnt){
					return;
				}
				var spatial:Box2DSpatialComponent = 
					throwEffectEnt.lookupComponentByName("Spatial") as Box2DSpatialComponent;
				spatial.position = throwEffectPointArray[throwEffectMoveCount] as Point;//取数组中的坐标
				trace("spatial.position "+spatial.position);
				throwMoveIntervalId = setTimeout(throwEffectMoveHandler,effectMoveStepTD,effectMoveStepTD);//递归
				throwEffectMoveCount++;//计数器加，先自增，再移动
			}
		}
		/**
		 * 播放投射特效 
		 * @param chaBattleId
		 * @param posStart
		 * @param posTarget
		 * @param effectId
		 * 
		 */		
		private function playThrowEffect(chaBattleId:int,enemyBattleId:int,effectId:int,effectType:int):void{
			clearTimeout(throwEffectIntervalId1);
			clearTimeout(throwEffectIntervalId2);
			if(effectId>0){
				var effectVo:RBattleEffectVo = new RBattleEffectVo();
				effectVo.effectId = effectId;
				dispatchEffectEvent(effectVo);
			}
			addThrowEffect(chaBattleId,enemyBattleId,effectId,effectType);
		}
		/**
		 * 添加投射特效 
		 * @param chaBattleId
		 * @param effectId
		 * 
		 */		
		private function addThrowEffect(chaBattleId:int,enemyBattleId:int,effectId:int,effectType:int):void{
			setEffectPoint2Offset(effectId);
			trace("throwEffectArray"+throwEffectPointArray.toString());
			trace("startPos"+effectPoint2Start.toString());
			trace("endPos"+effectPoint2End.toString());
			//var swfFileName:String = String(effectId);
			//var effectUrl:String = getSwfFileUrl(vo.chaProfessionType, effectId, false);
			
			/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			var res_id:String = res.get_fight_res_id(effectId);
			var mc:MovieClip = res.get_fight_mc_bitmapdata(res_id, RBattleConst.C_Effect_Name);*/
			
			var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(effectId,RLoadHelper.MC_EFFECT_CLS);
			
			
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;
			var chaInfo:RCharacterInfoComponent = 
				chaEnt.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			
			var throwEffectEnt:IEntity = getThrowEffectEntity();
			var spatial:Box2DSpatialComponent = throwEffectEnt.lookupComponentByName("Spatial") as Box2DSpatialComponent;
			spatial.position = throwEffectInitPos;
			var effectRender:RBattleChaMcRender;
			effectRender = throwEffectEnt.lookupComponentByName(RBattleConst.THROW_EFFECT_RENDER_NAME) as RBattleChaMcRender;
			if(effectRender){
				throwEffectEnt.removeComponent(effectRender);
			}else{
				effectRender = new RBattleChaMcRender();
			}
			effectRender.clip = mc;
			effectRender.layerIndex = chaRender.layerIndex+1;
			effectRender.loop = false;
			effectRender.scene = SceneHelper.getInstance().myScene;
			effectRender.positionProperty = new PropertyReference("@Spatial.position");
			effectRender.rotationProperty = new PropertyReference("@Spatial.rotation");
			if(vo.chaDirection == RDirectionVo.LEFT_DIRECTION){
				//effectRender.scale = new Point(-Math.abs(effectRender.scale.x),effectRender.scale.y);
				effectPoint2Start.x = -effectPoint2Start.x;
			}
			effectRender.positionOffset = effectPoint2Start;
			throwEffectEnt.addComponent(effectRender,RBattleConst.THROW_EFFECT_RENDER_NAME);
		}
		/**
		 * 设置相应角色的buffList，用来与新的BUFF列表比较 
		 * @param chaBattleId 要操作的角色ID
		 * @param buffList 要操作的buffList
		 * 
		 */		
		private function setChaBuffListInfo(chaBattleId:int,buffList:Array):void{
			var ent:IEntity = getCharacterEntity(chaBattleId);
			var chaInfo:RCharacterInfoComponent = 
				ent.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			chaInfo.buffListLast = chaInfo.buffList;
			//chaInfo.buffList = buffList;
			chaInfo.buffList = setRealBuffList(chaInfo.buffListLast,buffList,chaBattleId);
		}
		/**
		 * 设置bufflist为有效的真实bufflist如从[2,3,4]到[3,4,5]有效为[3,4,5]
		 * @param buffListLast
		 * @param buffList
		 * 
		 */		
		private function setRealBuffList(buffListLast:Array,buffList:Array,chaBattleId:int):Array{
			var arr1:Array = buffListLast;
			var arr2:Array = buffList;
			var len:int = buffList.length;
			for each(var effectId:int in arr1){
				if(!ArrayUtil.arrayContainsValue(arr2,effectId)){
					ArrayUtil.removeValueFromArray(arr1,effectId);
					//需要移除对应的特效
					removeChaBuffEffectById(chaBattleId,effectId);
				}
			}
			var arr:Array = getBuffIdList(arr1,arr2);
			return arr;
		}
		/**
		 * 连接数组 
		 */		
		private function contactArray(arr1:Array,arr2:Array):Array{
			var arr:Array = arr1;
			for(var i:int=0;i<arr2.length;i++){
				arr.push(arr2[i]);
			}
			return arr;
		}
		/**
		 * 获取不重复buff列表 
		 */		
		private function getBuffIdList(arr1:Array,arr2:Array):Array{
			var arr:Array = [];
			arr = contactArray(arr1,arr2);
			arr = ArrayUtil.createUniqueCopy(arr)
			return arr;
		}
		private function removeChaBuffEffectById(chaBattleId:int,effectId:int):void{
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			if(chaEnt){
				var effectId:int = effectId;
				//基本信息
				var effectRenderName:String = "effectRender"+effectId;
				var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;
				var effectRender:RBattleChaMcRender;
				effectRender = chaEnt.lookupComponentByName(effectRenderName) as RBattleChaMcRender;
				if(effectRender){
					chaEnt.removeComponent(effectRender);
				}
			}
		}
		/**
		 * 移除角色身上的效果 
		 * @param chaBattleId
		 * 
		 */		
		private function removeChaBuffEffect(chaBattleId:int):void{
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			var chaInfo:RCharacterInfoComponent = 
				chaEnt.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			var buffListLast:Array = chaInfo.buffListLast;
			var len:int = buffListLast.length;
			for(var i:int=0;i<len;i++){
				var effectId:int = int(buffListLast[i]);
				//基本信息
				var effectRenderName:String = "effectRender"+effectId;
				var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;
				var effectRender:RBattleChaMcRender;
				effectRender = chaEnt.lookupComponentByName(effectRenderName) as RBattleChaMcRender;
				if(effectRender){
					chaEnt.removeComponent(effectRender);
				}
			}
			//移除后重置
			chaInfo.buffListLast = chaInfo.buffList;
		}
		/**
		 * 特效播放类 
		 * @param chaBattleId 要播放的角色战场ID
		 * @param effectId 要播放的特效ID
		 * @param buffJsonObj 要操作的buff对应的json对象，可以是aJsonObj也可以是bJsonObj[角色类型]
		 * @param currentBuffIndex 当前操作的buff索引
		 * @param totalBuffLen buff总数
		 */		
		private function playBuffEffect(chaBattleId:int,effectId:int,buffJsonObj:Object,currentBuffIndex:int,totalBuffLen:int):void{
			if(effectId>0){
				var effectVo:RBattleEffectVo = new RBattleEffectVo();
				effectVo.effectId = effectId;
				dispatchEffectEvent(effectVo);
			}
			addBuffEffect(chaBattleId,effectId,buffJsonObj,currentBuffIndex,totalBuffLen);
		}
		/**
		 * 添加特效 
		 * @param chaBattleId 要添加的角色战场ID
		 * @param effectId 要添加的特效ID
		 * @param buffJsonObj 要操作的buff对应的json对象，可以是aJsonObj也可以是bJsonObj[角色类型]
		 * @param currentBuffIndex 当前操作的buff索引
		 * @param totalBuffLen buff总数
		 */		
		private function addBuffEffect(chaBattleId:int,effectId:int,buffJsonObj:Object,currentBuffIndex:int,totalBuffLen:int):void{
			if(effectId<0||effectId==0){
				return;
			}
			//基本信息
			var effectRenderName:String = "effectRender"+effectId;
			
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			var chaRender:RBattleChaMcRender = chaEnt.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender;
			
			var effectRender:RBattleChaMcRender;
			effectRender = chaEnt.lookupComponentByName(effectRenderName) as RBattleChaMcRender;
			var chaInfo:RCharacterInfoComponent = 
				chaEnt.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			if(!effectRender){
				/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
				var res_id:String = res.get_fight_res_id(effectId);
				var mc:MovieClip = res.get_fight_mc_bitmapdata(res_id, RBattleConst.C_Effect_Name);*/
				
				var mc:MovieClip = RLoadHelper.getInstance().getBattleResMc(effectId,RLoadHelper.MC_EFFECT_CLS);
				
				
				effectRender = new RBattleChaMcRender();
				//var McClass:Class = this.loader.get(effectUrl).getDefinition(RBattleConst.C_Effect_Name) as Class;
				//var mc:MovieClip = new McClass();
				effectRender.clip=mc;
				effectRender.layerIndex = chaRender.layerIndex+1;
				
				var posX:int;
				var posY:int;
				if(buffJsonObj){
					posX = int(buffJsonObj.battlePoint.buffPoint[0]);
					posY = int(buffJsonObj.battlePoint.buffPoint[1]);
				}
				
				effectRender.positionOffset = new Point(posX,posY);
				effectRender.scene = SceneHelper.getInstance().myScene;
				effectRender.positionProperty = new PropertyReference("@Spatial.position");
				if(vo.chaDirection == RDirectionVo.LEFT_DIRECTION){
					effectRender.scale = new Point(-Math.abs(effectRender.scale.x),effectRender.scale.y);
				}
				chaEnt.addComponent(effectRender,effectRenderName);
			}
			//如果操作的是buffList中的最后一个。移除全部多余的buff效果
			/*var realIndex = currentBuffIndex+1;
			if(realIndex == totalBuffLen){
				removeChaBuffEffect(chaBattleId);
			}*/
			
		}
		/**
		 * 暴击时多次挨打动作播放 
		 * @param tp
		 * 
		 */		
		private function playDefenseActionForCritical(tp:int):void{
			//攻击的同时B要受击，有延时，但是可同时处理
			//受击目录为数组，因为可能是群体攻击
			var len:int = vo.enemyChaArr.length;
			for(var i:int=0;i<len;i++){
				var rEnemyVo:RBattleEnemyVo = new RBattleEnemyVo();
				rEnemyVo = vo.enemyChaArr[i] as RBattleEnemyVo;
				defenseIntervalId4 = setTimeout(//挨打
					playEnemyAction,
					tp,
					rEnemyVo.enemyBattleId,
					rEnemyVo.enemyActionId,
					false,
					rEnemyVo.enemyProfessionType,
					rEnemyVo.enemyChaId,
					rEnemyVo.enemyCurrentHp,
					rEnemyVo.enemyChangeHp,
					rEnemyVo.enemyTotalHp
				);
				/*if(vo.chaEnemyEffectId>0){//承受特效与受击动作同时发生
				effectIntervalId = setTimeout(playEffect,int(aJsonObj.near.bDefenseTP),rEnemyVo.enemyBattleId,vo.chaEnemyEffectId);
				}*/
			}
		}
		/**
		 * 结束一回合，发送事件 
		 */		
		private function oneRoundOverEventDispatch(battleId:int):void{
			trace("==============================================="+getNextRoundTP());
			//setRingVisible(battleId,false);
			countInAoe = 0;
			enemyChaCount = 0;
			clearAllInterval();
			removeAllCriticalEnt();
			moveCount = 0;
			PBE.mainClass.dispatchEvent(new RBattleRoundEvent(
				RBattleRoundEvent.ONE_ROUND_OVER_EVENT,rAllRoundCount,rCurrentRoundCount)
			);
			/*if(rAllRoundCount == rCurrentRoundCount+1){//战斗全部回合完成，移除tip
				PBE.mainStage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);
				hideBattleTip();
			}*/
		}
		/**
		 * 处理powerDown和powerUp情况 
		 * @param chaBattleId
		 * @param chaId
		 * @param powerDown
		 * @param powerUp
		 * @param currentPower
		 * @param totalPower
		 * 
		 */		
		private function powerHandler(chaBattleId:int,chaId:int,powerDown:int,powerUp:int,currentPower:int,totalPower:int):void{
			getBattleTipData();
			battleRoundUIVoHandler();
			
			//POWER CHANGE
			var ent:IEntity = getCharacterEntity(chaBattleId);
			var infoCmp:RCharacterInfoComponent = 
				ent.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			if(infoCmp.isChaSelf){//只显示自己的power
				if(powerDown!=0 || powerUp!=0){
					var powerVo:RBattlePowerVo = new RBattlePowerVo();
					powerVo.powerDown = powerDown;
					powerVo.powerUp = powerUp;
					powerVo.currentPower = currentPower;
					powerVo.totalPower = totalPower;
					dispatchPowerChangeEvent(powerVo);
				}
			}
		}
		/**
		 * 处理战斗中本回合要发送到UI的数据 
		 */		
		private function battleRoundUIVoHandler():void{
			var uiVo:RBattleRoundUIVo = new RBattleRoundUIVo();
			uiVo.chaId = vo.chaId;
			uiVo.chaBattleId = vo.chaBattleId;
			uiVo.chaName = vo.chaName;
			uiVo.chaLevel = vo.chaLevel;
			uiVo.chaProfessionType = vo.chaProfessionType;
			uiVo.chaCurrentPower = vo.chaCurrentPower;
			uiVo.chaPowerDown = vo.chaPowerDown;
			uiVo.chaPowerUp = vo.chaPowerUp;
			uiVo.chaBuffShowList = vo.chaBuffShowList;
			uiVo.enemyChaArr = vo.enemyChaArr;
			
			dispatchBattleRoundUIVoEvent(uiVo);
		}
		/**
		 * 处理hpNumber和hpStateBar  
		 * @param chaBattleId
		 * @param chaId 要处理的角色存在数据库中的真实ID
		 * @param currentHp
		 * @param changeHp
		 * @param totalHp
		 * 
		 */			
		private function hpHandler(chaBattleId:int,chaId:int,currentHp:int,changeHp:int,totalHp:int,effectId:int=-1):void{
			if(changeHp == 0){
				return;
			}
			var arr:Array;
			if(effectId>0){
				arr = getVibrateArr(effectId);
			}
			getBattleTipData();
			//只有掉血才会有mask显示
			if(changeHp<0){
				var hpChangePercent:Number = Math.abs(changeHp)/totalHp;
				if((hpChangePercent>0.3 || vo.isCriticalBlow) && (chaId == SystemDataModel.roleId)){//是自己受击红色才显示
					maskShow();
				}
				if(!arr && hpChangePercent>0.3){
					screenVibrateHandler();
				}
			}
			updateHpNumber(chaBattleId,changeHp);
			updateStateBar(chaBattleId,currentHp,changeHp,totalHp);
			Logger.print(this,chaId + " --currentHp: " + currentHp + " --changeHp: " + changeHp + " --totalHp:" + totalHp);
		}
		/**
		 * 玩家战斗中血量改变数字显示 
		 * @param chaBattleId 要显示血量变化的玩家ID
		 * @param changeHp 要显示的血量变化值
		 * 
		 */		
		private function updateHpNumber(chaBattleId:int,changeHp:int):void{
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			if(chaEnt){
				var hpNumberMcRender:RMovieClipRenderer = 
					chaEnt.lookupComponentByName(RBattleConst.HP_NUMBER_RENDER_NAME) as RMovieClipRenderer;
				var mc:MovieClip = hpNumberMcRender.clip;
				var hpMc:MovieClip = mc.getChildByName("hpMc") as MovieClip;
				(hpMc.getChildByName("hpNumberTxt") as TextField).text = String(changeHp);
				if(vo.isCriticalBlow){
					newFormat.size = 44;
				}else{
					newFormat.size = 26;
				}
				(hpMc.getChildByName("hpNumberTxt") as TextField).setTextFormat(newFormat);
				mc.gotoAndPlay(1);
			}
		}
		private var newFormat:TextFormat = new TextFormat();
		/**
		 * 改变战斗中的血条
		 * 某些技能可能会使自己和敌人都掉HP，所以这里直接传相应参数 
		 * @param chaId 要改变血条的角色 ID
		 * @param currentHp 要改变角色当前的HP
		 * @param changeHp 角色本局的HP变化，如：-45
		 * @param totalHp 角色的总HP
		 * 
		 */		
		private function updateStateBar(chaBattleId:int,currentHp:int,changeHp:int,totalHp:int):void{
			Logger.print(this,"当前掉HP的角色："+chaBattleId+" --当前HP："+currentHp+" --本局掉HP："+changeHp+" --总HP："+totalHp);
			
			var chaEnt:IEntity = getCharacterEntity(chaBattleId);
			if(chaEnt){
				var chaInfoComponent:RCharacterInfoComponent = 
					chaEnt.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
				
				//BOSS HP CHANGE 与角色不同，需要单独处理
				if(chaInfoComponent.chaProfessionType>RCharacterConst.BOSS_MONSTER_TYPE){
					//BOSS CHANGE HP
					var bossVo:RBattleBossVo = new RBattleBossVo();
					bossVo.changeHp = changeHp;
					bossVo.currentHp = currentHp;
					bossVo.totalHp = totalHp;
					dispatchBossHpChangeEvent(bossVo);
					return;
				}
				if(!chaEnt.lookupComponentByName("hpMcRender")){
					return;
				}
				//为滚动条宽度
				var hpImgWidth:int;
				//50为MC的总帧数
				var hpBarFrame:int;
				var targetHp:int = currentHp+changeHp;
				if(chaInfoComponent){
					if(chaInfoComponent.chaProfessionType>RCharacterConst.BOSS_MONSTER_TYPE && 
						chaInfoComponent.chaProfessionType < RCharacterConst.NPC_TYPE){
						hpImgWidth = 
							int((targetHp)/totalHp*RBattleConst.HP_BOSS_IMG_WIDTH);
						if(hpImgWidth>RBattleConst.HP_BOSS_IMG_WIDTH){
							hpImgWidth = RBattleConst.HP_BOSS_IMG_WIDTH;
						}else if(hpImgWidth<2){
							hpImgWidth = 1;
						}
					}else{
						hpImgWidth = 
							int((targetHp)/totalHp*RBattleConst.HP_IMG_WIDTH);
						if(hpImgWidth>RBattleConst.HP_IMG_WIDTH){
							hpImgWidth = RBattleConst.HP_IMG_WIDTH;
						}else if(hpImgWidth<2){
							hpImgWidth = 0;
						}
					}
					
					//50为MC的总帧数
					hpBarFrame = 
						RBattleConst.HP_BAR_TOTAL_FRAME - 
						int((targetHp)/totalHp*RBattleConst.HP_BAR_TOTAL_FRAME);
					if(hpBarFrame>RBattleConst.HP_BAR_TOTAL_FRAME){
						hpBarFrame=RBattleConst.HP_BAR_TOTAL_FRAME;
					}else if(hpBarFrame<1){
						hpBarFrame=1;
					}
				}
				
				var hpMcRender:RHpMcRender = chaEnt.lookupComponentByName("hpMcRender") as RHpMcRender;
				if(hpMcRender){
					var mc:MovieClip = (chaEnt.lookupComponentByName("hpMcRender") as RHpMcRender).clip;
					var hpImg:MovieClip = mc.getChildByName("hpImg") as MovieClip;
					hpImg.width = hpImgWidth;
					hpMcRender.targetFrame = hpBarFrame;
				}
				
				if(hpBarFrame>RBattleConst.HP_BAR_TOTAL_FRAME ){
					trace("出错了，目标帧不能大于总帧数 HP-- "+RBattleConst.HP_BAR_TOTAL_FRAME);
				}
				
			}
		}
		private function clearMoveTimeout():void{
			for(var i:int=1;i<5;i++){
				clearTimeout(this[MOVE_INTERVAL_ID_STR+i]);
			}
		}
		private function clearEffectTimeout():void{
			for(var i:int=1;i<25;i++){
				clearTimeout(this[EFFECT_INTERVAL_ID_STR+i]);
			}
		}
		private function clearBuffTimeout():void{
			for(var i:int=1;i<4;i++){
				clearTimeout(this[BUFF_INTERVAL_ID_STR+i]);
			}
		}
		private function clearDefenseTimeout():void{
			for(var i:int=1;i<5;i++){
				clearTimeout(this[DEFENSE_INTERVAL_ID_STR+i]);
			}
		}
		private function clearVibrateTimeout():void{
			for(var i:int=1;i<5;i++){
				clearTimeout(this[VIBRATE_INTERVAL_ID_STR+i]);
			}
		}
		private function clearAllInterval():void{
			clearMoveTimeout();
			clearEffectTimeout();
			clearBuffTimeout();
			clearDefenseTimeout();
			clearVibrateTimeout();
			
			for(var i:int=1;i<10;i++){
				clearTimeout(this[STAND_INTERVAL_ID_STR+i]);
			}
			
			clearTimeout(throwEffectIntervalId1);
			clearTimeout(throwEffectIntervalId2);
			
			clearTimeout(attackIntervalId);
			clearTimeout(throwMoveIntervalId);
			
			clearTimeout(counterHitIntervalId1);
			clearTimeout(counterHitIntervalId2);
		}
		
		/**
		 * 获取暴击背景实体 
		 */		
		private function getCriticalBgEnt():IEntity{
			var ent:IEntity = PBE.nameManager.lookup(RBattleConst.CRITICAL_BG_ENTITI_NAME);
			return ent;
		}
		/**
		 * 获取暴击实体 
		 */		
		private function getCriticalEnt():IEntity{
			var ent:IEntity = PBE.nameManager.lookup(RBattleConst.CRITICAL_ENTITI_NAME);
			return ent;
		}
		/**
		 * 移除暴击相关实体 
		 */		
		private function removeAllCriticalEnt():void{
			var ent:IEntity = getCriticalEnt();
			var entBg:IEntity = getCriticalBgEnt();
			if(ent){
				ent.destroy();
			}
			if(entBg){
				entBg.destroy();
			}
		}
		/**
		 * 设置投射特效的角度 
		 * @param posStart 投射特效的起点
		 * @param posTarget 投射特点的终点
		 * 
		 */		
		private function setThrowEffectAngle(posStart:Point,posTarget:Point):void{
			var ent:IEntity = getThrowEffectEntity();
			var spatial:Box2DSpatialComponent = 
				ent.lookupComponentByName("Spatial") as Box2DSpatialComponent;
			//设置角度
			var tempX:int = posStart.x-posTarget.x;
			var tempY:int = posStart.y-posTarget.y;
			var throwRadian:Number = Math.atan2(tempX,tempY);
			var throwAngle:int = -throwRadian*180/Math.PI-90;
			if(throwRadian==0){
				throwAngle = 0;
			}else{
				throwAngle = -throwRadian*180/Math.PI-90;
			}
			
			if(posStart.toString() == posTarget.toString()){
				spatial.rotation = 0;
			}else{
				spatial.rotation = int(throwAngle);
			}
		}
		/**
		 * 获取群体攻击的全屏特效 
		 * @return 
		 */		
		private function getAoeEffectEntity():IEntity{
			var ent:IEntity = PBE.nameManager.lookup(RBattleConst.AOE_EFFECT_ENTITY_NAME);
			return ent;
		}
		/**
		 * 获取投射特效实体 
		 * @return 返回投射特效实体
		 */		
		private function getThrowEffectEntity():IEntity{
			var ent:IEntity = PBE.nameManager.lookup(RBattleConst.THROW_EFFECT_ENTITY_NAME);
			return ent;
		}
		/**
		 * 移除投射特效 
		 */		
		private function removeThrowEffect():void{
			var ent:IEntity = getThrowEffectEntity();
			if(ent){
				var throwEffectRender:RBattleChaMcRender = 
					ent.lookupComponentByName(RBattleConst.THROW_EFFECT_RENDER_NAME) as RBattleChaMcRender;
				if(throwEffectRender){
					ent.removeComponent(throwEffectRender);
				}
			}
		}
		/**
		 * 设置挨打光环的显示 
		 * @param value
		 * 
		 */		
		private function setRingVisible(battleId:int,value:Boolean):void{
			var ent:IEntity = getCharacterEntity(battleId);
			if(ent){
				var ringRender:RRingMcRender = ent.lookupComponentByName(RBattleConst.BATTLE_RING_RENDER_NAME) as RRingMcRender;
				if(value){
					ringRender.alpha = 1;
				}else{
					ringRender.alpha = 0;
				}
			}
		}
		/**
		 * 抓捕宠物成功后，发送事件
		 */		
		private function dispatchSealPetEvent():void{
			PBE.mainClass.dispatchEvent(new RBattleSealPetEvent(RBattleSealPetEvent.SEAL_PET_SUCCESS_EVENT));
		}
		/**
		 * 以下三个方法，不用一个，是因为可能同时调用，避免参数传错
		 */		
		private function dispatchEffectEvent(effectVo:RBattleEffectVo):void{
			PBE.mainClass.dispatchEvent(new RBattleToUIEvent(RBattleToUIEvent.BATTLE_SKILL_EVENT,effectVo,null,null));
		}
		private function dispatchBossHpChangeEvent(bossVo:RBattleBossVo):void{
			Logger.print(this,"发送掉血事件，当前回合"+rCurrentRoundCount);
			PBE.mainClass.dispatchEvent(new RBattleToUIEvent(RBattleToUIEvent.BOSS_HP_CHANGE_EVENT,null,bossVo,null));
		}
		private function dispatchPowerChangeEvent(powerVo:RBattlePowerVo):void{
			PBE.mainClass.dispatchEvent(new RBattleToUIEvent(RBattleToUIEvent.POWER_CHANGE_EVENG,null,null,powerVo));
		}
		/**
		 * 战斗中传向UI头像的各值变化，每回合都传 
		 * @param rBattleRoundUIVo 色头像VO的数值
		 */		
		private function dispatchBattleRoundUIVoEvent(rBattleRoundUIVo:RBattleRoundUIVo):void{
			PBE.mainClass.dispatchEvent(new RBattleToUIEvent(RBattleToUIEvent.BATTLE_ROUND_UI_EVENT,null,null,null,null,rBattleRoundUIVo));
		}
		/**
		 * 显示遮罩，比如暴击或大量掉血
		 */		
		private function maskShow():void{
			if(getMaskRender()){
				getMaskRender().alpha = 1;
				getMaskRender().clip.gotoAndPlay(1);
				getMaskRender().clip.addEventListener(ActionEffectEvent.EFFECT_PLAY_BACK_FINISH_EVENT,
					function effectPlayBackFinishHandler(event:Event):void{
						getMaskRender().clip.removeEventListener(ActionEffectEvent.EFFECT_PLAY_BACK_FINISH_EVENT,effectPlayBackFinishHandler);
						if(getMaskRender().owner){
							trace("addEffect -- effectName:"+event.type+"-- 播放完maskRender.clip，重置");
							getMaskRender().alpha = 0;
							getMaskRender().clip.gotoAndStop(1);
						}
					}
				)
			}
		}
		private function getMaskRender():RBattleChaMcRender{
			var ent:IEntity = PBE.nameManager.lookup(RBattleConst.BATTLE_MASK_ENTITY_NAME);
			var maskRender:RBattleChaMcRender = 
				ent.lookupComponentByName(RBattleConst.BATTLE_MASK_RENDER_NAME) as RBattleChaMcRender;
			return maskRender;
		}
		private var canVibrateMultiple:Boolean = false;//特效中是否包含多次震屏设置
		private var VIBRATE_TIME_DELAY:int = 40;//震动
		private var vibratePos:Point = new Point(0,0);
		private var vibratePos1:Point = new Point(2,2);
		private var vibratePos2:Point = new Point(-6,-6);
		/**
		 * 屏幕震动
		 */		
		private function screenVibrateHandler():void{
			var bgType:int = 2;
			var bgCmp:*;
			
			/*var preBg2Ent:IEntity = PBE.nameManager.lookup(RPBELevel.PRE_BG_ENTITY_NAME + bgType);
			if(preBg2Ent){
				var preRepeatCmp:RepeatingRenderComponentXOnlyPre = 
					preBg2Ent.lookupComponentByName(repeatCmpName) as RepeatingRenderComponentXOnlyPre;
				if(preRepeatCmp){
					bgCmp = preRepeatCmp;
				}
			}*/
			var repeatCmpName:String = "ga_backdrop_ent"+bgType;
			var bg2Ent:IEntity = PBE.nameManager.lookup(RPBELevel.BG_ENTITY_NAME+bgType);
			if(bg2Ent){
				var repeatCmp:RepeatingRenderComponentXOnly = 
					bg2Ent.lookupComponentByName(repeatCmpName) as RepeatingRenderComponentXOnly;
				if(repeatCmp){
					bgCmp = repeatCmp;
				}
			}
			vibrateIntervalId2 = setTimeout(screenVibrateComeOn,VIBRATE_TIME_DELAY,bgCmp,vibratePos1);
			vibrateIntervalId3 = setTimeout(screenVibrateComeOn,VIBRATE_TIME_DELAY*2,bgCmp,vibratePos2);
			vibrateIntervalId4 = setTimeout(screenVibrateComeOn,VIBRATE_TIME_DELAY*3,bgCmp,vibratePos);
		}
		/**
		 * come on!震吧！ 
		 */		
		private function screenVibrateComeOn(repeatCmp:*,locationOffset:Point):void{
			if(repeatCmp){
				repeatCmp.locationOffset = locationOffset;
			}
		}
		/**
		 * 获取多次震屏特效时间点数组 
		 * @param resId
		 * @return 
		 * 
		 */		
		private function getVibrateArr(resId:int):Array{
			var jsonObj:Object = getBattleJsonObj(resId);
			var arr:Array;
			if(jsonObj){
				if(jsonObj.vibarateTP){
					arr = jsonObj.vibarateTP.tpArr;
					return arr;
				}
			}
			return arr;
		}
		/**
		 * 获取角色 实体
		 * @param chaBattleId 要获取的战场ID
		 * @return 返回相应实体
		 * 
		 */		
		private function getCharacterEntity(chaBattleId:int):IEntity{
			var ent:IEntity;
			ent = PBE.nameManager.lookup(RBattleConst.CHA_BATTLE_ENTITY_NAME_STR+chaBattleId)
			return ent;
		}
		/**
		 * 获取配置文件对象 
		 * @param resId 要获取的配置文件名
		 */		
		private function getBattleJsonObj(resId:int):Object{
			/*var res:SceneAssetCenter = SceneAssetCenter.getInstance();
			var jsonId:String = res.get_fight_config_id(resId);
			var jsonObj:Object = res.get_fight_config_obj(jsonId);
			*/
			var jsonObj:Object = RLoadHelper.getInstance().getBattleInfoById(resId);
			return jsonObj;
		}
		/**
		 * 获取特效偏移点 
		 */		
		private var effectPoint2Start:Point;
		private var effectPoint2End:Point;
		private function setEffectPoint2Offset(effectId:int):void{
			effectPoint2Start = getThrowEffectOffsetPointStart(effectId);
			effectPoint2End = getThrowEffectOffsetPointEnd(effectId);
			if(!effectPoint2Start){
				effectPoint2Start = new Point(0,0);
			}
			if(!effectPoint2End){
				effectPoint2End = new Point(0,0);
			}
		}
		/**
		 * 获取2号特效的起始偏移点 
		 * @param resId
		 * @return 
		 * 
		 */		
		private function getThrowEffectOffsetPointStart(resId:int):Point{
			var effectPoint:Point;
			var jsonObj:Object = getBattleJsonObj(resId);
			if(jsonObj){
				if(jsonObj.point.effectPoint2Start){
					var posX:int = jsonObj.point.effectPoint2Start[0];
					var posY:int = jsonObj.point.effectPoint2Start[1];
					effectPoint = new Point(posX,posY);
					return effectPoint;
				}else{
					return null;
				}
			}
			return null;
		}
		/**
		 * 获取2号特效的落点偏移点 
		 * @param resId
		 * @return 
		 * 
		 */		
		private function getThrowEffectOffsetPointEnd(resId:int):Point{
			var effectPoint:Point;
			var jsonObj:Object = getBattleJsonObj(resId);
			if(jsonObj){
				if(jsonObj.point.effectPoint2End){
					var posX:int = jsonObj.point.effectPoint2End[0];
					var posY:int = jsonObj.point.effectPoint2End[1];
					effectPoint = new Point(posX,posY);
					return effectPoint
				}else{
					return null;
				}
			}
			return null;
		}
		/**
		 * 获取特效配置文件中的时间偏移 
		 * @param resId 要获取的资源ID
		 * @param effectTp 角色或怪物身上已有的TP
		 * 
		 */		
		private function getEffectTP(resId:int,effectTp:int):int{
			var jsonObj:Object = getBattleJsonObj(resId);
			var tp:int;
			if(jsonObj){
				if(jsonObj.tp){
					tp = jsonObj.tp.tp;
				}
			}
			tp = effectTp+tp;
			if(tp<0){
				tp = 0;
			}
			return tp;
		}
		/**
		 * 获取特效偏移坐标 ，此点是在图片上的爆炸点
		 * @param resId 要获取的资源ID
		 * @return Point 返回点
		 * 
		 */		
		private function getEffectOffsetPoint(resId:int):Point{
			var effectPoint:Point;
			var jsonObj:Object = getBattleJsonObj(resId);
			if(jsonObj){
				var posX:int = jsonObj.point.effectPoint[0];
				var posY:int = jsonObj.point.effectPoint[1];
				effectPoint = new Point(posX,posY);
			}else{
				return null;
			}
			return effectPoint;
		}
		/**
		 * 获取下一回合开始的时间点
		 * @return 
		 * 
		 */		
		private function getNextRoundTP():int{
			var nextRoundTP:int;
			if(vo.isCriticalBlow){
				nextRoundTP = int(aJsonObj.next.hasCriticalNextRoundTP);
			}else{
				nextRoundTP = int(aJsonObj.next.normalNextRoundTP);
			}
			return nextRoundTP;
		}
		
		private var renderArr:Array;
		private function mouseMoveHandler(event:MouseEvent=null):void{
			renderArr = new Array();
			var results:Array = new Array();
			var point:Point = new Point( PBE.mainStage.mouseX, PBE.mainStage.mouseY );
			var foundRenderers:Boolean = SceneHelper.getInstance().myScene.getRenderersUnderPoint(point,results);
			//遍历并排序
			for(var i:int=0;i<results.length;i++){
				var obj:DisplayObjectRenderer = results[i] as DisplayObjectRenderer;
				if(obj.name == RBattleConst.CHA_BATTLE_RENDER_NAME){ //NPC和角色一样的render名称
					renderArr.push(obj);
					//按层排序后取最上面一层的信息
					renderArr.sortOn("layerIndex",Array.DESCENDING);
				}
			}
			//判断鼠标下的有效render数组
			if(renderArr.length>0){
				var topRender:DisplayObjectRenderer = renderArr[0] as DisplayObjectRenderer;
				var ent:IEntity = topRender.owner as IEntity;
				var infoCmp:RCharacterInfoComponent = 
					ent.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
				//如果是角色或怪物
				if(topRender == ent.lookupComponentByName(RBattleConst.CHA_BATTLE_RENDER_NAME) as RBattleChaMcRender){
					rBattleTipVo = getRbattleTipVo(infoCmp.chaBattleId);
					if(rBattleTipVo&&!showTipsFlag){
						showTipsFlag = true;
						PBE.mainClass.dispatchEvent(new RBattleTipEvent(RBattleTipEvent.BATTLE_TIP_EVENT,rBattleTipVo));
						//trace("-- battleId:"+rBattleTipVo.chaBattleId +" -- chaId:"+rBattleTipVo.chaId +" -- chaHp:"+rBattleTipVo.chaHp+" -- totalHp"+rBattleTipVo.chaTotalHp);
					}
				}
			}else{
				hideBattleTip();
			}
		}
		/**
		 * 隐藏战斗tips 
		 */		
		private function hideBattleTip():void{
			return;
			showTipsFlag = false;
			PBE.mainClass.dispatchEvent(new RBattleTipEvent(RBattleTipEvent.BATTLE_TIP_HIDE_EVENT,rBattleTipVo));
		}
		/**
		 * hp或power变化时获取数据，发送事件 
		 */		
		private function getBattleTipData():void{
			return;
			showTipsFlag = false;
			mouseMoveHandler();
		}
		/**
		 * 处理动作声音 
		 * @param actionId 要处理的动作类型
		 * 
		 */		
		private function actionSoundHandler(actionId:int):void{
			var actionType:int = getActionTypeId(actionId);
			if(actionType == RBattleConst.ID_ATTACK_NORMAL || actionType == RBattleConst.ID_ATTACK_SKILL){
				playAttackSound();
			}else if(actionType == RBattleConst.ID_DEFENSE || actionType == RBattleConst.ID_DEATH){
				playDefenseSound();
			}
		}
		/**
		 * 播放攻击动作声音 
		 */		
		private function playAttackSound():void{
			trace("播放攻击声音");
			SoundManager.getInstance().play(SoundConst.ATTACK_SOUND);
			SoundManager.getInstance().setVolume(SoundConst.ATTACK_SOUND,0.2);
		}
		/**
		 * 播放挨打动作声音
		 */		
		private function playDefenseSound():void{
			trace("播放防御声音");
			SoundManager.getInstance().play(SoundConst.ATTACKED_SOUND);
			SoundManager.getInstance().setVolume(SoundConst.ATTACKED_SOUND,0.2);
		}
		private var showTipsFlag:Boolean = false;
		protected override function onAdd():void {
			//PBE.processManager.addTickedObject(this);
			sceneCenterPoint = RBattleShow.sceneCenterPoint;
			//PBE.mainStage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);//取消战斗中TIPS，移到UI上
		}
		
		protected override function onRemove():void {
			//PBE.processManager.removeTickedObject(this);
			removeAllCriticalEnt();
			//移除鼠标监听事件
			//PBE.mainStage.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveHandler);//取消战斗中TIPS，移到UI上
			//hideBattleTip();
			super.onRemove();
		}
	}
}
package sceneModule.mediator
{
	import com.greensock.TweenLite;
	import wordscene.WordSceneSprite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	import mx.events.EffectEvent;
	import mx.events.ResizeEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	
	import sceneModule.event.BattleOverAndEffectEvent;
	import sceneModule.event.SceneEffectEvent;
	import sceneModule.event.SceneLoadedAndShowSceneNameEvent;
	import sceneModule.rcommand.revent.RBattleRoundEvent;
	import sceneModule.rcommand.revent.RBattleTipEvent;
	import sceneModule.rcommand.revent.RBattleToUIEvent;
	import sceneModule.rcommand.revent.RLoadEvent;
	import sceneModule.rcommand.revent.RMousePosEvent;
	import sceneModule.rcommand.revent.RSwitchBattleEvent;
	import sceneModule.rcommand.revent.RSwitchEvent;
	import sceneModule.rcommon.RLoadHelper;
	import sceneModule.view.SceneEffectLayer;
	import sceneModule.view.battle.view.BattleBossHpComponent;
	import sceneModule.view.battle.view.BattleEnergyComponent;
	import sceneModule.view.battle.view.BattleRoleInfoToolTipComponent;
	import sceneModule.view.levelup.command.CrotaIILevelUpConfig;
	import sceneModule.view.levelup.view.CrotaIILevelUpComponent;
	import sceneModule.view.levelup.view.CrotaIILevelUpFunComponent;
	import sceneModule.view.levelup.vo.LevelUpEffectVO;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.ui.SceneInfoComponent;
	
	import service.ISocketServer;
	
	import spark.effects.Fade;
	
	import util.CommonTools;
	import util.DelayExcuter;

	/**
	 * 场景效果层，用于播放场景和战场的各种效果和一些特殊UI 
	 * @author Dream-Y
	 * 
	 */	
	public class SceneEffectLayerMediator extends Mediator
	{
		[Inject]
		public var comp:SceneEffectLayer;
		
		[Inject]
		public var applicationScene:Sprite;	
		
		[Inject]
		public var socketService:ISocketServer;
		
		//场景名称坐标常量
		private const SCENE_NAME_UI_X:int = 250;
		private const SCENE_NAME_UI_Y:int = 100;
		
		//战斗释放技能名称坐标常量
		private const BATTLE_SKILL_NAME_UI_X:int = 250;
		private const BATTLE_SKILL_NAME_UI_Y:int = 200;
		
		//淡入淡出的时间常量 默认为1000毫秒
		private const FADE_EFFECT_TIME:int = 1000;
		
		//如果需要显示一段时间后消失的时间常量
		private const SHOW_TIME:int = 3000;
		
		//Boss血条坐标
		private const BATTLE_BOSS_HP_R:int = 400;
		private const BATTLE_BOSS_HP_T:int = 10;
		
		//场景名称背景MC坐标
		private const SCENE_NAME_MC_BG_X:int = 200;
		private const SCENE_NAME_MC_BG_Y:int = -5;
		
		//场景名称MC坐标
		private const SCENE_NAME_MC_X:int = 375;
		private const SCENE_NAME_MC_Y:int = 40;
		
		//能量条控件坐标
		private const SCENE_ENERGY_COMP_X:int = 463;
		private const SCENE_ENERGY_COMP_Y:int = 497;
		
		private const SCENE_INFO_COMP_Y:int = 97;
		
		//场景名称Image对象
		private var sceImg:Image;
		
		public function SceneEffectLayerMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			comp.mouseEnabled = false;
			comp.mouseChildren = false;
			
			//监听切换场景事件
			//eventMap.mapListener(applicationScene,RMousePosEvent.MOUSE_SELECTED_EVENT,onMouseClickNpc);
			TaskMessage.getInstance().addEventListener(SceneEffectEvent.SwitchSceneOrBattleEffect,onEffectPlay);
			this.addContextListener(SceneLoadedAndShowSceneNameEvent.SCENELOADEDANDSHOWSCENENAME,onShowSceneNameMC);
			this.addContextListener(SceneLoadedAndShowSceneNameEvent.LEVELUPEFFECT,onAddLevelUpEffect);
//			this.eventMap.mapListener(applicationScene,RBattleToUIEvent.BATTLE_SKILL_EVENT,onBattleSkill);
			this.eventMap.mapListener(applicationScene,RBattleToUIEvent.BOSS_INIT_EVENT,onBossInit);
			this.eventMap.mapListener(applicationScene,RBattleToUIEvent.BOSS_HP_CHANGE_EVENT,onBossHpChange);
			this.eventMap.mapListener(applicationScene,RBattleToUIEvent.POWER_CHANGE_EVENG,changeEnergy);
			this.addContextListener(BattleOverAndEffectEvent.BATTLEOVERANDEFFECT,onRemoveBossComp);
			//监听战斗资源加载完毕事件
			eventMap.mapListener(applicationScene,RSwitchBattleEvent.SWITCH_BATTLE_EVENT,initEnergyComp);
			//监听战斗结束事件
			WordSceneSprite.getInstance().addEventListener(RBattleRoundEvent.ALL_ROUND_OVER_EVENT,removeEnergyComp);
			
			comp.addEventListener(ResizeEvent.RESIZE,onResize);
			
			this.eventMap.mapListener(applicationScene,RBattleTipEvent.BATTLE_TIP_EVENT,onShowBattleTips);
			this.eventMap.mapListener(applicationScene,RBattleTipEvent.BATTLE_TIP_HIDE_EVENT,onHideBattleTips);
			
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function onAddLevelUpEffect(event:SceneLoadedAndShowSceneNameEvent):void{
			SystemDataModel.openFunFlag = true;
			AssetCenter.getInstance().load_package("ui_levelUp",onLevelUp,null,true);
		}
		
		private var levelUpComp:CrotaIILevelUpComponent;
		private function onLevelUp():void{
			levelUpComp = new CrotaIILevelUpComponent();
			levelUpComp.x = (FlexGlobals.topLevelApplication.width-levelUpComp.width)*0.5;
			levelUpComp.y = (FlexGlobals.topLevelApplication.height - levelUpComp.height)*0.5 - 100;
			comp.effUi.addChild(levelUpComp);
			onLevelUpEffect(levelUpComp);
			new DelayExcuter(4000,onAddFunComp,null);
		}
		
		private function onLevelUpEffect(effComp:DisplayObject):void{
			var fade:Fade = new Fade();
			fade.alphaFrom = 0;
			fade.alphaTo = 1;
			fade.duration = FADE_EFFECT_TIME;
			fade.target = effComp;
			fade.play();
			new DelayExcuter(3000,function():void{
				if(levelUpComp && comp.effUi.contains(effComp)){
					var fade:Fade = new Fade();
					fade.alphaFrom = 1;
					fade.alphaTo = 0;
					fade.duration = FADE_EFFECT_TIME;
					fade.target = effComp;
					fade.play();
					new DelayExcuter(1000,function():void{
						comp.effUi.removeChild(effComp);
						effComp = null;
					},null);
				}
			},null);
		}
		
		private var fun:Image;
		private function onAddFunComp():void{
			
			var infoArr:Array = CrotaIILevelUpConfig.getInstance().getCurLevelEffectInfo(SystemDataModel.roleInfo.level);
			var l:int = infoArr.length;
			if(l>0){
				fun = new Image();
				CommonTools.make_bitmap(fun).bitmapData = AssetCenter.getInstance().get_img_form_pacakge("ui_levelUp","fun_bg");
				fun.width = 481;
				fun.height = 118;
				fun.x = (FlexGlobals.topLevelApplication.width-fun.width)*0.5;
				fun.y = (FlexGlobals.topLevelApplication.height - fun.height)*0.5 - 90;
				comp.effUi.addChild(fun);
				onLevelUpEffect(fun as DisplayObject);
			}
			for(var i:int=0;i<l;i++){
				var funComp:CrotaIILevelUpFunComponent = new CrotaIILevelUpFunComponent();
				funComp.levInfo = infoArr[i];
				funComp.x = FlexGlobals.topLevelApplication.width*0.5 - l*45 + i*80;
				funComp.y = (FlexGlobals.topLevelApplication.height - fun.height)*0.5 - 50;
				comp.effUi.addChild(funComp);
				onShowFunEff(infoArr[i] as LevelUpEffectVO,funComp);
			}
			new DelayExcuter(4000,function():void{
				SystemDataModel.openFunFlag = false;
				SystemDataModel.openFunLevel = SystemDataModel.roleInfo.level;
			},null);
		}
		
		private function onShowFunEff(info:LevelUpEffectVO,funComp:CrotaIILevelUpFunComponent):void{
			var toX:int;
			var toY:int = info.toT;;
			if(info.direction == 'left'){
				toX = info.toL;
			}else{
				toX = FlexGlobals.topLevelApplication.width - info.toR;
			}
			
			new DelayExcuter(2000,function():void{
				funComp.tt.visible = false;
				TweenLite.to(funComp,2,{x:toX,y:toY,width:20,height:45});
			},null);
			new DelayExcuter(4000,function():void{
				if(funComp && comp.effUi.contains(funComp)){
					comp.effUi.removeChild(funComp);
					funComp = null;
				}
			},null);
		}
		
		private var battleTips:BattleRoleInfoToolTipComponent;
		private function onShowBattleTips(evt:RBattleTipEvent):void{
//			trace("传入数据..........................");
			if(null == battleTips){
				battleTips = new BattleRoleInfoToolTipComponent();
				FlexGlobals.topLevelApplication.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			}
			
			battleTips.curObj = evt.rbattleTipVo;
			
			
			battleTips.x = FlexGlobals.topLevelApplication.mouseX;
			battleTips.y = FlexGlobals.topLevelApplication.mouseY;
			
			
			comp.effUi.addChild(battleTips);
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			battleTips.x = FlexGlobals.topLevelApplication.mouseX;
			battleTips.y = FlexGlobals.topLevelApplication.mouseY;
		}
		
		private function onHideBattleTips(evt:RBattleTipEvent):void{
			if(battleTips && comp.effUi.contains(battleTips)){
				comp.effUi.removeChild(battleTips);
				FlexGlobals.topLevelApplication.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				battleTips = null;
			}
		}
		
		private function onResize(evt:ResizeEvent):void{
			if(scNameEffMC){
				scNameEffMC.x = comp.width/2 - (500 -SCENE_NAME_MC_BG_X);
				scNameEffMC.y = comp.height/2 - (285 - SCENE_NAME_MC_BG_Y);
				
			}
			if(scNameMC){
				scNameMC.x = comp.width/2 - (500 - SCENE_NAME_MC_X);
				scNameMC.y = comp.height/2 - (285 - SCENE_NAME_MC_Y);
			}
			
			if(sceneInfoComp){
				sceneInfoComp.x = (comp.width - sceneInfoComp.width)/2;
				sceneInfoComp.y = comp.height/2 - (285 - SCENE_INFO_COMP_Y)
			}
		}
		
		private function onMouseClickNpc(e:RMousePosEvent):void{
			onShowSceneName(1000,true,true,3000);
			onShowSkillName(1);
		}
		
		/**
		 * 初始化Boss血条控件
		 */
		private var batBosHpComp:BattleBossHpComponent;
		private function onBossInit(evt:RBattleToUIEvent):void{
			if(null == batBosHpComp){
				batBosHpComp = new BattleBossHpComponent();
				batBosHpComp.right = 250;
				batBosHpComp.y = BATTLE_BOSS_HP_T;
				batBosHpComp.initBossInfo(evt.bossInitVo.professtionType,evt.bossInitVo.level,evt.bossInitVo.name,evt.bossInitVo.currentHp,evt.bossInitVo.totalHp);
				comp.effUi.addChild(batBosHpComp);
			}
		}
		
		/**
		 * 血量变化事件
		 */
		private function onBossHpChange(evt:RBattleToUIEvent):void{
			if(batBosHpComp){
				batBosHpComp.changeBossHp(evt.bossVo.currentHp+evt.bossVo.changeHp,evt.bossVo.totalHp);
			}
			
		}
		/**
		 * 移除Boss血条
		 */
		private function onRemoveBossComp(evt:BattleOverAndEffectEvent):void{
			if(batBosHpComp){
				comp.effUi.removeChild(batBosHpComp);
				batBosHpComp = null;
			}
		}
		
		/**
		 * 初始化能量条
		 */
		/*private var energyComp:BattleEnergyComponent;
		private function initEnergyComp(evt:RSwitchBattleEvent):void{
			if(null == energyComp){
				energyComp = new BattleEnergyComponent();
				energyComp.x = SCENE_ENERGY_COMP_X;
				energyComp.y = SCENE_ENERGY_COMP_Y;
				comp.effUi.addChild(energyComp);
			}
		}
		private function changeEnergy(evt:RBattleToUIEvent):void{
			if(energyComp){
				energyComp.setCurEnergy(evt.powerVo.currentPower,evt.powerVo.totalPower,evt.powerVo.powerDown+evt.powerVo.powerUp);
			}
		}
		private function removeEnergyComp(evt:RBattleRoundEvent):void{
			if(energyComp && comp.effUi.contains(energyComp)){
				comp.effUi.removeChild(energyComp);
				energyComp = null; 
			}
		}*/
		
		//private var energyMC:PowerMc;
		private function initEnergyComp(evt:RSwitchBattleEvent):void{
			//if(null == energyMC){
				//energyMC = new PowerMc();
				//energyMC.x = SCENE_ENERGY_COMP_X;
				//energyMC.y = SCENE_ENERGY_COMP_Y;
				//comp.effUi.addChild(energyMC); 
			//}
		}
		
		private function changeEnergy(evt:RBattleToUIEvent):void{
			//if(energyMC){
				//if(evt.powerVo.currentPower > evt.powerVo.totalPower){
					//energyMC.getChildByName("mkL").width = 170;
				//}else if(evt.powerVo.currentPower <=0 || evt.powerVo.totalPower <=0){
					//energyMC.getChildByName("mkL").width = 10;
				//}else{
					//energyMC.getChildByName("mkL").width = 160 * (evt.powerVo.currentPower/evt.powerVo.totalPower) + 10;
				//}
				//
				//var changeLen:int = 160 * ((evt.powerVo.currentPower+evt.powerVo.powerDown+evt.powerVo.powerUp)/evt.powerVo.totalPower) + 10;
				//if(170 < changeLen){
					//changeLen = 170;
				//}
				//
				//TweenLite.to(energyMC.getChildByName("mkL"),1,{width:changeLen});
			//}
		}
		private function removeEnergyComp(evt:RBattleRoundEvent):void{
			//if(energyMC && comp.effUi.contains(energyMC)){
				//comp.effUi.removeChild(energyMC);
				//energyMC = null; 
			//}
		} 
		
		private function onShowSceneNameMC(evt:SceneLoadedAndShowSceneNameEvent):void{
			onShowSceneNameBuyMC(evt.sceneResId);
		}
		/**
		 * 显示场景名称 
		 * @param sceneResId 场景资源id
		 * 
		 */		
		private var scNameEffMC:MovieClip;
		private var scNameMC:MovieClip;
		private var sceneInfoComp:SceneInfoComponent;
		private function onShowSceneNameBuyMC(sceneResId:int):void{
			if(scNameEffMC){
				comp.effUi.removeChild(scNameEffMC);
			}
			if(scNameMC){
				comp.effUi.removeChild(scNameMC);
			}
			if(sceneInfoComp){
				comp.effUi.removeChild(sceneInfoComp);
			}
			scNameEffMC = RLoadHelper.getInstance().sceneNameBg;
			scNameMC = RLoadHelper.getInstance().getSceneNameMc(String(sceneResId));
			
			//sceneInfoComp = new SceneInfoComponent();
			
			if(null == scNameEffMC){
				return;
			}
			
			if(null == scNameMC){
				return;
			}
			
			if(null == sceneInfoComp){
				sceneInfoComp = new SceneInfoComponent();
			}
			
			scNameEffMC.x = comp.width/2 - (500 -SCENE_NAME_MC_BG_X);
			scNameEffMC.y = comp.height/2 - (285 - SCENE_NAME_MC_BG_Y);
			if(scNameMC.width == 300){
				scNameMC.x = comp.width/2 - (500 - SCENE_NAME_MC_X);
			}else{
				scNameMC.x = comp.width/2 - (500 - SCENE_NAME_MC_X)-80;
			}
			scNameMC.y = comp.height/2 - (285 - SCENE_NAME_MC_Y);
			
			sceneInfoComp.x = (comp.width - sceneInfoComp.width)/2;
			sceneInfoComp.y = comp.height/2 - (285 - SCENE_INFO_COMP_Y);
			
			if(!comp.effUi.contains(scNameEffMC)){
				comp.effUi.addChild(scNameEffMC);
			}
			if(!comp.effUi.contains(scNameMC)){
				comp.effUi.addChild(scNameMC);
			}
			if(!comp.effUi.contains(sceneInfoComp)){
				comp.effUi.addChild(sceneInfoComp);
			}
			
			
			scNameEffMC.gotoAndPlay(3);
			scNameMC.gotoAndPlay(3);
			scNameEffMC.addEventListener(Event.ENTER_FRAME,onScNaBgMCEnFr);
		}
		private function onScNaBgMCEnFr(evt:Event):void{
			if(!scNameEffMC){
				return;
			}
			if(scNameEffMC.currentFrame == scNameEffMC.framesLoaded){
				scNameEffMC.stop();
				scNameMC.stop();
				scNameEffMC.removeEventListener(Event.ENTER_FRAME,onScNaBgMCEnFr);
				
				comp.effUi.removeChild(scNameEffMC);
				comp.effUi.removeChild(scNameMC);
				comp.effUi.removeChild(sceneInfoComp);
				
				scNameEffMC = null;
				scNameMC = null;
				sceneInfoComp = null;
			}
		}
		/**
		 * 显示场景名称 
		 * @param sceneId 场景id
		 * @param isFadeFlag 是否需要淡入淡出效果 默认不需要
		 * @param needRemoveFlag 显示一定时间后是否需要移除
		 * @param showTime 显示的时长 只有neddRemoveFlag为true时改值才起作用 
		 * 
		 */	
		private var snTimer:Timer;
		private function onShowSceneName(sceneId:int,isFadeFlag:Boolean = false,needRemoveFlag:Boolean = false,showTime:int = SHOW_TIME):void{
			//第一次先实例化Image
			if(null == sceImg){
				
				sceImg = new Image();
				
				comp.addElement(sceImg);
				
				//设置坐标
				sceImg.x = SCENE_NAME_UI_X;
				sceImg.y = SCENE_NAME_UI_Y;
			}
			//先设为false
			sceImg.visible = false;
			//获取Image数据源
			sceImg.source = "assets/tipsBg.png";
			
			//显示
			if(isFadeFlag){
				var fade:Fade = new Fade();
				fade.alphaFrom = 0;
				fade.alphaTo = 1;
				fade.duration = FADE_EFFECT_TIME;
				fade.target = sceImg;
				fade.play();
			}else{
				sceImg.visible = true;
			}
			
			//一段时间后需要移除的操作
			if(needRemoveFlag){
				snTimer = new Timer(showTime+FADE_EFFECT_TIME);
				snTimer.addEventListener(TimerEvent.TIMER,onSMTime);
				snTimer.start();
			}
		}
		//渐变消失
		private function onSMTime(evt:TimerEvent):void{
			if(snTimer){
				snTimer.stop();
				snTimer.reset();
				snTimer.removeEventListener(TimerEvent.TIMER,onSMTime);
				snTimer = null;
				if(sceImg){
					var fade:Fade = new Fade();
					fade.alphaFrom = 1;
					fade.alphaTo = 0;
					fade.duration = FADE_EFFECT_TIME;
					fade.target = sceImg;
					fade.play();
				}
			}
			
		}
		
		private function onBattleSkill(evt:RBattleToUIEvent):void{
			onShowSkillName(evt.effectVo.effectId);
		}
		
		/**
		 * 添加释放技能的技能名称特效 
		 * @param skillId 技能id
		 * 
		 */	
		private var skNameMC:MovieClip;
		private function onShowSkillName(skillId:int):void{
			//获取技能名称的MovieClip
			skNameMC = AssetCenter.getInstance().get_mc_form_pacakge('ui_battle_suc','flip_effect_swf',skNameMCLoaded);
		}
		private function skNameMCLoaded(mc:MovieClip):void{
			skNameMC = mc;
			
			if(skNameMC == null)return;
			
			comp.effUi.addChild(skNameMC);
			
			//设置坐标
			skNameMC.x = BATTLE_SKILL_NAME_UI_X;
			skNameMC.y = BATTLE_SKILL_NAME_UI_Y;
			
			//播放
			skNameMC.play();
			
			skNameMC.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private function onEnterFrame(evt:Event):void{
			if(skNameMC.currentFrame == skNameMC.framesLoaded){
				skNameMC.stop();
				
				skNameMC.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				
				comp.effUi.removeChild(skNameMC);
				
				skNameMC = null;
			}
		}
		
		private function onEffectPlay(evt:SceneEffectEvent):void{
			onPlaySceneEffect(evt.effID,evt.fun,evt.x,evt.y);
		}
		
		/**
		 * 播放场景中一些特性，例如：转场动画 
		 * @param resId 资源id
		 * @param fun 回调函数
		 * @param x X坐标默认0
		 * @param y Y坐标默认0
		 * 
		 */	
		private var effMC:MovieClip;
		private var tempFun:Function;
		private function onPlaySceneEffect(resId:String,fun:Function = null,x:int=0,y:int=0):void{
			
			if(resId == URLConst.TASK_COMPLETE_URL){
				effMC = AssetCenter.getInstance().get_mc_form_pacakge("Task_PreRes","Task_complete_swf",onCompleteMC);
			}else if(resId == URLConst.ACCESS_TASK_URL){
				effMC = AssetCenter.getInstance().get_mc_form_pacakge("Task_PreRes","Task_accept_swf",onCompleteMC);
			}else{
				effMC = RLoadHelper.getInstance().getSceneNameMc(resId);
				onStartEffect();
			}
			
			
			effMC.x = x;
			effMC.y = y;
			
			
		}
		
		private function onCompleteMC(mc:MovieClip):void{
			effMC = mc;
			onStartEffect();
		}
		
		private function onStartEffect():void{
			if(effMC == null)return;
			
			comp.effUi.addChild(effMC);
			
			effMC.play();
			
			effMC.addEventListener(Event.ENTER_FRAME,onEffMCframe);
		}
		
		private function onEffMCframe(evt:Event):void{
			if(effMC){
				if(effMC.currentFrame == effMC.framesLoaded){
					
					effMC.stop();
					
					effMC.removeEventListener(Event.ENTER_FRAME,onEffMCframe);
					
					comp.effUi.removeChild(effMC);
					
					if(tempFun != null){
						tempFun();
					}
					
					tempFun = null;
					effMC = null;
				}
			}
		}
	}
}
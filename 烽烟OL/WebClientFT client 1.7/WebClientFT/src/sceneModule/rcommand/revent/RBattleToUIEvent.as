package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	import sceneModule.model.rvo.RBattleBossVo;
	import sceneModule.model.rvo.RBattleEffectVo;
	import sceneModule.model.rvo.RBattlePowerVo;
	import sceneModule.model.rvo.RBattleRoundUIVo;

	/**
	 * 战斗中battle模块与UI模块交互事件 
	 * @author sxmad
	 * 
	 */	
	public class RBattleToUIEvent extends Event
	{
		/**
		 * Battle模块与UI模块交互事件 
		 * @param type 事件类型
		 * @param effectVo 技能对象
		 * @param bossVo BOSS掉血对象
		 * @param powerVo 能量变化对象
		 * @param rBattleRoundUIVo 战斗UI中包含的所有战斗角色当前回合的各种数值变化
		 * 
		 */		
		public function RBattleToUIEvent(
			type:String,
			effectVo:RBattleEffectVo=null,
			bossVo:RBattleBossVo=null,
			powerVo:RBattlePowerVo=null,
			bossInitVo:RBattleBossVo=null,
			rBattleRoundUIVo:RBattleRoundUIVo=null)
		{
			super(type);
			this.effectVo = effectVo;
			this.bossVo = bossVo;
			this.powerVo = powerVo;
			this.bossInitVo = bossInitVo;
			this.rBattleRoundUIVo = rBattleRoundUIVo
		}
		public var bossInitVo:RBattleBossVo;
		public static const BOSS_INIT_EVENT:String = "bossInitEvent";//战斗初始化时的BOSS信息
		
		public var effectVo:RBattleEffectVo;
		public static const BATTLE_SKILL_EVENT:String = "BattleSkillEvent";//战斗中要显示的技能
		
		public var bossVo:RBattleBossVo;
		public static const BOSS_HP_CHANGE_EVENT:String = "BossHpChangeEvent";//战斗中boss的HP变化
		
		public var powerVo:RBattlePowerVo;
		public static const POWER_CHANGE_EVENG:String = "PowerChangeEvent";//战斗中power的变化
		
		public var rBattleRoundUIVo:RBattleRoundUIVo;
		public static const BATTLE_ROUND_UI_EVENT:String = "battleRoundUIEvent";//战斗UI头像中各值的变化
	}
}
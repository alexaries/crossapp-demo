package sceneModule.rresource
{
	/**
	 * R版战斗 
	 * @author mutou
	 * 
	 */	
	public class RBattleConst
	{
		public function RBattleConst()
		{
			
		}
		
		//==========================基础动作，MC中的类名=================================
//		public static const C_1:String = "StandMc";//角色待机
//		public static const C_2:String = "WalkMc";//角色移动
//		public static const C_3:String = "AttackNormalMc";//普通攻击
//		public static const C_4:String = "AttackSkillMc";//技能攻击
//		public static const C_5:String = "DefenseMc";//角色防御
//		public static const C_6:String = "DeathMc";//角色死亡
		
		//===================殖民战之前的 “VS... 3...2...1...”字样特效
		public static const COLONY_VS_EFFECT_ID:int = 999;
		
		//public static const INVALIDE_CONST:int = -1; //无效值验证使用
		public static const CROTA_II_BUFF:int = -1;//系统BUFF
		
		//===================反击文字特效，如果需要变化，可以根据要求来修改
		public static const COUNTER_HIT_EFFECT_1:int = 9997;
		//封印宠物成功
		public static const SEAL_PET_SUCCESS:int = 9995;
		
		//===================暴击特效的释放特效与承受特效
		public static const CRITICAL_CHA_3_1:int = 11111;//男战士3号特效
		public static const CRITICAL_CHA_1_1:int = -1;//男战士1号特效
		
		public static const CRITICAL_CHA_3_2:int = 22222;//女法师3号特效
		public static const CRITICAL_CHA_1_2:int = 22220;//女法师1号特效
		
		public static const CRITICAL_CHA_3_3:int = 33333;//男游侠3号特效
		public static const CRITICAL_CHA_1_3:int = -1;//男游侠1号特效
		
		public static const CRITICAL_CHA_3_4:int = 44444;//女战士3号特效
		public static const CRITICAL_CHA_1_4:int = -1;//女战士1号特效
		
		public static const CRITICAL_CHA_3_5:int = 55555;//男法师3号特效
		public static const CRITICAL_CHA_1_5:int = 55550;//男法师1号特效
		
		public static const CRITICAL_CHA_3_6:int = 66666;//女游侠3号特效
		public static const CRITICAL_CHA_1_6:int = -1;//女游侠1号特效
		
		//==================特效的类型,
		//1号特效：释放，2号特效：投射，3号特效：承受特效，4号特效：文字，5号特效：power
		public static const EFFECT_TYPE_1:int = 1;
		public static const EFFECT_TYPE_2:int = 2;
		public static const EFFECT_TYPE_3:int = 3;
		public static const EFFECT_TYPE_4:int = 4;
		public static const EFFECT_TYPE_5:int = 5;
		public static const EFFECT_TYPE_6:int = 6;//6号特效：封印成功，弹出提示
		
		//======================状态条==============================
		
		public static const HP_BOSS_IMG_WIDTH:int = 834;//BOSS状态条图片宽
		public static const HP_IMG_WIDTH:int = 60;//状态条图片宽 --  HP与MP图片宽度相同 
		public static const HP_BAR_TOTAL_FRAME:int = 10;//状态条动画层帧数 -- HP与MP帧数相同
		
		//======================= 基础动作中，MC的类名
		public static const C_Action_Name:String = "ActionMc";//swf中，动作MC的类名
		public static const C_Effect_Name:String = "EffectMc";//swf中，特效MC的类名
		
		public static const ID_STAND:int = 530;//待机
		public static const ID_WALK:int = 540;//角色移动
		public static const ID_ATTACK_NORMAL:int = 550;//普通攻击
		public static const ID_ATTACK_SKILL:int = 560;//技能攻击
		public static const ID_DEFENSE:int = 570;//角色防御，挨打
		public static const ID_DEATH:int = 580;//角色死亡
		
		//战斗中角色动作图片离脚平面的偏移量
		public static const POS_OFFSET_Y:int = 20;
		
		//攻击方式 
		public static const ATTACK_TYPE_NEAR:int = 1;//进程攻击
		public static const ATTACK_TYPE_FAR:int = 2;//远程攻击
		
		//=========================================================
		//动作标识，此标识在swf中在事件ActionEvent中携带并发出。
		//由于攻击，防御，死亡动作播放完成后要进行相关操作，所以此处监听swf中播放完成后的事件
		public static const ATTACK_PLAY_BACK_FINISH:int = 1;//攻击动作播放完成，包括普通攻击，技能攻击，等各种攻击
		public static const DEFENSE_PLAY_BACK_FINISH:int = 2;//防御动作播放完成标识
		public static const DEATH_PLAY_BACK_FINISH:int = 3;//死亡动作播放完成标识
		
		//===============================反击
		public static const ENEMY_COUNTER_HIT_0:int = 0;//不反击
		public static const ENEMY_COUNTER_HIT_1:int = 1;//反击
		
		//======================文字特效=============================
		public static const TXT_EFFECT_TYPE_1:int = 1;//格挡
		public static const TXT_EFFECT_TYPE_2:int = 2;//闪避
		public static const TXT_EFFECT_TYPE_3:int = 3;//暴击
		public static const TXT_EFFECT_TYPE_4:int = 4;//反击
		
		//======================技能类型起始=============================
		public static const BATTLE_CHA_MIN_ACTION_ID:int = 1510;//角色动作起始ID
		public static const BATTLE_EFFECT_MIN_ID:int = 6000;//特效起始ID从6000开始用来区别于角色的4590等，以读取配置表
		public static const BATTLE_MONSTER_MIN_ACTION_ID:int = 5001510;//怪物动作最小ID，用来读取配置表
		
		//=======================实体名称========================
		public static const BATTLE_CAMERA_ENTITY_NAME:String = "CameraAnimatorEntity";//镜头实体
		public static const BATTLE_CAMERA_RENDER_NAME:String = "cameraRender";//镜头render组件
		public static const CRITICAL_BG_ENTITI_NAME:String = "CriticalBgEntity";//暴击背景实体
		public static const CRITICAL_ENTITI_NAME:String = "CriticalEntity";//暴击实体
		public static const THROW_EFFECT_ENTITY_NAME:String = "ThrowEffectEntity";//投射特效实体
		public static const THROW_EFFECT_RENDER_NAME:String = "throwEffectRender";//投射特效组件名
		public static const AOE_EFFECT_ENTITY_NAME:String = "AoeEffectEntity";//群体攻击实体
		public static const AOE_EFFECT_RENDER_NAME:String = "aoeEffectRender";//群体攻击组件名
		public static const HP_NUMBER_RENDER_NAME:String = "hpNumberMcRender";//HpNumber组件名称
		
		//=======================各种实体名前缀的字符串========================
		public static const CHA_BATTLE_ENTITY_NAME_STR:String = "ChaBattleAnimatorEntity";
		public static const CHA_BATTLE_RENDER_NAME:String = "chaRender";
		public static const BATTLE_ACTION_CONTROLLER_CMP_STR:String = "rBattleRoundController";
		public static const BATTLE_ACTION_ENTITY_NAME:String = "BattleRoundEntity";
		public static const BATTLE_RING_RENDER_NAME:String = "chaRingRender";
		public static const BATTLE_MASK_ENTITY_NAME:String = "BattleMaskEnt";
		public static const BATTLE_MASK_RENDER_NAME:String = "maskRender";
		
		//=======================战斗loaderId============================
		public static const BATTLE_RES_LOADER_NAME:String = "battle-res";
		
	}
}
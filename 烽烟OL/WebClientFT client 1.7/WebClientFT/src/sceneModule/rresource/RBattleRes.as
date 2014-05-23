package sceneModule.rresource
{
	/**
	 * 战斗资源 
	 * @author mutou
	 * 
	 */	
	public class RBattleRes
	{
		public function RBattleRes()
		{
		}
		//空白 png
		public static const BLANK_PNG:String = "assets/Images/blank.png";
		public static const BLANK_SWF:String = "assets/Images/blank.swf";
		
		public static const COLONY_VS_EFFECT_URL:String = "assets/swf/battleRes/999.swf";
		
		//====================================遮罩层
		public static const BATTLE_MASK_URL:String = "assets/swf/battleRes/battleMask.swf";
		public static const BATTLE_MASK_ID:String = "battleMask";
		
		//===================================全屏特效
		public static const CRITICAL_BG:String = "assets/swf/battleRes/0.swf";//暴击背景
		
		public static const CRITICAL_CHA_1:String = "assets/swf/battleRes/1.swf";//战士
		public static const CRITICAL_CHA_2:String = "assets/swf/battleRes/2.swf";//法师
		public static const CRITICAL_CHA_3:String = "assets/swf/battleRes/3.swf";//游侠
		public static const CRITICAL_CHA_4:String = "assets/swf/battleRes/4.swf";//牧师
		
		public static const CRITICAL_EYE_1:String = "assets/swf/battleRes/11.swf";//战士
		public static const CRITICAL_EYE_2:String = "assets/swf/battleRes/22.swf";//法师
		public static const CRITICAL_EYE_3:String = "assets/swf/battleRes/33.swf";//游侠
		public static const CRITICAL_EYE_4:String = "assets/swf/battleRes/44.swf";//牧师
		
		//==================================战斗资源
		public static const BATTLE_URL_PRE:String = "assets/swf/battleRes/";//战斗资源目录前缀
		public static const BATTLE_JSON_EXTENSION_NAME:String = ".gs-battle";//JSON文件扩展名
		//===================================战斗中需要配置文件的攻击动作
		public static const BATTLE_ATTACK_TYPE_RUL:String = "assets/swf/battleRes/battleAttackType.gs-battle";
		public static const BATTLE_ATTACK_TYPE_ID:String = "battleAttackType";
		
		//角色怪物战斗中的坐标配置文件
		public static const BATTLE_CHA_POS_URL:String = "assets/swf/battleRes/pos.gs-battle";
		public static const BATTLE_CHA_POS_JSON_ID:String = "battleChaPosJs";
		
		//角色挨打光环
		public static const BATTLE_RING_URL:String = "assets/swf/battleRes/ring.swf";
		public static const BATTLE_RING_ID:String = "ring";
		
	}
}
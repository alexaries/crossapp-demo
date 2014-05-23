package sceneModule.rresource
{
	/**
	 * 角色用到的常量类 
	 * @author mutou
	 * 
	 */	
	public class RCharacterConst
	{
		public function RCharacterConst()
		{
		}
		//字体颜色
		public static const NPC_COLOR:String = "0xCED027";//这个写到脚本中了，暂时没用到
		public static const CHA_MYSELF_COLOR:String = "0xFFB400  ";//自己名字颜色
		public static const CHA_OTHER_COLOR:String = "0xFFFFFF";//其他玩家名字颜色
		public static const MONSTER_COLOR:String = "0xFF0204";//小怪名字颜色
		public static const BOSS_COLOR:String = "0xFF0204";//BOSS名字颜色
		//空白名称数组
		public static const CHA_NULL_NAME_ARR:Array = ["","0xFFFFFF"];
		
		//场景中的角色动作id
		public static const WALK_TYPE:int = 510;//场景中的角色移动
		public static const STAND_TYPE:int = 520;//场景中的角色站立
		
		//角色类型
		public static const CHA_TYPE_1:int = 1;//角色
		public static const CHA_TYPE_2:int = 2;//怪物
		public static const CHA_TYPE_3:int = 3;//宠物
		
		//怪物职业类型起始点
		public static const NORMAL_MONSTER_TYPE:int = 5000; //怪物的类型ID从5001开始
		public static const BOSS_MONSTER_TYPE:int = 50000; //怪物的类型ID从50001开始
		public static const NPC_TYPE:int = 100000;//NPC 类型从100001开始
		public static const SWITCH_TYPE:int = 1000000;//传送门类型 从1000000开始
		
		//=================================实体名称==============================
		//帧频
		public static const CHA_FRAME_RATE:Number = 0.125;
		//JSON中的对象名称
		public static const CHA_JSON_OBJECT_NAME:String = "chaAction";
		public static const IDLE_STR:String = "idle";
		public static const WALK_STR:String = "walk";
		public static const GEM_STR:String = "gem";//角色镶嵌的宝石
		//角色动画实体（真正的角色）名
		public static const CHA_ENTITY_NAME:String = "ChaEntity";
		public static const CHA_SHEET_ENTITY_NAME:String = "ChaSheetEntity";
		//角色主图片Render组件名
		public static const CHA_RENDER_NAME:String = "ChaRender";
		public static const CHA_IDLE_SHEET_NAME:String = "idleSheet";
		public static const CHA_WALK_SHEET_NAME:String = "walkSheet";
		public static const CHA_ANIMATOR_NAME:String = "characterAnimator";
		public static const CHA_GEM_RENDER_NAME:String = "GemRender";
		public static const CHA_GEM_SHEET_NAME:String = "gemSheet";
		public static const CHA_GEM_ANIMATOR_NAME:String = "gemAnimator";
		//
		
		//角色信息组件名
		public static const CHA_INFO_COMPONENT_NAME:String = "ChaInfo";
		//角色资源监听组件名
		public static const RES_LISTENER_NAME:String = "RES_LISTENER_NAME";
		//角色ico资源监听组件
		public static const RES_LISTENER_ICO:String = "RES_LISTENER_ICO";
		//角色站立动作资源监听
		public static const RES_LISTENER_STD:String = "RES_LISTENER_STD";
		//角色行走动作资源监听
		public static const RES_LISTENER_WALK:String = "RES_LISTENER_WALK";
		
		public static const ACTION_NAME:String = "ActionImg";
		
		
		
	}
}
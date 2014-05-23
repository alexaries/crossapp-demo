package sceneModule.rcommon
{
	import sceneModule.rresource.RCharacterConst;

	/**
	 * 角色类型处理 
	 * @author mutou
	 * 
	 */	
	public class RChaType
	{
		
		private const TYPE_CHA:int = 1;//角色类型开始值
		private const TYPE_MONSTER:int = 5000;//怪物类型开始值 
		private const TYPE_BOSS:int = 50000;//BOSS类型开始值
		private const TYPE_NPC:int = 100000;//NPC类型开始值
		
		
		
		private static var instance:RChaType;
		
		public function RChaType()
		{
		}
		public static function getInstance():RChaType{
			if(!instance){
				instance = new RChaType();
			}
			return instance;
		}
		/**
		 * 获取角色类型 
		 * @param type DB中存储的角色类型：角色(1,2,3,4)，怪物(5000+)，BOSS(50000+)，NPC(100000+)
		 * @return 角色类型 
		 * 
		 */				
		public function getChaType(type:int):String{
			var str:String;
			return str;
		}
		/**
		 * 获取角色名称 
		 * @param chaProfession 角色类型
		 * @return 返回颜色值
		 * 
		 */		
		public function getChaNameColor(chaProfession:int):String{
			var nameColor:String="0xffffff";
			if(chaProfession<5){
				nameColor = RCharacterConst.CHA_OTHER_COLOR;//其他角色名字颜色
			}else if(chaProfession>TYPE_MONSTER && chaProfession<TYPE_BOSS){
				nameColor = RCharacterConst.MONSTER_COLOR;//普通怪物名字颜色
			}else if(chaProfession>chaProfession && chaProfession<TYPE_NPC){
				nameColor = RCharacterConst.BOSS_COLOR;//BOSS名字颜色
			}else if(chaProfession>TYPE_NPC){
				nameColor = RCharacterConst.NPC_COLOR;//NPC名字颜色
			}
			return nameColor;
		}
	}
}
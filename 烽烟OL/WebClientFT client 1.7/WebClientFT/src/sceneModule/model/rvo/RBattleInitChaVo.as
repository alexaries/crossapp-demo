package sceneModule.model.rvo
{
	import flash.geom.Point;

	/**
	 * 初始化战斗，单条数据（每个角色） 
	 * @author mutou
	 * 
	 */	
	public class RBattleInitChaVo
	{
		public var chaLayerIndex:int=19;//层,每一回合排一下，需要修改
		public var chaId:int; // 角色ID
		public var chaBattleId:int; // 角色战斗ID
		public var chaName:String;//角色名称
		public var chaLevel:int;//角色等级
		public var chaProfessionType:int;//角色形象ID 职业类型,1-战士，2-法师，3-游侠，4-牧师
		public var chaDirection:int;//1--玩家朝向右，朝向右。2--玩家朝向左
		
		public var chaCurrentHp:int;//角色当前的血量
		public var chaCurrentPower:int;//角色当前的Power
		
		public var chaTotalHp:int;//角色的总HP
		public var chaTotalPower:int;//角色的总Power
		
		public var chaPos:Point;//角色动画的坐标
		
		public var chaIsMySelf:Boolean;//判断战斗角色是否是自己,来区别名字的颜色等
		
		public var uiChaType:int;//角色类型，战斗中显示在UI上的头像类型
		public var uiChaIcon:int;//ICON类型，战斗中显示在UI上的头像图标
		
		public function RBattleInitChaVo()
		{
		}
		
	}
}
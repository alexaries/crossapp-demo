package sceneModule.model.rvo
{
	public class RBattleInitUIVo
	{
		public function RBattleInitUIVo()
		{
		}
		
		public var chaId:int; // 角色ID
		public var chaBattleId:int; // 角色战斗ID
		public var chaName:String;//角色名称
		public var chaLevel:int;//角色等级
		public var chaProfessionType:int;//角色形象ID 职业类型,1-战士，2-法师，3-游侠，4-牧师
		public var chaCurrentPower:int;//角色当前的Power
		public var chaTotalPower:int;//角色的总Power
		
		public var uiChaType:int;//角色类型，战斗中显示在UI上的头像类型
		public var uiChaIcon:int;//ICON类型，战斗中显示在UI上的头像图标
		
	}
}
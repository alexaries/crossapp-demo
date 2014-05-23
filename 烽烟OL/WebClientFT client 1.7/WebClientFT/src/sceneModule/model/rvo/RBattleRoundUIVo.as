package sceneModule.model.rvo
{
	public class RBattleRoundUIVo
	{
		public function RBattleRoundUIVo()
		{
		}
		public var chaName:String;//角色名字
		public var chaLevel:int;//角色等级
		public var chaId:int; // 角色ID 如果是 -1表示系统，本回合为buff回合，enemyChaArr中的角色会掉HP
		public var chaBattleId:int; // 角色战斗ID
		public var chaProfessionType:int;//角色形象ID 职业类型,1-战士，2-法师，3-游侠，4-牧师
		
		public var chaBuffShowList:Array;//buff显示列表，包括多个RbattleBuffVo
		public var chaPowerUp:int; // +20 power增加
		public var chaPowerDown:int; // -20 power减少
		public var chaCurrentPower:int; // 当前power
		
		public var enemyChaArr:Array; // 敌方数据数组,数组中每一个元素对象是一个RBattleEnemyVo
	}
}
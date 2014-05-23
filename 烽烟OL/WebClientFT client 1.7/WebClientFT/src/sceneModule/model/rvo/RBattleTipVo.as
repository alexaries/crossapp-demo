package sceneModule.model.rvo
{
	public class RBattleTipVo
	{
		public function RBattleTipVo()
		{
		}
		public var chaBattleId:int;//角色战斗ID
		public var chaId:int;//角色ID
		public var chaName:String;//角色或怪物的名称
		public var chaLevel:int;//等级
		public var chaHp:int;//角色当前HP
		public var chaTotalHp:int;//
		public var chaPower:int;//角色当前能量
		public var chaTotalPower:int;//
		public var chaStateArr:Array;//buff状态[1,2,3,...]
	}
}
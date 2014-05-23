package sceneModule.model.vo.battleVo
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 战斗结算Vo 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class BattleOverSettlementVo
	{
		public var id:int;	//角色的id
		public var expBonus:int; //角色获得的经验
		public var coinBonus:int; //角色获得的铜币奖励
		public var goldBonus:int; //角色获得的金币奖励
		public var itemsBonus:PackageItem; //角色获得的物品奖励
		public var popularity:int;//声望奖励
		public var attackGoal:int;//攻击得分
		public var defenseGoal:int;//防御得分
		public var slayGoal:int;//必杀得分
		public var name:String;//名称
		public var profession:int;//玩家职业类型
		public function BattleOverSettlementVo()
		{
		}
	}
}
package sceneModule.view.groupBattle.vo
{
	[Bindable]
	public class BattleInfoVO
	{
		public var roleId1:int;//角色1id
		public var roleName1:String;//角色1名称
		public var roleId2:int;//角色2id
		public var roleName2:String;//角色2名称
		public var sucObCoin:int;//战胜方获得的金币
		public var desBat:String;
		public function BattleInfoVO()
		{
		}
	}
}
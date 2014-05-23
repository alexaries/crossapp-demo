package sceneModule.model.vo.battleVo
{
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.rvo.RBattleAllRoundVo;
	import sceneModule.model.rvo.RBattleInitVo;

	/**
	 * 战斗信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class BattleInfoVO
	{
		public var battleSettlementArr:ArrayCollection = new ArrayCollection();//BattleOverSettlementVo
		public var battleResult:int;//1 success 2 fail
		public var fightType:int;//攻击类型 1： 打怪  2：决斗	3:Boss
		public var sceneName:String;//副本名称
		public var sucNum:int;//连胜次数
		public var goldNum:int;//金币奖励
		
		//竞技战斗结算信息
		public var jingjiResult:String;
		
		public var _initBattleVo:RBattleInitVo=null;
		public var _battleAllRoundVo:RBattleAllRoundVo=null;
		public function BattleInfoVO()
		{
		}
	}
}
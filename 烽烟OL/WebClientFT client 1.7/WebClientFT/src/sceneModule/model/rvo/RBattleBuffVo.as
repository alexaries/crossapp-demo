package sceneModule.model.rvo
{
	/**
	 * 显示列表的单个buff数据结构
	 * @author mutou
	 * 
	 */	
	public class RBattleBuffVo
	{
		public function RBattleBuffVo()
		{
		}
		public var buffId:int;//buff ID
		public var buffEffectId:int;//buff 特效ID
		public var buffIconId:int;//buff 图标ID
		public var buffName:String;//buff name
		public var buffLayerCount:int;//buff 层叠数
		public var buffRemainRoundCount:int;//buff 剩余回合数
	}
}
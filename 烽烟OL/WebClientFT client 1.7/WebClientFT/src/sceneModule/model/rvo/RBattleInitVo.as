package sceneModule.model.rvo
{
	import flash.geom.Point;

	/**
	 * 战斗初始化数据 
	 * @author mutou
	 * 
	 */	
	public class RBattleInitVo
	{
		public function RBattleInitVo()
		{
		}
		
		public var rBattleCenterPoint:Point;//战场的中点，镜头放置点
		public var rSceneId:int;//战斗场景ID
		public var rResArr:Array;//战斗场景资源列表
		public var rBattleInitChaVoArr:Array;//初始化的战斗场景中所有角色的VO(RBattleInitChaVo)数组
	}
}
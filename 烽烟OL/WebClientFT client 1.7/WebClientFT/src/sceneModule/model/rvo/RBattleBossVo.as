package sceneModule.model.rvo
{
	/**
	 * 战斗中的BOSS VO 
	 * @author sxmad
	 * 
	 */	
	public class RBattleBossVo
	{
		public function RBattleBossVo()
		{
		}
		public var id:int;//BOSS ID
		public var name:String;//BOSS 名称 
		public var level:int;// level
		public var professtionType:int;// 资源类型
		public var changeHp:int;
		public var currentHp:int;
		public var totalHp:int;
	}
}
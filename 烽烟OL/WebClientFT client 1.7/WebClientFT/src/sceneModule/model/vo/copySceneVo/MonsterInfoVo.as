package sceneModule.model.vo.copySceneVo
{
	/**
	 * 怪物信息VO
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class MonsterInfoVo
	{
		public var monsterId:int;//怪物id
		public var monsterLevel:int;//怪物等级
		public var monsterName:String;//怪物名称
		public var monsterType:int;//怪物类型
		public function MonsterInfoVo()
		{
		}
	}
}
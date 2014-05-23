package sceneModule.model.vo.copySceneVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 队伍中的副本信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class CopySceneOfGroupInfoVo
	{
		public var sceneResId:int;//副本id
		public var name:String;//副本名称
		public var monsterInfo:ArrayCollection = new ArrayCollection();//怪物信息集合MonsterInfo
		public var dropItemInfo:ArrayCollection = new ArrayCollection();//掉落的装备信息PackageItem
		public function CopySceneOfGroupInfoVo()
		{
		}
	}
}
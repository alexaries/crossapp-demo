package sceneModule.view.groupBattle.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MainGroupBattleInfoVO
	{
		public var lingdiInfo:GroupLingDiInfoVO = new GroupLingDiInfoVO();
		public var cityList:ArrayCollection = new ArrayCollection();//CityInfoVO
		public var xuyuanInfo:XuYuanInfoVO = new XuYuanInfoVO();
		public var groupBattleInfo:GroupBattleInfoVO = new GroupBattleInfoVO();
		public function MainGroupBattleInfoVO()
		{
		}
	}
}
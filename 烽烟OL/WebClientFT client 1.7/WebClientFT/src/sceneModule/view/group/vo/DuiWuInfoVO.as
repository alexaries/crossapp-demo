package sceneModule.view.group.vo
{
	import sceneModule.model.vo.packageVo.PackageItem;

	[Bindable]
	public class DuiWuInfoVO
	{
		public var dwId:int;//队伍Id
		public var dwType:int;//队伍类型1 lv30荒城回廊2 lv60斗技庭院3lv90混沌空间
		public var curNum:int;//当前人数
		public var leaderName:String;//队长
		public var itemInfo1:PackageItem = new PackageItem();
		public var itemInfo2:PackageItem = new PackageItem();
		public function DuiWuInfoVO()
		{
		}
	}
}
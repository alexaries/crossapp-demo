package sceneModule.view.groupBattle.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class XuYuanInfoVO
	{
		public var xyValue:int;//星运值
		public var usedInfo:ArrayCollection = new ArrayCollection();//使用记录UsedInfoVO
		public function XuYuanInfoVO()
		{
		}
	}
}
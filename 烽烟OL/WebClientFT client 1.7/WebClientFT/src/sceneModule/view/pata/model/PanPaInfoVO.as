package sceneModule.view.pata.model
{
	[Bindable]
	public class PanPaInfoVO
	{
		public var curLev:int;//当前阶级
		public var curMonster:String;//当前怪物
		public var obtainItem:String='';//挑战奖励
		public var reCount:int;//可刷新次数
		public var reZuan:int;//所需钻石
		public function PanPaInfoVO()
		{
		}
	}
}
package sceneModule.model.vo.commissionVo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CommissionGlodDataInfo
	{
		public var goldCon:ArrayCollection = new ArrayCollection();
		public var pageGoal:int;
		public var searchType:int;
		public function CommissionGlodDataInfo()
		{
		}
	}
}
package sceneModule.view.jingji.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MainJingJiInfoVO
	{
		public var rankInfo:String;//排名信息
		public var jifen:int;//积分
		public var weiwang:int;//威望
		public var rank:int;//排名
		public var liansheng:int;//连胜
		public var tzCount:int;//挑战次数
		public var drList:ArrayCollection = new ArrayCollection();//敌人列表信息DiRenInfoVO
		public var battleInfoList:ArrayCollection = new ArrayCollection();//战报信息BattleInfoVO
		
		public var CDTime:int;//CD时间
		public var rankAnnou:String;//排名公告
		
		public var buyTZCount:int;//已购买挑战次数
		public var buyReqZuan:int;//所需钻
		
		public var obtainTime:int;//奖励领取时间
		public function MainJingJiInfoVO()
		{
		}
	}
}
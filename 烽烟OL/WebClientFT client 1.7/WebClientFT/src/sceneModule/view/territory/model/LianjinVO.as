package sceneModule.view.territory.model
{
	/**
	 * 炼金信息VO 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class LianjinVO
	{
		public var runningFlag:Boolean;//是否存在挖掘线
		public var remainTime:int;
		public var sptimes:int=0;//点石成金当前剩余次数
		public var coinbound:int=0;//点石成金可以得到的金币奖励
		public var goldreq:int=0;//点石成金当前所需的消耗
		
		public function LianjinVO()
		{
		}
	}
}
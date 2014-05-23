package sceneModule.view.territory.model
{
	import mx.collections.ArrayCollection;

	/**
	 * 军营信息VO 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class TerritoryAramInfoVO
	{
		public var roleRunningFlag:Boolean;//当前角色是否正在训练中
		public var roleRunTime:int=0;//如果角色正在训练，则剩余时间
		public var sptimes:int=0;//加急训练当前的剩余次数
		public var expbound:int=0;//加急训练可以得到的经验奖励
		public var goldreq:int=0;//加急训练当前所需的消耗钻
		
		public var petAramInfo:ArrayCollection = new ArrayCollection();//TerritoryPetInfoVO
		public function TerritoryAramInfoVO()
		{
		}
	}
}
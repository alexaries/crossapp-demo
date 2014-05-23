package sceneModule.view.target.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class DayListTaskInfoVO
	{
		public var taskId:int;//任务id
		public var isCompleteFlag:Boolean;//是否完成
		public var icon:String;//图片名称
		public var taskDes:String;//任务说明
		public var isObtainFlag:Boolean;//奖励是否领取
		public var rewardInfoList:ArrayCollection = new ArrayCollection();//奖励信息RewardInfoVO
		public function DayListTaskInfoVO()
		{
		}
	}
}
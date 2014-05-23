package sceneModule.view.target.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 每日目标任务信息 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class DayTaskInfoVO
	{
		public var isSucFlag:Boolean;//是否领取
		public var dayListTaskInfo:ArrayCollection = new ArrayCollection();//每天任务列表信息DayListTaskInfoVO
		public var isOpenFlag:Boolean;//是否开启
		public function DayTaskInfoVO()
		{
		}
	}
}
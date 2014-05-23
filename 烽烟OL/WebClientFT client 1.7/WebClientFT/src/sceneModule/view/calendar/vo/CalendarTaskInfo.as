package sceneModule.view.calendar.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CalendarTaskInfo
	{
		
		public var totalLivenessNum:int;//总活跃度
		public var unfinished:ArrayCollection=new ArrayCollection();//未完成的日程列表
		public var finished:ArrayCollection=new ArrayCollection();//完成的日程列表
		public var scheduleBound:ArrayCollection=new ArrayCollection(); //奖励列表
		
		public function CalendarTaskInfo()
		{
		}
	}
}
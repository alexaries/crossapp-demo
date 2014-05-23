package sceneModule.model.vo.taskVO
{
	/**
	 * 任务追踪分线信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class TaskTrackingInfoVo
	{
		public var questGoalId:int;//任务目标Id
		public var requireNum:int;//目标的需求数目
		public var achieveNum:int;//目标已实现的数目
		public var trackDesc:String;//任务的追踪描述
		public var trackID:int;//追踪的ID
		public function TaskTrackingInfoVo()
		{
		}
	}
}
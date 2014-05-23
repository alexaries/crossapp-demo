package sceneModule.model.vo.taskVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 任务追踪主线任务VO 
	 * @author Yaolx
	 * 
	 */	
	public class TaskMainTrackingInfoVo
	{
		public var taskId:int;//任务的id
		public var taskName:String;//任务名称
		public var taskType:int;//任务的类型
		public var hasFinished:int;//是否已经完成 0：未完成 1：已完成
		public var processinfolist:ArrayCollection = new ArrayCollection();//任务的目标进度 TaskTrackingInfoVo
		public var circulatingCount:int;//环数
		public var finishedNpcId:int;//任务完成后的NPCid
		public function TaskMainTrackingInfoVo()
		{
		}
	}
}
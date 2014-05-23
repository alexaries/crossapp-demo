package sceneModule.model.vo.taskVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 任务信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class TaskInfoVo
	{
		public var taskId:int;			//任务的ID
		public var taskname:String;		//任务的名称
		public var taskType:int;//0可接受任务1进行中的任务2可提交的任务3失败的任务
		public var taskChild:ArrayCollection = new ArrayCollection();//孩子节点信息 TaskInfoVo
		public function TaskInfoVo()
		{
		}
	}
}
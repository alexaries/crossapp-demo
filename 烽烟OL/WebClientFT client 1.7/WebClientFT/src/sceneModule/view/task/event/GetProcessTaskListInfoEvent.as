package sceneModule.view.task.event
{
	import flash.events.Event;

	/**
	 * 获取正在进行的任务列表信息 
	 * @author Yaolx
	 * 
	 */	
	public class GetProcessTaskListInfoEvent extends Event
	{
		public static const GETPROCESSTASKLISTINFO:String = "getProcessTaskListInfo";
		public var _obj:Object;
		public function GetProcessTaskListInfoEvent(type:String,value:Object)
		{
			_obj = value;
			super(type);
		}
	}
}
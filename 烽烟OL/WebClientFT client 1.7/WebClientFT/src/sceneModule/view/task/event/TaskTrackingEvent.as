package sceneModule.view.task.event
{
	import flash.events.Event;

	/**
	 * 任务追踪 ， 服务器返回的已接受的任务列表 
	 * @author Yaolx
	 * 
	 */	
	public class TaskTrackingEvent extends Event
	{
		public static const TASKTRACKINGEVENT:String = "taskTrackingEvent";
		public var _obj:Object;
		public function TaskTrackingEvent(type:String,obj:Object)
		{
			_obj = obj;
			super(type);
		}
	}
}
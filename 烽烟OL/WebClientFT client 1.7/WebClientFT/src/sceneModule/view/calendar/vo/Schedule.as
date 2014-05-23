package sceneModule.view.calendar.vo
{
	//日程信息
	[Bindable]
	public class Schedule
	{
		public var scheduleId:int;//日程的ID
		public var desc:String;    //日程的描述
		public var now:int;//当前进度
		public var total:int;//总的进度
		public var activity:int;//日程奖励的活力
		
		public function Schedule()
		{
		}
	}
}
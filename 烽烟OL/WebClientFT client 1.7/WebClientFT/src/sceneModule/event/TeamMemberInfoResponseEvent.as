package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 组队成员信息返回事件 
	 * @author Yaolx
	 * 
	 */	
	public class TeamMemberInfoResponseEvent extends Event
	{
		public static const TEAMMEMBERINFOEVENT:String = "teamMemberInfoEvent";
		public var obj:Object;
		public function TeamMemberInfoResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
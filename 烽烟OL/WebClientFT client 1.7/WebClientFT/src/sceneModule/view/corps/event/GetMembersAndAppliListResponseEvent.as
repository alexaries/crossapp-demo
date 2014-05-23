package sceneModule.view.corps.event
{
	import flash.events.Event;

	/**
	 * 获取军团成员列表和申请列表 
	 * @author Dream-Y
	 * 
	 */	
	public class GetMembersAndAppliListResponseEvent extends Event
	{
		public static const GETMEMBERSANDAPPLILISTRESPONSE:String = "getMembersAndAppliListResponse";
		public var obj:Object;
		public function GetMembersAndAppliListResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
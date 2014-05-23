package sceneModule.event
{
	import flash.events.Event;

	/**
	 *获取角色信息Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleInfoEvent extends Event
	{
		public static const GET_ROLEINFO_EVENT:String = "getRoleInfo";
		public function GetRoleInfoEvent(type:String)
		{
			super(type);
		}
	}
}
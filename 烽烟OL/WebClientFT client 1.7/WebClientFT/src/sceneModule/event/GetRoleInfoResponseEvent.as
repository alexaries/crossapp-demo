package sceneModule.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;

	/**
	 *获取角色信息成功处理事件 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleInfoResponseEvent extends Event
	{
		public static const GET_ROLEINFO_SUCCESS_EVENT:String = "getRoleInfoSuccess";
		public var result:Object;
		public function GetRoleInfoResponseEvent(type:String,value:Object)
		{
			super(type);
			this.result = value;
		}
	}
}
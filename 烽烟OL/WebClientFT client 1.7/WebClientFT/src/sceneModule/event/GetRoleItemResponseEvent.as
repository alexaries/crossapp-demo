package sceneModule.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;

	/**
	 * 获取角色装备信息成功事件 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleItemResponseEvent extends Event
	{
		public static const GET_ROLEITEM_EVENT:String = "getRoleItemEvent";
		
		public var result:Object;
		public function GetRoleItemResponseEvent(type:String,evt:Object)
		{
			this.result = evt;
			super(type);
		}
	}
}
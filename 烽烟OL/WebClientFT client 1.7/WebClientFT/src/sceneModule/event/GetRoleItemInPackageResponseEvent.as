package sceneModule.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;

	/**
	 * 获取角色物品信息ResponseEvent 
	 * @author Yaolx
	 * 
	 */	
	public class GetRoleItemInPackageResponseEvent extends Event
	{
		public static const GETROLEITEMINPACKAGEVENT:String="getRoleItemInPackageEvent";
		public var result:Object;
		public function GetRoleItemInPackageResponseEvent(type:String,result:Object)
		{
			this.result = result;
			super(type);
		}
	}
}
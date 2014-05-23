package sceneModule.view.friend.event
{
	import flash.events.Event;

	/**
	 * 获取好友信息Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetPlayerFrindsEvent extends Event
	{
		public static const GETPLAYERFRINDS:String="getPlayerFrinds";
		public var desName:int;
		public var desRule:int;
		public function GetPlayerFrindsEvent(type:String,value1:int,value2:int)
		{
			desName = value1;
			desRule = value2;
			super(type);
		}
	}
}
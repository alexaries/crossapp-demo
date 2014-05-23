package sceneModule.view.friend.event
{
	import flash.events.Event;
	
	import mx.rpc.events.ResultEvent;
	
	import proto.friends.friends302.Friends;
	import proto.friends.friends302.getPlayerFrindsResponse;

	/**
	 * 获取好友信息Response Event 
	 * @author Yaolx
	 * 
	 */	
	public class GetPlayerFrindsResponseEvent extends Event
	{
		public static const GETPLAYERFRINDSRESPONSE:String="getPlayerFrindsResponse";
		public var result:getPlayerFrindsResponse
		public function GetPlayerFrindsResponseEvent(type:String,value:getPlayerFrindsResponse)
		{
			result = value;
			super(type);
		}
	}
}
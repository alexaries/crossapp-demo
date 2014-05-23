package sceneModule.view.ranking.event
{
	import flash.events.Event;

	/**
	 * 获取排行榜信息返回事件 
	 * @author Dream-Y
	 * 
	 */	
	public class GetRankingListInfoResponseEvent extends Event
	{
		public static const GETRANKINGLISTINFORESPONSE:String = "getRankingListInfoResponse";
		public var obj:Object;
		public function GetRankingListInfoResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
package sceneModule.view.corps.event
{
	import flash.events.Event;

	/**
	 * 获取军团科技列表返回事件
	 * @author Dream-Y
	 * 
	 */	
	public class GetCorpsTechnologyListInfoResponseEvent extends Event
	{
		public static const GETCORPSTECHNOLOGYLISTINFORESPONSE:String = "getCorpsTechnologyListInfoResponse";
		public var obj:Object;
		public function GetCorpsTechnologyListInfoResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
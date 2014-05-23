package sceneModule.view.corps.event
{
	import flash.events.Event;

	/**
	 * 获取军徽信息返回Event 
	 * @author Dream-Y
	 * 
	 */	
	public class GetEmblemInfoResponseEvent extends Event
	{
		public static const GETEMBLEMINFORESPONSE:String = "getEmblemInfoResponse";
		public var obj:Object;
		public function GetEmblemInfoResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
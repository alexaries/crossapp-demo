package sceneModule.view.corps.event
{
	import flash.events.Event;

	/**
	 * 获取或搜索军团返回事件 
	 * @author Dream-Y
	 * 
	 */	
	public class GetOrSearchCorpsListResponseEvent extends Event
	{
		public static const GETORSEARCHCORPSLISTRESPONSE:String = "getOrSearchCorpsListResponse";
		public var obj:Object;
		public function GetOrSearchCorpsListResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
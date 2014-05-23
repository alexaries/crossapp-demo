package event
{
	import flash.events.Event;

	/**
	 * 预加载资源加载进度事件 
	 * @author Dream-Y
	 * 
	 */	
	public class PreLoadResProgressEvent extends Event
	{
		public static var PROLOADRESPROGRESS:String = "preLoadResProgress";
		public static var PRELOADPRERESPROGRESS:String = "preLoadPreResProgress";
		public static var PRELOADZIPRESPROGRESS:String = "preLoadZipProgress";
		public var loadPer:Number;
		public function PreLoadResProgressEvent(type:String,per:Number)
		{
			loadPer = per;
			super(type);
		}
	}
}
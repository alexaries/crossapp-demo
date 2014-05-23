package sceneModule.view.blacksmith.event
{
	import flash.events.Event;

	public class ZhuanYiEvent extends Event
	{
		public static var SHUXINGZHUANYIEVENT:String='shuXingZhuanYiEvent';
		public static var SHUXINGZHUANYIRENDEREVENT:String='shuXingZhuanYiRenderEvent';
		public static var SHUXINGZHUANYIDRAGEVENT:String='shuXingZhuanYiDRAGEvent';
		public var _obj:Object;

		public function ZhuanYiEvent(type:String, value:Object,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_obj=value;
			super(type,bubbles, cancelable);
		}
		
		override public function clone():Event{
			return new ZhuanYiEvent(type, _obj, bubbles, cancelable);
		}
	}
}

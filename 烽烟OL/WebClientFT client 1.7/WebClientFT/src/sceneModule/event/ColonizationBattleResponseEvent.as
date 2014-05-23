package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 殖民战战斗数据返回事件 
	 * @author Dream-Y
	 * 
	 */	
	public class ColonizationBattleResponseEvent extends Event
	{
		public static var COLONIZATIONBATTLERESPONSE:String = "colonizationBattleResponse";
		public var obj:Object;
		public function ColonizationBattleResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
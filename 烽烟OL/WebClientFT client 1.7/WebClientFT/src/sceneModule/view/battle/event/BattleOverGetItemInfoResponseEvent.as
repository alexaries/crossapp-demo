package sceneModule.view.battle.event
{
	import flash.events.Event;
	import flash.utils.ByteArray;

	/**
	 * 获取战后结束物品信息返回值处理事件 
	 * @author Yaolx
	 * 
	 */	
	public class BattleOverGetItemInfoResponseEvent extends Event
	{
		public static const BATTLEOVERITEMRESPONSE:String="battleOverItemResponse";
		public var byteArray:ByteArray;
		public function BattleOverGetItemInfoResponseEvent(type:String,value:ByteArray)
		{
			byteArray = value;
			super(type);
		}
	}
}
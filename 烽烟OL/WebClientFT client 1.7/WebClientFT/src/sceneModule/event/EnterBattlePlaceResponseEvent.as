package sceneModule.event
{
	import flash.events.Event;
	
	import proto.battle.battle703.FightResponse;

	/**
	 * 进入战场初始化信息返回 
	 * @author Yaolx
	 * 
	 */	
	public class EnterBattlePlaceResponseEvent extends Event
	{
		public static const ENTERBATTLEPLACERESPONSE:String = "enterBattlePlaceResponse";
		public var result:FightResponse;
		public function EnterBattlePlaceResponseEvent(type:String,_result:FightResponse)
		{
			super(type);
			result = _result;
		}
	}
}
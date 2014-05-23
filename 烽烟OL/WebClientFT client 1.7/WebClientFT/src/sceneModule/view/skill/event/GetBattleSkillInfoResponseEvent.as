package sceneModule.view.skill.event
{
	import flash.events.Event;

	public class GetBattleSkillInfoResponseEvent extends Event
	{
		public static const GETBATTLESKILLINFORESPONSE:String = "getBattleSkillInfoResponse";
		public var obj:Object;
		public function GetBattleSkillInfoResponseEvent(type:String,value:Object)
		{
			obj = value;
			super(type);
		}
	}
}
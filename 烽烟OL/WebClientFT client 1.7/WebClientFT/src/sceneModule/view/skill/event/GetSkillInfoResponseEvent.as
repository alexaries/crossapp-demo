package sceneModule.view.skill.event
{
	import flash.events.Event;

	public class GetSkillInfoResponseEvent extends Event
	{
		public static const GETSKILLINFORESPONSE:String = "getSkillInfoResponse";
		public var _obj:Object;
		public function GetSkillInfoResponseEvent(type:String,value:Object)
		{
			_obj = value;
			super(type);
		}
	}
}
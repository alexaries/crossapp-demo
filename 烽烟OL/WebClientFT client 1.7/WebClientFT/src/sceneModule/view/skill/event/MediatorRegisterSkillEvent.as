package sceneModule.view.skill.event
{
	import flash.events.Event;

	public class MediatorRegisterSkillEvent extends Event
	{
		public static const MEDIATORREGISTER_BATTLESKILL:String = "mediatorRegister_battleSkill";
		public static const MEDIATORREGISTER_SKILLCOMP:String = "mediatorRegister_skillComp";
		public static const MEDIATORREGISTER_SKILLITEMRENDER:String = "mediatorRegister_skillItemRender";
		public var view:Object;
		public function MediatorRegisterSkillEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterSkillEvent(type, view, bubbles, cancelable);
		}
	}
}
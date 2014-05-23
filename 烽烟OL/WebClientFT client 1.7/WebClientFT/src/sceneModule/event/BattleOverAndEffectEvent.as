package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 战斗结束事件 
	 * @author Dream-Y
	 * 
	 */	
	public class BattleOverAndEffectEvent extends Event
	{
		public static var BATTLEOVERANDEFFECT:String = "battleOverAndEffect";
		public function BattleOverAndEffectEvent(type:String)
		{
			super(type);
		}
	}
}
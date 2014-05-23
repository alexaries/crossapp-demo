package sceneModule.view.battle.event
{
	import flash.events.Event;

	/**
	 * 战斗翻牌子事件 
	 * @author Dream-Y
	 * 
	 */	
	public class BattleFlipEvent extends Event
	{
		public static const BATTLEFLIPEVENT:String = "battleFlipEvent";
		public function BattleFlipEvent(type:String)
		{
			super(type);
		}
	}
}
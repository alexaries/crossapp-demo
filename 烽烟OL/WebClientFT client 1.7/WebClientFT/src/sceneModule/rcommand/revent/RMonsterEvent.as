package sceneModule.rcommand.revent
{
	/**
	 * 怪物事件类 
	 */	
	import flash.events.Event;
	
	public class RMonsterEvent extends Event
	{
		public function RMonsterEvent(type:String, id:int=0)
		{
			super(type);
			monsterId = id;
		}
		public var monsterId:int;//怪物ID
		public static const MONSTER_ID_STR:String = "monsterId";
		public static const NUM_STR:String = "|Number|";
		public static const NORMAL_MONSTER_EVENT:String = "normalMonsterEvent";//普通怪物事件
		public static const BOSS_MONSTER_EVENT:String = "bossMonsterEvent";//BOSS怪物事件
	}
}
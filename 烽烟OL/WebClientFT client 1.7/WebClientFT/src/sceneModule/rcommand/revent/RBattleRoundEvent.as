package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	/**
	 * 战斗事件 
	 * @author mutou
	 * 
	 */	
	public class RBattleRoundEvent extends Event
	{
		public function RBattleRoundEvent(type:String,allCount:int=0, currentCount:int=0)
		{
			super(type);
			this.rAllRoundCount = allCount;
			this.rCurrentRoundCount = currentCount;
		}
		public var rAllRoundCount:int;//总回合数
		public var rCurrentRoundCount:int;//当前是第几回合
		public static const ONE_ROUND_OVER_EVENT:String = "oneRoundOverEvent";//一回合结束事件
		public static const ALL_ROUND_OVER_EVENT:String = "allRoundOverEvent";//全部回合结束事件，或者称之为战斗结束事件
	}
}
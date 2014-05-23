package sceneModule.rcommand.revent
{
	import flash.events.Event;
	/**
	 * 动作事件 
	 * @author mutou
	 * 
	 */	
	public class ActionEvent extends Event
	{
		public function ActionEvent(type:String,actionType:int=-1)
		{
			super(type);
			this.actionType = actionType;
		}
		public static const ACTION_PLAY_BACK_FINISH_EVENT:String = "actionPlayBackFinishEvent";//动作完成
		public var actionType:int;//动作类型 1：攻击 ，2：防御，3：死亡
		
		//public static const ATTACK_PLAY_BACK_FINISH_EVENT:String = "attackPlayBackFinishEvent";//攻击动作完成
		//public static const DEFENSE_PLAY_BACK_FINISH_EVENT:String = "defensePlayBackFinishEvent";//防御动作穿完成
		//public static const DEATH_PLAY_BACK_FINISH_EVENT:String = "deathPlayBackFinishEvent";//死亡动作完成
	}
}
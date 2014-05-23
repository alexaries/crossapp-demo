package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	/**
	 * 进入战斗和退出战斗切换界面显示的事件 
	 * @author mutou
	 * 
	 */	
	public class RSwitchBattleEvent extends Event
	{
		public function RSwitchBattleEvent(type:String,voArr:Array=null)
		{
			super(type);
			this.rBattleInitUIVoArr = voArr;
		}
		public static const SWITCH_BATTLE_EVENT:String = "switchBattleEvent";//进入战斗和退出战斗显示界面切换
		public var rBattleInitUIVoArr:Array;//进入战斗，初始化头像UI数据,内含数据结构为：RBattleInitUIVo
	}
}
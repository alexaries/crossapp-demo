package sceneModule.view.battle.event
{
	import flash.events.Event;

	/**
	 * 选择牌子后发送请求 
	 * @author Yaolx
	 * 
	 */	
	public class BattleFlipSendSelectedEvemt extends Event
	{
		public static const SENDSELECTEDCOMMAND:String="sendSelectedCommand";
		public var selectedIndex:int;
		public function BattleFlipSendSelectedEvemt(type:String,index:int)
		{
			selectedIndex = index;
			super(type);
		}
	}
}
package sceneModule.rcommand.revent
{
	import flash.events.Event;
	
	import sceneModule.model.rvo.RBattleTipVo;
	
	public class RBattleTipEvent extends Event
	{
		public function RBattleTipEvent(type:String,vo:RBattleTipVo = null)
		{
			super(type);
			rbattleTipVo = vo;
		}
		public var rbattleTipVo:RBattleTipVo;
		public static const BATTLE_TIP_EVENT:String = "battleTipEvent";
		public static const BATTLE_TIP_HIDE_EVENT:String = "battleTipHideEvent";
	}
}
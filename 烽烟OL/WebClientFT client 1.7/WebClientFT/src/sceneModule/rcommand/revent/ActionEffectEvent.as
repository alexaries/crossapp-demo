package sceneModule.rcommand.revent
{
	import flash.events.Event;
	/**
	 * 战斗特效事件，对于普通特效，播放完以后发事件提示 
	 * @author mutou
	 * 
	 */	
	public class ActionEffectEvent extends Event
	{
		public function ActionEffectEvent(type:String)
		{
			super(type);
		}
		
		public static const EFFECT_PLAY_BACK_FINISH_EVENT:String = "effectPlayBackFinishEvent";//播放特效结束
	}
}
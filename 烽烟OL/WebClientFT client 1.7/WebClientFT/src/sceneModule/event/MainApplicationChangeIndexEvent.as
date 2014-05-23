package sceneModule.event
{
	import flash.events.Event;

	/**
	 * 舞台上的各层空间的层（index)改变事件 
	 * @author Yaolx
	 * 
	 */	
	public class MainApplicationChangeIndexEvent extends Event
	{
		public static const MAINAPPLICATIONCHILDSWAPINDEX:String = "mainApplicationChildSwapIndex";
		public function MainApplicationChangeIndexEvent(type:String)
		{
			super(type);
		}
	}
}
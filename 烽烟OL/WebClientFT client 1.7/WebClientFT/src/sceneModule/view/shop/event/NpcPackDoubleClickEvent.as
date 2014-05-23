package sceneModule.view.shop.event
{
	import flash.events.Event;

	public class NpcPackDoubleClickEvent extends Event
	{
		public static const NPCPACKDOUBLECLICKEVENT:String = "npcPackDoubleClickEvent";
		public function NpcPackDoubleClickEvent(type:String)
		{
			super(type);
		}
	}
}
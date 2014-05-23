package sceneModule.view.gaAndsd.event
{
	import flash.events.Event;

	public class GuaJiCancelEvent extends Event
	{
		public static const GUAJICANCELEVENT:String = 'guaJiCancelEvent';
		public function GuaJiCancelEvent(type:String)
		{
			super(type);
		}
	}
}
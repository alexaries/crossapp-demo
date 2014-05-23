package sceneModule.view.announ
{
	import flash.events.Event;

	public class AddWindowEvent extends Event
	{
		public static const PREADDWINDOWEVENT:String = 'preAddWindowEvent';
		public static const ADDWINDOWEVENT:String = 'addWindowEvent';
		public function AddWindowEvent(type:String)
		{
			super(type);
		}
	}
}
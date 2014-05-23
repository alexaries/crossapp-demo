package sceneModule.view.mail.event
{
	import flash.events.Event;

	public class MainMenuMailComponentCreateCompleteEvent extends Event
	{
		public static const MAINMENUMAILCOMPONENTCREATECOMPLETE:String = "mainMenuMailComponentCreateComplete";
		public function MainMenuMailComponentCreateCompleteEvent(type:String)
		{
			super(type);
		}
	}
}
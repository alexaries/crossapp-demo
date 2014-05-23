package sceneModule.view.ui.event
{
	import flash.events.Event;

	public class PopUpGuideLayerEvent extends Event
	{
		public static const POPUPGUIDELAYEREVENT:String = "popUpGuideLayerEvent";
		public var taskId:int;
		public function PopUpGuideLayerEvent(type:String,tId:int)
		{
			taskId = tId;
			super(type);
		}
	}
}
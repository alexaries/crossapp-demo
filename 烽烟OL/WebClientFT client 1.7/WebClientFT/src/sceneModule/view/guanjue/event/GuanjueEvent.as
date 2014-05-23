package sceneModule.view.guanjue.event
{
	import flash.events.Event;

	public class GuanjueEvent extends Event
	{
		public static const GUANJUE_EVENT:String = "guanjueevent";
		
		public var _obj:Object;
		public function GuanjueEvent(type:String, view:Object)
		{
			
			super(type);
			this._obj = view;
		}
		
		
		
	}
}
package sceneModule.view.corps.event
{
	import flash.events.Event;
	
	public class MediatorRegisterCorpsEvent extends Event
	{
		public static const MR_CORPS_ROOT:String = "mr_corps_root";
		public static const MR_CORPS_OUT:String = "mr_corps_out";
		public static const MR_CORPS_IN:String = "mr_corps_in";
		public static const MR_CORPS_EMBLEM:String = "mr_corps_emblem";
		public static const MR_CORPS_KEJI:String = "mr_corps_keji";
		public static const MR_CORPS_MEMBER:String = "mr_corps_member";
		public static const MR_CORPS_REQUEST:String = "mr_corps_request";
		public var view:Object;
		public function MediatorRegisterCorpsEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterCorpsEvent(type, view, bubbles, cancelable);
		}
	}
}
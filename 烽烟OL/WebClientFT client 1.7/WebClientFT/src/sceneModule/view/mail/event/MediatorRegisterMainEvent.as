package sceneModule.view.mail.event
{
	import flash.events.Event;

	public class MediatorRegisterMainEvent extends Event
	{
		public static const MR_MAIL_COMP:String = "mr_mail_comp";
		public static const MR_MAIL_ITEMRENDER:String = "mr_mail_itemRender";
		
		public var view:Object;
		public function MediatorRegisterMainEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new MediatorRegisterMainEvent(type, view, bubbles, cancelable);
		}
	}
}
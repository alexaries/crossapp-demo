package sceneModule.view.shop.event
{
	import flash.events.Event;

	public class RegisterMediatorShopItemEvent extends Event
	{
		public static const MEDIATORREGISTERSHOPITEM:String = "mediatorRegisterShopItem";
		public var view:Object;
		public function RegisterMediatorShopItemEvent(type:String, view:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
			this.view = view;
		}
		override public function clone():Event{
			return new RegisterMediatorShopItemEvent(type, view, bubbles, cancelable);
		}
	}
}
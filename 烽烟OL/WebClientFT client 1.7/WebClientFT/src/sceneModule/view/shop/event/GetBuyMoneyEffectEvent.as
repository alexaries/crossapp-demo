package sceneModule.view.shop.event
{
	import flash.events.Event;
	
	public class GetBuyMoneyEffectEvent extends Event
	{
		public static const GETBUYCHANGEMONEYFLASHEFFECT:String = "getBuyChangeMoneyFlashEffect";
		public function GetBuyMoneyEffectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			
			super(type, bubbles, cancelable);
		}
	}
}
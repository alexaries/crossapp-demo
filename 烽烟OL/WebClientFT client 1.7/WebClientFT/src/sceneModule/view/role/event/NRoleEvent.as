package sceneModule.view.role.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NRoleEvent extends Event 
	{
		public static const NRoleEvent_INFO_CHANGE:String = "NRoleEvent_INFO_CHANGE"; 
		public static const NRoleEvent_EQUIP_CHANGE:String = "NRoleEvent_EQUIP_CHANGE";
		public function NRoleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}
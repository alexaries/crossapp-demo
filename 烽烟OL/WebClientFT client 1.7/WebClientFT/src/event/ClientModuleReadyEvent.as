package event
{
	import flash.events.Event;
	
	public class ClientModuleReadyEvent extends Event
	{
		/**
		 * event type 
		 */		
		static public const CLIENT_MODULE_READY:String = "ClientModuleReadyEvent";
		
		/**
		 * module id 
		 */		
		public var moduleId:String = "";
		
		/**
		 * constructor 
		 * @param id	module id
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function ClientModuleReadyEvent(id:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			moduleId = id;
			super(CLIENT_MODULE_READY, bubbles, cancelable);
		}
		
		/**
		 * clone function 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new ClientModuleReadyEvent(moduleId, bubbles, cancelable);
		}
	}
}
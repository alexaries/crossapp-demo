package event
{
	import flash.events.Event;
	
	/**
	 * 切换模块 
	 * @author Linus
	 * 
	 */	
	public class ChangeModuleEvent extends Event
	{
		/**
		 * Event ID 
		 */		
		static public const CHANGE_MODULE_EVENT:String = "changeModuleEvent";
		
		/**
		 * new module id 
		 */		
		public var newModuleId:String = "";
		
		/**
		 * constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function ChangeModuleEvent(moduleId:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			newModuleId = moduleId;
			super(CHANGE_MODULE_EVENT, bubbles, cancelable);
		}
		
		/**
		 * clone function 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new ChangeModuleEvent(newModuleId, bubbles, cancelable);
		}
	}
}
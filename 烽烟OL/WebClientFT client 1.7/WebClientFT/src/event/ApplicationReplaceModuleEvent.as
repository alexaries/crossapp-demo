package event
{
	import flash.events.Event;
	
	/**
	 * 
	 * @author Linus
	 * 
	 */	
	public class ApplicationReplaceModuleEvent extends Event
	{
		/**
		 * 应用模块替换
		 */		
		static public const APPLICATION_REPLACE_MODULE:String = "applicationReplaceModuleEvent";
		
		/**
		 * constructor
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function ApplicationReplaceModuleEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(APPLICATION_REPLACE_MODULE, bubbles, cancelable);
		}
		
		/**
		 * clone
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new ApplicationReplaceModuleEvent(bubbles, cancelable);
		}
	}
}
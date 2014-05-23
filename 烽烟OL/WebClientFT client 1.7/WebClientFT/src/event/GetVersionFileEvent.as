package event
{
	import flash.events.Event;
	
	/**
	 * Event for get version file 
	 * @author Linus
	 * 
	 */	
	public class GetVersionFileEvent extends Event
	{
		static public const VERSION_FILE_LOADED:String = "versionFileLoaded";
		
		/**
		 * data stored 
		 */		
		public var xmlData:XML;
		
		/**
		 * constructor 
		 * @param data
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function GetVersionFileEvent(data:XML, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			xmlData = data;
			super(VERSION_FILE_LOADED, bubbles, cancelable);
		}
		
		/**
		 * override clone function 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new GetVersionFileEvent(xmlData, bubbles, cancelable);
		}
	}
}
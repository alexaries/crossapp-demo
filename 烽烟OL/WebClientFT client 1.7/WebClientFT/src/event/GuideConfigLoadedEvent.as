package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class GuideConfigLoadedEvent extends Event 
	{
		public static const EVENT_GuideConfigLoaded:String = "EVENT_GuideConfigLoaded";
		private var _xml:XML;
		public function GuideConfigLoadedEvent(xml:XML, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_xml = xml;
			super(EVENT_GuideConfigLoaded, bubbles, cancelable);
		}
		
		public function get xml():XML 
		{
			return _xml;
		}
		
	}

}
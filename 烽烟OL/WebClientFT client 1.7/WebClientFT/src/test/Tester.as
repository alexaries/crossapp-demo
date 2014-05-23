package test 
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import wordscene.helper.MapPathFinder;
	
	/**
	 * ...
	 * @author hao
	 */
	public class Tester extends Sprite 
	{
		
		public function Tester() 
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaded);
			loader.load(new URLRequest("config/door.xml"));
		}
		
		private function loaded(e:Event):void 
		{
			var loader:URLLoader = e.target as URLLoader;
			MapPathFinder.getInstance().init(XML(loader.data));
		}
		
	}

}
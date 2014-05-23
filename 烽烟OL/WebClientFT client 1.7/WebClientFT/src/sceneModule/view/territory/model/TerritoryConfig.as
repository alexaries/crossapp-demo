package sceneModule.view.territory.model
{
	public class TerritoryConfig
	{
		
		private var territoryXML:XML;
		private static var _instance:TerritoryConfig;
		public function TerritoryConfig()
		{
		}
		
		public static function getInstance():TerritoryConfig{
			if(null == _instance){
				_instance = new TerritoryConfig();
			}
			return _instance;
		}
		
		public function get territory_xml():XML{
			return territoryXML;
		}
		
		public function set territory_xml(xml:XML):void{
			territoryXML = xml;
		}
	}
}
package resource
{
	/**
	 * 文本资源配置文件 
	 * @author DreamY
	 * 
	 */	
	public class CrotaResourceConfig
	{
		private static var _instance:CrotaResourceConfig;
		
		private var _resXML:XML;
		
		public function CrotaResourceConfig()
		{
		}
		
		public function set resXML(value:XML):void{
			this._resXML = value;
		}
		
		public function get resXML():XML{
			return this._resXML;
		}
		
		public static function getInstance():CrotaResourceConfig{
			if(null == _instance){
				_instance = new CrotaResourceConfig();
			}
			
			return _instance;
		}
		
		public function getTextByModuleAndId(module:String,id:String):String{
			for each(var moduleXML:XML in CrotaResourceConfig.getInstance().resXML.module){
				if(moduleXML.@id == module){
					for each(var info:XML in moduleXML.info){
						if(info.@id == id){
							return info.@value;
						}
					}
				}
			}
			return '';
		}
	}
}
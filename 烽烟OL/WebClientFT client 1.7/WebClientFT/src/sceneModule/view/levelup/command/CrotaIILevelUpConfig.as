package sceneModule.view.levelup.command
{
	import sceneModule.view.levelup.vo.LevelUpEffectVO;

	public class CrotaIILevelUpConfig
	{
		private static var _instance:CrotaIILevelUpConfig;
		
		private var _levUpXML:XML;
		public function CrotaIILevelUpConfig()
		{
		}
		
		public static function getInstance():CrotaIILevelUpConfig{
			if(null == _instance){
				_instance = new CrotaIILevelUpConfig();
			}
			
			return _instance;
		}
		
		public function getCurLevelEffectInfo(lev:int):Array{
			var levEffArr:Array = [];
			for each(var mdXML:XML in CrotaIILevelUpConfig.getInstance().levUpXML.module){
				if(mdXML.@level == lev){
					for each(var infoXML:XML in mdXML.info){
						var levUpEffVO:LevelUpEffectVO = new LevelUpEffectVO();
						levUpEffVO.imgUrl = infoXML.@imgUrl;
						levUpEffVO.name = infoXML.@name;
						levUpEffVO.toL = infoXML.@toL;
						levUpEffVO.toT = infoXML.@toT;
						levUpEffVO.toR = infoXML.@toR;
						levUpEffVO.direction = infoXML.@direction;
						levEffArr.push(levUpEffVO);
					}
				}
			}
			return levEffArr;
		}
		
		public function set levUpXML(value:XML):void{
			_levUpXML = value;
		}
		
		public function get levUpXML():XML{
			return _levUpXML;
		}
	}
}
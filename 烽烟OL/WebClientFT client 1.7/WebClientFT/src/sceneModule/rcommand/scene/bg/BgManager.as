package sceneModule.rcommand.scene.bg
{
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.entity.IEntity;
	
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnly;
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnlyPre;
	import sceneModule.rfactory.RPBELevel;

	public class BgManager
	{
		public function BgManager()
		{
		}
		
		private static var _instance:BgManager;
		public static function getInstance():BgManager{
			if(_instance == null){
				_instance = new BgManager();
			}
			return _instance;
		}
		public function startBgRepeat():void{
			bgHandler("start");
		}
		public function stopBgRepeat():void{
			bgHandler("stop");
		}
		private function bgHandler(fun:String):void{
			var preBg2Ent:IEntity;
			var bgEnt:IEntity;
			var bgCmp:*;
			var repeatCmpName:String;
			for(var i:int=1;i<5;i++){
				repeatCmpName = "ga_backdrop_ent"+i;
				if(i==2){
					preBg2Ent = PBE.nameManager.lookup(RPBELevel.PRE_BG_ENTITY_NAME + i);
					if(preBg2Ent){
						var preRepeatCmp:RepeatingRenderComponentXOnlyPre = 
							preBg2Ent.lookupComponentByName(repeatCmpName) as RepeatingRenderComponentXOnlyPre;
						if(preRepeatCmp){
							preRepeatCmp[fun]();
						}
					}
				}
				bgEnt = PBE.nameManager.lookup(RPBELevel.BG_ENTITY_NAME+i);
				if(bgEnt){
					var repeatCmp:RepeatingRenderComponentXOnly = 
						bgEnt.lookupComponentByName(repeatCmpName) as RepeatingRenderComponentXOnly;
					if(repeatCmp){
						repeatCmp[fun]();
					}
				}
			}
		}
	}
}
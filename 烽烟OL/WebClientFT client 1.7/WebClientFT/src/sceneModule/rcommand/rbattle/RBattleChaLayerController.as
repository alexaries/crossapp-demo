package sceneModule.rcommand.rbattle
{
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	
	import sceneModule.model.rvo.RBattleInitChaVo;
	import sceneModule.model.rvo.RUpdateCharacterLayerVo;
	import sceneModule.rcommand.rcharacter.RCharacterInfoComponent;
	import sceneModule.rcommon.RBattleChaMcRender;
	import sceneModule.rcommon.RMovieClipRenderer;
	import sceneModule.rcommon.RRingMcRender;
	import sceneModule.rfactory.RBattleShow;
	import sceneModule.rresource.RBattleConst;
	import sceneModule.rresource.RCharacterConst;

	/**
	 * 层控制器 
	 * @author mutou
	 * 
	 */	
	public class RBattleChaLayerController extends EntityComponent implements ITickedObject
	{
		public function RBattleChaLayerController()
		{
			super();
		}
		private var characterLayerArr:Array = new Array();
		
		public function onTick(deltaTime:Number):void
		{
			setCharacterLayerIndex();
		}
		//设置玩家的层，对场景中玩家的显示位置进行排序
		private function setCharacterLayerIndex():void{
			if(RBattleShow.rBattleChaLayerArray==null){
				return;
			}
			
			characterLayerArr.length=0;
			characterLayerArr = new Array();
			var len:int = RBattleShow.rBattleChaLayerArray.length;
			for(var i:int=0;i<len;i++){
				var rInitBattleChaVo:RBattleInitChaVo = new RBattleInitChaVo();
				rInitBattleChaVo = RBattleShow.rBattleChaLayerArray[i] as RBattleInitChaVo;
				var id:int = rInitBattleChaVo.chaBattleId;
				var chaEnt:IEntity = PBE.lookupEntity(RBattleConst.CHA_BATTLE_ENTITY_NAME_STR+id);
				if(!chaEnt){
					return;
				}
				var spatial:Box2DSpatialComponent = chaEnt.lookupComponentByName("Spatial") as Box2DSpatialComponent;
				var posY:int = spatial.position.y;
				var render:RMovieClipRenderer = chaEnt.lookupComponentByName("chaRender") as RMovieClipRenderer;
				
				var characterLayerVo:RUpdateCharacterLayerVo = new RUpdateCharacterLayerVo();
				characterLayerVo.posY = posY;
				characterLayerVo.renderMc = render;
				//把对象添加到数组中。
				characterLayerArr.push(characterLayerVo);
			}
			//把存放层的数组以Y坐标进行排序
			characterLayerArr.sortOn("posY",Array.NUMERIC);
			var chaLayerLen:int = characterLayerArr.length;
			for(var j:int=0;j<chaLayerLen;j++){
				var chaRender:RMovieClipRenderer = (characterLayerArr[j] as RUpdateCharacterLayerVo).renderMc
				//以20做为基层重新设置层坐标
				chaRender.layerIndex = 20+j;
				
				var infoCmp:RCharacterInfoComponent = 
					chaRender.owner.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
				
				if(infoCmp.chaProfessionType<RCharacterConst.BOSS_MONSTER_TYPE){
					var nameRender:RMovieClipRenderer = 
						chaRender.owner.lookupComponentByName("chaNameMcRender") as RMovieClipRenderer;
					if(nameRender){
						nameRender.layerIndex = 21+j;//名字
					}
					
					var hpMcRender:RMovieClipRenderer = 
						chaRender.owner.lookupComponentByName("hpMcRender") as RMovieClipRenderer;
					if(hpMcRender){
						hpMcRender.layerIndex = 21+j;//血条
					}
				}
				
//				
//				var effectRender:SpriteSheetRenderer = 
//					chaRender.owner.lookupComponentByName("effectRender") as SpriteSheetRenderer;
//				effectRender.layerIndex = 22+j;//自身特效
//				
//				var fixedPointRender:SpriteSheetRenderer = 
//					chaRender.owner.lookupComponentByName("fixedPointRender") as SpriteSheetRenderer;
//				fixedPointRender.layerIndex = 23+j;//定点特效
//				
				
//				var mpMcRender:RMovieClipRenderer = 
//					chaRender.owner.lookupComponentByName("mpMcRender") as RMovieClipRenderer;
//				if(mpMcRender){
//					mpMcRender.layerIndex = 21+j;//蓝条
//				}
//				
				var hpNumberMcRender:RMovieClipRenderer = 
					chaRender.owner.lookupComponentByName(RBattleConst.HP_NUMBER_RENDER_NAME) as RMovieClipRenderer;
				hpNumberMcRender.layerIndex = 22+j;//掉血数字
				
				
				//挨打光环层
				var ringRender:RRingMcRender = 
					chaRender.owner.lookupComponentByName(RBattleConst.BATTLE_RING_RENDER_NAME) as RRingMcRender;
				if(ringRender){
					ringRender.layerIndex = 19+j;
				}
				//trace(chaRender.layerIndex);
			}
		}
		protected override function onAdd():void {
			PBE.processManager.addTickedObject(this);
		}
		
		protected override function onRemove():void {
			PBE.processManager.removeTickedObject(this);
			super.onRemove();
		}
	}
}
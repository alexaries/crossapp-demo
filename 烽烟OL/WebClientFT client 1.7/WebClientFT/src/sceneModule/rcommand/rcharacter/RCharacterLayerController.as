package sceneModule.rcommand.rcharacter
{
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	
	import sceneModule.model.rvo.RSwitchVo;
	import sceneModule.model.rvo.RUpdateCharacterLayerVo;
	import sceneModule.model.rvo.RUpdateCharacterVo;
	import sceneModule.rcommon.RChaChatPopoMcRender;
	import sceneModule.rcommon.RChaNameMcRender;
	import sceneModule.rfactory.RCharacterOp;
	import sceneModule.rfactory.RSwitchOp;
	import sceneModule.rresource.RCharacterConst;
	import sceneModule.rresource.RSceneConst;
	
	public class RCharacterLayerController extends EntityComponent implements ITickedObject
	{
		
		private var layerArr:Array = new Array();
		
		public function RCharacterLayerController()
		{
			super();
		}
		
		public function onTick(deltaTime:Number):void
		{
			setCharacterLayerIndex();
		}
		//设置玩家的层，对场景中玩家的显示位置进行排序
		private function setCharacterLayerIndex():void{
			if(RCharacterOp.chaVOArr==null){
				return;
			}
			layerArr.length=0;
			layerArr = new Array();
			var len:int = RCharacterOp.chaVOArr.length;
			for(var i:int=0;i<len;i++){
				var updateCharacterVo:RUpdateCharacterVo = new RUpdateCharacterVo();
				updateCharacterVo = RCharacterOp.chaVOArr[i] as RUpdateCharacterVo;
				var id:int = updateCharacterVo.id;
				var chaEnt:IEntity = PBE.lookupEntity(RCharacterConst.CHA_ENTITY_NAME+id);
				if(!chaEnt){
					return;
				}
				var posY:int = (chaEnt.lookupComponentByName("Spatial") as Box2DSpatialComponent).position.y;
				var professionType:int = updateCharacterVo.professionType;
				/*if(professionType>RCharacterConst.BOSS_MONSTER_TYPE&&professionType<RCharacterConst.NPC_TYPE){
					posY = posY+180;//需要把坐标跟角色脚下坐标对齐，差值应该是230-140=90。留10作为误差
				}*/
				var render:SpriteSheetRenderer = 
					chaEnt.lookupComponentByName(RCharacterConst.CHA_RENDER_NAME) as SpriteSheetRenderer;
				
				var characterLayerVo:RUpdateCharacterLayerVo = new RUpdateCharacterLayerVo();
				characterLayerVo.posY = posY;
				characterLayerVo.render = render;
				//把对象添加到数组中。
				layerArr.push(characterLayerVo);
			}
			/*var switchLen:int = RSwitchOp.switchVoArr.length;
			for(var k:int=0;k<switchLen;k++){
				var switchVo:RSwitchVo = new RSwitchVo();
				switchVo = RSwitchOp.switchVoArr[k] as RSwitchVo;
				var switchId:int = switchVo.id;
				var switchEnt:IEntity = PBE.lookupEntity(RSceneConst.SWITCH_ENTITY_NAME+switchId);
				if(switchEnt){
					var switchPosY:int = (switchEnt.lookupComponentByName("Spatial") as Box2DSpatialComponent).position.y;
					var switchSpriteRender:SpriteSheetRenderer = 
						switchEnt.lookupComponentByName(RSceneConst.SWITCH_RENDER_NAME) as SpriteSheetRenderer;
					var switchLayerVo:RUpdateCharacterLayerVo = new RUpdateCharacterLayerVo();
					switchLayerVo.posY = switchPosY;
					switchLayerVo.render = switchSpriteRender;
					//把对象添加到数组
					layerArr.push(switchLayerVo);
				}
			}*/
			//把存放层的数组以Y坐标进行排序
			layerArr.sortOn("posY",Array.NUMERIC);
			var chaLayerLen:int = layerArr.length;
			for(var j:int=0;j<chaLayerLen;j++){
				var chaRender:SpriteSheetRenderer = (layerArr[j] as RUpdateCharacterLayerVo).render
				//以20做为基层重新设置层坐标
				chaRender.layerIndex = 20+j;
				//设置名字的层与角色同步
				var nameRender:RChaNameMcRender = 
					chaRender.owner.lookupComponentByName("chaNameMcRender") as RChaNameMcRender;
				if(nameRender){
					nameRender.layerIndex = 21+j;
				}
				//设置聊天泡泡的层与角色同步
				var chaChatPopoMcRender:RChaChatPopoMcRender = 
					chaRender.owner.lookupComponentByName("chaChatPopoMcRender") as RChaChatPopoMcRender;
				if(chaChatPopoMcRender){
					chaChatPopoMcRender.layerIndex = 21+j;
				}
				//传送门
				/*var switchRender:SpriteSheetRenderer = 
					chaRender.owner.lookupComponentByName(RSceneConst.SWITCH_RENDER_NAME) as SpriteSheetRenderer;
				if(switchRender){
					switchRender.layerIndex = 20+j+1
				}*/
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
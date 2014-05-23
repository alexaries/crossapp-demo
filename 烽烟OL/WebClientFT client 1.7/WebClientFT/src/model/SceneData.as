package model 
{
	import flash.geom.Point;
	
	import proto.scene.scene602.characterPosition;
	
	import sceneModule.model.rvo.RUpdateCharacterVo;
	/**
	 * ...
	 * @author hao
	 */
	public class SceneData 
	{
		public static const ENTITY_TYPE_CHAR:int 	= 1;
		public static const ENTITY_TYPE_MONSTER:int = 2;
		public static const ENTITY_TYPE_PET:int = 3;
		
		//场景实体列表
		private var _entitys:Array;
		
		public function SceneData() 
		{
			_entitys = [];
		}
		
		public function add_entity(s_entity:characterPosition, type:int ):void {
			var entity_index:int = find_entity_index_by_id(s_entity.id);
			var entity:RUpdateCharacterVo;
			if (-1 == entity_index) {
				entity = new RUpdateCharacterVo();
				_entitys.push(entity);
			}
			else {
				entity = _entitys[entity_index] as RUpdateCharacterVo;
			}
			entity.id = s_entity.id;
			entity.name = s_entity.name;
			entity.position = new Point(s_entity.x, s_entity.y);
			entity.profession = s_entity.profession;
			entity.professionType = s_entity.figure;
			entity.chaType = type;
			entity.masterId = s_entity.masterId;
			entity.chaLevel = s_entity.level;
			entity.vipLevel = s_entity.viptype;
			entity.trueProfessionType = s_entity.headicon;
			entity.curHp = s_entity.currentHP;
			entity.maxHp = s_entity.MaxHP;
			entity.campid = s_entity.camp;
			
			if (ENTITY_TYPE_CHAR == type) {
				entity.unionName = s_entity.guildname == null || s_entity.guildname == ""?s_entity.guildname:"【" + s_entity.guildname + "】";
				entity.layer = 20;
				if(entity.id == SystemDataModel.roleId){
					entity.isMySelf = true;
				} else{
					entity.isMySelf = false;
				}
			}
			else if (ENTITY_TYPE_PET == type) {
				if(entity.masterId == SystemDataModel.roleId){
					entity.isSelfPet = true;
				} else{
					entity.isSelfPet = false;
				}
			}
		}
		public function rm_entity(id:int):void {
			var index:int = find_entity_index_by_id(id);
			if (-1 != index) {
				_entitys.splice(index, 1);
			}
		}
		public function clear_entity():void {
			_entitys = [];
		}
		public function find_entity_index_by_id(id:int):int {
			var index:int = -1;
			var len:int = _entitys.length;
			for (var i:int = 0; i < len; i++) 
			{
				var cur:RUpdateCharacterVo = _entitys[i] as RUpdateCharacterVo;
				if (cur.id == id) {
					index = i;
					break;
				}
			}
			return index;
		}
		
		public function get entitys():Array 
		{
			return _entitys.concat();
		}
		
	}

}
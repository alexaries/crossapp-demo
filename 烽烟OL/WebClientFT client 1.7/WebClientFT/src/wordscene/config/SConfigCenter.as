package wordscene.config 
{
	import sceneModule.view.zhanyi.model.ZhanyiItemVo;
	import util.Logging;
	/**
	 * ...
	 * @author hao
	 */
	public class SConfigCenter 
	{
		private static var _instance:SConfigCenter;
		public static function getInstance():SConfigCenter {
			if (null == _instance) {
				_instance = new SConfigCenter();
			}
			return _instance;
		}
		public function SConfigCenter() 
		{
			
		}
		
		private var _entitysXML:XML;
		private var _zhanyinXML:XML;
		
		public function getItemsInfoOfEntity(id:int):Vector.<EntityInfo> {
			var items:XMLList = _entitysXML.entity.(@id == id).item;
			var r:Vector.<EntityInfo> = new Vector.<EntityInfo>();
			var len:int = items.length();
			for (var i:int = 0; i < len; i++) 
			{
				var item:XML = items[i] as XML;
				var ritem:EntityInfo = new EntityInfo();
				ritem.id = item.@id;
				ritem.posx = item.@posx;
				ritem.posy = item.@posy;
				ritem.index = i;
				r.push(ritem);
			}
			if (0 == len) {
				Logging.log("没有角色资源配置,用 changqiangbing 代替", id);
				var ditem:EntityInfo = new EntityInfo();
				ditem.id = "changqiangbing";
				ditem.posx = 0;
				ditem.posy = 0;
				r.push(ditem);
			}
			return r;
		}
		
		public function getZhanyiItemInfo(id:int):ZhanyiItemVo {
			var xmlitem:XMLList = _zhanyinXML.item.(@id == id);
			if (0 == int(xmlitem.@id)) {
				return null;
			}
			var r:ZhanyiItemVo = new ZhanyiItemVo();
			r.id = xmlitem.@id;
			r.img = xmlitem.@img;
			r.posx = xmlitem.@posx;
			r.posy = xmlitem.@posy;
			return r;
		}
		
		public function set entitysXML(value:XML):void 
		{
			_entitysXML = value;
		}
		
		public function set zhanyinXML(value:XML):void 
		{
			_zhanyinXML = value;
		}
		
	}

}
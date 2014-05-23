package sceneModule.view.wordmap.model 
{
	import event.GuidEventCenter;
	import event.NGuidEvent;
	import sceneModule.view.copyScene.model.FubenChoseItemVo;
	import sceneModule.view.copyScene.model.FuBenItemVo;
	import util.xtrace;
	/**
	 * ...
	 * @author hao
	 */
	public class MapConfig 
	{
		private static var _instance:MapConfig;
		public function MapConfig() 
		{
			move_ing = false;
		}
		public static function getInstance():MapConfig {
			if (null == _instance) {
				_instance = new MapConfig();
			}
			return _instance;
		}
		
		public var map_info_xml:XML;
		public var fb_config_xml:XML;
		private var _guide_xml:XML;
		
		
		private var _map_infos:Array;
		public var move_ing:Boolean;
		
		private var _point_speed:int;
		
		/////////////////////////////////////////////////////////////////////////////////////////////////
		//世界地图
		public function get_all_map_info():Array {
			if (null == _map_infos) {
				_map_infos = [];
				for each (var item:XML in map_info_xml.map) 
				{
					var id:int = item.@id;
					var posx:int = item.@posx;
					var posy:int = item.@posy;
					var lev:int = item.@level;
					var info:MapIconInfo = new MapIconInfo();
					info.id = id;
					info.posx = posx;
					info.posy = posy;
					info.need_lev = lev;
					info.name = item.@name;
					info.des = item.@des;
					_map_infos.push(info);
				}
			}
			return _map_infos;
		}
		
		public function get_map_ico_info(id:int):MapIconInfo {
			if (null == _map_infos) {
				get_all_map_info();
			}
			var r:MapIconInfo = null;
			for each (var item:MapIconInfo in _map_infos) 
			{
				if (id == item.id) {
					r = item;
					break;
				}
			}
			return r;
		}
		///////////////////////////////////////////////////////////////////////////////////
		//副本
		public function get_fb_by_id(id:int):FuBenItemVo {
			var item:XMLList = fb_config_xml.fb.(@id == id);
			
			if (item.attributes().length() <= 0) {
				xtrace("没有配置传送门id " , id);
			}
			
			var f:FuBenItemVo = new FuBenItemVo();
			f.id = item.@id;
			f.bg_img_path = item.@bgimg;
			//for each (var chose_item:XML in item.chose) 
			//{
				//var f_c:FubenChoseItemVo = new FubenChoseItemVo();
				//f_c.id = chose_item.@id;
				//f_c.nomal_bg_path = chose_item.@nomal_img;
				//f_c.down_bg_path = chose_item.@down_img;
				//f_c.selected_bg_path = chose_item.@selected_img;
				//f_c.disable_bg_path = chose_item.@disable_img;
				//f_c.pos_x = chose_item.@posx;
				//f_c.pos_y = chose_item.@posy;
				//f_c.point = chose_item.@point;
				//f_c.des = chose_item.@des;
				//f.chose_items.push(f_c);
			//}
			return f;
		}
		
		//获取副本信息
		public function get_fb_item_by_id(id:int):FubenChoseItemVo {
			var chose_item:XMLList =  fb_config_xml..chose.(@id == id);
			if (chose_item.attributes().length() <= 0) {
				xtrace("没有配置副本组id " , id);
			}
			var f_c:FubenChoseItemVo = new FubenChoseItemVo();
			f_c.id = chose_item.@id;
			f_c.nomal_bg_path = chose_item.@nomal_img;
			f_c.down_bg_path = chose_item.@down_img;
			f_c.selected_bg_path = chose_item.@selected_img;
			f_c.disable_bg_path = chose_item.@disable_img;
			f_c.pos_x = chose_item.@posx;
			f_c.pos_y = chose_item.@posy;
			f_c.point = chose_item.@point;
			f_c.des = chose_item.@des;
			return f_c;
		}
		
		public function get guide_xml():XML 
		{
			return _guide_xml;
		}
		
		public function set guide_xml(value:XML):void 
		{
			_guide_xml = value;
			GuidEventCenter.getInstance().dispatchEvent(new NGuidEvent(NGuidEvent.NGuidEvent_XML_LOADED));
		}
		
		public function get point_speed():int 
		{
			return _point_speed;
		}
		
		public function set point_speed(value:int):void 
		{
			_point_speed = value;
		}
		
	}

}
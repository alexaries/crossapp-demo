package sceneModule.view.wordmap.mediator
{
	import com.greensock.TweenLite;
	import event.KeyFuncEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import managers.KeyBordManager;
	import model.SystemDataModel;
	import model.URLConst;
	import mx.controls.Image;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.Responder;
	import org.robotlegs.mvcs.Mediator;
	import proto.scene.scene601.enterPlaceRequest;
	import proto.scene.scene601.enterPlaceResponse;
	import resource.AssetCenter;
	import resource.AssetItemInfo;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.wordmap.model.MapConfig;
	import sceneModule.view.wordmap.model.MapIconInfo;
	import sceneModule.view.wordmap.view.WordmapComponent;
	import service.ISocketServer;
	import util.CommonTools;
	import util.DelayExcuter;
	import util.ObjectToString;
	import util.xtrace;
	
	import sceneModule.view.wordmap.view.MapIconImg;
	
	//世界地图视图管理器
	public class WordMapMediator extends Mediator
	{
		public static const CHAR_H:int = 70;
		public static const CHAR_W:int = 25;
		
		[Inject]
		public var map_view:WordmapComponent;
		[Inject]
		public var socket:ISocketServer;
		
		private var _show_d_infos:Array;
		private var _selected:int;
		
		public function WordMapMediator()
		{
			super();
			_selected = -1;
		}
		
		override public function onRegister():void {
			map_view.clokeBtn.addEventListener(MouseEvent.CLICK, on_close);
			
			init_view();
		}
		
		override public function preRemove():void {
			map_view.clokeBtn.removeEventListener(MouseEvent.CLICK, on_close);
		}
		
		private function go_to_city(taget_id:int):void {
			var map_len:int = _show_d_infos.length;
			var is_find:Boolean = false;
			for (var i:int = 0; i < map_len; i++) 
			{
				var t:MapIconInfo = _show_d_infos[i] as MapIconInfo;
				if (t.id == taget_id) {
					_selected = i;
					is_find = true;
					move_to_selected();
					break;
				}
			} 
			if (!is_find) {
				xtrace("自动寻路未找到城镇", taget_id);
			}
		}
		
		
		private function init_view():void {
			var t_arr:Array = [];
			
			var std_swf:AssetItemInfo = new AssetItemInfo();
			std_swf.package_id = 'word_map';
			std_swf.id = 'word_map_std';
			std_swf.type = AssetItemInfo.AssetItemInfo_TYPE_SWF;
			std_swf.path = getJobImg(SystemDataModel.roleInfo.profession) + "_stand.swf";
			
			var move_swf:AssetItemInfo = new AssetItemInfo();
			move_swf.package_id = 'word_map';
			move_swf.id = 'word_map_move';
			move_swf.type = AssetItemInfo.AssetItemInfo_TYPE_SWF;
			move_swf.path = getJobImg(SystemDataModel.roleInfo.profession) + ".swf";
			
			var movel_swf:AssetItemInfo = new AssetItemInfo();
			movel_swf.package_id = 'word_map';
			movel_swf.id = 'word_map_move_l';
			movel_swf.type = AssetItemInfo.AssetItemInfo_TYPE_SWF;
			movel_swf.path = getJobImg(SystemDataModel.roleInfo.profession) + "_walk_L.swf";
			
			t_arr.push(std_swf);
			t_arr.push(move_swf);
			t_arr.push(movel_swf);
			
			AssetCenter.getInstance().load_package('word_map', real_show, null, true,null,null,t_arr);
		}
		
		private function real_show():void {
			CommonTools.make_bitmap(map_view.img_bg).bitmapData = 
				AssetCenter.getInstance().get_img_form_pacakge('word_map', 'word_map_bg');
			
			var icon_infos:Array = MapConfig.getInstance().get_all_map_info();
			var show_infos:Array = get_use_icon(icon_infos);
			_show_d_infos = show_infos;
			var d_len:int = show_infos.length;
			var v_len:int = map_view.icons.length;
			var index:int = 0;
			for (; index < d_len; index++) 
			{
				if (index < v_len) {
					//需要刷新
				}
				else {
					//需要添加
					add_icon(show_infos[index] as MapIconInfo);
				}
			}
			remove_icons(index);
			
			place_player();
			
			var taget_city:int = TaskMessage.getInstance().find_path_check_wordmap();
			if (0 != taget_city) {
				new DelayExcuter(1000, go_to_city, [taget_city]);
			}
		}
		
		private function add_icon(info:MapIconInfo):void {
			var v_icon:MapIconImg = new MapIconImg();
			v_icon.x = info.posx;
			v_icon.y = info.posy;
			v_icon.icon_id = info.id;
			v_icon.refresh();
			v_icon.l_des.text = info.des;
			v_icon.l_name.text = info.name;
			v_icon.addEventListener(MouseEvent.CLICK, icon_click);
			map_view.ico_contain.addElement(v_icon);
			map_view.icons.push(v_icon);
		}
		
		private function remove_icons(index:int):void {
			while (map_view.icons.length > index) {
				var icon:MapIconImg = map_view.icons.pop();
				icon.parent.removeChild(icon);
			}
		}
		
		private function get_use_icon(arr:Array):Array {
			var r:Array = [];
			var cur_lv:int = SystemDataModel.roleInfo.level;
			for each (var item:MapIconInfo in arr) 
			{
				if (cur_lv >= item.need_lev) {
					r.push(item);
				}
			}
			return r;
		}
		
		private function place_player():void {
			var map_id:int = SystemDataModel.placeId;
			if (null == map_view.player.source) {
				map_view.player.source = AssetCenter.getInstance().get_mc_form_pacakge('word_map', 'word_map_std');
				(map_view.player.source as MovieClip).mouseEnabled = false;
				(map_view.player.source as MovieClip).mouseChildren = false;
				map_view.player.mouseEnabled = false;
				map_view.player.mouseChildren = false;
			}
			var cur_info:MapIconInfo = MapConfig.getInstance().get_map_ico_info(map_id);
			map_view.player.x = cur_info.posx - CHAR_W;
			map_view.player.y = cur_info.posy - CHAR_H;
		}
		
		
		public function getJobImg(profession:int):String{
			var r:String = null;
			switch (profession) 
			{
				case 1:
					r = "assets/word_map/ZS";
					break;
				case 2:
					r = "assets/word_map/FS";
					break;
				case 3:
					r = "assets/word_map/YX";
					break;
				case 4:
					r = "assets/word_map/MS";
					break;
				
				default:
					r = null;
			}
			return r;
		}
		
		private function on_close(e:MouseEvent):void {
			KeyBordManager.getInstance().dispatchEvent(new KeyFuncEvent(KeyFuncEvent.KeyFuncEvent_MAP_CHANGE));
		}
		
		private function icon_click(e:MouseEvent):void {
			var icon:MapIconImg = e.currentTarget as MapIconImg;
			var index:int = map_view.icons.indexOf(icon);
			if (_selected == index) {
				return;
			}
			else {
				clear_selected();
				icon.set_selected(true);
				_selected = index;
				move_to_selected();
			}
		}
		
		private function move_to_selected():void {
			var targ:MapIconInfo = _show_d_infos[_selected] as MapIconInfo;
			MapConfig.getInstance().move_ing = true;
			
			var targetx:int = targ.posx;
			var sourcex:int = map_view.player.x - CHAR_W;
			
			var mc:MovieClip = null;
			if (targetx > sourcex) {
				//向右移动
				mc = AssetCenter.getInstance().get_mc_form_pacakge('word_map', 'word_map_move');
				mc.mouseEnabled = false;
				mc.mouseChildren = false;
				map_view.player.source = mc;
			}
			else {
				//向左移动
				mc = AssetCenter.getInstance().get_mc_form_pacakge('word_map', 'word_map_move_l');
				mc.mouseEnabled = false;
				mc.mouseChildren = false;
				map_view.player.source = mc;
			}
			
			TweenLite.to(map_view.player, 2, {x:(targ.posx - CHAR_W),y:(targ.posy - CHAR_H),onComplete:move_over,onCompleteParams:[targ.id]});
		}
		
		
		private function move_over(to_id:int):void {
			xtrace("move to map " , to_id);
			MapConfig.getInstance().move_ing = false;
			map_view.player.source = AssetCenter.getInstance().get_mc_form_pacakge('word_map', 'word_map_std');
			(map_view.player.source as MovieClip).mouseEnabled = false;
			(map_view.player.source as MovieClip).mouseChildren = false;
			if (to_id == SystemDataModel.placeId) {
				KeyBordManager.getInstance().dispatchEvent(new KeyFuncEvent(KeyFuncEvent.KeyFuncEvent_MAP_CHANGE));
			}
			else {
				//发送切换场景指令
				requese_change_map(to_id);
			}
		}
		
		private function clear_selected():void {
			for each (var item:MapIconImg in map_view.icons) 
			{
				item.set_selected(false);
			}
		}
		
		
		//请求切换场景
		private function requese_change_map(mapid:int):void{
			var msg:enterPlaceRequest = new enterPlaceRequest();
			msg.id = SystemDataModel.roleId;
			msg.placeId = mapid;
			var byteArray:ByteArray = new ByteArray();
			msg.writeExternal(byteArray);
			xtrace("发送请求切换场景消息", new ObjectToString(msg).getString());
			socket.send(new Responder(response_change_map,faultHandler),URLConst.ENTER_PLACE_COMMANDID,byteArray);
		}
		private function response_change_map(data:Object):void{
			var acceptByte:ByteArray = data as ByteArray;
			var responseData:enterPlaceResponse = new enterPlaceResponse();
			responseData.readExternal(acceptByte);
			xtrace("请求场景切换回复", new ObjectToString(responseData).getString());
			if (responseData.result) {
				KeyBordManager.getInstance().dispatchEvent(new KeyFuncEvent(KeyFuncEvent.KeyFuncEvent_MAP_CHANGE));
			}
		}
		
		
		
		/**
		 * faultHandler 
		 */		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
	}
}
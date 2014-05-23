package sceneModule.view.copyScene.mediator
{
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle712.ColonizationFightRequest;
	import proto.copyScene.copyScene1501.enterInstanceRequest;
	import proto.copyScene.copyScene1501.enterInstanceResponse;
	
	import resource.AssetCenter;
	import resource.AssetItemInfo;
	
	import sceneModule.event.ColonizationBattleResponseEvent;
	import sceneModule.event.ColonizationBattleSendCommandEvent;
	import sceneModule.model.vo.copySceneVo.CopySceneInfoVo;
	import sceneModule.view.chat.event.MainOpenWhisperWindowEvent;
	import sceneModule.view.copyScene.event.NCopySceneEvent;
	import sceneModule.view.copyScene.model.FuBenItemVo;
	import sceneModule.view.copyScene.model.FubenChoseItemVo;
	import sceneModule.view.copyScene.view.BitmapButton;
	import sceneModule.view.copyScene.view.ColonizationBattleByCopySceneComponent;
	import sceneModule.view.copyScene.view.NCopySceneChoseView;
	import sceneModule.view.copyScene.view.NFubenItemView;
	import sceneModule.view.gaAndsd.view.SaoDangWindow;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.wordmap.model.MapConfig;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;
	import util.ObjectToString;
	import util.xtrace;

	/**
	 * 副本Mediator 
	 */	
	public class NCopySceneChoseMediator extends Mediator
	{
		public static const FUBEN_CHOSE_AEEST_PACKAGE:String = "FUBEN_CHOSE_AEEST_PACKAGE";
		
		[Inject]
		public var socketService:ISocketServer;
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		private var _fb_info:FuBenItemVo;
		private var _chose_icons:Array;
		
		private var _selected:int;
		
		private var _bg_bitmap:Bitmap;
		
		//private var _exit_btn:BitmapButton;
		
		public function NCopySceneChoseMediator()
		{
			_chose_icons = [];
			_selected = -1;
			_bg_bitmap = new Bitmap();
			super();
		}
		
		override public function onRegister():void {
			//view.clokeBtn.addEventListener(MouseEvent.CLICK, on_close);
			view.addEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
			view.exit_btn.addEventListener(MouseEvent.CLICK, on_close);
			TaskMessage.getInstance().addEventListener(NTaskEvent.NTaskEvent_Open_FB_Group, open_group);
			init_view_struct();
			init_view();
		}
		
		private function remove_from_stage(e:Event):void {
			
			if(view){
				view.removeEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
				preRemove();
			}
			
		}
		
		override public function preRemove():void {
			//view.clokeBtn.removeEventListener(MouseEvent.CLICK, on_close);
			if(!view){
				return;
			}
			view.exit_btn.removeEventListener(MouseEvent.CLICK, on_close);
			TaskMessage.getInstance().removeEventListener(NTaskEvent.NTaskEvent_Open_FB_Group, open_group);
			for each (var item:NFubenItemView in _chose_icons) 
			{
				item.removeEventListener(NCopySceneEvent.NCopySceneEvent_ITEM_CLICK, item_click);
				item.removeEventListener(NCopySceneEvent.NCopySceneEvent_ENTER, on_enter);
				item.removeEventListener(NCopySceneEvent.NCopySceneEvent_SHOW_NO_IN, show_no_in);
				item.removeEventListener(NCopySceneEvent.NCopySceneEvent_CHAT, on_chat);
				item.removeEventListener(ColonizationBattleSendCommandEvent.COLONIZATIONBATTLESENDCOMMAND, onSendColonizationBattle);
				if (view && view.icon_contain) {
					view.icon_contain.removeAllElements();
				}
			}
			_chose_icons = [];
		}
		
		private function init_view_struct():void {
			//_exit_btn = new BitmapButton('btn_res', 'btn_backcity_nomal', 'btn_backcity_over', 'btn_backcity_down');
			//view.addChild(_exit_btn);
		}
		
		private function open_group(e:NTaskEvent):void {
			var chose_id:int = e.obj.groupid;
			new DelayExcuter(1000, read_open_group, [chose_id]);
			TaskMessage.getInstance().clear_find_path();
		}
		
		private function read_open_group(chose_id:int):void {
			var arr:Array = _fb_info.chose_items;
			var len:int = arr.length;
			var is_find:Boolean = false;
			for (var i:int = 0; i < len; i++) 
			{
				var item:FubenChoseItemVo = arr[i] as FubenChoseItemVo;
				if (chose_id == item.id) {
					is_find = true;
					item_click(null, i);
				}
			}
			if (!is_find) {
				xtrace("自动寻路未找到副本组id", chose_id);
			}
		}
		
		private function on_close(e:MouseEvent = null):void {
			SystemDataModel.open_trip_id = 0;
			WindowManager.closeWindow(NCopySceneChoseView.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE);
			mediatorMap.removeMediator(this);
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.FB_CHOSE));
		}
		
		private function init_view():void {
			_fb_info = view.data as FuBenItemVo;
			real_show();
			TaskMessage.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_Enter_FB_CHOSE, { tripid:_fb_info.id } ));
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_FU_CHOSE, _fb_info.id));
		}
		
		private function make_border_asset_info(id:String, path:String):AssetItemInfo {
			var item_img:AssetItemInfo = new AssetItemInfo();
			item_img.id = FUBEN_CHOSE_AEEST_PACKAGE + "_BORDER_" + id;
			item_img.package_id = FUBEN_CHOSE_AEEST_PACKAGE;
			item_img.path = path;
			return item_img;
		}
		
		private function make_chose_asset_info(item:FubenChoseItemVo, type:String):AssetItemInfo {
			var item_img:AssetItemInfo = new AssetItemInfo();
			item_img.id = FUBEN_CHOSE_AEEST_PACKAGE + "_CHOSE_" + type + "_" + item.id;
			item_img.package_id = FUBEN_CHOSE_AEEST_PACKAGE;
			item_img.path = item[type];
			return item_img;
		}
		
		
		private function real_show():void {
			//重绘背景
			view.img_bg.source = _bg_bitmap;
			_bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge(FUBEN_CHOSE_AEEST_PACKAGE, FUBEN_CHOSE_AEEST_PACKAGE + "_BG_" + _fb_info.id);
			//绘制选择项
			place_chose();
		}
		
		
		private function place_chose():void {
			view.icon_contain.removeAllElements();
			for each (var item:FubenChoseItemVo in _fb_info.chose_items) 
			{
				var icon:NFubenItemView = new NFubenItemView();
				icon.x = item.pos_x;
				icon.y = item.pos_y;
				icon.setInfo(item);
				icon.set_disable(!item.is_enable);
				//icon.setLevelState(_fb_info.level_stage);
				icon.addEventListener(NCopySceneEvent.NCopySceneEvent_ENTER, on_enter);
				icon.addEventListener(NCopySceneEvent.NCopySceneEvent_SHOW_NO_IN, show_no_in);
				view.icon_contain.addElement(icon);
				icon.addEventListener(NCopySceneEvent.NCopySceneEvent_ITEM_CLICK, item_click);
				icon.addEventListener(NCopySceneEvent.NCopySceneEvent_CHAT, on_chat);
				icon.addEventListener(ColonizationBattleSendCommandEvent.COLONIZATIONBATTLESENDCOMMAND,onSendColonizationBattle);
				_chose_icons.push(icon);
			}
		}
		
		private function onSendColonizationBattle(evt:ColonizationBattleSendCommandEvent):void{
//			var obj:Object = new Object();
//			obj.cId = evt.copySceneId;
//			obj.camp = evt.camp;
//			WindowManager.createWindow(ColonizationBattleByCopySceneComponent.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer, false);
//			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QINLUE)]);
			WindowManager.createWindow(SaoDangWindow.NAME,evt._info,null,false,false,false,null,mediatorMap,popUpWindowLayer);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_MAIN_PLAYER)]);
			on_close();
		}
		
		private function colonizationHandler(data:Object):void{
			this.dispatch(new ColonizationBattleResponseEvent(ColonizationBattleResponseEvent.COLONIZATIONBATTLERESPONSE,data));
		}
		
		private function show_no_in(e:NCopySceneEvent):void {
			popUpShow.show(e.obj.str);
		}
		
		
		private function on_enter(e:NCopySceneEvent):void {
			var cur:NFubenItemView = e.currentTarget as NFubenItemView;
			var cur_d:FubenChoseItemVo = cur.info;
			xtrace("进入副本", new ObjectToString(cur_d).getString());
			var id:int = -1;
			switch (e.obj.level) 
			{
				case 0:
					id = cur_d.id0;
					break;
				case 1:
					id = cur_d.id1;
					break;
				case 2:
					id = cur_d.id2;
					break;
				default:
			}
			if (-1 != id) {
				requese_enter_copy(id);
			}
		}
		
		private function item_click(e:Event = null, selected:int = -1):void {
			var index:int = -1;
			var ico:NFubenItemView = null;
			if (null != e) {
				ico = e.currentTarget as NFubenItemView;
				index = _chose_icons.indexOf(ico);
			}
			else {
				index = selected;
				ico = _chose_icons[index] as NFubenItemView;
			}
			
			if (_selected == index) {
				return;
			}
			else {
				for each (var item:NFubenItemView in _chose_icons) 
				{
					if(item.info.id != ico.info.id){
						item.set_selected(false);
					}
				}
				if(ico){
					ico.set_selected(true);
				}
			}
		}
		
		private function on_chat(e:NCopySceneEvent):void {
			this.dispatch(new MainOpenWhisperWindowEvent(MainOpenWhisperWindowEvent.MAINOPENWHISPERWINDOWEVENT, e.obj.id,e.obj.name));
		}
		
		
		
		/**
		 * 进入副本
		 */
		private function requese_enter_copy(id:int):void{
			var msg:enterInstanceRequest = new enterInstanceRequest();
			msg.id = SystemDataModel.roleId;
			msg.InstanceId = id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求进入副本",new ObjectToString(msg).getString());
			socketService.send(new Responder(response_enter_copy,faultHandler),URLConst.ENTER_COPYSCENE_COMMANDID,bytes);
		}
		/**
		 * 进入副本返回处理
		 */
		private function response_enter_copy(data:Object):void{
			var bytes:ByteArray = data as ByteArray;
			var msg:enterInstanceResponse = new enterInstanceResponse();
			msg.readExternal(bytes);
			xtrace("请求进入副本回复", new ObjectToString(msg).getString());
			if (msg.result) {
				on_close();
			}
			else {
				popUpShow.show(msg.message);
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		public function get view():NCopySceneChoseView {
			return viewComponent as NCopySceneChoseView;
		}
		
	}
}
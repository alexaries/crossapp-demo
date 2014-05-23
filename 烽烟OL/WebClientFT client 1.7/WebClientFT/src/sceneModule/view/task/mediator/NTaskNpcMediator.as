package sceneModule.view.task.mediator
{	
	import br.com.stimuli.loading.loadingtypes.VideoItem;
	
	import com.greensock.TweenLite;
	
	import component.CrotaBasicLabel;
	
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	import managers.ToolTipManager;
	import managers.UILayerManager;
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.shop.shop206.getNpcShopInfoRequest;
	import proto.shop.shop206.getNpcShopInfoResponse;
	import proto.task.ItemInfo;
	import proto.task.TaskItemInfo;
	import proto.task.TaskState;
	import proto.task.TaskTalk;
	import proto.task.TaskType;
	
	import resource.AssetCenter;
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.mediator.SceneModuleCommonMessage;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.shop.event.GetShopInfoResponseEvent;
	import sceneModule.view.shop.view.NpcShopComponent;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.task.view.MainTaskComponent;
	import sceneModule.view.task.view.NTaskNpcInfoView;
	import sceneModule.view.task.view.NTaskNpcPriceView;
	import sceneModule.view.task.view.NTaskNpcTaskItemView;
	import sceneModule.view.task.view.NTaskNpcView;
	import sceneModule.view.task.view.NTaskNpcWordView;
	import sceneModule.view.tavern.view.WOWTavernComponent;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;
	import util.xtrace;
	
	public class NTaskNpcMediator extends Mediator
	{
		public static const TASK_INFO_COLOR:String = "#ffffff";
		public static const TASK_USER_COLOR:String = "#00ff00";
		public static const TASK_INFO_SIZE:int = 14;
		
		public static const PRICE_SHOW_TIME:Number = 4;
		
		
		private var _npc_id:int;
		private var _task_msg:TaskMessage;
		private var _word_page:int;
		
		private var _npc_word_view:NTaskNpcWordView;
		private var _npc_task_item_view:NTaskNpcTaskItemView;
		private var _npc_info_view:NTaskNpcInfoView;
		private var _npc_price_view:NTaskNpcPriceView;
		
		private var _price_mask:Sprite;
		private var _price_item_gap:int = 5;
		
		private var _tips:MainMenuEquipmentTooltip;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		public function NTaskNpcMediator()
		{
			super();
		}
		override public function onRegister():void {
			xtrace("add npc taks mediator");
			
			_task_msg = TaskMessage.getInstance();
			_word_page = 0;
			
			init_view();
			
			view.addEventListener(Event.ADDED_TO_STAGE, init_view);
			//this.eventDispatcher.addEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK, init_view);
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK, init_view);
			
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_VIEW, refresh_view);
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_SHOE_PRICE, show_move_price);
			
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_CLOSE_PARENT, close_parent);
			
			this.eventMap.mapListener(this.view.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(this.view.shopBtn,MouseEvent.CLICK,onShopWindow);
			this.eventMap.mapListener(this.view.htBtn,MouseEvent.CLICK,onHotelWindow);
			
			//view.addEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
		}
		
		private function onCloseWindow(evt:MouseEvent=null):void{
			//关闭任务界面
			WindowManager.closeWindow(MainTaskComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		private var temp_id:int;
		private function onShopWindow(evt:MouseEvent):void{
			temp_id = this.view.data.npcId;
			onCloseWindow();
			new DelayExcuter(300,function():void{
				//打开相应商店
				getShopInfo(temp_id);
			},null);
			
		}
		
		private function onHotelWindow(evt:MouseEvent):void{
			onCloseWindow();
			AssetCenter.getInstance().load_package("ui_pet",to_Tavern,null,true);
		}
		
		private function to_Tavern():void{
			var obj:Object=new Object();
			WindowManager.createWindow(WOWTavernComponent.NAME, obj, null, false, false, false, null, mediatorMap, popUpWindowLayer, true);
			new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_JIUGUAN)]);

		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function getShopInfo(npcId:int):void{
			var requestGetShopInfo:getNpcShopInfoRequest = new getNpcShopInfoRequest();
			requestGetShopInfo.id = SystemDataModel.roleId;
			requestGetShopInfo.npcId = npcId;
			requestGetShopInfo.shopCategory = ProConst.NPCSHOP_BUY_SHOP;
			requestGetShopInfo.curPage = 1;
			var getShopInfoByteArray:ByteArray = new ByteArray();
			requestGetShopInfo.writeExternal(getShopInfoByteArray);
			socketService.send(new mx.rpc.Responder(resultNpcShopHandler,faultHandler),URLConst.GET_SHOPINFO_COMMANDID,getShopInfoByteArray);
		}
		/**
		 * 获取商店信息返回处理
		 */
		private function resultNpcShopHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:getNpcShopInfoResponse = new getNpcShopInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				this.dispatch(new GetShopInfoResponseEvent(GetShopInfoResponseEvent.GETSHOPINFORESPONSE,responseData.data,GetShopInfoResponseEvent.GETSHOPINFO));
				AssetCenter.getInstance().load_package('ui_npcshop', show_npc_shop, [responseData.data], true, null, null, null, ['ui_package']);
			}
		}
		private function show_npc_shop(obj:proto.shop.shop206.ShopInfo):void {
//			SceneModuleCommonMessage.getInstance().getNpcShopInfo(SystemDataModel.shopInfoVo.itemType,1);
			SystemDataModel.packType = NpcShopComponent.NAME;
			WindowManager.createWindow(NpcShopComponent.NAME, null, null, false, false, false, null, mediatorMap, popUpWindowLayer);
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_SHANGDIAN));
			dispatch(new Event("hello"));
		}
		
		private function remove_from_stage(e:Event):void {
			//view.removeEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
			//preRemove();
		}
		
		override public function preRemove():void {
			xtrace("remove npc taks mediator");
			this.eventDispatcher.removeEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK, init_view);
			_task_msg.removeEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK, init_view);
			
			_task_msg.removeEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_VIEW, refresh_view);
			_task_msg.removeEventListener(NTaskEvent.NTaskEvent_SHOE_PRICE, show_move_price);
			
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_CLOSE_PARENT, close_parent);
			
			this.eventMap.unmapListener(this.view.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.unmapListener(this.view.shopBtn,MouseEvent.CLICK,onShopWindow);
			if (null != _npc_info_view) {
				_npc_info_view.btn_next.removeEventListener(MouseEvent.CLICK, next_task_info_page);
			}
			if (null != _npc_price_view) {
				if (null != _npc_price_view.img_price_0) {
					_npc_price_view.img_price_0.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
					_npc_price_view.img_price_0.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
					_npc_price_view.img_price_0.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
				}
				if (null != _npc_price_view.img_price_1) {
					_npc_price_view.img_price_1.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
					_npc_price_view.img_price_1.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
					_npc_price_view.img_price_1.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
				}
				if (null != _npc_price_view) {
					_npc_price_view.btn_accept.removeEventListener(MouseEvent.CLICK, on_accept_task);
				}
			}
			if (null != _npc_task_item_view) {
				_npc_task_item_view.removeEventListener(MouseEvent.CLICK, on_task_item_click);
			}
			this.eventDispatcher.removeEventListener(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK, init_view);
		}
		
		private function close_parent(e:NTaskEvent):void {
			if (null == view.stage) {
				return;
			}
			var clsname:String = getQualifiedClassName(view.parentDocument);
			clsname = clsname.replace("::",".");
			WindowManager.closeWindow(clsname);
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.NPC_TASK_UI));
		}
		
		private function init_view(e:Event = null):void {
			if (null == view.stage) {
				return;
			}
			//_npc_id = view.data.npcid;
			_npc_id = SystemDataModel.tempId;
			
			view.task_content.removeAllElements();
			
			_task_msg.requeset_npc_task_info(_npc_id);
			
			//test
			//show_move_price();
		}
		
		private function npc_img_loaded(img:BitmapData):void {
			if (null != view) {
				CommonTools.make_bitmap(view.img_ncp).bitmapData = img;
			}
		}
		
		private function refresh_view(e:NTaskEvent):void {
			if (null == view.stage) {
				return;
			}
			CommonTools.make_bitmap(view.img_ncp).bitmapData = null;
			AssetCenter.getInstance().get_list_res_img('npc_img_' + _task_msg.npc_img, npc_img_loaded);
			view.task_content.removeAllElements();
			if (null == _npc_word_view) {
				_npc_word_view = new NTaskNpcWordView();
			}
			view.l_ncp_name.text = "[" + _task_msg.npc_name + "]";
			_npc_word_view.l_ncp_word.htmlText = "    " + _task_msg.npc_word;
			if(_task_msg.npc_task_list.length > 0){
				var npcTaskList:Array = _task_msg.npc_task_list;
				var l:int = npcTaskList.length;
				for(var i:int=0;i<l;i++){
					var taskInfo:TaskItemInfo = npcTaskList[i];
					//有任务信息
						var npcTaskItemView:NTaskNpcTaskItemView = new NTaskNpcTaskItemView();
						npcTaskItemView._taskId = taskInfo.taskId;
						npcTaskItemView.buttonMode = true;
						npcTaskItemView.addEventListener(MouseEvent.CLICK, on_task_item_click);
					//添加任务条目视图
					//_npc_word_view.task_item_contain.y = _npc_word_view.l_ncp_word.y + _npc_word_view.l_ncp_word.measuredHeight;
					
					var state_str:String = "";
					
					switch (taskInfo.taskState) 
					{
						case TaskState.ACCERT_ABLE:
							CommonTools.make_bitmap(npcTaskItemView.img_task_icon).bitmapData =
							AssetCenter.getInstance().get_img_form_pacakge('ui_npc_task', 'npc_task_ico_accept');
							state_str = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_kjs');
							break;
						case TaskState.RUNING:
						case TaskState.EXCUTE:
							CommonTools.make_bitmap(npcTaskItemView.img_task_icon).bitmapData =
							AssetCenter.getInstance().get_img_form_pacakge('ui_npc_task', 'npc_task_ico_running');
							state_str = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_wwc');
							break;
						case TaskState.COMPLETE:
							CommonTools.make_bitmap(npcTaskItemView.img_task_icon).bitmapData =
							AssetCenter.getInstance().get_img_form_pacakge('ui_npc_task', 'npc_task_ico_complete');
							state_str = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_kwc');
							break;
						default:
					}
					var type_str:String='[Bug]';
					if(taskInfo.taskId >= 20000){
						type_str = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_zhi');
					}else{
						type_str = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_zhu');
					}
					
					npcTaskItemView.l_item_content.text = type_str + taskInfo.taskName + state_str;
					
					_npc_word_view.task_item_contain.addElement(npcTaskItemView);
				}
			}
//			if (null != _task_msg.task_info) {
//				//有任务信息
//				if (null == _npc_task_item_view) {
//					_npc_task_item_view = new NTaskNpcTaskItemView();
//					_npc_task_item_view.buttonMode = true;
//					_npc_task_item_view.addEventListener(MouseEvent.CLICK, on_task_item_click);
//				}
//				_npc_word_view.task_item_contain.removeAllElements();
//				//添加任务条目视图
//				//_npc_word_view.task_item_contain.y = _npc_word_view.l_ncp_word.y + _npc_word_view.l_ncp_word.measuredHeight;
//				
//				var state_str:String = "";
//				
//				switch (_task_msg.task_info.taskState) 
//				{
//					case TaskState.ACCERT_ABLE:
//						CommonTools.make_bitmap(_npc_task_item_view.img_task_icon).bitmapData =
//							AssetCenter.getInstance().get_img_form_pacakge('ui_npc_task', 'npc_task_ico_accept');
//						state_str = "（可接受）";
//						break;
//					case TaskState.RUNING:
//					case TaskState.EXCUTE:
//						CommonTools.make_bitmap(_npc_task_item_view.img_task_icon).bitmapData =
//							AssetCenter.getInstance().get_img_form_pacakge('ui_npc_task', 'npc_task_ico_running');
//						state_str = "（未完成）";
//						break;
//					case TaskState.COMPLETE:
//						CommonTools.make_bitmap(_npc_task_item_view.img_task_icon).bitmapData =
//							AssetCenter.getInstance().get_img_form_pacakge('ui_npc_task', 'npc_task_ico_complete');
//						state_str = "（可完成）";
//						break;
//					default:
//				}
//				
//				_npc_task_item_view.l_item_content.text = _task_msg.task_info.taskName + state_str;
//				
//				_npc_word_view.task_item_contain.addElement(_npc_task_item_view);
//			}
//			else {
//				_npc_word_view.task_item_contain.removeAllElements();
//			}
			//添加npc对话视图
			view.task_content.addElement(_npc_word_view);
			
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_TYPE_NPC_TASK));
		}
		
		//滚动显示奖励信息
		private function show_move_price(e:NTaskEvent = null):void {
			if (null == view.stage) {
				return;
			}
			var layer:UIComponent = UILayerManager.getInstance().alert_layer;
			var t_w:int = 400;
			var t_h:int = 160;
			if (null == _price_mask) {
				_price_mask = new Sprite();
				
				var sptop:Sprite = new Sprite();
				sptop.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000], [0, 1], [100, 0xFF]);
				sptop.graphics.drawRect(0, 0, t_h, t_w);
				sptop.rotation = 90;
				sptop.x = t_w;
				_price_mask.addChild(sptop);
				
				var spdown:Sprite = new Sprite();
				spdown.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000], [0, 1], [100, 0xFF]);
				spdown.graphics.drawRect(0, 0, t_h, t_w);
				spdown.rotation = -90;
				spdown.y = t_h * 2;
				_price_mask.addChild(spdown);
				_price_mask.cacheAsBitmap = true;
				
				_price_mask.x = 240;
				_price_mask.y = 105;
			}
			
			var tf_contain:Sprite = new Sprite();
			var base_y:int = 0;
			var tf:TextField;
			var b_str:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_hdjl');
			for each (var price_item:ItemInfo in curTaskInfo.taskPriceItem) 
			{
				var itemInfo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(price_item.itemId);
				tf = create_tf();
				var e_color:uint = CommonTools.get_equipement_color(itemInfo.nowQuality);
				//test
				//var e_color:uint = CommonTools.get_equipement_color(6);
				//end test
				var e_format:TextFormat = new TextFormat();
				e_format.size = 12;
				e_format.color = e_color;
				tf.text = b_str + itemInfo.name + " X " + itemInfo.stack;
				tf.setTextFormat(e_format, b_str.length, b_str.length +  itemInfo.name.length);
				tf.y = base_y;
				tf.x = (t_w - tf.width) / 2;
				tf_contain.addChild(tf);
				base_y += (tf.height + _price_item_gap);
			}
			
			if (curTaskInfo.taskExp > 0) {
				tf = create_tf();
				tf.text = b_str + CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_jyz') + " X " + curTaskInfo.taskExp;
				tf.y = base_y;
				tf.x = (t_w - tf.width) / 2;
				tf_contain.addChild(tf);
				base_y += (tf.height + _price_item_gap);
			}
			
			if (curTaskInfo.taskPriceCoins > 0) {
				tf = create_tf();
				tf.text = b_str + CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjW_jb') + " X " + curTaskInfo.taskPriceCoins;
				tf.y = base_y;
				tf.x = (t_w - tf.width) / 2;
				tf_contain.addChild(tf);
				base_y += (tf.height + _price_item_gap);
			}
			
			if (curTaskInfo.taskPriceZuan > 0) {
				tf = create_tf();
				tf.text = b_str + CrotaResourceConfig.getInstance().getTextByModuleAndId('guanjue','gjW_jb') + " X " + curTaskInfo.taskPriceZuan;
				tf.y = base_y;
				tf.x = (t_w - tf.width) / 2;
				tf_contain.addChild(tf);
				base_y += (tf.height + _price_item_gap);
			}
//			for each (var price_item:ItemsInfo in _task_msg.task_info.taskPriceItem) 
//			{
//				tf = create_tf();
//				var e_color:uint = CommonTools.get_equipement_color(price_item.nowQuality);
//				//test
//				//var e_color:uint = CommonTools.get_equipement_color(6);
//				//end test
//				var e_format:TextFormat = new TextFormat();
//				e_format.size = 12;
//				e_format.color = e_color;
//				tf.text = b_str + price_item.name + " X " + price_item.stack;
//				tf.setTextFormat(e_format, b_str.length, b_str.length +  price_item.name.length);
//				tf.y = base_y;
//				tf.x = (t_w - tf.width) / 2;
//				tf_contain.addChild(tf);
//				base_y += (tf.height + _price_item_gap);
//			}
//			
//			if (_task_msg.task_info.taskExp > 0) {
//				tf = create_tf();
//				tf.text = b_str + "经验值" + " X " + _task_msg.task_info.taskExp;
//				tf.y = base_y;
//				tf.x = (t_w - tf.width) / 2;
//				tf_contain.addChild(tf);
//				base_y += (tf.height + _price_item_gap);
//			}
//			
//			if (_task_msg.task_info.taskPriceCoins > 0) {
//				tf = create_tf();
//				tf.text = b_str + "金币" + " X " + _task_msg.task_info.taskPriceCoins;
//				tf.y = base_y;
//				tf.x = (t_w - tf.width) / 2;
//				tf_contain.addChild(tf);
//				base_y += (tf.height + _price_item_gap);
//			}
//			
//			if (_task_msg.task_info.taskPriceZuan > 0) {
//				tf = create_tf();
//				tf.text = b_str + "金币" + " X " + _task_msg.task_info.taskPriceZuan;
//				tf.y = base_y;
//				tf.x = (t_w - tf.width) / 2;
//				tf_contain.addChild(tf);
//				base_y += (tf.height + _price_item_gap);
//			}
			
			tf_contain.x = _price_mask.x;
			tf_contain.y = _price_mask.y + t_h * 2;
			tf_contain.cacheAsBitmap = true;
			tf_contain.mask = _price_mask;
			layer.addChild(tf_contain);
			layer.addChild(_price_mask);
			
			TweenLite.to(tf_contain, PRICE_SHOW_TIME, {y:_price_mask.y - tf_contain.height, onComplete:clear_mask, onCompleteParams:[_price_mask, tf_contain]} );
			
		}
		
		//添加tips
		private function price_item_over(e:MouseEvent):void {
			var taget:Object = e.target;
			var item:PackageItem = null;
//			var prices:Array = _task_msg.task_info.taskPriceItem;
			var prices:Array = curTaskInfo.taskPriceItem;
			if (taget == _npc_price_view.img_price_0) {
				item = CrotaItemConfig.getItemInfoByTempleteId(prices[0].itemId);
			}
			else if (taget == _npc_price_view.img_price_1) {
				item = CrotaItemConfig.getItemInfoByTempleteId(prices[1].itemId);
			}
			if (null != item) {
				_tips = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
				_tips.curDataInfo = item;
				//设置ToolTip位置
				var base_x:int = popUpWindowLayer.mouseX;
				var base_y:int = popUpWindowLayer.mouseY;
				_tips.x = base_x;
				_tips.y = base_y - _tips.height;
				_tips.addEventListener(
					FlexEvent.CREATION_COMPLETE,
					function (e:Event):void {
						if (null != _tips) {
							_tips.y = base_y - _tips.height;
						}
					}
				);
				popUpWindowLayer.addElement(_tips);
			}
		}
		//删除tips
		private function price_item_out(e:Event):void {
			if (null != _tips) {
				if (popUpWindowLayer.contains(_tips)) {
					popUpWindowLayer.removeElement(_tips);
				}
				_tips = null;
			}
		}
		
		private function clear_mask(mask_sp:Sprite, tf_sp:Sprite):void {
			var layer:UIComponent = UILayerManager.getInstance().alert_layer;
			//layer.removeChild(mask_sp);
			layer.removeChild(tf_sp);
		}
		
		
		private function create_tf():TextField {
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			var format:TextFormat = new TextFormat();
			format.size = 12;
			format.color = 0xBEBEBE;
			tf.defaultTextFormat = format;
			
			var growFilte:GlowFilter = new GlowFilter(ProConst.BORDER_COLOR,0.7,2,2,5,1);			
			tf.filters = [growFilte];
			
			return tf;
		}
		
		private function getCurTaskInfo(taskId:int):TaskItemInfo{
			var l:int = _task_msg.npc_task_list.length;
			for(var i:int=0;i<l;i++){
				if(_task_msg.npc_task_list[i].taskId == taskId){
					return _task_msg.npc_task_list[i];
				}
			}
			return null;
		}
		
		//点击人物条目
		private var curTaskInfo:TaskItemInfo;
		private function on_task_item_click(e:MouseEvent):void {
			var itemRender:NTaskNpcTaskItemView = e.currentTarget as NTaskNpcTaskItemView;
			curTaskInfo = getCurTaskInfo(itemRender._taskId);
			if(curTaskInfo == null)return;
			switch(curTaskInfo.taskState) {
				case TaskState.ACCERT_ABLE:
				case TaskState.EXCUTE:
				case TaskState.COMPLETE:
				on_to_task();
				break;
				case TaskState.RUNING:
				//case TaskState.COMPLETE:
				on_to_running();
				break;
				//case TaskState.COMPLETE:
				//_task_msg.request_sub_task(_task_msg.task_info.taskId, _npc_id);
				//break;
				default:
				throw new Error("error task state " + _task_msg.task_info.taskState);
			}
//			switch(_task_msg.task_info.taskState) {
//				case TaskState.ACCERT_ABLE:
//				case TaskState.EXCUTE:
//				case TaskState.COMPLETE:
//					on_to_task();
//					break;
//				case TaskState.RUNING:
//				//case TaskState.COMPLETE:
//					on_to_running();
//					break;
//				//case TaskState.COMPLETE:
//					//_task_msg.request_sub_task(_task_msg.task_info.taskId, _npc_id);
//					//break;
//				default:
//					throw new Error("error task state " + _task_msg.task_info.taskState);
//			}
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_TASK_ITEM_CLICK));
		}
		
		
		//切换到未完成语言
		private function on_to_running():void {
			view.task_content.removeAllElements();
			_word_page = 0;
			if (null == _npc_info_view) {
				_npc_info_view = new NTaskNpcInfoView();
				_npc_info_view.btn_next.addEventListener(MouseEvent.CLICK, next_task_info_page);
			}
			refresh_task_runing_info();
			view.task_content.addElement(_npc_info_view);
			
			if (TaskState.RUNING == curTaskInfo.taskState) {
				//正在进行中
				remove_if_have(_npc_info_view.btn_next);
			}
			else {
				_npc_info_view.btn_next.visible = true;
			}
//			view.task_content.removeAllElements();
//			_word_page = 0;
//			if (null == _npc_info_view) {
//				_npc_info_view = new NTaskNpcInfoView();
//				_npc_info_view.btn_next.addEventListener(MouseEvent.CLICK, next_task_info_page);
//			}
//			refresh_task_runing_info();
//			view.task_content.addElement(_npc_info_view);
//			
//			if (TaskState.RUNING == _task_msg.task_info.taskState) {
//				//正在进行中
//				remove_if_have(_npc_info_view.btn_next);
//			}
//			else {
//				_npc_info_view.btn_next.visible = true;
//			}
		}
		
		//刷新未完成任务对白
		private function refresh_task_runing_info():void {
			var des_content:Array = curTaskInfo.taskRuningDes.split("\n");
			var des_name:String = des_content[0];
			var des_word:String = des_content[1];
			
			_npc_info_view.l_ncp_name.text = "[" + des_name + "]";
			_npc_info_view.l_des.htmlText = "<font color='" + TASK_INFO_COLOR + "' size='" + TASK_INFO_SIZE + "'>" + 
				"    " + des_word + 
				"</font>"; 
			_npc_info_view.btn_next.text = "    " + des_word; 
//			var des_content:Array = _task_msg.task_info.taskRuningDes.split("\n");
//			var des_name:String = des_content[0];
//			var des_word:String = des_content[1];
//			
//			_npc_info_view.l_ncp_name.text = "[" + des_name + "]";
//			_npc_info_view.l_des.htmlText = "<font color='" + TASK_INFO_COLOR + "' size='" + TASK_INFO_SIZE + "'>" + 
//												"    " + des_word + 
//											"</font>"; 
//			_npc_info_view.btn_next.text = "    " + des_word; 
		}
		
		//切换到任务对话界面
		private function on_to_task():void {
			view.task_content.removeAllElements();
			view.task_content.validateNow();
			_word_page = 0;
			if (null == _npc_info_view) {
				_npc_info_view = new NTaskNpcInfoView();
				_npc_info_view.btn_next.addEventListener(MouseEvent.CLICK, next_task_info_page);
			}
			//刷新任务说明视图
			refresh_task_info();
			//添加任务说明视图 
			view.task_content.addElement(_npc_info_view);
			//_npc_info_view.btn_next.label = "下一页";
			//_npc_info_view.addElement(_npc_info_view.btn_next);
			_npc_info_view.btn_next.visible = true;
		}
		
		//刷新任务说明视图
		private function refresh_task_info():void {
			var des_info:TaskTalk = curTaskInfo.taskDes[_word_page] as TaskTalk;
			var des_type:String = "[" + des_info.roleType + "]";
			var des_word:String = des_info.taskDes;
			
			_npc_info_view.l_ncp_name.text = des_type;
			_npc_info_view.l_des.htmlText = "<font color='" + TASK_INFO_COLOR + "' size='" + TASK_INFO_SIZE + "'>" + 
				"    " + des_word + 
				"</font>";
			var u_info:TaskTalk = curTaskInfo.taskDes[_word_page + 1] as TaskTalk;
			var w:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_hd');
			if (null == u_info) {
				
			}
			else {
				w = u_info.taskDes;
			}
			_npc_info_view.btn_next.text = w ;
//			var des_info:TaskTalk = _task_msg.task_info.taskDes[_word_page] as TaskTalk;
//			var des_type:String = "[" + des_info.roleType + "]";
//			var des_word:String = des_info.taskDes;
//			
//			_npc_info_view.l_ncp_name.text = des_type;
//			_npc_info_view.l_des.htmlText = "<font color='" + TASK_INFO_COLOR + "' size='" + TASK_INFO_SIZE + "'>" + 
//												"    " + des_word + 
//											"</font>";
//			var u_info:TaskTalk = _task_msg.task_info.taskDes[_word_page + 1] as TaskTalk;
//			var w:String = "好的";
//			if (null == u_info) {
//				
//			}
//			else {
//				w = u_info.taskDes;
//			}
//			_npc_info_view.btn_next.text = w ;
		}
		//切换到下一页说明
		private function next_task_info_page(e:MouseEvent):void {
			if(!CommonTools.delayClick())return;
			_word_page += 2;
			if (_word_page < curTaskInfo.taskDes.length - 2) {
				refresh_task_info();
				//执行过程中最后一页显示按钮
				if (_word_page == curTaskInfo.taskDes.length - 3) {
					if (
						TaskState.EXCUTE == curTaskInfo.taskState ||
						TaskState.COMPLETE == curTaskInfo.taskState
					) {
						_npc_info_view.btn_next.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','ntnM_wc');
					}
				}
			}
			else {
				//可接状态显示奖励界面
				if (TaskState.ACCERT_ABLE == curTaskInfo.taskState) {
					to_price_page();
				}
					//执行状态,发送操作完成指令
				else if (TaskState.EXCUTE == curTaskInfo.taskState) {
					//发送对话任务操作指令
					_task_msg.request_excute_talk_task(curTaskInfo.taskId, _npc_id);
				}
					//完成状态,直接提交
				else if (TaskState.COMPLETE == curTaskInfo.taskState) {
					_task_msg.request_sub_task(curTaskInfo.taskId, _npc_id);
				}
			}
//			if (_word_page < _task_msg.task_info.taskDes.length - 2) {
//				refresh_task_info();
//				//执行过程中最后一页显示按钮
//				if (_word_page == _task_msg.task_info.taskDes.length - 3) {
//					if (
//						TaskState.EXCUTE == _task_msg.task_info.taskState ||
//						TaskState.COMPLETE == _task_msg.task_info.taskState
//					) {
//						_npc_info_view.btn_next.text = "完成";
//					}
//				}
//			}
//			else {
//				//可接状态显示奖励界面
//				if (TaskState.ACCERT_ABLE == _task_msg.task_info.taskState) {
//					to_price_page();
//				}
//				//执行状态,发送操作完成指令
//				else if (TaskState.EXCUTE == _task_msg.task_info.taskState) {
//					//发送对话任务操作指令
//					_task_msg.request_excute_talk_task(_task_msg.task_info.taskId, _npc_id);
//				}
//				//完成状态,直接提交
//				else if (TaskState.COMPLETE == _task_msg.task_info.taskState) {
//					_task_msg.request_sub_task(_task_msg.task_info.taskId, _npc_id);
//				}
//			}
		}
		//切换到经历界面
		private function to_price_page():void {
			view.task_content.removeAllElements();
			_word_page = 0;
			if (null == _npc_price_view) {
				_npc_price_view = new NTaskNpcPriceView();
				_npc_price_view.btn_accept.addEventListener(MouseEvent.CLICK, on_accept_task);
			}
			
			
//			var prices:Array = _task_msg.task_info.taskPriceItem;
			var prices:Array = curTaskInfo.taskPriceItem;
			if (null != prices && prices.length > 0 ) {
				var price0:ItemInfo = prices[0] as ItemInfo;
				if (null != price0) {
					var price0Info:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(price0.itemId);
					price0Info.stack = price0.stack;
					_npc_price_view.img_price_0.source = CommonTools.setEquipmentUrl(price0Info.icon, price0Info.type);
					_npc_price_view.img_price_0.addEventListener(MouseEvent.ROLL_OVER, price_item_over);
					_npc_price_view.img_price_0.addEventListener(MouseEvent.ROLL_OUT, price_item_out);
					_npc_price_view.img_price_0.addEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
					_npc_price_view.l_price0_num.text = "" + price0Info.stack;
				}
				var price1:ItemInfo = prices[1] as ItemInfo;
				if (null != price1) {
					var price1Info:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(price1.itemId);
					price1Info.stack = price1.stack;
					_npc_price_view.img_price_1.source = CommonTools.setEquipmentUrl(price1Info.icon, price1Info.type);
					_npc_price_view.img_price_1.addEventListener(MouseEvent.ROLL_OVER, price_item_over);
					_npc_price_view.img_price_1.addEventListener(MouseEvent.ROLL_OUT, price_item_out);
					_npc_price_view.img_price_1.addEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
					_npc_price_view.l_price1_num.text = "" + price1Info.stack;
				}
				else {
					_npc_price_view.img_price_1.source = null;
					_npc_price_view.l_price1_num.text = "";
				}
			}
			else {
				_npc_price_view.img_price_0.source = null;
				_npc_price_view.img_price_1.source = null;
				_npc_price_view.img_price_0.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
				_npc_price_view.img_price_0.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
				_npc_price_view.img_price_0.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
				_npc_price_view.img_price_1.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
				_npc_price_view.img_price_1.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
				_npc_price_view.img_price_1.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
				_npc_price_view.l_price0_num.text = "";
				_npc_price_view.l_price1_num.text = "";
			}
			_npc_price_view.l_g_money.text = curTaskInfo.taskPriceCoins.toString();
			_npc_price_view.l_r_money.text = curTaskInfo.taskPriceZuan.toString();
			_npc_price_view.l_r_exp.text = curTaskInfo.taskExp.toString();
			var u_info:TaskTalk = curTaskInfo.taskDes[curTaskInfo.taskDes.length - 1] as TaskTalk;
			_npc_price_view.btn_accept.text = u_info.taskDes;
//			_npc_price_view.l_g_money.text = _task_msg.task_info.taskPriceCoins.toString();
//			_npc_price_view.l_r_money.text = _task_msg.task_info.taskPriceZuan.toString();
//			_npc_price_view.l_r_exp.text = _task_msg.task_info.taskExp.toString();
//			var u_info:TaskTalk = _task_msg.task_info.taskDes[_task_msg.task_info.taskDes.length - 1] as TaskTalk;
//			_npc_price_view.btn_accept.text = u_info.taskDes;
			
			view.task_content.addElement(_npc_price_view);
			
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_NPC_PRIVE_UI));
		}
		
		//接收任务
		private function on_accept_task(e:MouseEvent):void {
			_task_msg.request_accept_task(curTaskInfo.taskId, _npc_id);
//			_task_msg.request_accept_task(_task_msg.task_info.taskId, _npc_id);
			
		}
		
		private function remove_if_have(dis:Object):void {
			//if (null != dis.parentDocument ) {
				//dis.parentDocument.removeElement(dis);
			//}
			dis.visible = false;
		}
		
		public function get view():NTaskNpcView {
			return viewComponent as NTaskNpcView;
		}
	}
}
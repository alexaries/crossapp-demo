package sceneModule.view.task.mediator
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import managers.ToolTipManager;
	import managers.WindowManager;
	
	import mx.controls.Image;
	import mx.events.ItemClickEvent;
	import mx.events.ListEvent;
	import mx.events.TreeEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.task.ItemInfo;
	import proto.task.TaskItemInfo;
	
	import resource.AssetCenter;
	import resource.CrotaItemConfig;
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.pack.view.MainMenuEquipmentTooltip;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.task.model.TaskTreeLabelVo;
	import sceneModule.view.task.view.MainMenuTaskComponent;
	
	import util.CommonTools;
	import util.xtrace;
	
	public class MainMenuTaskMediator extends Mediator
	{
		private var _task_msg:TaskMessage;
		private var _selelcted_id:int;
		private var _cur_seleced_card:String;
		private var _tree_data:Array;
		
		private var _tips:MainMenuEquipmentTooltip;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function MainMenuTaskMediator()
		{
			super();
		}
		
		override public function onRegister():void {
			_task_msg = TaskMessage.getInstance();

			init_view();
			
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_REFRESH_MENU_SHOW, init_view);
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_REFRESH_MENU_VIEW, refresh_view);
			_task_msg.addEventListener(NTaskEvent.NTaskEvent_REFRESH_CUR_CARD_SHOW, refres_cur_card);
			view.cardtype.addEventListener(ItemClickEvent.ITEM_CLICK, car_change);
			view.myTree.addEventListener(TreeEvent.ITEM_OPEN, label_open);
			view.myTree.addEventListener(ListEvent.ITEM_CLICK, label_click);
			view.btn_func.addEventListener(MouseEvent.CLICK, on_fun_btn);
			view.btn_trac.addEventListener(MouseEvent.CLICK, on_change_trac_btn);
			view.closeBtn.addEventListener(MouseEvent.CLICK,onCloseWindow);
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(MainMenuComponent.NAME,false,false,null,popUpWindowLayer);
		}
		
		override public function preRemove():void {
			_task_msg.removeEventListener(NTaskEvent.NTaskEvent_REFRESH_MENU_SHOW, init_view);
			_task_msg.removeEventListener(NTaskEvent.NTaskEvent_REFRESH_MENU_VIEW, refresh_view);
			view.cardtype.removeEventListener(ItemClickEvent.ITEM_CLICK, car_change);
			view.myTree.removeEventListener(TreeEvent.ITEM_OPEN, label_open);
			view.myTree.removeEventListener(ListEvent.ITEM_CLICK, label_click);
			view.btn_func.removeEventListener(MouseEvent.CLICK, on_fun_btn);
			view.btn_trac.removeEventListener(MouseEvent.CLICK, on_change_trac_btn);
			view.closeBtn.removeEventListener(MouseEvent.CLICK,onCloseWindow);
			
			if (null != view.img_price0) {
				view.img_price0.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
				view.img_price0.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
				view.img_price0.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
			}
			if (null != view.img_price1) {
				view.img_price1.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
				view.img_price1.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
				view.img_price1.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
			}
			
		}
		/////////////////////////////////////////////////////////////////////
		private function init_view(e:Event = null):void {
			//强制选中当前任务
			view.cardtype.selectedValue = "cur_task";
			_cur_seleced_card = "cur_task";
			_selelcted_id = 0;
			to_cur_task();
			clear_task_info();
		}
		
		private function refres_cur_card(e:NTaskEvent):void {
			//clear_task_info();
			if ("cur_task" ==  view.cardtype.selectedValue ) {
				to_cur_task();
			}
			else if ("accept_task" == view.cardtype.selectedValue) {
				to_accept_task();
			}
		}
		
		private function refresh_view(e:NTaskEvent):void {
			if (TaskMessage.TYPE_CUR_TASK_LIST == _task_msg.cur_task_list_type) {
				view.cardtype.selectedValue = "cur_task";
				_cur_seleced_card = "cur_task";
				_tree_data = _task_msg.get_tree_data(_task_msg.cur_task_list)
				view.myTree.dataProvider = _tree_data;
				open_first();
			}
			else if (TaskMessage.TYPE_ACCEPT_TASK_LIST == _task_msg.cur_task_list_type) {
				view.cardtype.selectedValue = "accept_task";
				_cur_seleced_card = "accept_task";
				_tree_data = _task_msg.get_tree_data(_task_msg.acceptable_task_list)
				view.myTree.dataProvider = _tree_data;
				open_first();
				view.btn_func.enabled = false;
				view.btn_trac.enabled = false;
			}
		}
		
		private function car_change(e:ItemClickEvent):void {
			clear_task_info();
			if ("cur_task" ==  view.cardtype.selectedValue ) {
				view.cardtype.selectedValue = _cur_seleced_card;
				to_cur_task();
			}
			else if ("accept_task" == view.cardtype.selectedValue) {
				to_accept_task();
				view.cardtype.selectedValue = _cur_seleced_card;
			}
		}
		
		private function label_click(e:ListEvent):void {
			var data:TaskTreeLabelVo = e.itemRenderer.data as TaskTreeLabelVo;
			if (0 != data.id) {
				to_selected(data.id);
			}
			else {
				view.myTree.selectedItem = find_selected_label();
			}
		}
		
		//添加tips
		private function price_item_over(e:MouseEvent):void {
			var taget:Object = e.target;
			var item:ItemInfo = null;
			var t_task:TaskItemInfo = _task_msg.find_task(_selelcted_id);
			if (null != t_task) {
				var prices:Array = t_task.taskPriceItem;
				if (null == prices) {
					prices = [];
				}
				if (taget == view.img_price0) {
					item = prices[0] as ItemInfo;
				}
				else if (taget == view.img_price1) {
					item = prices[1] as ItemInfo;
				}
				if (null != item) {
					_tips = ToolTipManager.showToolTip(MainMenuEquipmentTooltip.NAME) as MainMenuEquipmentTooltip;
					var packgeItem:PackageItem =CrotaItemConfig.getItemInfoByTempleteId(item.itemId);
					_tips.curDataInfo = packgeItem;
					//设置ToolTip位置
					var base_x:int = popUpWindowLayer.mouseX;
					var base_y:int = popUpWindowLayer.mouseY;
					_tips.x = base_x;
					_tips.y = base_y;
					popUpWindowLayer.addElement(_tips);
				}
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
		
		private function to_selected(id:int):void {
			_selelcted_id = id;
			var t_task:TaskItemInfo = _task_msg.find_task(_selelcted_id);
			if (null != t_task) {
				view.l_target.text = t_task.taskTaget;
				view.l_des.text = t_task.taskUiDes;
				var prices:Array = t_task.taskPriceItem;
				if (null == prices) {
					prices = [];
				}
				set_price_img(view.img_price0, CrotaItemConfig.getItemInfoByTempleteId(prices[0].itemId));
				set_price_img(view.img_price1, CrotaItemConfig.getItemInfoByTempleteId(prices[1].itemId));
				//view.l_price.text = "Exp: " + t_task.taskExp + "    魔币:" + t_task.taskPriceCoins + "    魔钻:" + t_task.taskPriceZuan; 
				
				view.l_r_exp.text = t_task.taskExp.toString();
				view.l_r_money.text = t_task.taskPriceZuan.toString();
				view.l_g_money.text = t_task.taskPriceCoins.toString();
				CommonTools.make_bitmap(view.img_g_money_ico).bitmapData = 
					AssetCenter.getInstance().get_img_form_pacakge('common_res',
						'coin_img');
				
				CommonTools.make_bitmap(view.img_r_money_ico).bitmapData = 
					AssetCenter.getInstance().get_img_form_pacakge('common_res',
						'cry_img');
				
				CommonTools.make_bitmap(view.img_r_exp_ico).bitmapData = 
					AssetCenter.getInstance().get_img_form_pacakge('common_res',
						'npt_task_ico_exp');
				
				view.btn_trac.label = (0 == t_task.taskIsTrack) ?CrotaResourceConfig.getInstance().getTextByModuleAndId('task','mmtM_zzrw') : CrotaResourceConfig.getInstance().getTextByModuleAndId('task','mmtM_fqzz');
				view.l_task_name.text = t_task.taskName;
				view.btn_func.enabled = true;
				view.btn_trac.enabled = true;
			}
			else {
				clear_task_info();
			}
		}
		
		private function open_first():void {
			if (_tree_data.length > 0) {
				view.myTree.validateNow();
				var first_group:TaskTreeLabelVo = _tree_data[0] as TaskTreeLabelVo;
				view.myTree.expandChildrenOf(first_group, true);
				if (first_group.children.length > 0) {
					var first_child:TaskTreeLabelVo = first_group.children[0] as TaskTreeLabelVo;
					to_selected(first_child.id);
					view.myTree.selectedItem = find_selected_label();
				}
				else {
					clear_task_info();
				}
			}
			else {
				clear_task_info();
			}
		}
		
		private function label_open(e:TreeEvent):void {
			view.myTree.selectedItem = find_selected_label();
		}
		
		private function on_change_trac_btn(e:MouseEvent):void {
			if (0 != _selelcted_id) {
				var t_task:TaskItemInfo = _task_msg.find_task(_selelcted_id);
				_task_msg.request_change_trac_state(_selelcted_id, (0 == t_task.taskIsTrack)? 1 : 0);
			}
		}
		
		private function set_price_img(img:Image, iteminfo:PackageItem):void {
			if (null == iteminfo) {
				img.source = null;
				img.removeEventListener(MouseEvent.ROLL_OVER, price_item_over);
				img.removeEventListener(MouseEvent.ROLL_OUT, price_item_out);
				img.removeEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
			}
			else {
				img.source = CommonTools.setEquipmentUrl(iteminfo.icon, iteminfo.type);
				img.addEventListener(MouseEvent.ROLL_OVER, price_item_over);
				img.addEventListener(MouseEvent.ROLL_OUT, price_item_out);
				img.addEventListener(Event.REMOVED_FROM_STAGE, price_item_out);
			}
		}
		
		private function clear_task_info():void {
			view.l_target.text = "";
			view.l_des.text = "";
			
			//view.l_price.text = "";
			view.l_r_exp.text = "";
			view.l_r_money.text = "";
			view.l_g_money.text = "";
			
			CommonTools.make_bitmap(view.img_g_money_ico).bitmapData = null;
				
			CommonTools.make_bitmap(view.img_r_money_ico).bitmapData = null;
				
			CommonTools.make_bitmap(view.img_r_exp_ico).bitmapData = null;
				
			view.img_price0.source = null;
			view.img_price1.source = null;
			view.btn_trac.label = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','mmtM_zzrw');
			view.l_task_name.text = "";
			view.btn_func.enabled = false;
			view.btn_trac.enabled = false;
		}
		
		private function on_fun_btn(e:MouseEvent):void {
			if (0 != _selelcted_id) {
				popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('task','mmtM_sffq'),null,null,null,null, _task_msg.request_drop_task,null,[_selelcted_id]);
				//_task_msg.request_drop_task(_selelcted_id);
			}
		}
		
		
		private function to_cur_task():void {
			_task_msg.request_have_task_list();
		}
		
		private function to_accept_task():void {
			_task_msg.request_accept_task_list();
		}
		
		private function find_selected_label():TaskTreeLabelVo {
			var r:TaskTreeLabelVo = null;
			if (0 == _selelcted_id) {
				return r;
			}
			else {
				for each (var item:TaskTreeLabelVo in _tree_data) 
				{
					for each (var item_in:TaskTreeLabelVo  in item.children) 
					{
						if (item_in.id == _selelcted_id) {
							r = item_in;
							break;
						}
					}
				}
			}
			return r;
		}
		
		////////////////////////////////////////////////////////////////////
		public function get view():MainMenuTaskComponent{
			return this.viewComponent as MainMenuTaskComponent;
		}
	}
}
package mediator
{
	import com.greensock.TweenLite;
	
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	import event.NGuidEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import managers.UILayerManager;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	
	import mx.controls.SWFLoader;
	import mx.core.FlexGlobals;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.task.TaskItemInfo;
	import proto.task.TaskState;
	import proto.task.task1421.TaskTracItem;
	
	import resource.AssetCenter;
	
	import sceneModule.model.rvo.RNpcVo;
	import sceneModule.rcommand.revent.RNpcEvent;
	import sceneModule.view.ScenePageView;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.task.view.TaskComponent;
	import sceneModule.view.ui.GuidePointer;
	import sceneModule.view.wordmap.model.MapConfig;
	
	import util.CommonTools;
	import util.xtrace;

	/**
	 * 整个应用的mediator，用来处理应用的Module关系。 
	 * @author mutou
	 * 
	 */	
	public class TaskGuideMediator extends Mediator
	{
		public static const BASE_W:int = 1000;
		public static const BASE_H:int = 570;
		
		public static const MAX_W:int = 1250;
		public static const MAX_H:int = 650;
		
		public static const BASE_PATH:String = 'assets/guid/';
		public static const IS_OPEN:Boolean = false;
		
		public static const MAIN_PLAYER_DELAY:int = 1000;
		public static const MAKE_ALPHA:Number = 0.6;
		public static const MASK_ROUND_SIZE:int = 10;
		
		public static const MOVE_POINT_ST_NONE:int = 0;
		public static const MOVE_POINT_ST_LEFT:int = 1;
		public static const MOVE_POINT_ST_RIGHT:int = 2;
		
		
		
		[Inject]
		public var sp:GuidLayer;
		
		
		private var _guid_info:Array;
		private var _cur_guid:GuideInfo;
		private var _last_guide:GuideInfo;
		private var _left_sp:GuidePointer;
		private var _right_sp:GuidePointer;
		private var _down_sp:GuidePointer;
		private var _move_poin:MovieClip;
		
		private var _move_point_y:int = 130;
		private var _move_point_state:int = 0;
		
		private var _move_speed:int;
		
		public function TaskGuideMediator()
		{
			super();
			_guid_info = [];
			_cur_guid = null;
			_last_guide = null;
		}
		
		override public function onRegister():void {
			//sp.mouseEnabled = false;
			sp.mouseChildren = false;
			initEvent();
		}
		
		private function set last_guide(item:GuideInfo):void {
			if (null != item) {
				_last_guide = item;
			}
		}
		
		
		private function initEvent():void {
			GuidEventCenter.getInstance().addEventListener(NGuidEvent.NGuidEvent_XML_LOADED, init_data);
			//PBE.mainClass.addEventListener(RNpcEvent.NPC_CTREATED_EVENT, out_create_npc);
			GuidEventCenter.getInstance().addEventListener(GuidEvent.GuidEvent_EVENT, check_guide);
			GuidEventCenter.getInstance().addEventListener(GuidClearEvent.GuidClearEvent_EVENT, clear_guide);
			GuidEventCenter.getInstance().addEventListener(NGuidEvent.NGuidEvent_SHOW_LEFT_GO, show_left_go);
			GuidEventCenter.getInstance().addEventListener(NGuidEvent.NGuidEvent_SHOW_RIGHT_GO, show_right_go);
			GuidEventCenter.getInstance().addEventListener(NGuidEvent.NGuidEvent_CLEAR_GO, clear_go);
			//PBE.mainClass.stage.addEventListener(Event.RESIZE, on_resize);
		}
		
		private function show_left_go(e:Event):void {
//			trace('新手引导showLeftGo...........');
			if (_move_point_state != MOVE_POINT_ST_LEFT) {
				if (null != _move_poin && null != _move_poin.parent) {
					_move_poin.parent.removeChild(_move_poin);
				}
			}
			
			
			if (null == _move_poin) {
				_move_poin = AssetCenter.getInstance().get_mc_form_pacakge('guide', 'guide_move_point_left');
			}
			//if (-1 != _move_poin.scaleX) {
				//_move_poin.scaleX = -1;
				_move_poin.x = 0;
				_move_poin.y = _move_point_y;
			//}
			
			_move_point_state = MOVE_POINT_ST_LEFT;
			if (null == _move_poin.parent) {
				//UILayerManager.getInstance().sky_layer.addChild(_move_poin);
			}
		}
		private function show_right_go(e:Event):void {
//			trace('新手引导showRightGo');
			if (_move_point_state != MOVE_POINT_ST_RIGHT) {
				if (null != _move_poin && null != _move_poin.parent) {
					_move_poin.parent.removeChild(_move_poin);
				}
			}
			
			if (null == _move_poin) {
				_move_poin = AssetCenter.getInstance().get_mc_form_pacakge('guide', 'guide_move_point');
			}
			//if (1 != _move_poin.scaleX) {
				_move_poin.scaleX = 1;
				_move_poin.x = sp.stage.stageWidth - _move_poin.width;
				_move_poin.y = _move_point_y;
			//}
			
			_move_point_state = MOVE_POINT_ST_RIGHT;
			if (null == _move_poin.parent) {
				//UILayerManager.getInstance().sky_layer.addChild(_move_poin);
			}
		}
		private function clear_go(e:Event = null):void {
			if (null != _move_poin && null != _move_poin.parent) {
				_move_poin.parent.removeChild(_move_poin);
				_move_point_state = MOVE_POINT_ST_NONE;
			}
		}
		
		private function init_data(e:NGuidEvent):void {
			var speedxml:XMLList = MapConfig.getInstance().guide_xml.elements('guidspeed');
			if (speedxml.length() > 0) {
				_move_speed = speedxml.@speed;
			}
			else {
				_move_speed = 500;
			}
			
			
			
			for each (var item:XML in MapConfig.getInstance().guide_xml.info) 
			{
				var guide_info:GuideInfo = new GuideInfo();
				guide_info.id = item.@id;
				guide_info.type = item.@type;
				guide_info.arg1 = item.@arg1;
				guide_info.arg2 = item.@arg2;
				guide_info.arg3 = item.@arg3;
				guide_info.arg4 = item.@arg4;
				guide_info.arg5 = item.@arg5;
				guide_info.arg6 = item.@arg6;
				guide_info.pos_x = item.@pos_x;
				guide_info.pos_y = item.@pos_y;
				guide_info.targetid = item.@targetid;
				guide_info.show_contain_type = item.@containtype;
				guide_info.show_arg = item.@show_arg;
				guide_info.label = item.@label;
				guide_info.mask_w = item.@marsk_w;
				guide_info.mask_h = item.@mask_h;
				guide_info.asset_name = item.@asset;
				guide_info.label_str = item.@labelStr;
			    guide_info.tips_str = item.@tipStr;
				guide_info.tipx = item.@tipx;
				guide_info.tipy = item.@tipy;
				_guid_info.push(guide_info);
			}
		}
		
		private function on_enter_frame(e:Event):void {
			var l_stage:Stage = sp.stage;
			var stagePt:Point = new Point(l_stage.mouseX, l_stage.mouseY);
			//取得容器中鼠标处的对象数组
			var arr:Array = sp.stage.getObjectsUnderPoint(stagePt);
			var spindex:int = arr.indexOf(sp);
			
			//暂时关闭遮挡鼠标点击无效
			//sp.mouseEnabled = ( -1 != spindex);
			
			sp.mouseEnabled = false;
		}
		
		private function clear_guide(e:GuidClearEvent = null, close_ui:Boolean = false):void {
//			trace('清理新手引导..........');
			xtrace("清理新手指引 event : ",_cur_guid, " close_ui :", close_ui );
			clear_sp();
			last_guide = _cur_guid;
			_cur_guid = null;
			clear_go(); 
			if (!close_ui) {
				if (null == e || (e.etype != GuidClearEvent.CHANGE_MODEL && e.etype != GuidClearEvent.MAIN_UI_ALERT && e.etype != GuidClearEvent.SOCKET_CLOSE)) {
					if (e.etype != GuidClearEvent.UI_CHANGE) {
						xtrace("新手指引--","检测任务状态");
						check_task();
					}
				}
			}
		}
		
		private function check_guide(e:GuidEvent):void {
//			trace('新手指引---CheckGuide.........');
			if (!IS_OPEN) {
				return;
			}
			xtrace("新手指引--", "检测触发事件", e);
			switch (e.etype) 
			{
				case GuideInfo.TYPE_OPEN_UI:
					check_ui(e);
					break;
				case GuideInfo.TYPE_ACTION_EXCUTE:
					check_action(e);
					break;
				case GuideInfo.TYPE_CHANGE_SCENE:
					check_task();
					break;
				case GuideInfo.TYPE_CHECH_TASK:
					check_task();
					break;
				case GuideInfo.SECOND_SCENE:
					check_secondUI(e);
					break;
				default:
					throw new Error("Error guide type " + e.etype);
			}
		}
		
		//创建NPC监听
		//event:[npcid]
		//taget:[arg1:npcid, arg2:可接任务id]
		private function out_create_npc(e:RNpcEvent):void {
			if (!IS_OPEN) {
				return;
			}
			xtrace("新手指引--","检测创建npc",e.npcId);
			for each (var item:GuideInfo in _guid_info) 
			{
				//创建NPC
				if (GuideInfo.TYPE_CREATE_NPC == item.type) {
					var accept_tasks:Array = TaskMessage.getInstance().trac_accepted_tasks;
					//指定npc
					if (e.npcId == int(item.arg1)) {
						//可接任务
						for each (var task_item:TaskTracItem in accept_tasks) 
						{
							if (task_item.taskId == int(item.arg2)) {
								last_guide = _cur_guid;
								_cur_guid = item;
								show_guide();
								break;
							}
						}
					}
				}
			}
		}
		
		//显示ui界面
		private function check_secondUI(e:GuidEvent):void {
			//打开ui的时候,关闭指向任务追踪的指引
			if (null != _cur_guid && GuideInfo.SHOW_TASK_TRAC == _cur_guid.show_contain_type) {
				xtrace("打开主菜单,关闭指向任务追踪的指引");
				clear_guide(null, true);
			}
			if (GuideInfo.UI_FU_CHOSE == e.arg1) {
				clear_guide(null, true);
			}
			for each (var item:GuideInfo in _guid_info) 
			{
				if (GuideInfo.TYPE_OPEN_UI == item.type) {
					//判断打开ui的类型
					if (item.arg1 == e.arg1) {
						//xtrace("新手指引--", "检测打开ui", e);
						if ( GuideInfo.UI_TYPE_NPC_TASK == e.arg1) {
							if (check_npc_task_ui(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_TYPE_MAIN_PLAYER == e.arg1) {
							if (check_main_player(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_FU_CHOSE == e.arg1) {
							if (check_fu_chose(item, e.arg2)) {
								break;
							}
						}
						else if (GuideInfo.UI_QIANGHUA == e.arg1) {
							if (check_qianghua(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_SKILL == e.arg1) {
							if (check_skill(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_JUNTUAN == e.arg1) {
							if (check_juntuan(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_CREATE_UNION == e.arg1) {
							if (check_create_union(item)) {
								break;
							}
						}
						else{
							if (check_single_ui(item)) {
								break;
							}
						}
						
					}
				}
			}
		}
		
		
		
		
		//双层界面
		private function check_ui(e:GuidEvent):void {
			//打开ui的时候,关闭指向任务追踪的指引
			if (null != _cur_guid && GuideInfo.SHOW_TASK_TRAC == _cur_guid.show_contain_type) {
				xtrace("打开主菜单,关闭指向任务追踪的指引");
				clear_guide(null, true);
			}
			if (GuideInfo.UI_FU_CHOSE == e.arg1) {
				clear_guide(null, true);
			}
			for each (var item:GuideInfo in _guid_info) 
			{
				if (GuideInfo.TYPE_OPEN_UI == item.type) {
					//判断打开ui的类型
					if (item.arg1 == e.arg1) {
						//xtrace("新手指引--", "检测打开ui", e);
						if ( GuideInfo.UI_TYPE_NPC_TASK == e.arg1) {
							if (check_npc_task_ui(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_TYPE_MAIN_PLAYER == e.arg1) {
							if (check_main_player(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_FU_CHOSE == e.arg1) {
							if (check_fu_chose(item, e.arg2)) {
								break;
							}
						}
						else if (GuideInfo.UI_QIANGHUA == e.arg1) {
							if (check_qianghua(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_SKILL == e.arg1) {
							if (check_skill(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_JUNTUAN == e.arg1) {
							if (check_juntuan(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_CREATE_UNION == e.arg1) {
							if (check_create_union(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_SENCOND_QINGLUE == e.arg1) {
							if (check_test(item)) {
								break;
							}
						}
						else if (GuideInfo.UI_TIEKUANGDONG == e.arg1) {
							if (check_tkd(item)) {
								break;
							}
						}
						else{
							if (check_single_ui(item)) {
								break;
							}
						}
						
					}
				}
			}
		}
		
		//检测操作动作
		//event:[arg1:动作类型,arg2:打开的副本组id]
		//target:[arg1:操作类型, arg2:上一个指引id, arg3:副本组id]
		private function check_action(e:GuidEvent):void {
			for each (var item:GuideInfo in _guid_info) 
			{
				//xtrace("新手指引--", "检测系统内部操作", item);
				if (e.arg1 == int(item.arg1) && null != _cur_guid && _cur_guid.id == int(item.arg2)) {
					if (0 != int(item.arg3)) {
						var target_group_id:int = int(item.arg3);
						if (target_group_id == e.arg2) {
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							break;
						}
					}
					else {
						last_guide = _cur_guid;
						_cur_guid = item;
						show_guide();
						break;
					}
				}
			}
		}
		
		//检测打开npc任务界面
		//event:[arg1:ui类型]
		//target:[arg1:ui类型, arg2:可接任务id, arg3:已接任务id]
		private function check_npc_task_ui(item:GuideInfo):Boolean {
			var r:Boolean = false;
			
			var accepted_taskid:int = int(item.arg2);
			var cur_taskid:int = int(item.arg3);
			var excute_taskid:int = int(item.arg4);
			var complete_taskid:int = int(item.arg5);
			var taskInfo:TaskItemInfo = TaskMessage.getInstance().npc_task_list[0];
			if (null != taskInfo) {
				var cur_task:int = taskInfo.taskId;
				var state:int = taskInfo.taskState;
				if (TaskState.ACCERT_ABLE == state) {
					//可接状态
					if (accepted_taskid == cur_task) {
						r = true;
					}
				}
				else if (TaskState.EXCUTE == state) {
					//任务执行状态
					if (excute_taskid == cur_task) {
						r = true;
					}
				}
				else if (TaskState.COMPLETE == state) {
					//完成的任务
					if (complete_taskid == cur_task) {
						r = true;
					}
				}
				
				if (r) {
					last_guide = _cur_guid;
					_cur_guid = item;
					show_guide();
				}
				else {
					if (0 != accepted_taskid) {
						//检测可接
					}
					else if (0 != cur_taskid) {
						//执行中
						var t_tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
						for each (var task_item:TaskTracItem in t_tasks) 
						{
							if (TaskState.RUNING == task_item.taskState) {
								if (task_item.taskId == cur_taskid) {
									last_guide = _cur_guid;
									_cur_guid = item;
									show_guide();
									return true;
								}
							}
						}
					}
				}
			}
			
			
			return r;
		}
		
		
		//检测打开主菜单人物界面
		private function check_main_player(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var runing_task_id:int = int(item.arg3);
			if (0 != runing_task_id) {
				var tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in tasks) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (task_item.taskId == runing_task_id) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		
		//检测打开副本选择界面
		//arg2 副本id
		private function check_fu_chose(item:GuideInfo,e_fb_id:int):Boolean {
			var r:Boolean = false;
			var runing_task_id:int = int(item.arg3);
			var fb_id:int = int(item.arg6);
			if (0 != runing_task_id) {
				var tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in tasks) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (task_item.taskId == runing_task_id && e_fb_id == fb_id) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		
		//检测打开强化界面
		private function check_qianghua(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var runing_task_id:int = int(item.arg3);
			if (0 != runing_task_id) {
				var tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in tasks) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (task_item.taskId == runing_task_id) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		
		//检测打开技能界面
		private function check_skill(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var runing_task_id:int = int(item.arg3);
			if (0 != runing_task_id) {
				var tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in tasks) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (task_item.taskId == runing_task_id) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		
		//检测打开军团
		private function check_juntuan(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var runing_task_id:int = int(item.arg3);
			if (0 != runing_task_id) {
				var tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in tasks) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (task_item.taskId == runing_task_id) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		
		//检测打开创建军团页面
		private function check_create_union(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var runing_task_id:int = int(item.arg3);
			if (0 != runing_task_id) {
				var tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in tasks) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (task_item.taskId == runing_task_id) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		//检测第二次侵略点击界面ui
		private function check_test(item:GuideInfo):Boolean {
			var r:Boolean = false;
			
			var accepted_taskid:int = int(item.arg2);
			var cur_taskid:int = int(item.arg3);
			var excute_taskid:int = int(item.arg4);
			var complete_taskid:int = int(item.arg5);
			
			var t_tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
			if (0 != accepted_taskid) {
			}
			else if (0 != cur_taskid) {
				//执行中
				for each (var task_item1:TaskTracItem in t_tasks) 
				{
					if (TaskState.RUNING == task_item1.taskState) {
						if (task_item1.taskId == cur_taskid && item.arg1 == GuideInfo.UI_SENCOND_QINGLUE) {
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return true;
						}
					}
				}
			}
			else if (0 != excute_taskid) {
			}
			
			
			return r;
		}
		
		//检测打开铁矿洞界面ui
		private function check_tkd(item:GuideInfo):Boolean {
			var r:Boolean = false;
			
			var accepted_taskid:int = int(item.arg2);
			var cur_taskid:int = int(item.arg3);
			var excute_taskid:int = int(item.arg4);
			var complete_taskid:int = int(item.arg5);
			
			var t_tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
			if (0 != accepted_taskid) {
			}
			else if (0 != cur_taskid) {
				//执行中
				for each (var task_item1:TaskTracItem in t_tasks) 
				{
					if (TaskState.RUNING == task_item1.taskState) {
						if (task_item1.taskId == cur_taskid && item.arg1 == GuideInfo.UI_TIEKUANGDONG) {
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return true;
						}
					}
				}
			}
			else if (0 != excute_taskid) {
			}
			
			
			return r;
		}
		
		//检测打开的任意ui
		private function check_single_ui(item:GuideInfo):Boolean {
			var r:Boolean = false;
			
			var accepted_taskid:int = int(item.arg2);
			var cur_taskid:int = int(item.arg3);
			var excute_taskid:int = int(item.arg4);
			var complete_taskid:int = int(item.arg5);
			
				var t_tasks:Array = TaskMessage.getInstance().trac_cur_tasks;
				if (0 != accepted_taskid) {
					//检测可接
					for each (var task_item:TaskTracItem in t_tasks) 
					{
						if (TaskState.ACCERT_ABLE == task_item.taskState) {
							if (task_item.taskId == accepted_taskid) {
								last_guide = _cur_guid;
								_cur_guid = item;
								show_guide();
								return true;
							}
						}
					}
				}
				else if (0 != cur_taskid) {
					//执行中
					for each (var task_item1:TaskTracItem in t_tasks) 
					{
						if (TaskState.RUNING == task_item1.taskState) {
							if (task_item1.taskId == cur_taskid) {
								last_guide = _cur_guid;
								_cur_guid = item;
								show_guide();
								return true;
							}
						}
					}
				}
				else if (0 != excute_taskid) {
					//执行中
					for each (var task_item2:TaskTracItem in t_tasks) 
					{
						if (TaskState.COMPLETE == task_item2.taskState) {
							if (task_item2.taskId == excute_taskid) {
								last_guide = _cur_guid;
								_cur_guid = item;
								show_guide();
								return true;
							}
						}
					}
				}
			
			
			return r;
		}
		
		
		//检测当前的任务是否需要指引
		private function check_task():void {
			if (!IS_OPEN) {
				return;
			}
			//副本中,不设置任务指引
			//1000-5000 城镇
			var t_id:int = SystemDataModel.placeId;
			if (t_id < 1000 || t_id > 5000) {
				if (_cur_guid && _cur_guid.show_contain_type == GuideInfo.SHOW_TASK_TRAC) {
					//return;
				}
			}
			if (SystemDataModel.isBattleStatusFlag) {
				return;
			}
			/*
			for each (var item:GuideInfo in _guid_info) 
			{
				if (GuideInfo.TYPE_CHECH_TASK == item.type) {
					//xtrace("新手指引--", "检测任务状态", item);
					var npcs:Array = RNpcOp.npcVoArr;
					var is_npc_here:Boolean = (null != rGuideArrowOp.getCharacterEntity(item.arg4));
					//for each (var npc_item:RNpcVo in npcs) 
					//{
						//if (npc_item.id == int(item.arg4)) {
							//is_npc_here = true;
						//}
					//}
					var arg5:int = item.arg5;
					if (0 != arg5) {
						if (arg5 != SystemDataModel.placeId) {
							continue;
						}
					}
					
					if (is_npc_here || 0 == int(item.arg4)) {
						if (check_acceptable_task(item)) {
							break;
						}
						else if (check_cur_task(item)) {
							break;
						}
						else if (check_complete_task(item)) {
							break;
						}
					}
				}
			}
			*/
		}
		
		
		//检测可接任务
		private function check_acceptable_task(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var info_cur_id:int = int(item.arg1);
			if (0 != info_cur_id) {
				for each (var task_item:TaskTracItem in TaskMessage.getInstance().trac_accepted_tasks) 
				{
					if (info_cur_id == task_item.taskId) {
						r = true;
						last_guide = _cur_guid;
						_cur_guid = item;
						show_guide();
						break;
					}
				}
			}
			return r;
		}
		
		//检测当前未完成任务
		private function check_cur_task(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var info_cur_id:int = int(item.arg2);
			if (0 != info_cur_id) {
				var cur_task_list:Array = TaskMessage.getInstance().trac_cur_tasks;
				for each (var task_item:TaskTracItem in cur_task_list) 
				{
					if (TaskState.RUNING == task_item.taskState) {
						if (info_cur_id == task_item.taskId) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							return r;
						}
					}
				}
			}
			return r;
		}
		//检测完成的任务
		private function check_complete_task(item:GuideInfo):Boolean {
			var r:Boolean = false;
			var info_cur_id:int = int(item.arg3);
			if (0 != info_cur_id) {
				for each (var task_item:TaskTracItem in TaskMessage.getInstance().trac_cur_tasks) 
				{
					if (TaskState.COMPLETE == task_item.taskState) {
						if (info_cur_id == task_item.taskId) {
							r = true;
							last_guide = _cur_guid;
							_cur_guid = item;
							show_guide();
							break;
						}
					}
				}
			}
			return r;
		}
		
		private function is_task_here(tasks:Array, task_id:int):Boolean {
			var r:Boolean = false;
			if (0 == r) {
				r = true;
			}
			else {
				for each (var item:TaskItemInfo in tasks) 
				{
					if (item.taskId == task_id) {
						r = true;
						break;
					}
				}
			}
			return r;
		}
		
		private function clear_sp():void {
			sp.removeEventListener(Event.ENTER_FRAME, on_enter_frame);
			if (null != _left_sp) {
				if (_left_sp.parent && _left_sp.parent == sp) {
					_left_sp.parent.removeChild(_left_sp);
				}
			}
			if (null != _right_sp && _right_sp.parent == sp) {
				if (_right_sp.parent) {
					_right_sp.parent.removeChild(_right_sp);
				}
			}
			if (null != _down_sp && _down_sp.parent == sp) {
				if (_down_sp.parent) {
					_down_sp.parent.removeChild(_down_sp);
				}
			}
			sp.graphics.clear();
			sp.mouseEnabled = false;
		}
		
		private function draw_mask():void {
			return;
			var fix_x:int = 0;
			var fix_y:int = 0;
			var is_show:Boolean = false;
			if (null != _left_sp) {
				if (_left_sp.parent) {
					fix_x = _left_sp.x - _cur_guid.mask_w;
					fix_y = _left_sp.y + GuidePointer.SELF_H/ 2 - _cur_guid.mask_h / 2;
					is_show = true;
				}
			}
			if (null != _right_sp) {
				if (_right_sp.parent) {
					fix_x = _right_sp.x + GuidePointer.SELF_W;
					fix_y = _right_sp.y + GuidePointer.SELF_H / 2 - _cur_guid.mask_h / 2;
					is_show = true;
				}
			}
			if (is_show) {
				sp.graphics.clear();
				sp.graphics.beginFill(0x000000, MAKE_ALPHA);
				sp.graphics.drawRect(0, 0, sp.stage.stageWidth, sp.stage.stageHeight);
				sp.graphics.drawRoundRect(fix_x, fix_y, _cur_guid.mask_w, _cur_guid.mask_h, MASK_ROUND_SIZE);
				sp.graphics.endFill();
				sp.addEventListener(Event.ENTER_FRAME, on_enter_frame);
			}
			
		}
		
		
		
		private function show_guide():void {
			xtrace("显示新手指引", _cur_guid);
			if (null == _left_sp) {
				_left_sp = new GuidePointer(GuidePointer.GuidePointer_LEFT, _move_speed);
				_left_sp.mouseEnabled = false;
				_left_sp.mouseChildren = false;
			}
			if (null == _right_sp) {
				_right_sp = new GuidePointer(GuidePointer.GuidePointer_RIGHT, _move_speed);
				_right_sp.mouseEnabled = false;
				_right_sp.mouseChildren = false;
			}
			if (null == _down_sp) {
				_down_sp = new GuidePointer(GuidePointer.GuidePointer_DOWN, _move_speed);
				_down_sp.mouseEnabled = false;
				_down_sp.mouseChildren = false;
			}
			
			var oldx:int = 0;
			var oldy:int = 0;
			var tPoint:Point;
			
			if (null != _cur_guid) {
				if (GuideInfo.SHOW_SCENE != _cur_guid.show_contain_type) {
					if (null != _last_guide) {
						if ("click_right.swf" == _last_guide.asset_name) {
							oldx = _right_sp.x;
							oldy = _right_sp.y;
							tPoint = new Point(oldx, oldy);
						}
						else if ("click_left.swf" == _last_guide.asset_name) {
							oldx = _left_sp.x;
							oldy = _left_sp.y;
							tPoint = new Point(oldx, oldy);
						}
						else if ("click_down.swf" == _last_guide.asset_name) {
							oldx = _down_sp.x;
							oldy = _down_sp.y;
							tPoint = new Point(oldx, oldy);
						}
						xtrace("获取前一个stage坐标 ", tPoint);
					}
				}
			}
			
			clear_sp();
			
			//rGuideArrowOp.removeGuideArrow();
			
			//额外的显示操作
			switch (_cur_guid.show_arg) 
			{
				case GuideInfo.SHOW__SBLANK:
					break;
				case GuideInfo.SHOW__CHANGE_TASK_TRACK_CUR:
					//切换任务追踪到当前任务
					GuidEventCenter.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_CHANGE_TRAC_CUR));
					break;
				case GuideInfo.SHOW__CHANGE_TASK_TRACK_ACCEPT:
					//切换任务追踪到可接任务
					GuidEventCenter.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_CHANGE_TRAC_ACCEPT));
					break;
				default:
					throw new Error("error show arg " + _cur_guid.show_arg);
			}
			
			
			//显示在UI层
			if (GuideInfo.SHOW_UI == _cur_guid.show_contain_type || GuideInfo.SHOW_MAIN_MENU == _cur_guid.show_contain_type || GuideInfo.SHOW_TASK == _cur_guid.show_contain_type|| GuideInfo.SHOW_STRENG_MENU == _cur_guid.show_contain_type|| GuideInfo.SHOW_PET == _cur_guid.show_contain_type) {
				if ("click_right.swf" == _cur_guid.asset_name) {
					sp.addChild(_right_sp);
					_right_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_right_sp.x = _cur_guid.pos_x + get_fix_x(_cur_guid.show_contain_type);
					_right_sp.y = _cur_guid.pos_y + get_fix_y(_cur_guid.show_contain_type);
				}
				else if ("click_left.swf" == _cur_guid.asset_name) {
					sp.addChild(_left_sp);
					_left_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_left_sp.x = _cur_guid.pos_x + get_fix_x(_cur_guid.show_contain_type);//get_fix_x得到r值 
					_left_sp.y = _cur_guid.pos_y + get_fix_y(_cur_guid.show_contain_type);
				}
				else if ("click_down.swf" == _cur_guid.asset_name) {
					//新手指引箭头指向第一个主菜单时跳出任务去副本时不显示向下的箭头
					if(ProConst.MAX_CITY_ID >= SystemDataModel.placeId){
					sp.addChild(_down_sp);
					_down_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_down_sp.x = _cur_guid.pos_x + get_fix_x(_cur_guid.show_contain_type);
					_down_sp.y = _cur_guid.pos_y + get_fix_y(_cur_guid.show_contain_type);
					}
				}
				else {
					throw new Error("unkonwn swf " + _cur_guid.asset_name);
				}
				draw_mask();
				on_resize();
			}
			//显示在场景层
			else if (GuideInfo.SHOW_SCENE == _cur_guid.show_contain_type) {
				if ("click_right.swf" == _cur_guid.asset_name) {
					_right_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					//rGuideArrowOp.setGuideArrow(_cur_guid.targetid, _right_sp, new Point(_cur_guid.pos_x, _cur_guid.pos_y));
				}
				else if ("click_left.swf" == _cur_guid.asset_name) {
					_left_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					//rGuideArrowOp.setGuideArrow(_cur_guid.targetid, _left_sp, new Point(_cur_guid.pos_x, _cur_guid.pos_y));
				}
				else if ("click_down.swf" == _cur_guid.asset_name) {
					_down_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					//rGuideArrowOp.setGuideArrow(_cur_guid.targetid, _down_sp, new Point(_cur_guid.pos_x, _cur_guid.pos_y));
				}
				else {
					throw new Error("unkonwn swf " + _cur_guid.asset_name);
				}
			}
			//显示在背包的装备上
			else if (GuideInfo.SHOW_PACKAGE == _cur_guid.show_contain_type) {
				var t_pos:Point = CommonTools.getEquipmentPos(_cur_guid.targetid);
				if ("click_right.swf" == _cur_guid.asset_name) {
					sp.addChild(_right_sp);
					_right_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_right_sp.x = _cur_guid.pos_x + t_pos.x + get_fix_x(GuideInfo.SHOW_UI);
					_right_sp.y = _cur_guid.pos_y + t_pos.y + get_fix_y(GuideInfo.SHOW_UI);
				}
				else if ("click_left.swf" == _cur_guid.asset_name) {
					sp.addChild(_left_sp);
					_left_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_left_sp.x = _cur_guid.pos_x + t_pos.x + get_fix_x(GuideInfo.SHOW_UI);
					_left_sp.y = _cur_guid.pos_y + t_pos.y + get_fix_y(GuideInfo.SHOW_UI);
				}
				else if ("click_down.swf" == _cur_guid.asset_name) {
					sp.addChild(_down_sp);
					_down_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_down_sp.x = _cur_guid.pos_x + t_pos.x + get_fix_x(GuideInfo.SHOW_UI);
					_down_sp.y = _cur_guid.pos_y + t_pos.y + get_fix_y(GuideInfo.SHOW_UI);
				}
				else {
					throw new Error("unkonwn swf " + _cur_guid.asset_name);
				}
				draw_mask();
			}
			//显示在任务指引上
			else if (GuideInfo.SHOW_TASK_TRAC == _cur_guid.show_contain_type) {
				var tt_pos:Array = TaskMessage.getInstance().get_trac_task_pos(_cur_guid.targetid);
				if ("click_right.swf" == _cur_guid.asset_name) {
					sp.addChild(_right_sp);
					_right_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_right_sp.x = _cur_guid.pos_x + tt_pos[0] + get_trace_fix_x();
					_right_sp.y = _cur_guid.pos_y + tt_pos[1] + get_trace_fix_y();
				}
				else if ("click_left.swf" == _cur_guid.asset_name) {
					sp.addChild(_left_sp);
					_left_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_left_sp.x = _cur_guid.pos_x + tt_pos[0] + get_trace_fix_x();
					_left_sp.y = _cur_guid.pos_y + tt_pos[1] + get_trace_fix_y();
				}
				else if ("click_down.swf" == _cur_guid.asset_name) {
					sp.addChild(_down_sp);
					_down_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
					_down_sp.x = _cur_guid.pos_x + tt_pos[0] + get_trace_fix_x();
					_down_sp.y = _cur_guid.pos_y + tt_pos[1] + get_trace_fix_y();
				}
				else {
					throw new Error("unkonwn swf " + _cur_guid.asset_name);
				}
				draw_mask();
				
				if (0 == tt_pos[0]) {
					xtrace("获取任务追踪位置错误",_cur_guid.targetid);
					clear_guide(null, true);
				}
			}
			else {
				throw new Error("非法任务指引层 "+ _cur_guid.show_contain_type);
			}
			if (tPoint) {
				if (_left_sp.stage) {
					to_pos(_left_sp, tPoint);
				}
				if (_right_sp.stage) {
					to_pos(_right_sp, tPoint);
				}
				if (_down_sp) {
					to_pos(_down_sp, tPoint);
				}
			}
			
			
		}
		
		private function to_pos(sp:Sprite, oldpos:Point):void {
			var tx:int = sp.x;
			var ty:int = sp.y;
			sp.rotation = -90;
			sp.x = oldpos.x;
			sp.y = oldpos.y;
			TweenLite.to(sp, 0.01 , {x:tx, y:ty, rotation:0});
		}
		private var  spv:ScenePageView;
		private function get_fix_x(type:int):int {
			var r:int = 0;
			/*
			if (null != PBE.mainClass){
				if (null != PBE.mainClass.stage) {
					var stage_w:int = PBE.mainClass.stage.stageWidth;
					var stage_h:int = PBE.mainClass.stage.stageHeight;
					switch (type) 
					{
						case GuideInfo.SHOW_MAIN_MENU:
							if (stage_w <= BASE_W) {
								
							}
							else{
								r = stage_w - BASE_W;
							}
							break;
						case GuideInfo.SHOW_PET:
							if (stage_h <= BASE_H) {
								
							}
							else{
								if (stage_h <= MAX_H) {
									r = stage_h - BASE_H;
								}
								else {
									r = MAX_H - BASE_H;
								}
							}
							break;
						case GuideInfo.SHOW_TASK:
							r = 0;
							break;
						default:
							r = (stage_w - BASE_W) / 2;
							if (r < 0) {
								r = 0;
							}
					}
					
				}
			}
			*/
			return r;
		}
		
		private function get_fix_y(type:int):int {
			var r:int = 0;
			/*
			if (null != PBE.mainClass){
				if (null != PBE.mainClass.stage) {
					var stage_h:int = PBE.mainClass.stage.stageHeight;
					switch (type) 
					{
						case GuideInfo.SHOW_MAIN_MENU:
							if (stage_h <= BASE_H) {
								
							}
							else{
								if (stage_h <= MAX_H) {
									r = stage_h - BASE_H;
								}
								else {
									r = MAX_H - BASE_H;
								}
							}
							break;
						case GuideInfo.SHOW_PET:
							if (stage_h <= BASE_H) {
								
							}
							else{
								if (stage_h <= MAX_H) {
									r = stage_h - BASE_H;
								}
								else {
									r = MAX_H - BASE_H;
								}
							}
							break;
						case GuideInfo.SHOW_TASK:
							r = 0;
							break;
						default:
							var t_h:int = Math.min(MAX_H, stage_h);
							r = (t_h - BASE_H) / 2;
							if (r < 0) {
								r = 0;
							}
					}
				}
			}
			*/
			return r;
		}
		
		
		private function get_trace_fix_x():int {
			var r:int = 0;
			var stage_w:int = sp.stage.stageWidth;
			if (stage_w > MAX_W) {
				r = stage_w - TaskComponent.V_W;
			}
			else {
				var t_w:int = Math.max(stage_w, BASE_W);
				r = t_w - TaskComponent.V_W;	
			}
			return r;
		}
		private function get_trace_fix_y():int {
			var r:int = 0;
			//var stage_h:int = sp.stage.stageHeight;
			//if (stage_h > MAX_H) {
				//r = (stage_h - MAX_H) / 2;
			//}
			return r;
		}
		
		
		private function on_resize(e:Event = null):void {
			if (null != _cur_guid) {
				//显示在UI层
				if (GuideInfo.SHOW_UI == _cur_guid.show_contain_type || GuideInfo.SHOW_MAIN_MENU == _cur_guid.show_contain_type || GuideInfo.SHOW_TASK == _cur_guid.show_contain_type|| GuideInfo.SHOW_STRENG_MENU == _cur_guid.show_contain_type|| GuideInfo.SHOW_PET == _cur_guid.show_contain_type) {
					if ("click_right.swf" == _cur_guid.asset_name) {
						_right_sp.x = _cur_guid.pos_x + get_fix_x(_cur_guid.show_contain_type);
						_right_sp.y = _cur_guid.pos_y + get_fix_y(_cur_guid.show_contain_type);
					}
					else if ("click_left.swf" == _cur_guid.asset_name) {
						_left_sp.x = _cur_guid.pos_x + get_fix_x(_cur_guid.show_contain_type);
						_left_sp.y = _cur_guid.pos_y + get_fix_y(_cur_guid.show_contain_type);
					}
					else if ("click_down.swf" == _cur_guid.asset_name) {
						_down_sp.x = _cur_guid.pos_x + get_fix_x(_cur_guid.show_contain_type);
						_down_sp.y = _cur_guid.pos_y + get_fix_y(_cur_guid.show_contain_type);
					}
					else {
						throw new Error("unkonwn swf " + _cur_guid.asset_name);
					}
					draw_mask();
				}
				//显示在任务指引上
				else if (GuideInfo.SHOW_TASK_TRAC == _cur_guid.show_contain_type) {
					var stage_w:int =  Math.min(MAX_W, sp.stage.stageWidth);
					var tt_pos:Array = TaskMessage.getInstance().get_trac_task_pos(_cur_guid.targetid);
					if ("click_right.swf" == _cur_guid.asset_name) {
						_right_sp.x = _cur_guid.pos_x + tt_pos[0] + get_trace_fix_x();
						_right_sp.y = _cur_guid.pos_y + tt_pos[1] + get_trace_fix_y();
					}
					else if ("click_left.swf" == _cur_guid.asset_name) {
						_left_sp.x = _cur_guid.pos_x + tt_pos[0] + get_trace_fix_x();
						_left_sp.y = _cur_guid.pos_y + tt_pos[1] + get_trace_fix_y();
					}
					else if ("click_down.swf" == _cur_guid.asset_name) {
						_down_sp.x = _cur_guid.pos_x + tt_pos[0] + get_trace_fix_x();
						_down_sp.y = _cur_guid.pos_y + tt_pos[1] + get_trace_fix_y();
					}
					else {
						throw new Error("unkonwn swf " + _cur_guid.asset_name);
					}
					draw_mask();
					if (0 == tt_pos[0]) {
						xtrace("获取任务追踪位置错误",_cur_guid.targetid);
						clear_guide(null, true);
					}
				}
				//显示在背包的装备上
				else if (GuideInfo.SHOW_PACKAGE == _cur_guid.show_contain_type) {
					var t_pos:Point = CommonTools.getEquipmentPos(_cur_guid.targetid);
					if ("click_right.swf" == _cur_guid.asset_name) {
						sp.addChild(_right_sp);
						_right_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
						_right_sp.x = _cur_guid.pos_x + t_pos.x + get_fix_x(GuideInfo.SHOW_UI);
						_right_sp.y = _cur_guid.pos_y + t_pos.y + get_fix_y(GuideInfo.SHOW_UI);
					}
					else if ("click_left.swf" == _cur_guid.asset_name) {
						sp.addChild(_left_sp);
						_left_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
						_left_sp.x = _cur_guid.pos_x + t_pos.x + get_fix_x(GuideInfo.SHOW_UI);
						_left_sp.y = _cur_guid.pos_y + t_pos.y + get_fix_y(GuideInfo.SHOW_UI);
					}
					else if ("click_down.swf" == _cur_guid.asset_name) {
						sp.addChild(_down_sp);
						_down_sp.change_label(_cur_guid.label_str, _cur_guid.tips_str, _cur_guid.tipx, _cur_guid.tipy);
						_down_sp.x = _cur_guid.pos_x + t_pos.x + get_fix_x(GuideInfo.SHOW_UI);
						_down_sp.y = _cur_guid.pos_y + t_pos.y + get_fix_y(GuideInfo.SHOW_UI);
					}
					else {
						throw new Error("unkonwn swf " + _cur_guid.asset_name);
					}
					draw_mask();
				}
			}
			
		}
	}
}

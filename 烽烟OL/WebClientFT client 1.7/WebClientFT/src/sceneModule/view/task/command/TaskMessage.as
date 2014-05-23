package sceneModule.view.task.command {
	import Animation.AnimationManager;
	import util.Logging;
	import wordscene.helper.MapPathFinder;
	import wordscene.helper.TripItem;
	import wordscene.WordSceneSprite;
	
	
	import event.GuidEvent;
	import event.GuidEventCenter;
	import event.KeyFuncEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import managers.KeyBordManager;
	import managers.WindowManager;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	
	import proto.task.TaskItemInfo;
	import proto.task.TaskState;
	import proto.task.TaskTalk;
	import proto.task.task1410.TaskNpcTaskInfoRequest;
	import proto.task.task1410.TaskNpcTaskInfoResponse;
	import proto.task.task1411.TaskNpcSubTaskRequest;
	import proto.task.task1411.TaskNpcSubTaskResponse;
	import proto.task.task1412.TaskNpcAcceptTaskRequest;
	import proto.task.task1412.TaskNpcAcceptTaskResponse;
	import proto.task.task1413.TaskEntrustListRequest;
	import proto.task.task1413.TaskEntrustListResponse;
	import proto.task.task1414.TaskEntrustListRefreshRequest;
	import proto.task.task1414.TaskEntrustListRefreshResponse;
	import proto.task.task1415.TaskEntrustForceCompleteRequest;
	import proto.task.task1415.TaskEntrustForceCompleteResponse;
	import proto.task.task1416.TaskPlayerHaveTaskListRequest;
	import proto.task.task1416.TaskPlayerHaveTaskListResponse;
	import proto.task.task1417.TaskPlayerAcceptTaskListRequest;
	import proto.task.task1417.TaskPlayerAcceptTaskListResponse;
	import proto.task.task1418.TaskPlayerDropTaskRequest;
	import proto.task.task1418.TaskPlayerDropTaskResponse;
	import proto.task.task1419.TaskExcuteTalkTaskRequest;
	import proto.task.task1419.TaskExcuteTalkTaskResponse;
	import proto.task.task1420.updateQuestTraceStatuRequest;
	import proto.task.task1420.updateQuestTraceStatuResponse;
	import proto.task.task1421.TaskTracItem;
	import proto.task.task1421.TaskTracLinkInfo;
	import proto.task.task1421.TaskTracListNotify;
	import proto.task.task1422.TaskFinshNotify;
	
	import resource.AssetCenter;
	import resource.AssetItemInfo;
	import resource.CrotaResourceConfig;
	
	import sceneModule.rcommand.revent.RNpcEvent;
	import sceneModule.view.copyScene.view.NCopySceneChoseView;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.task.event.NTaskEvent;
	import sceneModule.view.task.model.TaskTreeLabelVo;
	import sceneModule.view.ui.GuideWindowLayer;
	import sceneModule.view.ui.event.PopUpGuideLayerEvent;
	
	import service.ISocketServer;
	
	import util.CommonTools;
	import util.DelayExcuter;
	import util.xtrace;
	
	/**
	 * ...
	 * @author hao
	 */
	public class TaskMessage extends EventDispatcher {
		public static const TYPE_CUR_TASK_LIST:int = 1;
		public static const TYPE_ACCEPT_TASK_LIST:int = 2;
		
		public static const TRAC_INFO_SPLIT:String = ",";
		public static const USERNAME_REPLACY:String = "%u";
		
		[Inject]
		public var socket:ISocketServer;
		
		private static var _instance:TaskMessage;
		
		public static function getInstance():TaskMessage {
			if (null == _instance) {
				_instance = new TaskMessage();
			}
			return _instance;
		}
		
		public function TaskMessage() {
			_cur_task_list = [];
			_acceptable_task_list = [];
			_find_path_target_map_path = new Vector.<TripItem>();
		}
		/////////////////////////////////////////////////////////////////////
		private var _npc_id:int;
		private var _npc_img:int;
		private var _npc_name:String;
		private var _npc_word:String;
		private var _task_info:TaskItemInfo;
		private var _task_npc_list:Array;
		private var _cur_task_list_type:int;
		private var _cur_task_list:Array;
		private var _acceptable_task_list:Array;
		
		private var _trac_cur_tasks:Array;
		private var _trac_accepted_tasks:Array;
		private var _trac_cur_pos:Array;
		private var _trac_accepted_pos:Array;
		
		private var _find_path_target_city:int;
		private var _find_path_target_npc:int;
		private var _find_path_target_trip:int;
		private var _find_path_target_fb_group:int;
		private var _find_path_target_fb:int;
		
		private var _find_path_target_map_path:Vector.<TripItem>;
		
		/////////////////////////////////////////////////////////////////////
		public function init_events():void {
			socket.send(new Responder(notify_task_trac, faultHandler), URLConst.TASK_NOTIFY_TRAC_LIST, null, false);
			socket.send(new Responder(notify_task_finish, faultHandler), URLConst.TASK_NOTIFY_CHANGE_TO_FINISH, null, false);
			//PBE.mainClass.addEventListener(RNpcEvent.ALL_NPC_CREATED_EVENT, find_path_enter_city);
			this.addEventListener(NTaskEvent.NTaskEvent_Enter_FB_CHOSE, find_path_enter_fb_chose);
		}
		
		////////////////////////////////////////////////////////////////////
		//获取NPC任务信息
		public function requeset_npc_task_info(npcId:int):void {
			var msg:TaskNpcTaskInfoRequest = new TaskNpcTaskInfoRequest();
			msg.id = SystemDataModel.roleId;
			msg.npcId = npcId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求NPC任务信息", msg);
			socket.send(new Responder(response_npc_task_info, faultHandler), URLConst.TASK_REQUEST_NCP_TASK_INFO, bytes);
		}
		
		private function response_npc_task_info(bytes:ByteArray):void {
			var msg:TaskNpcTaskInfoResponse = new TaskNpcTaskInfoResponse();
			msg.readExternal(bytes);
			xtrace("回复NPC任务信息", msg);
			_task_npc_list = new Array();
			if (msg.result) {
				_npc_id = msg.npcId;
				_npc_img = msg.npcImg;
				_npc_name = msg.npcName;
				_npc_word = msg.npcWord;
				//_task_info = msg.ncpTaskItem;
				
				//test
				//msg.ncpTaskItem.taskRuningDes = USERNAME_REPLACY + msg.ncpTaskItem.taskTaget;
				//end test
				
//				_task_info = convert_task_item_info(msg.ncpTaskItem);
				var l:int = msg.ncpTaskItem.length;
				for (var i:int = 0; i < l; i++) {
					var taskInfo:TaskItemInfo = convert_task_item_info(msg.ncpTaskItem[i]);
					_task_npc_list.push(taskInfo);
				}
				this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_NPC_VIEW));
			} else {
				
			}
		}
		
		//请求提交任务
		public function request_sub_task(taskid:int, npcid:int = 0):void {
			var msg:TaskNpcSubTaskRequest = new TaskNpcSubTaskRequest();
			msg.id = SystemDataModel.roleId;
			msg.taskId = taskid;
			msg.npcId = npcid;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求提交任务", msg);
			socket.send(new Responder(response_sub_task, faultHandler), URLConst.TASK_REQUEST_SUB_TASK, bytes);
		}
		
		private function response_sub_task(bytes:ByteArray):void {
			var msg:TaskNpcSubTaskResponse = new TaskNpcSubTaskResponse();
			msg.readExternal(bytes);
			if (msg.result) {
				//var animation:AnimationManager = new AnimationManager("Task_PreRes","Task_complete_swf");
				//animation.addToParent();
				//animation.setPosition(300,160);
				//animation.play();
				
				//显示任务奖励
				this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_SHOE_PRICE));
			}
			xtrace("提交任务回复", msg);
			this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_CLOSE_PARENT));
		}
		
		//请求接受任务
		public function request_accept_task(taskid:int, npcid:int = 0):void {
			var msg:TaskNpcAcceptTaskRequest = new TaskNpcAcceptTaskRequest();
			msg.id = SystemDataModel.roleId;
			msg.taskId = taskid;
			msg.npcId = npcid;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求接受任务", msg);
			socket.send(new Responder(response_accept_task, faultHandler), URLConst.TASK_REQUEST_ACCEPT_TASK, bytes);
		}
		private var tempTaskId:int;
		
		private function response_accept_task(bytes:ByteArray):void {
			var msg:TaskNpcAcceptTaskResponse = new TaskNpcAcceptTaskResponse();
			msg.readExternal(bytes);
			xtrace("接受任务回复", msg);
			var guideStr:String;
			
			if (msg.result) {
				var animation:AnimationManager = new AnimationManager("Task_PreRes", "Task_accept_swf");
				animation.addToParent();
				animation.setPosition(300, 160);
				animation.play();
				tempTaskId = msg.taskId;
				
//				//显示功能任务指引图片
				if (msg.taskId == 10004 || msg.taskId == 10029 || msg.taskId == 10036 || msg.taskId == 10262 || msg.taskId == 10271 || msg.taskId == 10264 || msg.taskId == 10267 || msg.taskId == 10268 || msg.taskId == 10272 || msg.taskId == 10273 || msg.taskId == 10274 || msg.taskId == 10275 || msg.taskId == 10276 || msg.taskId == 10277 || msg.taskId == 10278 || msg.taskId == 10279 || msg.taskId == 20246 || msg.taskId == 10280 || msg.taskId == 10010 || msg.taskId == 10031) {
					TaskMessage.getInstance().dispatchEvent(new PopUpGuideLayerEvent(PopUpGuideLayerEvent.POPUPGUIDELAYEREVENT, tempTaskId));
				}
				
			}
			//if (msg.result) {
			this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_CLOSE_PARENT));
			//}
			GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_ACCEPT_TASK_OK));
		}
		
//		private function to_yd_ui():void{
//			var obj:Object = new Object();
//			obj.tempTaskId = tempTaskId;
//			WindowManager.createWindow(GuideWindowLayer.NAME,obj,null,false,false,false,null,mediatorMap
//		}
		
		//请求支线任务列表
		public function request_entrust_list(npcid:int):void {
			var msg:TaskEntrustListRequest = new TaskEntrustListRequest();
			msg.id = SystemDataModel.roleId;
			msg.npcId = npcid;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求支线人物列表", msg);
			socket.send(new Responder(response_entrust_list, faultHandler), URLConst.TASK_REQUEST_Entrust_TASK_LIST, bytes);
		}
		
		private function response_entrust_list(bytes:ByteArray):void {
			var msg:TaskEntrustListResponse = new TaskEntrustListResponse();
			msg.readExternal(bytes);
			xtrace("支线人物列表回复", msg);
		}
		
		//请求刷新支线任务
		public function request_refresh_entrust_list(npcid:int):void {
			var msg:TaskEntrustListRefreshRequest = new TaskEntrustListRefreshRequest();
			msg.id = SystemDataModel.roleId;
			msg.npcId = npcid;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求刷新支线任务列表", msg);
			socket.send(new Responder(response_refresh_entrust_list, faultHandler), URLConst.TASK_REQUEST_Entrust_REFRESH_TASK_LIST, bytes);
		}
		
		private function response_refresh_entrust_list(bytes:ByteArray):void {
			var msg:TaskEntrustListRefreshResponse = new TaskEntrustListRefreshResponse();
			msg.readExternal(bytes);
			xtrace("刷新支线任务回复", msg);
		}
		
		//请求立即完成某个支线任务
		public function request_entrust_force_finish(taskid:int, npcid:int):void {
			var msg:TaskEntrustForceCompleteRequest = new TaskEntrustForceCompleteRequest();
			msg.id = SystemDataModel.roleId;
			msg.taskId = taskid;
			msg.npcId = npcid;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求完成某个支线任务", msg);
			socket.send(new Responder(response_entrust_force_finish, faultHandler), URLConst.TASK_REQUEST_Entrust_FORCE_COMPLETE, bytes);
		}
		
		private function response_entrust_force_finish(bytes:ByteArray):void {
			var msg:TaskEntrustForceCompleteResponse = new TaskEntrustForceCompleteResponse();
			msg.readExternal(bytes);
			xtrace("请求完成支线任务回复", msg);
		}
		
		//请求角色已接任务列表
		public function request_have_task_list():void {
			var msg:TaskPlayerHaveTaskListRequest = new TaskPlayerHaveTaskListRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求已结任务列表", msg);
			socket.send(new Responder(response_have_task_list, faultHandler), URLConst.TASK_REQUEST_PLAYER_TASK_LIST, bytes);
		}
		
		private function response_have_task_list(bytes:ByteArray):void {
			var msg:TaskPlayerHaveTaskListResponse = new TaskPlayerHaveTaskListResponse();
			msg.readExternal(bytes);
			xtrace("请求已结任务列表回复", msg);
			if (msg.result) {
				_cur_task_list = convert_task_list(msg.tasks);
				_cur_task_list_type = TYPE_CUR_TASK_LIST;
				this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_MENU_VIEW));
			}
		}
		
		//请求可接任务列表
		public function request_accept_task_list():void {
			var msg:TaskPlayerAcceptTaskListRequest = new TaskPlayerAcceptTaskListRequest();
			msg.id = SystemDataModel.roleId;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求可接任务列表", msg);
			socket.send(new Responder(response_accept_task_list, faultHandler), URLConst.TASK_REQUEST_ACCEPT_TASK_LIST, bytes);
		}
		
		private function response_accept_task_list(bytes:ByteArray):void {
			var msg:TaskPlayerAcceptTaskListResponse = new TaskPlayerAcceptTaskListResponse();
			msg.readExternal(bytes);
			xtrace("请求可接任务列表回复", msg);
			if (msg.result) {
				_acceptable_task_list = convert_task_list(msg.tasks);
				_cur_task_list_type = TYPE_ACCEPT_TASK_LIST;
				this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_MENU_VIEW));
			}
		}
		
		//请求放弃任务
		public function request_drop_task(taskid:int):void {
			var msg:TaskPlayerDropTaskRequest = new TaskPlayerDropTaskRequest();
			msg.id = SystemDataModel.roleId;
			msg.taskId = taskid;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求放弃任务", msg);
			socket.send(new Responder(response_drop_task, faultHandler), URLConst.TASK_REQUEST_DROP_TASK, bytes);
		}
		
		private function response_drop_task(bytes:ByteArray):void {
			var msg:TaskPlayerDropTaskResponse = new TaskPlayerDropTaskResponse();
			msg.readExternal(bytes);
			xtrace("请求放弃任务回复", msg);
			this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_CUR_CARD_SHOW));
		}
		
		//请求执行对话任务
		public function request_excute_talk_task(taskid:int, npcid:int = 0):void {
			var msg:TaskExcuteTalkTaskRequest = new TaskExcuteTalkTaskRequest();
			msg.id = SystemDataModel.roleId;
			msg.taskId = taskid;
			msg.npcId = npc_id;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求执行对话任务", msg);
			socket.send(new Responder(response_excute_talk_task, faultHandler), URLConst.TASK_REQUEST_EXCUTE_TALK_TASK, bytes);
		}
		
		private function response_excute_talk_task(bytes:ByteArray):void {
			var msg:TaskExcuteTalkTaskResponse = new TaskExcuteTalkTaskResponse();
			msg.readExternal(bytes);
			xtrace("请求执行对话任务", msg);
			this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_NPC_TASK));
		}
		
		//请求更新任务追踪状态
		public function request_change_trac_state(taskid:int, state:int):void {
			var msg:updateQuestTraceStatuRequest = new updateQuestTraceStatuRequest();
			msg.id = SystemDataModel.roleId;
			msg.taskID = taskid;
			msg.traceStatu = state;
			var bytes:ByteArray = new ByteArray();
			msg.writeExternal(bytes);
			xtrace("请求更改任务追踪状态", msg);
			socket.send(new Responder(response_change_trac_state, faultHandler), URLConst.TASK_RWQUEST_CHANGE_TRACK_STATE, bytes);
		}
		
		private function response_change_trac_state(bytes:ByteArray):void {
			var msg:updateQuestTraceStatuResponse = new updateQuestTraceStatuResponse();
			msg.readExternal(bytes);
			xtrace("更改任务追踪状态回复", msg);
			this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_CUR_CARD_SHOW));
		}
		
		//任务追踪广播
		private function notify_task_trac(bytes:ByteArray):void {
			var msg:TaskTracListNotify = new TaskTracListNotify();
			msg.readExternal(bytes);
			xtrace("任务追踪更新广播", msg);
			_trac_cur_tasks = msg.curList;
			_trac_accepted_tasks = msg.acceptableList;
			_trac_accepted_pos = [];
			_trac_cur_pos = [];
			if (null == msg.curList || msg.curList.length <= 0) {
				//没有当前任务,切换到可接
				GuidEventCenter.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_CHANGE_TRAC_ACCEPT));
			}
			if (null == msg.acceptableList || msg.acceptableList.length <= 0) {
				//没有可接任务,切换到当前
				GuidEventCenter.getInstance().dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_CHANGE_TRAC_CUR));
			}
			this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_REFRESH_TRAC));
		}
		
		//任务达到完成条件广播
		private function notify_task_finish(bytes:ByteArray):void {
			var msg:TaskFinshNotify = new TaskFinshNotify();
			msg.readExternal(bytes);
			xtrace("任务达到完成条件", msg);
			var animation:AnimationManager = new AnimationManager("Task_PreRes", "Task_complete_swf");
			animation.addToParent();
			animation.setPosition(300, 160);
			animation.play();
		}
		
		//取得任务树显示数据格式
		public function get_tree_data(arr:Array):Array {
			var types:Array = [];
			
			for each (var item:TaskItemInfo in arr) {
				var t_item:TaskTreeLabelVo = new TaskTreeLabelVo();
				var state:String = (TaskState.COMPLETE == item.taskState) ? "(완료)" : "(진행중)";
				t_item.label = "    [" + item.taskLv + "] " + item.taskName + '\t' + state;
				t_item.id = item.taskId;
				var type:TaskTreeLabelVo = check_tree_type(types, item.taskTypeName);
				type.children.push(t_item);
			}
			
			return types;
		}
		
		public function find_task(task_id:int):TaskItemInfo {
			var arr:Array = [];
			if (TaskMessage.TYPE_CUR_TASK_LIST == _cur_task_list_type) {
				arr = _cur_task_list;
			} else if (TaskMessage.TYPE_ACCEPT_TASK_LIST == _cur_task_list_type) {
				arr = _acceptable_task_list
			}
			var r_t:TaskItemInfo = null;
			for each (var item:TaskItemInfo in arr) {
				if (item.taskId == task_id) {
					r_t = item;
					break;
				}
			}
			return r_t;
		}
		
		public function get_acceptable_trac_list():String {
			var str:String = "";
			for each (var item:TaskTracItem in _trac_accepted_tasks) {
				var tag:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('task', 'ntnM_zhi');
				;
				if (item.taskId < 20000) {
					tag = CrotaResourceConfig.getInstance().getTextByModuleAndId('task', 'ntnM_zhu');
				}
				var linkstr:String = item.taskAccpetCityId + TRAC_INFO_SPLIT + item.taskAccpetNpcId + TRAC_INFO_SPLIT + "0" + TRAC_INFO_SPLIT + "0" + TRAC_INFO_SPLIT + "0";
				var t_str:String = tag + item.taskName;
				var needlv:int = item.needLv;
				var t_lv:String = "(Lv." + needlv + ")";
				var lv_class:String = "";
				if (needlv > SystemDataModel.roleInfo.level) {
					//不满足等级需求
					lv_class = "levelfail";
				} else {
					//满足等级需求
					lv_class = "levelok";
				}
				str += ("<a href='event:" + linkstr + "'><span class='taccpetable'>" + t_str + "</span><span class='" + lv_class + "'>" + t_lv + "</span></a><br>");
				_trac_accepted_pos.push([item.taskId, t_str, [0, 0]]);
			}
			return str;
		}
		
		public function get_cur_trac_list():String {
			var str:String = "";
			if (null == _trac_cur_tasks) {
				_trac_cur_tasks = [];
			}
			
			//test
			//str += "[test]测试人物四谛法力克肺疾阿拉斯加法律将非拉卡斯就法拉康记肥垃圾费杜拉克将飞拉萨kdj飞拉萨及发达龙卷风的龙卡阿斯兰费据拉萨打飞机<br>";	
			//end test
			
			for each (var item:TaskTracItem in _trac_cur_tasks) {
				if (0 == item.isTrac) {
					continue;
				}
				var class_name:String = "tword";
				if (TaskState.RUNING == item.taskState) {
					str += get_task_des_html(item.taskRunningDes, item.runingArgs, item.needNum, item.curNum, TaskState.COMPLETE == item.taskState, item.taskName, item.taskId);
				} else {
					str += get_task_des_html(item.taskCompleteDes, item.completeArgs, item.needNum, item.curNum, TaskState.COMPLETE == item.taskState, item.taskName, item.taskId);
				}
			}
			
			str = "<span class='" + class_name + "'>" + str + "</span>";
			return str;
		}
		
		public function get_task_des_html(str:String, links:Array, neednum:int, curnum:int, is_over:Boolean, taskname:String, taskid:int):String {
			if (null == links) {
				links = [];
			}
			
			var tag:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('task', 'ntnM_zhi');
			if (taskid < 20000) {
				tag = CrotaResourceConfig.getInstance().getTextByModuleAndId('task', 'ntnM_zhu');
			}
			
			var over_str:String = is_over ? CrotaResourceConfig.getInstance().getTextByModuleAndId('task', 'ntnM_wc') : "";
			
			var t_str:String = "<span class='tword'>" + tag + " <span class='cur_task_name'>" + taskname + "</span> " + over_str + "</span>";
			var t_name:String = taskname;
			
			_trac_cur_pos.push([taskid, t_name, [0, 0]]);
			
			str = (t_str + "<br>    ") + str;
			
			for each (var item:TaskTracLinkInfo in links) {
				if (null == item.label || "" == item.label) {
					break;
				}
				var infos:Array = item.label.split(TRAC_INFO_SPLIT);
				var label:String = infos[0];
				infos.shift();
				var link_str:String = infos.join(TRAC_INFO_SPLIT);
				str = str.replace("%s", "<a href='event:" + link_str + "'><span class='tlink'>" + label + "</span></a>");
			}
			var class_name:String = is_over ? "tover" : "tword";
			str += "(" + curnum + "/" + neednum + ")"
			str = "<span class='" + class_name + "'>" + str + "</span>";
			str += "<br>"
			return str;
		}
		
		public function get_trac_task_pos(id:int):Array {
			var r:Array = [0, 0];
			var t_task_id:int = 0;
			var r_task_pos:Array = null;
			for each (var c_item:Array in _trac_cur_pos) {
				t_task_id = c_item[0];
				if (t_task_id == id) {
					r_task_pos = c_item;
				}
			}
			if (null == r_task_pos) {
				for each (var a_item:Array in _trac_accepted_pos) {
					t_task_id = a_item[0];
					if (t_task_id == id) {
						r_task_pos = a_item;
					}
				}
			}
			if (null != r_task_pos) {
				r = r_task_pos[2];
			}
			return r;
		}
		
		public function find_path(link_str:String = null):void {
			if (SystemDataModel.isGuaJiFlag) {
				clear_find_path();
				return;
			}
			if (null != link_str) {
				var infos:Array = link_str.split(TRAC_INFO_SPLIT);
				var city_id:int = infos[0];
				var npc_id:int = infos[1];
				var trip_id:int = infos[2];
				var fb_group_id:int = infos[3];
				var fb_id:int = infos[4];
				
				_find_path_target_city = city_id;
				_find_path_target_npc = npc_id;
				_find_path_target_trip = trip_id;
				_find_path_target_fb_group = fb_group_id;
				_find_path_target_fb = fb_id;
			}
			
			if (
				0 == _find_path_target_city && 
				0 == _find_path_target_npc &&
				0 == _find_path_target_trip
			) {
				return;
			}
			
			_find_path_target_map_path.length = 0;
			if (0 != _find_path_target_city) {
				if (SystemDataModel.placeId == _find_path_target_city) {
					//同一张地图
					if (0 != _find_path_target_npc) {
						//查找npc
						xtrace("自动寻路,寻路到npc ", _find_path_target_npc);
						WordSceneSprite.getInstance().gotoNPC(_find_path_target_npc);
						clear_find_path();
					} else {
						//查找传送门
						if (0 != _find_path_target_trip) {
							xtrace("自动寻路,寻路到传送门", _find_path_target_trip);
							WordSceneSprite.getInstance().gotoTrip(_find_path_target_trip);
							clear_find_path();
						} else {
							xtrace("自动寻路错误的传送门id");
						}
					}
				} else {
					//不同地图
					_find_path_target_map_path = MapPathFinder.getInstance().find(SystemDataModel.placeId, _find_path_target_city);
					if (0 == _find_path_target_map_path.length || null == _find_path_target_map_path[0]) {
						Logging.log("查找地图路径错误 from", SystemDataModel.placeId, "to", _find_path_target_city);
						clear_find_path();
					}
					else {
						WordSceneSprite.getInstance().gotoTrip(_find_path_target_map_path[0].id);
					}
				}
			} else {
				xtrace("find path cityid error ");
			}
		
		}
		
		private function find_path_enter_city(e:Event):void {
			if (0 == _find_path_target_npc && 0 == _find_path_target_trip) {
				return;
			}
			if (SystemDataModel.placeId == _find_path_target_city) {
				if (0 != _find_path_target_npc) {
					//查找npc
					xtrace("自动寻路,寻路到npc", _find_path_target_npc);
					new DelayExcuter(500, WordSceneSprite.getInstance().gotoNPC, [_find_path_target_npc]);
					clear_find_path();
				} else {
					//查找传送门
					if (0 != _find_path_target_trip) {
						xtrace("自动寻路,寻路到传送门", _find_path_target_trip);
						new DelayExcuter(500, WordSceneSprite.getInstance().gotoTrip, [_find_path_target_trip]);
					} else {
						xtrace("自动寻路错误的传送门id");
					}
				}
			} else {
				clear_find_path();
			}
		}
		
		private function find_path_enter_fb_chose(e:NTaskEvent):void {
			var trip_id:int = e.obj.tripid;
			if (trip_id == _find_path_target_trip) {
				this.dispatchEvent(new NTaskEvent(NTaskEvent.NTaskEvent_Open_FB_Group, {groupid: _find_path_target_fb_group}));
			} else {
				clear_find_path();
			}
		}
		
		public function find_path_check_wordmap():int {
			return _find_path_target_city;
		}
		
		public function clear_find_path():void {
			_find_path_target_city = 0;
			_find_path_target_npc = 0;
			_find_path_target_trip = 0;
			_find_path_target_fb_group = 0;
			_find_path_target_fb = 0;
			_find_path_target_map_path.length = 0;
			xtrace("删除自动寻路信息");
		}
		
		private function check_tree_type(arr:Array, task_name:String):TaskTreeLabelVo {
			var is_have:Boolean = false;
			var r_label:TaskTreeLabelVo;
			for each (var item:TaskTreeLabelVo in arr) {
				if (item.label == task_name) {
					r_label = item;
					is_have = true;
					break;
				}
			}
			if (!is_have) {
				r_label = new TaskTreeLabelVo();
				r_label.label = task_name;
				r_label.children = [];
				arr.push(r_label);
			}
			return r_label;
		}
		
		public function convert_task_str(str:String):String {
			if (null == str) {
				return str;
			}
			while (-1 != str.indexOf(USERNAME_REPLACY)) {
				str = str.replace(USERNAME_REPLACY, SystemDataModel.roleInfo.nickname);
			}
			return str;
		}
		
		private function convert_task_item_info(item:TaskItemInfo):TaskItemInfo {
			if (null == item) {
				return item;
			}
			item.taskUiDes = convert_task_str(item.taskUiDes);
			item.taskRuningDes = convert_task_str(item.taskRuningDes);
			item.taskTaget = convert_task_str(item.taskTaget);
			if (null != item.taskDes) {
				var len:int = item.taskDes.length;
				for (var i:int = 0; i < len; i++) {
					var o_item:TaskTalk = item.taskDes[i] as TaskTalk;
					var o_str:String = o_item.taskDes;
					o_item.taskDes = convert_task_str(o_str);
				}
			}
			return item;
		}
		
		private function convert_task_list(tasks:Array):Array {
			if (null == tasks) {
				return tasks;
			}
			for each (var item:TaskItemInfo in tasks) {
				convert_task_item_info(item);
			}
			return tasks;
		}
		
		private function faultHandler(e:Object):void {
		
		}
		
		public function get npc_id():int {
			return _npc_id;
		}
		
		public function get npc_img():int {
			return _npc_img;
		}
		
		public function get task_info():TaskItemInfo {
			return _task_info;
		}
		
		public function get npc_name():String {
			return _npc_name;
		}
		
		public function get npc_word():String {
			return _npc_word;
		}
		
		public function get cur_task_list_type():int {
			return _cur_task_list_type;
		}
		
		public function get cur_task_list():Array {
			return _cur_task_list;
		}
		
		public function get npc_task_list():Array {
			return _task_npc_list;
		}
		
		public function get acceptable_task_list():Array {
			return _acceptable_task_list;
		}
		
		public function get trac_cur_tasks():Array {
			return _trac_cur_tasks;
		}
		
		public function get trac_accepted_tasks():Array {
			return _trac_accepted_tasks;
		}
		
		public function get trac_cur_pos():Array {
			return _trac_cur_pos;
		}
		
		public function get trac_accepted_pos():Array {
			return _trac_accepted_pos;
		}
	
	}

}

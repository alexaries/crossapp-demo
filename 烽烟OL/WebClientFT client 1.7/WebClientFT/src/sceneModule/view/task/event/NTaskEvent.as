package sceneModule.view.task.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NTaskEvent extends Event 
	{
		//刷新npc任务信息 {npc_id:xxx}
		public static const NTaskEvent_REFRESH_NPC_TASK:String = "NTaskEvent_REFRESH_NPC_TASK";
		//获取npc任务信息后刷新页面
		public static const NTaskEvent_REFRESH_NPC_VIEW:String = "NTaskEvent_REFRESH_NPC_VIEW";
		
		//刷新任务菜单界面数据
		public static const NTaskEvent_REFRESH_MENU_VIEW:String = "NTaskEvent_REFRESH_MENU_VIEW";
		//刷新任务菜单界面
		public static const NTaskEvent_REFRESH_MENU_SHOW:String = "NTaskEvent_REFRESH_MENU_SHOW";
		//刷新当前人物界面
		public static const NTaskEvent_REFRESH_CUR_CARD_SHOW:String = "NTaskEvent_REFRESH_CUR_CARD_SHOW";
		
		//刷新任务追踪
		public static const NTaskEvent_REFRESH_TRAC:String = "NTaskEvent_REFRESH_TRAC";
		
		//大地图中走到指定的地图
		public static const NTaskEvent_WORD_MAP_GO_TO:String = "NTaskEvent_WORD_MAP_GO_TO";
		//切换到某个城镇
		public static const NTaskEvent_Enter_City:String = "NTaskEvent_Enter_City";
		//打开某个副本选择界面
		public static const NTaskEvent_Enter_FB_CHOSE:String = "NTaskEvent_Enter_FB_CHOSE";
		//打开某个副本组
		public static const NTaskEvent_Open_FB_Group:String = "NTaskEvent_Open_FB_Group";
		
		//切换任务追踪到当前任务
		public static const NTaskEvent_CHANGE_TRAC_CUR:String = "NTaskEvent_CHANGE_TRAC_CUR";
		//切换任务追踪到可接任务
		public static const NTaskEvent_CHANGE_TRAC_ACCEPT:String = "NTaskEvent_CHANGE_TRAC_ACCEPT";
		
		//滚动显示任务奖励
		public static const NTaskEvent_SHOE_PRICE:String = "NTaskEvent_SHOE_PRICE";
		
		
		//关闭npc对应的窗口
		public static const NTaskEvent_CLOSE_PARENT:String = "NTaskEvent_CLOSE_PARENT";
		
		
		private var _obj:Object;
		
		public function NTaskEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = obj;
			super(type, bubbles, cancelable);
		}
		
		public function get obj():Object 
		{
			return _obj;
		}
		
	}

}
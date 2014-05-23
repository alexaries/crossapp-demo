package event
{
	import flash.events.Event;
	
	public class GuidClearEvent extends Event
	{
		public static const GuidClearEvent_EVENT:String = "GuidClearEvent_EVENT";
		
		//npc商店关闭界面
		public static const NPC_SHOP_CLOSE:int = 1;
		//关闭主菜单
		public static const MAIN_MENU:int = 2;
		//关闭副本选择界面
		public static const FB_CHOSE:int = 3;
		//切换模块
		public static const CHANGE_MODEL:int = 4;
		//关闭强化界面
		public static const QIANGHUA:int = 5;
		//打开弹出界面
		public static const MAIN_UI_ALERT:int = 6;
		//断开连接
		public static const SOCKET_CLOSE:int = 7;
		//切换主菜单ui
		public static const UI_CHANGE:int = 8;
		//关闭任务界面
		public static const NPC_TASK_UI:int = 9;
		//进入殖民战
		public static const INTER_ZHIMIN_BAT:int = 10;
		//关闭创建军团界面
		public static const CLOSE_UNION_CREATE_WINDOW:int = 11;
		//关闭战斗界面
		public static const CLOSE_FIGHT_JIANGLI:int = 12;
		//进入战斗
		public static const INTO_FIGHT:int = 13;
		//关闭翻牌子
		public static const CLOSE_FANPAIZI:int = 14;
		//关闭阵营选择界面
		public static const CLOSE_UNION_ZHENYING:int = 15;
		//关闭侵略界面
		public static const CLOSE_QINLUE:int = 16;
		//关闭侵略结果_成功界面
		public static const CLOSE_QINLUE_JIEGUO_CHENGGONG:int = 17;
		//关闭侵略结果_失败界面
		public static const CLOSE_QINLUE_JIEGUO_SHIBAI:int = 18;
		
		private var _etype:int;
		public function GuidClearEvent(etype:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_etype = etype;
			super(GuidClearEvent_EVENT, bubbles, cancelable);
		}
		
		public function get etype():int 
		{
			return _etype;
		}
	}
}
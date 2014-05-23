package sceneModule.view.corps.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NCropsEvent extends Event 
	{
		public static const EVENT_Crops_REFRESH:String = "EVENT_Crops_REFRESH";
		public static const EVENT_Crops_VIEW_IN_REFRESH:String = "EVENT_Crops_VIEW_IN_REFRESH";
		public static const EVENT_Crops_VIEW_OUT_REFRESH:String = "EVENT_Crops_VIEW_OUT_REFRESH";
		
		public static const EVENT_Crops_TAB_BAR:String = "EVENT_Crops_TAB_BAR";
		
		public static const EVENT_Crops_SHOW_UNIONT_INFO:String = "EVENT_Crops_SHOW_UNIONT_INFO";
		//显示加入军团对话框
		public static const EVENT_Crops_JOIN_UNION:String = "EVENT_Crops_JOIN_UNION";
		//隐藏加入军团对话框
		public static const EVENT_Crops_REMOVE_JOIN_UNION:String = "EVENT_Crops_REMOVE_JOIN_UNION";
		//隐藏创建军团对话框
		public static const EVENT_Crops_REMOVE_CREATE_UNION:String = "EVENT_Crops_REMOVE_CREATE_UNION";
		//确定创建军团
		public static const EVENT_Crops_SEND_CREATE_UNION:String = "EVENT_Crops_SEND_CREATE_UNION";
		
		//刷新申请列表界面
		public static const EVENT_Crops_REFRESH_REQUEST_VIEW:String = "EVENT_Crops_REFRESH_REQUEST_VIEW";
		//刷新成员列表界面
		public static const EVENT_Crops_REFRESH_MEMBER_VIEW:String = "EVENT_Crops_REFRESH_MEMBER_VIEW";
		//刷新军徽界面
		public static const EVENT_Crops_REFRESH_Emblem_VIEW:String = "EVENT_Crops_REFRESH_Emblem_VIEW";
		//刷新科技界面
		public static const EVENT_Crops_REFRESH_Keji_VIEW:String = "EVENT_Crops_REFRESH_Keji_VIEW";
		
		//接受申请加入军团
		public static const EVENT_Crops_ACCEPT_REQUEST:String = "EVENT_Crops_ACCEPT_REQUEST";
		//拒绝申请加入军团
		public static const EVENT_Crops_REJEST_REQUEST:String = "EVENT_Crops_REJEST_REQUEST";
		
		//点击移交团长
		public static const EVENT_Crops_MEMBER_GIVE_LEADER:String = "EVENT_Crops_MEMBER_GIVE_LEADER";
		//点击查看资料
		public static const EVENT_Crops_MEMBER_LOOK:String = "EVENT_Crops_MEMBER_LOOK";
		//给成员发送邮件
		public static const EVENT_Crops_MEMBER_SEND_MAIL:String = "EVENT_Crops_MEMBER_SEND_MAIL";
		//给成员私聊
		public static const EVENT_Crops_MEMBER_CHAT:String = "EVENT_Crops_MEMBER_CHAT";
		//将成员踢出军团
		public static const EVENT_Crops_MEMBER_REMOVE:String = "EVENT_Crops_MEMBER_REMOVE";
		
		//关闭修改军号界面
		public static const EVENT_Crops_REMOVE_CHANGE_JUNHAO:String = "EVENT_Crops_REMOVE_CHANGE_JUNHAO";
		//确认修改军号
		public static const EVENT_Crops_ON_CHANGE_JUNHAO:String = "EVENT_Crops_ON_CHANGE_JUNHAO";
		//点击军团科技项
		public static const EVENT_Crops_ON_CLICK_KEJI_ITEM:String = "EVENT_Crops_ON_CLICK_KEJI_ITEM";
		//移除捐献界面
		public static const EVENT_Crops_REMOVE_JUANXIAN:String = "EVENT_Crops_REMOVE_JUANXIAN";
		//确认捐献
		public static const EVENT_Crops_ON_JUANXIAN:String = "EVENT_Crops_ON_JUANXIAN";
		
		//确认修改公告
		public static const EVENT_Crops_ON_CHANGE_GONGGAO:String = "EVENT_Crops_ON_CHANGE_GONGGAO";
		
		//军团查看界面,点击功能按钮
		public static const EVENT_Crops_ON_UNION_INFO_FUN_BTN:String = "EVENT_Crops_ON_UNION_INFO_FUN_BTN";
		
		//选择阵营结束
		public static const EVENT_Crops_CHOSE:String = "EVENT_Crops_CHOSE";
		
		
		private var _obj:Object;
		
		public function NCropsEvent(type:String, obj:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			_obj = obj;
			super(type, bubbles, cancelable);
		}
		
		public function get obj():Object{
			return _obj;
		}
		
	}

}
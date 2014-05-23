package model
{
	import com.adobe.utils.IntUtil;
	
	public class GuideInfo
	{
		//创建npc
		//[arg1:npcid, arg2:可接任务id]
		public static const TYPE_CREATE_NPC:int = 1;
		//打开ui
		//[arg1:ui类型, arg2:可接任务id, arg3:已接任务id, arg4:对话任务id, arg5:完成的任务id]
		public static const TYPE_OPEN_UI:int = 2;
		//内部操作
		//[arg1:操作类型, arg2:上一个指引id, arg3:打开的副本组id]
		public static const TYPE_ACTION_EXCUTE:int = 3;
		//检测当前任务信息
		//[arg1:可接任务id, arg2:当前任务id, arg3:完成的任务id, arg4:npcid, arg5:场景id]
		public static const TYPE_CHECH_TASK:int = 4;
		//切换场景
		public static const TYPE_CHANGE_SCENE:int = 5;
		//双层页面
		//[arg1:ui类型, arg2:可接任务id, arg3:已接任务id, arg4:对话任务id, arg5:完成的任务id]
		public static const SECOND_SCENE:int = 6;
		
		
		//ui类型
		//npc任务界面
		public static const UI_TYPE_NPC_TASK:int = 1;
		//主菜单人物界面
		public static const UI_TYPE_MAIN_PLAYER:int = 2;
		//打开副本选择界面
		public static const UI_FU_CHOSE:int = 3;
		//打开强化界面
		public static const UI_QIANGHUA:int = 4;
		//打开技能界面
		public static const UI_SKILL:int = 5;
		//打开军团页面
		public static const UI_JUNTUAN:int = 6;
		//打开创建军团页面
		public static const UI_CREATE_UNION:int = 7;
		//打开结算界面
		public static const UI_FIGHT_JIESUAN:int = 8;
		//打开翻牌子
		public static const UI_FIGHT_FANPAIZI:int = 9;
		//打开再次征战副本
		public static const UI_FIGHT_AGAIN:int = 10;
		//打开宠物界面
		public static const UI_PET:int = 11;
		//打开场景地图
		public static const UI_SCENE_MAP:int = 12;
		//打开世界地图
		public static const UI_MAP_SCENE:int = 13;
		//打开军团阵营选择
		public static const UI_UNION_ZHENYING_CHOSE:int = 14;
		//打开商店界面
		public static const UI_SHANGDIAN:int = 15;
		//打开侵略界面
		public static const UI_QINLUE:int = 16;
		//打开侵略结果_成功界面
		public static const UI_QINGLUE_JIEGUO_CHENGGONG:int = 17;
		//打开侵略结果_失败界面
		public static const UI_QINGLUE_JIEGUO_SHIBAI:int = 18;
		//打开酒馆界面
		public static const UI_JIUGUAN:int = 19;
		//确认神格激活界面
		public static const UI_QUEREN_SHENGGE:int = 20;
		//第二次侵略点击界面
		public static const UI_SENCOND_QINGLUE:int = 21;
		//打开官爵界面
		public static const UI_GUANJUE:int = 22;
		//打开威望任务界面
		public static const UI_WEIWANG:int = 23;
		//关闭神di页面
		public static const CLOSE_SHENGDI:int = 25;
		//打开铁矿洞页面
		public static const UI_TIEKUANGDONG:int = 26;
		
		
		
		
		//操作类型
		//点击NPC任务条目
		public static const ACTION_TASK_ITEM_CLICK:int = 1;
		//接受任务成功
		public static const ACTION_ACCEPT_TASK_OK:int = 2;
		//穿装备
		public static const ACTION_ADD_EQUIP:int = 3;
		//打开副本组
		public static const ACTION_OPEN_FB_GROUP:int = 4;
		//放入强化物品
		public static const ACTION_PUT_QIANGHUA_ITEM:int = 5;
		//执行强化操作
		public static const ACTION_EXCUTE_QIANGHUA:int = 6;
		//扩展背包提示
		public static const ACTION_ALERT_OPEN_PACKAGE:int = 7;
		//扩展背包成功
		public static const ACTION_BIG_PACKAGE_OK:int = 8;
		//关闭扩展背包提示
		public static const ACTION_ALERT_CLOSE_PACKAGE:int = 9;
		//切换到奖励界面
		public static const ACTION_NPC_PRIVE_UI:int = 10;
		//激活技能
		public static const ACTION_SKILL_ACTIVE:int = 11;
		//装备技能
		public static const ACTION_SKILL_ENABLE:int = 12;
		//进入立刻布阵
		public static const ACTION_LIKE_BUZHEN:int = 13;
		//选择阵法
		public static const ACTION_XUANZE_ZHENFA:int = 14;
		//宠物拖动到阵法
		public static const ACTION_DROP_PET:int = 15;
		//启动阵法
		public static const ACTION_QIYONG_ZHENFA:int = 16;
		//准备强化完成
		public static const ACTION_ZHUNBEI_QIANGHUA:int = 17;
		//创建军团输入军团名称
		public static const ACTION_INPUT_UNION_NAME:int = 18;
		//创建军团成功
		public static const ACTION_CREATE_UNION_OK:int = 19;
		//获得宠物
		public static const ACTION_GET_PET:int = 20;
		//领取俸禄
		public static const ACTION_GET_FENGLU:int = 21;
		//宠物图鉴
		public static const ACTION_GET_TUJIAN:int = 22;
		//宠物布阵
		public static const ACTION_GET_BUZHEN:int = 23;
		//激活神格
		public static const ACTION_JIHUO_SHENGGE:int = 24;
		//关闭官爵页面
		public static const CLOSE_GUANJUE:int = 25;
		//殖民选择
		public static const CHOOSE_ZHIMING:int = 27;
		//关闭铁矿洞
		public static const CLOSE_TIEKUANGDONG:int = 28;
		//关闭神格
		public static const CLOSE_SHENGGE:int = 29;
		//宠物培养标签
		public static const PET_PEIYANG:int = 30;
		//培养宠物
		public static const PET_PEIYANG_ACTION:int = 31;
		//关闭宠物培养
		public static const CLOSE_PEIYANG:int = 32;
		//宠物培养-替换
		public static const PEI_TIHUAN:int = 33;
		//单击选择装备——镶嵌
		public static const XQ_CHOOSEPACK:int = 34;
		//拖动宝石——镶嵌
		public static const XQ_CHOOSEBAO:int = 35;
		//关闭强化页面
		public static const CLOSE_STRENG:int = 36;
		//点击双枪竞技
		public static const UI_JINGJI:int = 37;
		//探宝页面
		public static const UI_TANBAO:int = 38;
		//合成页面
		public static const UI_HECHENG:int = 39;
		//宠物传承页面
		public static const UI_PEI_CHUANGCHENG:int = 40;
		
		
		
		//显示类型
		//ui层
		public static const SHOW_UI:int = 1;
		//场景层
		public static const SHOW_SCENE:int = 2;
		//指向背包里的装备
		public static const SHOW_PACKAGE:int = 3;
		//指向背包的扩展背包
		public static const SHOW_EXCLUDE_PACKAGE:int = 4;
		//指向任务追踪的某条任务
		public static const SHOW_TASK_TRAC:int = 5;
		//指向主菜单
		public static const SHOW_MAIN_MENU:int = 6;
		//指向任务界面
		public static const SHOW_TASK:int = 7;
		//指向宠物布阵
		public static const SHOW_PET:int = 8;
		//指向装备强化按钮
		public static const SHOW_STRENG_MENU:int = 9;
		
		
		//显示的额外操作
		//空操作
		public static const SHOW__SBLANK:int = 0;
		//切换任务追踪到当前任务
		public static const SHOW__CHANGE_TASK_TRACK_CUR:int = 1;
		//切换任务追踪到可接任务
		public static const SHOW__CHANGE_TASK_TRACK_ACCEPT:int = 2;
		
		
		//触发类型
		private var _id:int;
		private var _type:int;
		private var _pos_x:int;
		private var _pos_y:int;
		private var _arg1:*;
		private var _arg2:*;
		private var _arg3:*;
		private var _arg4:*;
		private var _arg5:*;
		private var _arg6:*;
		private var _targetid:int;
		private var _show_contain_type:int;
		private var _show_arg:int;
		private var _label:int;
		private var _mask_w:int;
		private var _mask_h:int;
		private var _asset_name:String;
		private var _label_str:String;
		private var _tips_str:String;
		private var _tipx:int;
		private var _tipy:int;
		
		public function GuideInfo()
		{
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get pos_x():int 
		{
			return _pos_x;
		}
		
		public function set pos_x(value:int):void 
		{
			_pos_x = value;
		}
		
		public function get pos_y():int 
		{
			return _pos_y;
		}
		
		public function set pos_y(value:int):void 
		{
			_pos_y = value;
		}
		
		public function get arg1():* 
		{
			return _arg1;
		}
		
		public function set arg1(value:*):void 
		{
			_arg1 = value;
		}
		
		public function get arg2():* 
		{
			return _arg2;
		}
		
		public function set arg2(value:*):void 
		{
			_arg2 = value;
		}
		
		public function get arg3():* 
		{
			return _arg3;
		}
		
		public function set arg3(value:*):void 
		{
			_arg3 = value;
		}
		
		public function get arg4():* 
		{
			return _arg4;
		}
		
		public function set arg4(value:*):void 
		{
			_arg4 = value;
		}
		
		public function get arg5():* 
		{
			return _arg5;
		}
		
		public function set arg5(value:*):void 
		{
			_arg5 = value;
		}
		
		public function get show_contain_type():int 
		{
			return _show_contain_type;
		}
		
		public function set show_contain_type(value:int):void 
		{
			_show_contain_type = value;
		}
		
		public function get asset_name():String 
		{
			return _asset_name;
		}
		
		public function set asset_name(value:String):void 
		{
			_asset_name = value;
		}
		
		public function get targetid():int 
		{
			return _targetid;
		}
		
		public function set targetid(value:int):void 
		{
			_targetid = value;
		}
		
		public function get show_arg():int 
		{
			return _show_arg;
		}
		
		public function set show_arg(value:int):void 
		{
			_show_arg = value;
		}
		
		public function get arg6():* 
		{
			return _arg6;
		}
		
		public function set arg6(value:*):void 
		{
			_arg6 = value;
		}
		
		public function get label():int 
		{
			return _label;
		}
		
		public function set label(value:int):void 
		{
			_label = value;
		}
		
		public function get mask_w():int 
		{
			return _mask_w;
		}
		
		public function set mask_w(value:int):void 
		{
			_mask_w = value;
		}
		
		public function get mask_h():int 
		{
			return _mask_h;
		}
		
		public function set mask_h(value:int):void 
		{
			_mask_h = value;
		}
		
		public function get label_str():String 
		{
			return _label_str;
		}
		
		public function set label_str(value:String):void 
		{
			_label_str = value;
		}
		
		public function get tips_str():String 
		{
			return _tips_str;
		}
		
		public function set tips_str(value:String):void 
		{
			_tips_str = value;
		}
		
		public function get tipx():int 
		{
			return _tipx;
		}
		
		public function set tipx(value:int):void 
		{
			_tipx = value;
		}
		
		public function get tipy():int 
		{
			return _tipy;
		}
		
		public function set tipy(value:int):void 
		{
			_tipy = value;
		}
	}
}
package model
{
	/**
	 * 此类用来保存一些URL的常量 
	 * @author mutou
	 * 
	 */	
	public class URLConst
	{
		public function URLConst()
		{
		}
		/**
		 * Socket host 
		 */		
		public static const SOCKET_SERVER_HOST:String = "192.168.1.116";
		/**
		 * Socket server point 
		 */		
		public static const SOCKET_SERVER_POINT:int = 11009; 
		/**
		 * 角色动画URL
		 * 
		 */
		public static const ROLE_ANIMATION_URL:String ="assets/swf/roleAnimation.swf";
		/**
		 * 角色弓箭手动画URL
		 * 
		 */
		public static const GJS_ANIMATION_URL:String = "assets/swf/gongjianshou.swf";
		/**
		 * 牧师
		 */
		public static const PASTOR_ANIMATION_URL:String="assets/swf/mushi.swf";
		/**
		 * 法师
		 */
		public static const MAGE_ANIMATION_URL:String = "assets/swf/mage.swf";
		/**
		 * 游侠
		 * 
		 */
		public static const RANGER_ANIMATION_URL:String = "assets/swf/youxia.swf";
		/**
		 * 战士
		 */
		public static const WARRIOR_ANIMATION_URL:String = "assets/swf/zhanshi.swf";
		/**
		 * 注册成功动画
		 */
		public static const REGISTER_ANIMATION_URL:String = "assets/swf/registerAnimation.swf";
		/**
		 * 组队成功
		 */
		public static const GROUP_SUCCESS_ANIMATION_URL:String = "assets/swf/groupAnimation.swf";
		/**
		 * 接受任务
		 */
		public static const ACCESS_TASK_URL:String="assets/swf/accessTask.swf";
		/**
		 * 升级动画
		 */
		public static const LEVEL_UP_URL:String = "assets/swf/levelUp.swf";
		/**
		 * 战斗场景切换动画
		 */
		public static const SWITCH_BATTLEANIMATION_URL:String = "assets/swf/switchBattle.swf";
		/**
		 * 翻牌子特效 
		 */		
		public static const BATTLE_FLIPEFFECT_URL:String = "assets/battle/flipEffect.swf";
		/**
		 * 任务完成
		 */
		public static const TASK_COMPLETE_URL:String = "assets/swf/taskComplete.swf";
		/**
		 * 登陆背景动画URL
		 * 
		 */
		public static const LOGIN_ANIMATION_URL:String = "assets/swf/loginAnimation.swf";
		
		public static const GET_VALIDATE_CODE_URL:String="http://192.168.1.116:11008/validateCode";
		/**
		 * 注册请求URL 
		 */		
		public static const REG_REQUEST_URL:String="http://192.168.1.116:11008/register";
		/**
		 * 登录请求URL 
		 */		
		public static const LOGIN_REQUEST_URL:String="http://192.168.1.116:11008/services";
		/**
		 * 小蓝家Test
		 */
		public static const LOGIN_HOME_URL:String="http://125.34.147.101:11008/services";
		/**
		 * 登录请求的destination 
		 */		
		public static const LOGIN_REQUEST_DESTINATION:String="MeleeService";
		/**
		 * 登陆请求的后台接口
		 */
		public static const LOGIN_REQUEST_FUNCTION:String="loginToServer";
		public static const LOGIN_REQUEST_COMMANDID:int = 101;
		/**
		 * 创建角色后台接口
		 */
		public static const CREATE_ROLE_FUNCTION:String="activeNewPlayer";
		public static const CREATE_ROLE_COMMANDID:int = 102;
		/**
		 * 进入游戏接口
		 * 
		 */
		public static const ENTER_GAME_GUNCTION:String="roleLogin";
		public static const ENTER_GAME_COMMANDID:int = 103;
		/**
		 *删除角色 
		 */	
		public static const DELETE_ROLE_FUNCTION:String = "deleteRole";
		public static const DELETE_ROLE_COMMANDID:int = 104;
		/**
		 * 获取角色信息
		 */
		public static const GET_ROLEINFO_FUNCTION:String="getPlayerInfo";
		public static const GET_ROLEINFO_COMMANDID:int = 201;
		/**
		 * 获取其他玩家信息 
		 */		
		public static const GET_OTHERROLEINFO_COMMANDID:int = 221;
		/**
		 * 添加活力 
		 */		
		public static const ADD_HUOLI_COMMANDID:int = 224;
		/**
		 * 装备物品
		 */
		public static const EQUIP_ROLE_COMMANDID:int = 210;
		/**
		 * 拆分物品
		 */
		public static const SPLIT_ITEM_COMMANDID:int = 215;
		/**
		 * 丢弃物品
		 */
		public static const DROP_ITEM_COMMANDID:int = 216;
		/**
		 * 扩张背包 
		 */		
		public static const EXPANSION_PACK_COMMANDID:int=223;
		/**
		 * 添加好友
		 */
		public static const ADD_FRIENDS_FUNCTION:String="addPlayerFriend";
		public static const ADD_FRIENDS_COMMANDID:int= 301;
		/**
		 * 获取好友信息
		 */
		public static const GET_PLAYERFRIEND_FUNCTION:String="getPlayerFrinds";
		public static const GET_PLAYERFRIEND_COMMANDID:int= 302;
		/**
		 * 获取黑名单信息
		 */
		public static const GET_BLACKPLAYER_FUNCTION:String="getBlackPlayer";
		public static const GET_BLACKPLAYER_COMMANDID:int= 300;
		/**
		 * 搜索好友 
		 */		
		public static const SEARCH_FRIENDS_COMMANDID:int=305;
		/**
		 * 举报
		 */
		public static const REPORT_FRIENDS_COMMANDID:int = 306;
		/**
		 * 上线提示
		 */
		public static const FRIEND_LOADGAMESHOWMES_COMMANDID:int = 307;
		
		//有人添加自己有好友
		public static const FRIEND_ADD_SELF:int = 308;
		//更改心情
		public static const FRIEND_CHANGE_STATE:int = 309;
		//好友升级广播
		public static const FRIEND_NOTIFY_LEVEL_UP:int = 310;
		//好友升级回复
		public static const FRIEND_REQUEST_LEVEL_UP_REPLY:int = 311;
		
		
		/**
		 * 获取邮件列表信息
		 */
		public static const GET_MAILLIST_COMMANDID:int=501;
		/**
		 * 添加邮件
		 */
		public static const ADD_MAIL_COMMANDID:int=502;
		/**
		 * 保存删除邮件
		 */
		public static const DELETE_MAIL_COMMANDID:int=503;
		/**
		 * 有新邮件通知
		 */
		public static const MAIL_ARRIVED_COMMANDID:int = 504;
		/**
		 * 查看邮件详细信息
		 */
		public static const MAIL_GETINFO_COMMANDID:int = 505;
		/**
		 * 新邮件 
		 */		
		public static const MAIL_NEW_COMMANDID:int = 506;
		/**
		 * 开始训练
		 */
		public static const LOBBY_OPERATE_FUNCTION:String="lobbyOperate";
		public static const LOBBY_OPERATE_COMMANDID:int= 401;
		/**
		 * 终止训练
		 */
		public static const TERMINATE_LOBBY_FUNCTION:String="terminateLobbyOperation";
		public static const TERMINATE_LOBBY_COMMANDID:int = 402;
		/**
		 * 修炼
		 */
		public static const PRACTIEC_FUNCTION:String="pratice";
		public static const PRACTIEC_COMMANDID:int= 403;
		/**
		 * 终止修炼
		 */
		public static const TERMINATE_PRACTIEC_FUNCTION:String="terminatePractice";
		public static const TERMINATE_PRACTIEC_COMMANDID:int = 404;
		/**
		 * 立即完成修炼
		 */
		public static const IMMEDIATEFINISH_PRACTIEC_FUNCTION:String="immediateFinishPractice";
		public static const IMMEDIATEFINISH_PRACTIEC_COMMANDID:int=405;
		/**
		 * 删除好友
		 */
		public static const REMOVE_FRIEND_FUNCTION:String="removePlayerFriend";
		public static const REMOVE_FRIEND_COMMANDID:int = 303;
		/**
		 * 扩展玩家好友数量上限
		 */
		public static const EXPAND_FRIEND_FUNCTION:String="expandPlayerFriendCount";
		public static const EXPAND_FRIEND_COMMANDID:int = 304;
		/**
		 * 获取仓库信息
		 */
		public static const GET_WAREHOUSE_FUNCTION:String="getWarehouseInfo";
		public static const GET_WAREHOUSE_COMMANDID:int = 202;
		/**
		 * 获取角色装备
		 */
		public static const GET_ROLEITEM_FUNCTION:String="getItemsInEquipSlot";
		public static const GET_ROLEITEM_COMMANDID:int=203;
		/**
		 * 存款
		 */
		public static const DEPOSIT_MOENY_FUNCTION:String="depositMoney";
		
		/**
		 * 获取角色物品
		 */
		public static const GET_ITEMINPACKAGE_FUNCTION:String="getItemsInPackage";
		public static const GET_ITEMINPACKAGE_COMMANDID:int= 204;
		/**
		 * 获取玩家临时包裹栏中的物品
		 */
		public static const GET_ITEMSINTEMPPACKAGE_FUNCTION:String="getItemsInTempPackage";
		public static const GET_ITEMSINTEMPPACKAGE_COMMANDID:int = 205;
		
		/**
		 * 获取商店信息
		 */
		public static const GET_SHOPINFO_FUNCTION:String="getShopInfo";
		public static const GET_SHOPINFO_COMMANDID:int= 206;
		/**
		 *获取商城信息 
		 */		
		public static const GET_MALLSHOP_COMMANDID:int=208;
		/**
		 * 角色信息改变
		 */
		public static const ROLE_CHANGE_COMMANDID:int = 209;
		/**
		 * 角色升级
		 */
		public static const ROLE_LEVELUP_COMMANDID:int = 218;
		/**
		 * 商店的购买或购回
		 */
		public static const NPCSHOP_BUYORBACKBUY_COMMANDID:int = 219;
		/**
		 * 商店出售
		 */
		public static const NPCSHOP_SELL_COMMANDID:int = 220;
		/**
		 * 获取商城
		 */
		public static const GET_SHOP_ITEM:int = 214;
		/**
		 * 获取Npc商店
		 */
		public static const GET_NPCSHOP_ITEM:int = 213;
		/**
		 * 卸载装备
		 */
		public static const UNLOAD_EQUIPMENT_COMMANDID:int = 211;
		/**
		 * 移动物品
		 */
		public static const MOVE_ITEM_COMMANDID:int = 212;
		/**
		 * 整理背包
		 */
		public static const ARRANGE_PACK_COMMANDID:int = 217;
		/**
		 * Buff列表信息 
		 */		
		public static const BUFFLIST_INFO_COMMANDID:int = 222;
		/**
		 * 
		 */
		public static const MOVE_PALCE_FUNCTION:String="moveInScene";
		/**
		 * 获取宿屋的信息
		 */
		public static const GET_RESTROOM_FUNCTION:String="getRestRoomInfo";
		public static const GET_RESTROOM_COMMANDID:int=406;
		/**
		 * 操作宿屋
		 */
		public static const REST_OPERATE_FUNCTION:String="restOperate";
		public static const REST_OPERATE_COMMANDID:int=407;
		/**
		 * 发送消息
		 */
		public static const SEND_MESSAGE_FUNCTION:String="chatConnecting";
		/**
		 * 获取合成屋信息
		 */
		public static const SET_SYNTHETIC_ITEM_FUNCTION:String="setSyntheticItem";
		/**
		 * 立即刷新商店信息
		 */
		public static const REFRESH_SHOPINFO_FUNCTION:String="immediateRefreshShopItems";
		public static const REFRESH_SHOPINFO_COMMANDID:int= 207;
		/**
		 * 自动刷新商店信息
		 */
		public static const AUTO_REFRESH_SHOPINFO_FUNCTION:String="refreshShopItems";
		/**
		 * 请求验证常量
		 */		
		public static const LOGIN_REQUEST_VALIDATE_STR:String="correct";
		
		/**
		 * enterPlace
		 * 进入指定场景，获取该场景信息 
		 */		
		public static const ENTER_PLACE_FUNCTION:String="enterPlace";
		public static const ENTER_PLACE_COMMANDID:int=601;
		
		public static const PLAYER_LOCATION_COMMANDID:int=602;
		
		public static const MOVE_INSCENE_COMMANDID:int=603;
		
		/**
		 * 从场景移除玩家
		 */
		public static const REMOVE_PLAYERFROMPLACE_COMMANDID:int=604;
		/**
		 * 监听服务器的场景切换指令
		 */
		public static const ADDEVENTLISTER_CHANGESCENE_COMMANDID:int = 605;
		
		
		
		//申请场景实体列表
		public static const SCENE_REQUEST_ENTITY_LIST:int = 606;
		//主控角色请求移动
		public static const SCENE_REQUEST_HEARO_MOVE:int = 607;
		//创建实体广播
		public static const SCENE_NOTIFY_CREATE_ENTITY:int = 608;
		//销毁实体广播
		public static const SCENE_NOTIFY_REMOVE_ENTITY:int = 609;
		//实体移动
		public static const SCENE_NOTIFY_ENTITY_MOVE:int = 610;
		//实体属性刷新
		public static const SCENE_NOTIFY_REFRESH_ENTITY_PROPERTY:int = 611;
		
		/**
		 *战斗 
		 */	
		public static const BATTLE_INIT_COMMANDID:int=702;
		/**
		 * 跟怪物战斗
		 */
		public static const BATTLE_MONSTER_COMMANDID:int=703;
		
		/**
		 * 退出战斗
		 */
		public static const QUIT_BATTLE_COMMANDID:int=704;
		/**
		 * 获取战后结算物品信息
		 */
		public static const GET_BATTLE0VER_ITEMINFO_COMMANDID:int=705;
		/**
		 * 发送选择牌子
		 */
		public static const SEND_SELECTEDITEM_COMMANDID:int=706;
		/**
		 * 服务器发送过来的翻牌请求
		 */
		public static const TURN_ITEM_COMMANDID:int=707;
		/**
		 * 翻所有牌子
		 */
		public static const TURN_ALLITEM_COMMANDID:int=708;
		/**
		 * 显示翻牌子界面
		 */
		public static const SHOW_BATTLECOMP_COMMANDID:int = 709;
		/**
		 * 服务器进入战斗的指令
		 */
		public static const ENTERBATTLE_SERVER_COMMANDID:int = 711;
		/**
		 * 殖民战指令
		 */
		public static const BATTLE_COLONIZATION_COMMANDID:int = 712;
		/**
		 * 退出殖民战
		 */
		public static const BATTLE_ESCCOL_COMMANDID:int = 713;
		
		//场景pk
		public static const BATTLE_SCENE_PK_COMMANDID:int = 720;
		/**
		 * 获取技能数列表 
		 */		
		public static const SKILL_GETINFO_COMMANDID:int = 801;
		/**
		 * 升级技能 
		 */		
		public static const SKILL_LEVELUP_COMMANDID:int = 802;
		/**
		 * 激活技能 
		 */		
		public static const SKILL_ACTIVATION_COMMANDID:int = 803;
		/**
		 * 获取角色战斗技能 
		 */		
		public static const SKILL_ROLESELF_COMMANDID:int = 804;
		/**
		 * 装载技能 
		 */		
		public static const SKILL_LOAD_COMMANDID:int = 805;
		/**
		 * 卸载技能 
		 */		
		public static const SKILL_UNLOAD_COMMANDID:int = 806;
		/**
		 * 打开未开放的技能栏 
		 */		
		public static const SKILL_OPENCLOCK_COMMANDID:int = 807;
		
		/**
		 *邀请组队
		 */		
		public static const INVITED_GROUP_COMMANDID:int=902;
		/**
		 * 被邀请组队请求
		 * 
		 */
		public static const PUSHINVITED_GROUP_COMMANDID:int=901;
		/**
		 * 接受组队邀请
		 * 
		 */
		public static const AGREE_INVITEGROUP_COMMANDID:int=903;
		/**
		 * 拒绝组队邀请
		 * 
		 */
		public static const REJECT_INVITEGROUP_COMMANDID:int=904;
		/**
		 * 拒绝组队邀请服务器广播消息
		 * 
		 */
		public static const REJECT_SERVERINFO_COMMANDID:int=905;
		/**
		 * 监听服务器返回的组队成员信息
		 */
		public static const TEAM_GROUPINFO_COMMANDID:int=906;
		/**
		 * 聊天服务器
		 */
		public static const CHAT_SERVER_COMMANDID:int=1001;
		/**
		 * 模糊搜索好友
		 */
		public static const CHAT_SEARCHFRI_COMMANDID:int= 1004;
		/**
		 * 喊话 
		 */		
		public static const CHAT_USEITEMHORN_COMMANDID:int=1005;
		/**
		 * 修改聊天系统设置
		 */
		public static const CHAT_MODIFYSETTING_COMMANDID:int= 1006;
		/**
		 * 获取聊天系统设置信息 
		 */		
		public static const CHAT_GETSETTINGINFO_COMMANDID:int= 1007;
		/**
		 * 加点
		 */
		public static const ADD_POINT_COMMANDID:int=1101;
		/**
		 *私聊对象列表 
		 */		
		public static const CHAT_OBJECTLIST_COMMANDID:int = 1010;
		/**
		 *获取某一个私聊对象私聊信息 
		 */		
		public static const CHAT_GETONEOBJINFO_COMMANDID:int = 1011;
		/**
		 *服务器推送的私聊信息 
		 */		
		public static const CHAT_SERVERTOINFO_COMMANDID:int = 1012;
		/**
		 * 发送私聊信息 
		 */		
		public static const CHAT_SENDCHATMESSAGE_COMMANDID:int = 1013;
		/**
		 * 关闭私聊窗口 
		 */		
		public static const CHAT_CLOSECHATWINDOW_COMMANDID:int = 1014;
		/**
		 * 获取拍卖信息
		 */
		public static const COMMISSION_GETINFO_COMMANDID:int = 1201;
		/**
		 *购买拍卖行的物品
		 */
		public static const COMMISSION_BUYITEM_COMMANDID:int = 1202;
		/**
		 * 获取价格走势图数据
		 */
		public static const COMMISSION_GETPRICETRENDS_COMMANDID:int = 1203;
		/**
		 * 获取自己寄卖的信息
		 */
		public static const COMMISSION_GETSELFINFO_COMMANDID:int = 1204;
		/**
		 * 取消物品寄卖
		 */
		public static const CANCEL_ITEMCOMM_COMMANDID:int = 1205;
		/**
		 * 寄卖
		 */
		public static const COMMISSION_SELL_COMMANDID:int = 1206;
		/**
		 * 发公告
		 */
		public static const SEND_SYSTEMINFO_COMMANDID:int = 1210;
		/**
		 * 获取军团列表或搜索军团 
		 */		
		public static const CORPS_GETORSEARCHLIST_COMMANDID:int = 1301;
		/**
		 *创建军团 
		 */		
		public static const CORPS_CREATE_COMMANDID:int = 1302;
		/**
		 * 获取成员列表信息
		 */		
		public static const CORPS_MEMBERORAPPLI_COMMANDID:int = 1303;
		/**
		 * 接受或拒绝入团申请 
		 */		
		public static const CORPS_ACCEPTORREFUSE_COMMANDID:int = 1304;
		/**
		 * 申请或取消申请入团 
		 */		
		public static const CORPS_APPLIORUNSUBSCRIBE_COMMANDID:int = 1305;
		/**
		 * 移交军团长或踢出军团 
		 */		
		public static const CORPS_TRANSFERORKICK_COMMANDID:int = 1306;
		/**
		 * 修改军团公告 
		 */		
		public static const CORPS_MODIFYANNOU_COMMANDID:int = 1307;
		/**
		 * 讨伐军团 
		 */		
		public static const CORPS_CROSADE_COMMANDID:int = 1308;
		/**
		 * 退出军团
		 */		
		public static const CORPS_LEAVE_COMMANDID:int = 1309;
		/**
		 * 获取军徽信息 
		 */		
		public static const CORPS_GETEMBLEMINFO_COMMANDID:int = 1310;
		/**
		 * 升级军徽 
		 */		
		public static const CORPS_LEVELUPEMBLEM_COMMANDID:int = 1311;
		/**
		 * 修改军号 
		 */		
		public static const CORPS_MODIFYBUGLE_COMMANDID:int = 1312;
		/**
		 * 接位 
		 */		
		public static const CORPS_TASKCHIEF_COMMANDID:int = 1313;
		/**
		 * 获取军团科技列表
		 */
		public static const CORPS_TECHNOLOGYLIST_COMMANDID:int = 1314;
		/**
		 * 捐献魔币
		 */
		public static const CORPS_DONATEGOLD_COMMANDID:int = 1315;
		/**
		 * 修改默认捐献 
		 */		
		public static const CORPS_MOFIGYDONATE_COMMANDID:int = 1316;
		/**
		 * 获取申请列表信息
		 */
		public static const CORPS_REQUEST_LIST_COMMANDID:int = 1317;
		
		//邀请他人加入军团
		public static const CORPS_REQUEST_INVITE_OTHER:int = 1318;
		//邀请玩家加入军团广播
		public static const CORPS_NOTIFY_INVITE_PLAYER:int = 1319;
		//邀请加入军团回复
		public static const CORPS_REQUEST_INVITE_REPLY:int = 1320;
		//邀请他人加入军团处理结果广播
		public static const CORPS_NOTIFY_INVITE_BACK:int = 1321;
		//请求军团信息
		public static const CORPS_REQUEST_UNION_INFO:int = 1322;
		//军团升级广播申请
		public static const CORPS_LEVELUP:int = 1323;
		
		public static const CORPS_LEVELUPREQ_COMMANDID:int = 1324;
		
		
		
		/**
		 * 任务
		 * 
		 */
		public static const GETTASK_INFO_COMMANDID:int = 1401;
		/**
		 * 接受任务 
		 */		
		public static const ACCESS_TASK_COMMANDID:int = 1402;
		/**
		 * 提交完成的任务
		 */
		public static const COMMIT_TASK_COMMANDID:int = 1403;
		/**
		 * 任务追踪
		 */
		public static const TASK_RUDE_COMMANDID:int = 1404;
		/**
		 * 获取任务列表
		 */
		public static const GETPROCESS_TASKINFO_COMMANDID:int = 1406;
		/**
		 * 获取可接任务列表
		 */
		public static const GETTASK_CANRECEIVED_COMMANDID:int = 1407;
		/**
		 * NPC状态更改
		 */
		public static const NPC_STATUS_COMMANDID:int = 1408;
		/**
		 * 获取任务的详细信息
		 */
		public static const GETTASK_BASICINFO_COMMANDID:int = 1409;
		
		
		
		
		//new task
		//申请ncp任务信息
		public static const TASK_REQUEST_NCP_TASK_INFO:int = 1410;
		//提交已经完成的任务
		public static const TASK_REQUEST_SUB_TASK:int	= 1411;
		//接受任务
		public static const TASK_REQUEST_ACCEPT_TASK:int = 1412;
		//请求支线任务列表
		public static const TASK_REQUEST_Entrust_TASK_LIST:int = 1413;
		//请求刷新支线任务
		public static const TASK_REQUEST_Entrust_REFRESH_TASK_LIST:int = 1414;
		//请求立即完成某个支线任务
		public static const TASK_REQUEST_Entrust_FORCE_COMPLETE:int = 1415;
		//请求角色已结任务列表
		public static const TASK_REQUEST_PLAYER_TASK_LIST:int = 1416;
		//请求可接任务列表
		public static const TASK_REQUEST_ACCEPT_TASK_LIST:int = 1417;
		//请求放弃任务
		public static const TASK_REQUEST_DROP_TASK:int = 1418;
		//请求完成对话
		public static const TASK_REQUEST_EXCUTE_TALK_TASK:int = 1419;
		//请求更新任务追踪状态
		public static const TASK_RWQUEST_CHANGE_TRACK_STATE:int = 1420;
		//推送任务追踪状态
		public static const TASK_NOTIFY_TRAC_LIST:int = 1421;
		//任务达到完成条件广播
		public static const TASK_NOTIFY_CHANGE_TO_FINISH:int = 1422;
		
		
		
		
		/**
		 * 进入副本
		 */
		public static const ENTER_COPYSCENE_COMMANDID:int = 1501;
		/**
		 * 退出副本
		 */
		public static const ESC_COPYSCENE_COMMANDID:int = 1502;
		/**
		 * 监听进入副本信息
		 */
		public static const ENTERSERVER_COPYSCENE_COMMANDID:int = 1503;
		/**
		 * 确定进入副本
		 */
		public static const SUBMIT_ENTERCOPYSCENE_COMMANDID:int = 1504;
		/**
		 * 再次征战副本
		 */
		public static const SUBMITENTER_COPYSCENE_COMMANDID:int = 1505;
		/**
		 * 获取副本信息 
		 */		
		public static const COPYSCENE_INFO_COMMANDID:int = 1507;
		/**
		 * 获取副本数据
		 */
		public static const GETCOPYSCENE_DATA_COMMANDID:int = 1506;
		/**
		 * 新手引导中的用户名验证
		 */
		public static const GUIDE_VALIDATENAME_COMMANDID:int = 1601;
		/**
		 * 新手注册
		 */
		public static const GUIDE_REGISTER_COMMANDID:int = 1602;
		/**
		 * 从服务器获取临时id
		 */
		public static const GETTEMPID_FROMSERVER_COMMANDID:int = 1603;
		/**
		 * 进行的每一步记录入数据库
		 */
		public static const INSERTSTEP_TOSERVER_COMMANDID:int = 1604;
		/**
		 * 获取商城物品剩余时间
		 */
        public static const GETTIME_SHOP_COMMANDID:int = 1605;
		/**
		 * 获取随即名称
		 */
		public static const GETRANDOMNAME_GUIDE_COMMANDID:int = 1606;
		/**
		 * 死亡消息通知 
		 */		
		public static const DEAD_INFO_COMMANDID:int = 1701;
		/**
		 * 立即复活 
		 */		
		public static const NOW_RESUR_COMMANDID:int = 1702;
		/**
		 * 回城复活 
		 */		
		public static const BACKCITY_RESUR_COMMANDID:int = 1703;
		/**
		 * 索取复活 
		 */		
		public static const QUEST_RESUR_COMMANDID:int = 1704;
		/**
		 * 索取复活监听
		 */
		public static const OTHERROLE_RESUR_COMMANDID:int = 1705;
		/**
		 * 复活同盟玩家
		 */
		public static const RESUR_OTHER_COMMANDID:int = 1706;
		/**
		 * 获取队伍大厅组队信息 
		 */		
		public static const GROUPHALL_GETINFO_COMMANDID:int = 1801;
		/**
		 * 创建队伍 
		 */		
		public static const GROUPHALL_CREATE_COMMANDID:int = 1802;
		/**
		 * 加入队伍 
		 */		
		public static const GROUPHALL_JOIN_COMMANDID:int = 1803;
		/**
		 * 快速加入队伍 
		 */		
		public static const GROUPHALL_FASTJOIN_COMMANDID:int = 1804;
		/**
		 * 获取副本信息
		 */
		public static const GROUPHALL_COPYSCENE_COMMANDID:int = 1805;
		/**
		 * 获取房间角色信息 
		 */		
		public static const GROUPHALL_ROOMROLEINFO_COMMANDID:int = 1806;
		/**
		 * 获取玩家列表 
		 */		
		public static const GROUPHALL_ROLELIST_COMMANDID:int = 1807;
		/**
		 * 邀请入队 
		 */		
		public static const GROUPHALL_INVITEJOINGROUP_COMMANDID:int = 1808;
		/**
		 * 离开房间 
		 */		
		public static const GROUPHALL_LEAVEROOM_COMMANDID:int = 1809;
		/**
		 *邀请加入房间 
		 */		
		public static const GROUPHALL_INVITEJOINROOM_COMMANDID:int = 1810;
		/**
		 *接受邀请加入房间请求 
		 */		
		public static const GROUPHALL_ACCEPTINVITE_COMMANDID:int = 1811;
		/**
		 * 拒绝邀请加入房间请求 
		 */		
		public static const GROUPHALL_REFUSEINVITE_COMMANDID:int = 1812;
		/**
		 * 获取阵法列表信息 
		 */		
		public static const GROUPHALL_MATRIXINFO_COMMANDID:int = 1813;
		/**
		 * 启用阵法 
		 */		
		public static const GROUPHALL_OPENINGMATRIX_COMMANDID:int = 1814;
		/**
		 * 阵法设置成后服务器推送的消息 
		 */		
		public static const GROUPHALL_PUSHMATRIX_COMMANDID:int = 1815;
		/**
		 * 准备或取消准备 
		 */		
		public static const GROUPHALL_READYORCANCEL_COMMANDID:int = 1816;
		/**
		 * 房主开始副本 
		 */		
		public static const GROUPHALL_STARTSCENE_COMMANDID:int = 1817;
		/**
		 * 把角色踢出房间 
		 */		
		public static const GROUPHALL_KICKFROMROOM_COMMANDID:int = 1818;
		/**
		 * 离开大厅
		 */
		public static const GROUPHALL_LEAAVEHALL_COMMANDID:int = 1819;
		/**
		 * 离开房间进入副本 
		 */		
		public static const GROUPHALL_LEAVEROOMENTERSCENE_COMMANDID:int = 1820;
		/**
		 * 获取房间信息 
		 */		
		public static const GROUPHALL_ROOMINFO_COMMANDID:int = 1821;
		/**
		 * 修改房间信息 
		 */		
		public static const GROUPHALL_MODIFYROOMINFO_COMMANDID:int = 1822;
		/**
		 * 判断阵法是否有足够的条件使用
		 */
		public static const GROUPHALL_USEVIPMATRIX_COMMANDID:int = 1823;
		/**
		 * 获取酒店信息 
		 */		
		public static const HOTEL_GETINFO_COMMANDID:int = 1901;
		/**
		 * 使用酒店里的恢复品 
		 */		
		public static const HOTEL_USEITEM_COMMANDID:int = 1902;
		/**
		 * 获取排行榜信息 
		 */		
		public static const RANKING_GETLISTINFO_COMMANDID:int = 2001;
		/**
		 * 获取评分信息 
		 */		
		public static const RANKING_MYSCOREINFO_COMMANDID:int = 2002;
		/**
		 * 获取强化信息 
		 */		
		public static const BLACKSMITH_STRENGTHENINFO_COMMANID:int = 2101;
		/**
		 * 强化
		 */
		public static const BLACKSMITH_STRENGTHEN_COMMANDID:int = 2102;
		/**
		 * 获取祭炼信息 
		 */		
		public static const BLACKSMITH_CASTINGINFO_COMMANDID:int = 2103;
		/**
		 * 祭炼
		 */
		public static const BLACKSMITH_CASTING_COMMANDID:int = 2104;
		/**
		 * 获取合成信息 
		 */		
		public static const BLACKSMITH_SYNTHESISINFO_COMMANDID:int = 2105;
		/**
		 * 合成 
		 */		
		public static const BLACKSMITH_SYNTHESIS_COMMANDID:int = 2106;
		/**
		 * 获取强化背包数据 
		 */		
		public static const BLACKSMITH_PACKAGE_INFO_COMMANDID:int = 2109;
		/**
		 *获取镶嵌背包信息 
		 */		
		public static const BLACKSMITH_XQ_PACK_INFO_COMMANDID:int = 2110;
		/**
		 * 获取镶嵌宝石信息 
		 */		
		public static const BLACKSMITH_XQ_STORE_INFO_COMMANDID:int = 2111;
		/**
		 *  镶嵌
		 */		
		public static const BLACKSMITH_XQ_COMMANDID:int = 2112;
		/**
		 * 卸载镶嵌 
		 */		
		public static const BLACKSMITH_UNLOAD_XQ_COMMANDID:int = 2113;
		/**
		 * 获取合成装备宝石信息 
		 */		
		public static const BLACKSMITH_HECHENG_ALL_COMMANDID:int = 2114;
		/**
		 * 获取单个合成所需的信息 
		 */		
		public static const BLACKSMITH_HECHENG_ONE_COMMANDID:int = 2115;
		/**
		 * 合成 
		 */		
		public static const BLACKSMITH_HECHENG_COMMANDID:int = 2116;
		/**
		 * 获取强化物品强化信息类型
		 */	
		public static const BLACKSMITH_STRENGTHEN_ONE_COMMANDID:int = 2117;
		/**
		 * 属性转移
		 */	
		public static const BLACKSMITH_CHANGEPROP_COMMANDID:int = 2118;
		/**
		 * 确认属性转移
		 */	
		public static const QUEREN_CHANGEPROP_COMMANDID:int = 2119;
		/**
		 * 强化倒计时 
		 */		
		public static const BLACKSMITH_TIME_COMMANDID:int = 2120;
		/**
		 * 清除CD 
		 */		
		public static const BLACKSMITH_CLEAN_CD_COMMANDID:int = 2121;
		/**
		 * 系统消息 
		 */		
		public static const SYSTEMINFO_COMMANDID:int = 2200;
		/**
		 * 获取宠物列表信息 
		 */		
		public static const PET_GETLISTINFO_COMMANDID:int = 2300;
		/**
		 * 激活宠物技能 
		 */		
		public static const PET_ACTIVATIONSKILL_COMMANDID:int = 2301;
		/**
		 * 升级宠物技能 
		 */		
		public static const PET_LEVELUPSKILL_COMMANDID:int = 2302;
		/**
		 * 修改宠物名称 
		 */	
		public static const PET_MODIFYNAME_COMMANDID:int = 2303;
		/**
		 * 培养宠物 
		 */		
		public static const PET_TRAINING_COMMANDID:int = 2304;
		/**
		 * 丢弃宠物 
		 */		
		public static const PET_DROP_COMMANDID:int = 2305;
		/**
		 * 获取宠物系统中德阵法信息 
		 */		
		public static const PET_GETMATRIX_COMMANDID:int = 2306;
		/**
		 * 宠物系统的阵法设置 
		 */		
		public static const PET_SETTINGMATRIX_COMMANDID:int = 2307;
		/**
		 * 启用阵法 
		 */		
		public static const PET_ACTIVATIONMATRIX_COMMANDID:int = 2308;
		/**
		 * 宠物宣言 
		 */		
		public static const PET_MODIFYSLOGAN_COMMANDID:int = 2309;
		
		/**
		 * 修改宠物展示状态
		 */
		public static const PET_MODIFY_STATUS_COMMANDID:int = 2310;
		/**
		 * 查看宠物信息 
		 */		
		public static const PET_VIEWINFO_COMMANDID:int = 2311;
		/**
		 * 维持或替换 
		 */		
		public static const PET_WEI_TI_COMMANDID:int = 2312;
		/**
		 * 获取被传承列表信息 
		 */		
		public static const PET_BEI_CHUAN_COMMANDID:int = 2313;
		/**
		 * 传承 
		 */		
		public static const PET_CHUANGCHENG_COMMANDID:int = 2314;
		/**
		 * 获取宠物图鉴列表信息 
		 */		
		public static const PET_TUJIAN_PET_COMMANDID:int = 2315;
		/**
		 * 获取宠物图鉴单个信息 
		 */		
		public static const PET_ONE_TUJIAN_INFO_COMMANDID:int = 2316;
		/**
		 * 召唤 
		 */		
		public static const PET_ZHAOHUAN_COMMANDID:int = 2317;
		
		
		//地图信息
		//请求场景地图信息
		public static const MAP_REQUEST_SCENE_INFOS:int 	= 2501;
		//请求副本组地图信息
		public static const MAP_REQUEST_INSTANCE_INFOS:int 	= 2502;
		//请求更换本军团势力颜色
		public static const MAP_REQUEST_CHANGE_COLOR:int = 2503;

		/**
		 * 游戏头部系统推送的奖励信息 
		 */		
		public static const REWARD_GAMETOP_COMMANDID:int = 2400;
		/**
		 * 获取奖励信息列表 
		 */		
		public static const REWARD_LISTINFO_COMMANDID:int = 2401;
		/**
		 * 领取单一奖励 
		 */		
		public static const REWARD_OBTAINONE_COMMANDID:int = 2402;
		/**
		 * 领取所有奖励 
		 */		
		public static const REWARD_OBTAINALL_COMMANDID:int = 2403;
		/**
		 * 获取入侵信息 
		 */		
		public static const REWARD_BATTLEINFO_COMMANDID:int = 2404;
		/**
		 * 获取奖励信息
		 */
		public static const REWARD_GETINFO_COMMANDID:int = 2410;
		/**
		 * 领取奖励 
		 */		
		public static const REWARD_OBTAINDAY_COMMAND:int = 2411;
		/**
		 *  获取殖民管理信息
		 */		
		public static const REWARD_COLONI_COMMANDID:int = 2405;
		/**
		 * 激活药剂 
		 */		
		public static const REWARD_ACTIVA_ELI_COMMANDID:int = 2406;
		/**
		 * 获取仓库信息 
		 */		
		public static const CANGKU_INFO_COMMANDID:int = 2407;
		/**
		 * 拾取物品 
		 */		
		public static const OBTAIN_ITEM_COMMANDID:int = 2408;
		/**
		 * 开仓库 
		 */		
		public static const OPEN_CANGKU_COMMANDID:int = 2409;
		/**
		 * 告诉服务器场景模块加载完毕，可以推送消息
		 *  
		 */
		public static const SCENEMODULE_LOADED_TO_SERVER:int = 2600;
		/**
		 * 系统公告 
		 */		
		public static const SYSTEM_INFO_COMMANDID:int = 2700;
		/**
		 * 复活 
		 */		
		public static const RESUR_PET_COMMANDID:int = 2701;
		/**
		 * 获取炼金信息 
		 */		
		public static const TERRITORY_GETLIANJININFO_COMMANDID:int = 2800;
		/**
		 *开始挖掘 
		 */		
		public static const TERRITORY_STARTWUJUE_COMMANDID:int = 2801;
		/**
		 * 点石成金 
		 */		
		public static const TERRITORY_DIANSHICHENGJIN_COMMANDID:int = 2802;
		/**
		 * 钻加速 
		 */		
		public static const TERRITORY_SPEEDUP_COMMANDID:int = 2803;
		/**
		 * 立即完成 
		 */		
		public static const TERRITORY_NOWSUC_COMMANDID:int = 2804;
		/**
		 * 获取军营信息列表 
		 */		
		public static const TERRITORY_ARAM_GETLIST_COMMANDID:int = 2805;
		/**
		 * 开始训练 
		 */		
		public static const TERRITORY_ARAM_STARTXUNLIAN_COMMANDID:int = 2806;
		/**
		 * 加急训练 
		 */		
		public static const TERRITORY_ARAM_JIAJIXUNLIAN_COMMANDID:int = 2807;
		/**
		 * 钻加速 
		 */		
		public static const TERRITORY_ARAM_LEVELUP_COMMANDID:int = 2808;
		/**
		 * 立即完成 
		 */		
		public static const TERRITORY_ARAM_NOWSUC_COMMANDID:int = 2809;
		/**
		 * 系统提醒军团入团申请 
		 */		
		public static const SYSOPE_SHOW_COMMANDID:int = 2900;
		/**
		 * 殖民特权领地列表信息 
		 */		
		public static const COLO_LINGDI_LIST_COMMANDID:int = 2901;
		/**
		 * 殖民特权副本集合信息 
		 */		
		public static const COLO_FUBEN_INFO_COMMANDID:int = 2902;
		/**
		 * 获取副本组殖民信息 
		 */        
		public static const COLO_FUBEN_GROUP_COLO_COMMANDID:int = 2903;
		/**
		 * 领取奖励 新手奖励 
		 */		
		public static const REWARD_OBTAIN_NEW_COMMANDID:int = 3000;
		/**
		 * 日程表任务
		 */		
		public static const CALENDAR_REWARD_NEW_COMMANDID:int = 3100;
		/**
		 * 日程表任务奖励
		 */
		public static const RECEIVED_CALENDAR_BOUNDS_NEW_COMMANDID:int = 3101;
		/**
		 * 开始挂机 
		 */		
		public static const GUAJI_START_COMMANDID:int = 3200;
		/**
		 * 获取挂机信息 
		 */		
		public static const GUAJI_GETINFO_COMMANDID:int = 3201;
		/**
		 * 取消挂机 
		 */		
		public static const GUAJI_CANCEL_COMMANDID:int = 3202;
		/**
		 * 获取每日目标信息 
		 */		
		public static const TARGET_GETINFO_COMMANDID:int = 3203;
		/**
		 * 领取每日目标任务奖励 
		 */		
		public static const TARGET_OBTAIN_REWARD_COMMANDID:int = 3204;
		/**
		 * 扫荡 
		 */		
		public static const GUAJI_SAODANG_COMMANDID:int = 3205;
		
		/**
		 * 获取官爵信息
		 */		
		public static const GUANJUEINFO_COMMANDID:int = 3300;
		/**
		 * 获取官爵信息
		 */		
		public static const SHENGJUE_COMMANDID:int = 3302;
		/**
		 * 领取爵禄
		 */		
		public static const GETJUELU_COMMANDID:int = 3301;
		/**
		 * 声望信息
		 */		
		public static const GETSHNEGWANG_COMMANDID:int = 3303;
		/**
		 * 上交
		 */		
		public static const SHANGJIAO_COMMANDID:int = 3304;
		/**
		 * 确认贡献
		 */		
		public static const QUERENGONGXIAN_COMMANDID:int = 3305;
		/**
		 * 点击贡献获取钻石数量
		 */		
		public static const GETGONGXIANZHUAN_COMMANDID:int = 3306;
		
		/**
		 * 获取官邸信息 
		 */		
		public static const GUANDI_GETINFO_COMMANDID:int = 3400;
		/**
		 * 激活神格 
		 */		
		public static const GUANDI_ACTIVE_SHENGE_COMMANDID:int = 3401;
		/**
		 * 魔兽酒馆信息
		 */		
		public static const MOSHOUJIUGUAN_COMMANDID:int = 3500;
		/**
		 * 雇佣宠物
		 */		
		public static const GUYONGCONGWU_COMMANDID:int = 3501;
		/**
		 * 立即刷新宠物列表
		 */		
		public static const NOWREFRESH_COMMANDID:int = 3502;
		/**
		 * 幸运值兑换
		 */		
		public static const LUCKEXCHANGE_COMMANDID:int = 3503;
		/**
		 * 打对勾屏蔽提示
		 */		
		public static const PINGBIDUIGOU_COMMANDID:int = 3504;
		/**
		 * 获取星运集合信息 
		 */		
		public static const ZHANXING_XINGYUNLIST_INFO_COMMANDID:int = 3600;
		/**
		 * 占星
		 */		
		public static const ZHANXING_ZHANXING_COMMANDID:int = 3601;
		/**
		 *一键获取或一键卖出 
		 */		
		public static const ZHANXING_OBTAIN_DROP_COMMANDID:int = 3602;
		/**
		 * 一键占星 
		 */		
		public static const ZHANXING_YIJIAN_ZHANXING_COMMANDID:int = 3603;
		/**
		 * 获取角色或宠物列表信息 
		 */		
		public static const ZHANXING_PETORROLELIST_COMMANDID:int = 3604;
		/**
		 * 获取背包星运信息 
		 */		
		public static const ZHANXING_XINGYUNPACK_COMMANDID:int = 3605;
		/**
		 *一键合成星运 
		 */		
		public static const ZHANXING_YIJIANHECHENG_COMMANDID:int = 3606;
		/**
		 * 操作星运 
		 */		
		public static const ZHANXING_OPE_XINGYUN_COMMANDID:int = 3607;
		/**
		 * 积分兑换信息
		 */		
		public static const JIFENGEXCHANGE_COMMANDID:int = 3609;
		/**
		 * 确认兑换
		 */		
		public static const QUERENEXCHANGE_COMMANDID:int = 3610;
		/**
		 * 获取竞技信息 
		 */		
		public static const JINGJI_INFO_COMMANDID:int = 3700;
		/**
		 * 竞技冷却时间 
		 */		
		public static const JINGJI_CD_TIME_COMMANDID:int = 3701;
		/**
		 * 竞技排行公告信息 
		 */
		public static const JINGJI_RANKING_COMMANDID:int = 3702;
		/**
		 * 花钱加挑战次数 
		 */		
		public static const JINGJI_ADDCOUNT_COMMANDID:int = 3703;
		/**
		 * 竞技战斗 
		 */		
		public static const JINGJI_BATTLE_COMMANDID:int = 3704;
		/**
		 *清除CD 
		 */		
		public static const JINGJI_CLEAN_CD_COMMANDID:int = 3705;
		/**
		 * VIP信息 
		 */		
		public static const VIP_INFO_COMMANDID:int = 3800;
		/**
		 * VIP自动弹出 
		 */		
		public static const VIP_AUTO_OPEN_COMMANDID:int = 3801;
		/**
		 * GM 
		 */	
		public static const GM_COMMANDID:int = 4000;
		/**
		 *获取攀爬信息 
		 */		
		public static const PANPA_INFO_COMMANDID:int = 4200;
		/**
		 * 祈祷信息 
		 */	
		public static const PRAYINFO_COMMANDID:int = 4100;
		/**
		 *刷新攀爬 
		 */		
		public static const PANPA_REFRESH_COMMANDID:int = 4201;
		/**
		 *自动攀爬 
		 */		
		public static const PANPA_AUTO_COMMANDID:int = 4202;
		/**
		 * 攀爬战斗 
		 */		
		public static const PANPA_BATTLE_COMMANDID:int = 4203;
		/**
		 *获取队伍列表信息 
		 */		
		public static const GROUP_LISTINFO_COMMANDID:int = 4300;
		/**
		 * 创建队伍 
		 */		
		public static const GROUP_CREATE_COMMANDID:int = 4301;
		/**
		 *获取阵法中的队伍信息 
		 */		
		public static const GROUP_MAINFO_COMMANDID:int = 4302;
		/**
		 *加入队伍 
		 */		
		public static const GROUP_JOIN_COMMANDID:int = 4303;
		/**
		 *获取队伍信息 
		 */		
		public static const GROUP_INFO_COMMANDID:int = 4304;
		/**
		 *离开队伍 
		 */		
		public static const GROUP_LEAVE_COMMANDID:int = 4305;
		/**
		 *踢人 
		 */	
		public static const GROUP_TIREN_COMMANDID:int = 4306;
		/**
		 * 多人组队战斗 
		 */		
		public static const GROUP_BATTLE_COMMANDID:int = 4308;
		/**
		 * 获取军团领地信息
		 */		
		public static const GROUPBATTLE_LINGDI_COMMANDID:int = 4400;
		/**
		 *领取奖励 
		 */		
		public static const GROUPBATTLE_OBTAIN_COMMANDID:int = 4401;
		/**
		 *城镇列表 
		 */		
		public static const GROUPBATTLE_CITYLIST_COMMANDID:int = 4402;
		/**
		 * 挑战 
		 */		
		public static const GROUPBATTLE_PK_COMMANDID:int = 4403;
		/**
		 * 获取许愿信息 
		 */		
		public static const GROUPBATTLE_XUYUAN_COMMANDID:int = 4404;
		/**
		 * 使用许愿信息 
		 */		
		public static const GROUPBATTLE_USEXUYUAN_COMMANDID:int = 4405;
		/**
		 * 军团战战斗信息 
		 */		
		public static const GROUPBATTLE_BATTLEINFO_COMMANDID:int = 4406;
		/**
		 * 参战 
		 */		
		public static const GROUPBATTLE_JOINBATTLE_COMMANDID:int = 4407;
		/**
		 * 自动参战 
		 */		
		public static const GROUPBATTLE_AUTOJOIN_COMMANDID:int = 4408;
		/**
		 * 取消参战 
		 */		
		public static const GROUPBATTLE_CANCEL_COMMANDID:int = 4409;
		
		//申请战役信息
		public static const ZHANYI_REQUEST_LIST:int = 4500;
		//战役战斗
		public static const ZHANYI_FIGHT:int = 4501;
		
	}
}
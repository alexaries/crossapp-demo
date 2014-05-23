package model
{
	/**
	 * 此类的功能  共享所有的数据
	 * 所有游戏模块数据必须在此类中创建一份共享数据
	 * @author Yaolx
	 */
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import logonModule.module.vo.User;
	
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.vo.ItemInfoVo;
	import sceneModule.model.vo.OtherRoleInfoVo;
	import sceneModule.model.vo.RoleInfoVo;
	import sceneModule.model.vo.battleVo.BattleInfoVO;
	import sceneModule.model.vo.battleVo.BattleOverSettlementVo;
	import sceneModule.model.vo.blacksmithVO.BlacksmithStrengthenPackageInfoVO;
	import sceneModule.model.vo.commissionVo.MainCommissionInfoVo;
	import sceneModule.model.vo.corpsVO.CorpsInfoVo;
	import sceneModule.model.vo.familyVo.FamilyInfoVo;
	import sceneModule.model.vo.groupVo.GroupListInfoVo;
	import sceneModule.model.vo.groupVo.RoomInfoVo;
	import sceneModule.model.vo.mailVo.MailListInfoVo;
	import sceneModule.model.vo.rankingVO.MainRankingInfoVo;
	import sceneModule.model.vo.shopVo.MainShopVo;
	import sceneModule.model.vo.skillVo.SkillInfoVo;
	import sceneModule.view.blacksmith.vo.MainStrInfoVO;
	import sceneModule.view.blacksmith.vo.ZhuanYiInfoVO;
	import sceneModule.view.calendar.vo.Bound;
	import sceneModule.view.calendar.vo.CalendarTaskInfo;
	import sceneModule.view.calendar.vo.Schedule;
	import sceneModule.view.chat.vo.ChatSystemSettingVo;
	import sceneModule.view.colonMan.vo.ColonaztionFuBenGroupInfoVO;
	import sceneModule.view.colonMan.vo.ColonaztionFuBenInfoVO;
	import sceneModule.view.colonMan.vo.ColonaztionPrivilegeVO;
	import sceneModule.view.colonMan.vo.CopyColoInfoVO;
	import sceneModule.view.colonMan.vo.MainColoManInfoVO;
	import sceneModule.view.friend.model.vo.PlayerFriendsVo;
	import sceneModule.view.group.vo.MainGroupInfoVO;
	import sceneModule.view.groupBattle.vo.MainGroupBattleInfoVO;
	import sceneModule.view.guanjue.vo.GuanJueInfoVo;
	import sceneModule.view.guanjue.vo.Itemt;
	import sceneModule.view.jingji.vo.MainJingJiInfoVO;
	import sceneModule.view.mainMenu.view.MainMenuComponent;
	import sceneModule.view.pack.vo.PackageInfoVO;
	import sceneModule.view.pata.model.PanPaInfoVO;
	import sceneModule.view.pet.vo.PetInfoVO;
	import sceneModule.view.pet.vo.PetMatrixInfoVO;
	import sceneModule.view.pet.vo.PetTuJianListInfoVO;
	import sceneModule.view.pray.vo.PrayInfoVo;
	import sceneModule.view.reward.vo.RewardBattleVO;
	import sceneModule.view.reward.vo.RewardListInfo;
	import sceneModule.view.sg.vo.ShenDiInfoVO;
	import sceneModule.view.shop.model.vo.ShopInfoVo;
	import sceneModule.view.tavern.vo.TavernWoWInfo;
	import sceneModule.view.tavern.vo.WOW;
	import sceneModule.view.tavern.vo.XingYunTavernWoWInfo;
	import sceneModule.view.tavern.vo.XingYunTravernInfo;
	import sceneModule.view.territory.model.LianjinVO;
	import sceneModule.view.territory.model.TerritoryAramInfoVO;
	import sceneModule.view.vip.vo.MainVIPInfoVO;
	import sceneModule.view.zhanxing.vo.JiFengExch;
	import sceneModule.view.zhanxing.vo.ZhanXingInfoVO;
	
	[Bindable]
	public final class SystemDataModel
	{
		//兵器信息
		public static var Arms:int;
		//用户信息
		public static var userInfo:User = new User();
		//当前是否处于战斗状态
		public static var isBattleStatusFlag:Boolean = false;
		//当前角色是否是新手
		public static var isGuideFlag:Boolean = false;
		//背包类型 商店背包 强化背包 角色背包
		public static var packType:String = MainMenuComponent.NAME;
		//当前显示的是否是其他玩家的信息
		public static var curShowInfoIsOtherRoleFlag:Boolean;
		//新手类型
		public static var roleType:int;
		//新手阶段用户昵称
		public static var guideNickName:String;
		//新手临时id
		public static var guideTempId:int;
		//角色信息集合
		public static var roleCollection:ArrayCollection = new ArrayCollection();
		//队伍队长id
		public static var teamLeaderId:int;
		//队伍信息集合
		public static var teamCollection:ArrayCollection = new ArrayCollection();
		//家族信息
		public static var familyInfo:FamilyInfoVo = new FamilyInfoVo();
		//当前进入场景的角色信息
		public static var roleId:int;
		//场景id
		public static var placeId:int;
		//军团名称
		public static var sceneCorpsName:String='';
		//场景名称
		public static var sceneName:String;
		//军团id
		public static var sceneCorpsId:int;
		//殖民军阀名称
		public static var rewardCorpsName:String='';
		//殖民军阀id
		public static var rewardCorpsId:int;
		//怪物数量
		public static var monsterNum:int;
		//场景资源id
		public static var placeResId:int;
		//当前角色信息
		public static var roleInfo:RoleInfoVo = new RoleInfoVo();
		//其他角色信息
		public static var otherInfo:RoleInfoVo = new RoleInfoVo();
		//装备信息集合
		public static var peopleItemInfo:ArrayCollection = new ArrayCollection();//ItemInfoVo
		//背包信息
		public static var packageinfoVo:PackageInfoVO = new PackageInfoVO();
		//仓库信息
		public static var cangKuInfoVo:PackageInfoVO = new PackageInfoVO();
		//聊天信息 最近聊天对象信息vo
		public static var whisperObjList:ArrayCollection = new ArrayCollection();//私聊对象信息VO  WhisperChatObjectInfoVO
		//新邮件通知
		public static var newMailFlag:Boolean=false;
		//当前包裹类型
		public static var packageType:int=1;
		//临时包裹信息
		public static var tempPackageInfo:ArrayCollection = new ArrayCollection();
		//倉庫信息
		public static var warehouseInfo:ArrayCollection = new ArrayCollection();
		//商店武器类信息
		public static var shopInfoVo:ShopInfoVo = new ShopInfoVo();
		//商城信息
		public static var mainShopVo:MainShopVo = new MainShopVo();
		//好友信息
		public static var playerFriendsVo:PlayerFriendsVo = new PlayerFriendsVo();
		//邮件信息
		public static var mailListInfo:MailListInfoVo = new MailListInfoVo();
		//玩家列表
		public static var playerList:ArrayCollection = new ArrayCollection();
		//黑名单列表
		public static var blackPlayerList:ArrayCollection = new ArrayCollection();
	    //角色技能
		public static var mainSkillInfo:SkillInfoVo = new SkillInfoVo();
		
		//场景是否加载完毕  加载完毕后才可以向场景中传入玩家列表，初始化玩家或是否在场景内
		public static var sceneIsLoaded:Boolean = false;
		
		//战后结算数据
		public static var battleInfoVo:BattleInfoVO = new BattleInfoVO();//战斗数据
		//战后结束牌子信息集合
		public static var battleOverItemInfoCollection:ArrayCollection = new ArrayCollection();
		//翻动牌子的次数
		public static var flipCount:int;
		//shift
		public static var shiftKeyDown:Boolean = false;
		//任务追踪主线任务集合
		public static var taskMainTrackingList:ArrayCollection = new ArrayCollection();//TaskMainTrackingInfoVo
		//某一个NPC的任务
		public static var taskListNpc:ArrayCollection = new ArrayCollection();
		//任务面板当前任务信息集合
		public static var mainTaskInfoList:ArrayCollection = new ArrayCollection();
		//任务配置文件
		public static var taskAimXML:XML;
		public static var taskInfoXML:XML;
		
		//临时解决办法
		public static var tempId:int;
		//装备位置
		public static var bodyPos:int = -1;//-1非装备  1头部 2肩部 3胸部 4手部 5腿部 6脚部 7项链 8戒指 9主武器 10副武器
		
		//队伍信息集合
		public static var groupListInfo:GroupListInfoVo = new GroupListInfoVo();
		//房间队伍成员信息集合
		public static var roomRoleInfoList:ArrayCollection = new ArrayCollection();
		//当前角色是否是房主
		public static var curRoleIsOwnerFlag:Boolean;
		//房间信息
		public static var roomInfo:RoomInfoVo = new RoomInfoVo();
		//当前副本id
		public static var curSceneId:int;
		//副本信息
		public static var copySceneList:ArrayCollection = new ArrayCollection();
		//阵法信息集合
		public static var matrixListInfoList:ArrayCollection = new ArrayCollection();//MatrixInfoVo
		//队伍ID
		public static var groupId:int;
		//拍卖信息
		public static var mainCommissionInfoVo:MainCommissionInfoVo = new MainCommissionInfoVo();
		//酒店信息
		public static var mainHotelInfo:ArrayCollection = new ArrayCollection();//HotelInfoVo
		//军团信息
		public static var mainCorpsInfo:CorpsInfoVo = new CorpsInfoVo();
		//排行榜
		public static var mainRankingInfo:MainRankingInfoVo = new MainRankingInfoVo();
		//聊天系统设置信息
		public static var mainChatSystemSettingInfo:ChatSystemSettingVo = new ChatSystemSettingVo();
		
		//新手指引配置文件数据
		public static var guide_config_xml:XML;
		
		//BuffListInfoVO
		public static var buffListArr:ArrayCollection = new ArrayCollection();//BuffInfoVO
		
		//加黑名单提升标志位
		public static var addBlackFlag:Boolean;
		
		//是否是殖民战
		public static var isColonizationFlag:Boolean;
		
		//殖民管理信息
		public static var colonizationInfo:MainColoManInfoVO = new MainColoManInfoVO();
		
		public static var colCopyId:int;
		
		//上次登录角色id
		public static var last_char_id:int;
		
		//场景NPC信息
		public static var npcInfoArr:Array = new Array();
		//传送门信息
		public static var switchInfoArr:Array = new Array();
		
		public static var is_loading:Boolean = false;
		
		//点击聊天窗口是否点击的是超链接
		public static var chatClickLinkFlag:Boolean = false;
		
		//游戏状态
		public static var game_state:uint;
		
		//宠物系统数据
		public static var petList:ArrayCollection = new ArrayCollection();
		public static var curPetNum:int;
		public static var maxPetNum:int;
		public static var ptjListInfo:PetTuJianListInfoVO = new PetTuJianListInfoVO();
		public static var bjcList:ArrayCollection = new ArrayCollection();
		//宠物阵法集合
		public static var petMatrixList:PetMatrixInfoVO = new PetMatrixInfoVO();
		//临时存放宠物id
		public static var tempPetId:int;
		//临时存放宠物阵法id
		public static var tempMatrixId:int;
		
		//是否登录中
		public static var is_logining:Boolean = false;
		
		//打开的副本对应的传送门id
		public static var open_trip_id:int = 0;
		
		//打开的npc的类型
		public static var opening_npc_type:int = 0;
		
		//场景数据
		public static var scene_data:SceneData = new SceneData();
		
		//殖民奖励
		public static var rewardInfo:RewardListInfo = new RewardListInfo();
		//入侵信息
		public static var rewardBattleVo:RewardBattleVO = new RewardBattleVO();
		//GameTopUI
		public static var gameTopList:ArrayCollection = new ArrayCollection();//GameTopUIVO
		//当前打开的窗口
		public static var curOpenWindowName:String;
		//当前窗口的父窗口
		public static var curWindowParentName:String;
		//其他宠物信息
		public static var otherPetInfoVo:PetInfoVO = new PetInfoVO();
		//我的领地信息 点石成金
		public static var lianjinInfoVo:LianjinVO = new LianjinVO();
		//军营信息
		public static var aramInfoVo:TerritoryAramInfoVO = new TerritoryAramInfoVO();
		//殖民特权
		public static var colonizationPrivilegeInfo:ColonaztionPrivilegeVO = new ColonaztionPrivilegeVO();
		public static var curColonizationFuBenInfo:ColonaztionFuBenGroupInfoVO = new ColonaztionFuBenGroupInfoVO();
		
		//日程表
		public static var calendarTaskInfo:CalendarTaskInfo =new CalendarTaskInfo();
		//强化背包信息
		public static var strPackageInfo:BlacksmithStrengthenPackageInfoVO = new BlacksmithStrengthenPackageInfoVO();
		
		//角色当前是否处于挂机中....
		public static var isGuaJiFlag:Boolean;
		//每日任务信息
		public static var targetInfoList:ArrayCollection = new ArrayCollection();//DayTaskInfoVO
		//神邸信息
		public static var shenDiInfo:ShenDiInfoVO = new ShenDiInfoVO();//神邸信息
	    //激活神格时是否需要提示
		public static var activeSGFlag:Boolean = true;//默认不需要提示
		//强化模块功能数据信息
		public static var mainStrInfoVo:MainStrInfoVO = new MainStrInfoVO();
		
		//官爵信息
		public static var guanJueInfo:GuanJueInfoVo =new GuanJueInfoVo();
		
		//声望信息
		public static var shengWangInfo:Itemt =new Itemt();
		//属性转移信息
		public static var ZhuanYiInfo:ZhuanYiInfoVO =new ZhuanYiInfoVO();
		//强化冷却时间
		public static var strWinTime:int;//强化冷却时间
		
		//是否是组队战斗
		public static var groupBattleFlag:Boolean = false;
		
		//魔兽酒馆
		public static var taverInfo:TavernWoWInfo =new TavernWoWInfo();
		
		public static var wow: WOW=new WOW();
		
		public static var xingYunTravernInfo:XingYunTravernInfo =new XingYunTravernInfo();
		
		public static var xingyuntravernwow:XingYunTavernWoWInfo =new XingYunTavernWoWInfo();
		
		//占星
		public static var zhanxingInfo:ZhanXingInfoVO = new ZhanXingInfoVO();
		public static var opeId:int;
		//积分兑换信息
		public static var jifengInfo:JiFengExch =new JiFengExch();
		
		//上一次点击功能按钮的时间计时
		public static var preClickFunctionBtnTime:Number = new Date().time;
		
		//系统推送的信息
		public static var sysOpeDictionary:Dictionary = new Dictionary();
		
		//竞技系统
		public static var mainJingJiInfoVo:MainJingJiInfoVO = new MainJingJiInfoVO();
		
		//是否是竞技战斗
		public static var jingjiBattleFlag:Boolean = false;//是否是竞技战斗
		
		//攀爬
		public static var panPaBattleFlag:Boolean = false;
		public static var openPanPaUI:Boolean = false;
		
		//vip信息
		public static var mainVipInfo:MainVIPInfoVO = new MainVIPInfoVO();
		
		//祈祷信息
		public static var prayInfoVo:PrayInfoVo =new PrayInfoVo();
		
		//panpa
		public static var panPaInfoVo:PanPaInfoVO = new PanPaInfoVO();
		
		public static var  praybool:Boolean=false;
		
		
		public static var  isPracbool:Boolean=false;
		
		//当前正在播放开启功能介绍
		public static var openFunFlag:Boolean = false;
		//功能开始等级
		public static var openFunLevel:int;
		
		public static var hideOtherPlayer:Boolean;
		
		//多人组队
		public static var mainGroupInfo:MainGroupInfoVO = new MainGroupInfoVO();
		
		//军团战
		public static var groupBattleInfo:MainGroupBattleInfoVO = new MainGroupBattleInfoVO();
		public function SystemDataModel()
		{
		}
	}
}
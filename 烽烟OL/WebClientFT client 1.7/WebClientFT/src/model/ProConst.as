package model
{
	import resource.CrotaResourceConfig;

	public class ProConst
	{
		public function ProConst()
		{
		}
		//NPC 商店
		public static const NPC_SHOP:int = 100001;
		//挂机修炼
		public static const NPC_UNITING:int = 100002;
		//挂机训练
		public static const NPC_TRAINING:int = 100003;
		//宿屋
		public static const NPC_LODGEHOUSE:int = 100004;
		//道具NPC
		public static const NPC_DAOJU:int = 100002;
		//防具
		public static const NPC_FANGJU:int = 100003;
		//铁匠铺
		public static const NPC_BLACKSMITH:int = 100006;
		//战士
		public static const  WARRIOR:int = 1;
		//法师
		public static const MAGE:int = 2;
		//牧师
		public static const PASTOR:int = 4;
		//游侠
		public static const RANGER:int = 3;
		
		//全部物品
		public static const ALL_ITEM:int = 0;
		//普通物品
		public static const COMMON_ITEM:int = 1;
		//任务物品
		public static const TASK_ITEM:int = 2;
		//武器商店
		public static const WEAPONRY_SHOP:int = 1;
		//防具商店
		public static const DEFENSE_SHOP:int = 2;
		//消耗品
//		public static const XIAOHAO_SHOP:int = 2;
		//材料
//		public static const MATERIALS_SHOP:int = 3;
		//杂货商店
		public static const GROCERY_SHOP:int = 4;
		//购买
		public static const NPCSHOP_BUY_SHOP:int = 0;
		//出售
		public static const NPCSHOP_SELL_SHOP:int = 1;
		//--------------场景类型----------------------
		//普通场景
		public static const COMMON_SCENE:int = 1;
		//副本场景
		public static const COPY_SCENE:int = 2;
		//----------------移动物品时的包裹类型------------
		//临时包裹
		public static const TEMPLATE_PACKAGE:int = 1;
		//仓库
		public static const WAREHOUSE_PACKAGE:int = 2;
		//普通物品包裹
		public static const COMMON_PACKAGE:int = 3;
		//任务物品包裹
		public static const TASK_PACKAGE:int = 4;
		//----------包裹Menu类型---------------------------
		//丢弃
		public static const MENU_DROP:String = "버리다";
		//使用
		public static const MENU_USE:String = "사용";
		//出售
		public static const MENU_SELL:int = 3;
		//展示
		public static const MENU_EXVIEW:String = "표시";
		//装备
		public static const MENU_EQUIP:int = 4;
		//复制
		public static const MENU_COPY:int = 5;
		//拆分
		public static const MENU_SPLIT:int = 6;
		//----------------聊天频道-------------------------
		public static const COMPOSITE_INFO:int = 0;//综合
		public static const WORLD_INFO:int = 1;//世界
		public static const CURRENT_INFO:int = 2;//当前
		public static const CORPS_INFO:int = 3;//军团
		public static const GM_INFO:int = 4;//GM
		public static const SYSTEM_INFO:int = 5;//系统公告
		public static const CORPSSYSTEM_INFO:int=6;//军团系统信息
//		public static const SINGLETION_INFO:int = 7;//密语
//		public static const TRUMPET_INFO:int = 8;//小喇叭
//		public static const BIGHORN_INFO:int = 9;//大喇叭
		
//		public static const SMALL_MESSAGE:int = 8;//小喇叭
//		public static const SYSTEM_NOTICE:int = 9;//电视
		//---------------聊天连接类型-------------
		public static const CHATLINK_EQUIP:int = 0;//装备
		public static const CHATLINK_ROLE:int = 1;//角色
		public static const CHATLINK_BOSS:int = 2;//怪物
		//-------------------任务系统相关变量----------------------
		public static const ACCESSTASK:int = 0;//可接受任务
		public static const PROGRESSTASK:int = 1;//进行的任务
	    public static const CANSUBMITTASK:int = 2;//可提交任务
		public static const FAILTASK:int = 3;//失败的任务
		public static const NPCSELF:int = 4;//npc本身
		//------------------任务追踪-----------------
		public static const MAINTASKLINE:int = 1;//主线任务
		public static const ONETASKLINE:int = 2;//分线任务
		public static const CIRCLETASKLINE:int = 3;//环线任务
		public static const FAMILYTASKLINE:int = 4;//行会日常任务
		//-------------------复活方式--------------------------
		public static const RESUR_ITEM_COMMANDID:int = 1;
		public static const RESUR_GOLD_COMMANDID:int = 2;
		//-------------------复活返回信息类型-----------------------
		public static const RESUR_NOTITEM:int = 1;
		public static const RESUR_NOTGOLD:int = 2;
		//-------------------显示数字类型-------------------------------
		public static const ROLELEVEL_TYPE:int = 1;//角色等级
		public static const BATTLECOIN_TYPE:int = 2;//战斗结算
		//----------------副本类型--------------------
		public static const COPYSCENE_1:int = 1;
		public static const COPYSCENE_2:int = 2;
		public static const COPYSCENE_3:int = 3;
		//------------副本状态-------------------------------------
		public static const DISABLEACTIVE_STATE:int = -1;
		public static const ACTIVE_STATE:int = 1;
		public static const CROSSCOPYSCENE_STATE:int = 2;
		//------------------绑定状态-------------------------------
		//拾取绑定
		public static const ITEMSTATE1:int = 1;
		//装备绑定
		public static const ITEMSTATE2:int = 2;
		//不绑定
		public static const ITEMSTATE3:int = 3;
		//----------  -------等级限制-----------------------------
		//无限制
		public static const PROFESSIONREQUIRE1:int = 0;
		//战士
		public static const PROFESSIONREQUIRE2:int = 1;
		//法师
		public static const PROFESSIONREQUIRE3:int = 2;
		//牧师
		public static const PROFESSIONREQUIRE4:int = 4;
		//游侠
		public static const PROFESSIONREQUIRE5:int = 3;
		//
		public static const petWarriorImg4:int = 4;
		//
		public static const petMageImg5:int = 5;
		//
		public static const petRangerImg6:int = 6;
		
		//-------------------武器分类----------------------------
		//胸部
		public static const WEAPONTYPE0:int = 0;
		//腿部
		public static const WEAPONTYPE1:int = 1;
		//头部
		public static const WEAPONTYPE2:int = 2;
		//手部
		public static const WEAPONTYPE3:int = 3;
		//脚部
		public static const WEAPONTYPE4:int = 4;
		//副手
		public static const WEAPONTYPE5:int = 5;
		//颈部
		public static const WEAPONTYPE6:int = 6;
		//手指
		public static const WEAPONTYPE7:int = 7;
		//肩部
		public static const WEAPONTYPE8:int = 8;
		//单手
		public static const WEAPONTYPE9:int = 9;
		//双手
		public static const WEAPONTYPE10:int = 10;
		//药剂
		public static const WEAPONTYPE20:int = 20;
		//宝石
		public static const WEAPONTYPE21:int = 21;
		//其他
		public static const WEAPONTYPE22:int = 22;
		//任务物品
		public static const WEAPONTYPE23:int = 23;
		//材料
		public static const WEAPONTYPE24:int = 24;
		//-----------------装备部位----------------------------
		//双手
		public static const BODYTYPEPOS0:int = 0;
		//头部
		public static const BODYTYPEPOS1:int = 1;
		//肩部
		public static const BODYTYPEPOS2:int = 2;
		//胸部
		public static const BODYTYPEPOS3:int = 3;
		//手部
		public static const BODYTYPEPOS4:int = 4;
		//腿部
		public static const BODYTYPEPOS5:int = 5;
		//脚部
		public static const BODYTYPEPOS6:int = 6;
		//项链
		public static const BODYTYPEPOS7:int = 7;
		//戒指
		public static const BODYTYPEPOS8:int = 8;
		//主手
		public static const BODYTYPEPOS9:int = 9;
		//副手
		public static const BODYTYPEPOS10:int = 10;
		
		//军团职位
		public static const ORDINARYMEMBERS:int = 0;
		//议事
		public static const ORDERMEMBERS:int = 1;
		//参谋
		public static const STAFFOFFICERMEMBERS:int = 2;
		//元老
		public static const VETERANMEMBERS:int = 3;
		//军团长
		public static const CORPSCHIEFMEMBERS:int = 4;
		
		//--------------------------技能类型------------------------------
		public static const ZHUSKILL:int = 0;//主动技能
		public static const PASSKILL:int = 1;//被动技能
		public static const APPSKILL:int = 2;//应用技能
		public static const BATTLESKILL:int = 3;//战斗技能
		
		//-----------------------------------NPC功能类型------------------------------
		public static const MEIRIRENWU:int = 1;//每日任务
		public static const DAOJUDIAN:int = 2;//道具店
		public static const FANGJUDIAN:int = 3;//防具店
		public static const WUQIDIAN:int = 4;//武器店
		public static const JIUDIAN:int = 5;//酒店
		public static const CANGKUGUANLIYUAN:int = 6;//仓库管理员
		public static const RENWUNPC:int = 7;//任务NPC
		public static const JUNTUANGUANLIYUAN:int = 8;//军团管理员
		public static const JIAOYISUONPC:int = 9;//交易所NPC
		public static const JINENGNPC:int = 10;//技能NPC
		public static const SHENMISHANGREN:int = 11;//神秘商人
		public static const ZHANPUSHI:int = 12; 
		
		
		public static const GAME_STATE_NONE:uint 			= 0;	//未赋值状态		
		public static const GAME_STATE_WORD_MAP:uint 		= 2;	//世界地图打开中
		public static const GAME_STATE_FUBEN_CHOSE:uint		= 4;	//副本选择打开中
		
		//描边颜色
		public static const BORDER_COLOR:int = 0x34332d;
		
		
		[Embed(source="/embed/shop/shopAndSkillBackground.png",scaleGridTop='24',scaleGridBottom='40',scaleGridLeft='33',scaleGridRight='200')]
		[Bindable]
		public static var shopAndSkillBgObj:Class;
			
		//---------------选择角色部分职业头像--------------------------
		public static function getWorkTypeURL(type:String):String{
			var wURL:String = "";
			switch(type){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_ms'):
					wURL = "assets/role/pastorRoleImg.png";
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_fashi'):
					wURL = "assets/role/mageRoleImg.png";
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_yx'):
					wURL = "assets/role/rangerRoleImg.png";
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_zs'):
					wURL = "assets/role/warriorRoleImg.png";
					break;
			}
			return wURL;
		}
		
		public static function getJobImg(profession:int):String{
			var r:String = null;
			switch (profession) 
			{
				case 1:
					r = "assets/mainui/zhanshiHeadImg.png";
					break;
				case 2:
					r = "assets/mainui/fashiHeadImg.png";
					break;
				case 3:
					r = "assets/mainui/youxiaHeadImg.png";
					break;
				case 4:
					r = "assets/mainui/zhanshinv4.png";
					break;
				case 5:
					r = "assets/mainui/fashinan5.png";
					break;
				case 6:
					r = "assets/mainui/youxianv6.png";
					break;
				
				default:
					r = null;
			}
			return r;
		}
		
		public static function getJobSquareHeadImg(profession:int):String{
			var r:String = null;
			switch (profession) 
			{
				case 1:
					r = "assets/pet/petWarriorImg.png";
					break;
				case 2:
					r = "assets/pet/petMageImg.png";
					break;
				case 3:
					r = "assets/pet/petRangerImg.png";
					break;
				case 4:
					r = "assets/pet/petWarriorImg4.png";
					break;
				case 5:
					r = "assets/pet/petMageImg5.png";
					break;
				case 6:
					r = "assets/pet/petRangerImg6.png";
					break;
				default:
					r = null;
			}
			return r;
		}
		
		public static function getImageResUrl(type:int):String{
			var url:String = "";
			switch(type){
				case 100:
					url = "assets/Image/equipment/Item/Head/";
					break;
				case 200:
					url = "assets/Image/equipment/Item/Chest/";
					break;
				case 300:
					url = "assets/Image/equipment/Item/Shoulder/";
					break;
				case 400:
					url = "assets/Image/equipment/Item/Leg/";
					break;
				case 500:
					url = "assets/Image/equipment/Item/Foot/";
					break;
				case 600:
					url = "assets/Image/equipment/Item/Gloves/";
					break;
				case 700:
					url = "assets/Image/equipment/Item/Neck/";
					break;
				case 800:
					url = "assets/Image/equipment/Item/Jewelry/";
					break;
				case 900:
					url = "assets/Image/equipment/Item/jewelry/";
					break;
				case 1000:
					url = "assets/Image/equipment/Weapon/Book/";
					break;
				case 2000:
					url = "assets/Image/equipment/Weapon/Staves/";
					break;
				case 3000:
					url = "assets/Image/equipment/Weapon/Bow/";
					break;
				case 4000:
					url = "assets/Image/equipment/Weapon/Sword/";
					break;
				case 110000:
					url = "assets/Image/Props/";
					break;
				case 120000:
					url = "assets/Image/Skill/";
					break;
				case 130000:
					url = "assets/Image/PetSkill/";
					break;
				case 200000:
					url = "assets/Image/Buff/buffItem/";
					break;
				case 210000:
					url = "assets/Image/Buff/buffSkill/";
					break;
				case 220000:
					url = "assets/Image/Pet/";
					break;
				case 230000:
					url = "assets/Image/zhanxing/";
					break;
			}
			return url;
		}
		
		public static function getImageSource(type:int,icon:int):String{
			if(type == 0){
				return '';
			}else{
				return getImageResUrl(type)+icon+'.png';
			}
			
		}
		
		public static function getItemTypeDes(ty:int):String{
			var desType:String = "";
			switch(ty){
				case 1:
					desType = CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','hcC_zb');
					break;
				case 2:
					desType = CrotaResourceConfig.getInstance().getTextByModuleAndId('model','pc_xhp');
					break;
				case 3:
					desType = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeT_cl');
					break;
				case 4:
					desType = CrotaResourceConfig.getInstance().getTextByModuleAndId('pack','mmeGM_rw');
					break;
			}
			return desType;
		}
		
		public static const MAX_Energy:int = 200;
		
		[Embed(source="/embed/hotel/hotelInfoBg.png",scaleGridTop='29',scaleGridBottom='30',scaleGridLeft='54',scaleGridRight='200')]
		[Bindable]
		public static var hotelBgObj:Class;
		
		public static const MIN_CITY_ID:int = 1000;
		public static const MAX_CITY_ID:int = 5000;
		
		
		/**
		 * 判断当前场景是否是城镇或新手村
		 * @param sceneId 当前场景id 
		 */		
		public static function curSceneIsCity(sceneId:int):Boolean{
			if(sceneId < MAX_CITY_ID){
				return true;
			}
			return false;
		}
		
		/**
		 * 宠物品质 
		 */		
		public static function getPetQuality(quly:int):String{
			var str:String='';
			switch(quly){
				case 0:
					str = "<font color='#00FF00'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('copyScene','cbbcSC_pt')+"</font>";
					break;
				case 1:
					str = "<font color='#00FFFF'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('model','pc_yx')+"</font>";
					break;
				case 2:
					str = "<font color='#9900FF'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('model','pc_jl')+"</font>";
					break;
				case 3:
					str = "<font color='#FFFF00 '>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('model','pc_ss')+"</font>";
					break;
				case 4:
					str = "<font color='#FF6600'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('model','pc_cs')+"</font>";
					break;
				case 5:
					str = "<font color='#FF0000'>"+CrotaResourceConfig.getInstance().getTextByModuleAndId('model','pc_nt')+"</font>";
					break;
			}
			return str;
		}
		
		public static function getRoleImg(profession:int):String{
			switch(profession){
				case ProConst.PROFESSIONREQUIRE2:
					return "assets/pet/petWarriorImg.png";
					break;
				case ProConst.PROFESSIONREQUIRE3:
					return "assets/pet/petMageImg.png";
					break;
				case ProConst.PROFESSIONREQUIRE4:
					return "assets/pet/petPastorImg.png";
					break;
				case ProConst.PROFESSIONREQUIRE5:
					return "assets/pet/petRangerImg.png";
					break;
			}
			return '';
		}
		
		
		public static function getPetImage(icon:int):String{
			if(icon==0){
				return '';
			}else{
				return 'assets/Image/petImg/'+icon+'.png';
			}
			
		}
	}
}
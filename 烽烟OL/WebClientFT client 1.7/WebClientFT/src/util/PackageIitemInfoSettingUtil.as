package util
{
	import mx.collections.ArrayCollection;
	
	import proto.ItemsInfo;
	import proto.Suite;
	import proto.pet.PetInfo;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.vo.SuiteEffectInfoVO;
	import sceneModule.model.vo.SuiteInfoVO;
	import sceneModule.model.vo.packageVo.PackageItem;
	import sceneModule.model.vo.packageVo.PackageSuite;
	import sceneModule.view.pet.vo.PetInfoVO;
	
	public class PackageIitemInfoSettingUtil
	{
		public function PackageIitemInfoSettingUtil()
		{
		}
		
		public static function setPetInfo(petInfoVo:PetInfoVO,petInfo:PetInfo):void{
			petInfoVo.petId = petInfo.petId;//宠物id
			petInfoVo.resPetId = petInfo.resPetId;//宠物资源id
			petInfoVo.petName = petInfo.petName;//宠物名称
			petInfoVo.petLevel=petInfo.petLevel;//宠物等级
			petInfoVo.inMatrixFlag = petInfo.inMatrixFlag;//是否在阵法中
			petInfoVo.petDes=petInfo.petDes;//宠物描述
			petInfoVo.baseHp=petInfo.baseHp;//基础血量
			petInfoVo.manualHp=petInfo.manualHp;//血量加成
			petInfoVo.basePhyAttack=petInfo.basePhyAttack;//基础物理攻击
			petInfoVo.manualPhyAttack=petInfo.manualPhyAttack;//物理攻击加成
			petInfoVo.baseMagicAttack=petInfo.baseMagicAttack;//基础魔法攻击
			petInfoVo.manualMagicAttack=petInfo.manualMagicAttack;//魔法攻击加成
			petInfoVo.basePhyDefense=petInfo.basePhyDefense;//基础物理防御
			petInfoVo.manualPhyDefense=petInfo.manualPhyDefense;//物理防御加成
			petInfoVo.baseMagicDefense=petInfo.baseMagicDefense;//基础魔法防御
			petInfoVo.manualMagicDefense=petInfo.manualMagicDefense;//魔法防御加成
			petInfoVo.baseHitRate=petInfo.baseHitRate;//基础命中
			petInfoVo.manualHitRate=petInfo.manualHitRate;//命中加成
			petInfoVo.baseDodgeRate=petInfo.baseDodgeRate;//基础闪避
			petInfoVo.manualDodgeRate=petInfo.manualDodgeRate;//闪避加成
			petInfoVo.baseSpeed=petInfo.baseSpeed;//基础攻击速度
			petInfoVo.manualSpeed=petInfo.manualSpeed;//基础速度加成
			petInfoVo.baseCritRate=petInfo.baseCritRate;//基础暴击
			petInfoVo.manualCritRate=petInfo.manualCritRate;//暴击加成
			petInfoVo.type=petInfo.type;//暴击加成
			petInfoVo.icon=petInfo.icon;//暴击加成
			petInfoVo.flowFlag = petInfo.flowFlag;
			petInfoVo.baseBlock = petInfo.baseBlock;//基础抗暴
			petInfoVo.manualBlock = petInfo.manualBlock;//抗暴加成
			petInfoVo.liliang = petInfo.liliang;//力量
			petInfoVo.zhili = petInfo.zhili;//智力
			petInfoVo.naili =  petInfo.naili;//耐力
			petInfoVo.minjie = petInfo.minjie;//敏捷
			petInfoVo.maxHp = petInfo.maxHp;//总血量
			petInfoVo.curExp = petInfo.curExp;//当前经验
			petInfoVo.maxExp = petInfo.maxExp;//总经验
			petInfoVo.curQuality = petInfo.curQuality;//当前品质0普通1优秀2精良3史诗5传说
			petInfoVo.texing = petInfo.texing;//特性
			petInfoVo.skillName = petInfo.petSkillInfo;
		}
		
		public static function PackageItemSetting(itemInfo:ItemsInfo):PackageItem{
			var packageInfoVo:PackageItem = CrotaItemConfig.getItemInfoByTempleteId(itemInfo.templateId);//VO
			PackageIitemInfoSettingUtil.setItemDefaultInfo2(packageInfoVo,itemInfo);
			return packageInfoVo;
		}
		
		
		public static function setWorghtPackageItemSetting():PackageItem{
			var packageInfoVo:PackageItem = new PackageItem();//VO
			packageInfoVo.id=1400000;//物品的id
			packageInfoVo.type=200;//物品的类型
			packageInfoVo.name='皮制铠甲';//物品的名称
			packageInfoVo.prefixNmae='';//物品的前缀名称
			packageInfoVo.suffixName='';//物品的后缀名称
			packageInfoVo.bindType=1;//物品的绑定类型
			packageInfoVo.isBound=0;//是否绑定
			packageInfoVo.description='';//物品描述
			packageInfoVo.professionRequire=1;//职业限制
			packageInfoVo.canInjection=0;//可否注魂
			packageInfoVo.bodyType=3;
			packageInfoVo.weaponType=-1;
			packageInfoVo.nowQuality=2;
			packageInfoVo.baseAttack=-1;
			packageInfoVo.extAttack=-1;
			packageInfoVo.attackType=-1;
			packageInfoVo.baseSpeed=-1;
			packageInfoVo.levelRequire=1;
			packageInfoVo.baseStr=5;
			packageInfoVo.extStr=1;
			packageInfoVo.baseVit=10;
			packageInfoVo.extVit=0;
			packageInfoVo.baseDex=5;
			packageInfoVo.extDex=0;
			packageInfoVo.baseWis=5;
			packageInfoVo.extWis=0;
			packageInfoVo.basePhysicalAttack=-1;
			packageInfoVo.extPhysicalAttack=-1;
			packageInfoVo.baseMagicAttack=5;
			packageInfoVo.extMagicAttack=1;
			packageInfoVo.basePhysicalDefense=5;
			packageInfoVo.extPhysicalDefense=1;
			packageInfoVo.baseMagicDefense=5;
			packageInfoVo.extMagicDefense=0;
			packageInfoVo.baseHpAdditional=5;
			packageInfoVo.extHpAdditional=1;
			packageInfoVo.baseHitAdditional=5;
			packageInfoVo.extHitAdditional=1;
			packageInfoVo.baseCritAdditional=5;
			packageInfoVo.extCritAdditional=1;
			packageInfoVo.baseDodgeAdditional=5;
			packageInfoVo.extDodgeAdditional=1;
			packageInfoVo.baseSpeedAdditional=5;
			packageInfoVo.extSpeedAdditional=5;
			packageInfoVo.equipEffect='';
			packageInfoVo.devilEffect='';
			packageInfoVo.suiteEffect='';
			packageInfoVo.buyingRateCoin=100;
			packageInfoVo.baseDurability=5;
			packageInfoVo.nowDurability=5;
			packageInfoVo.baseDefense=5;
			packageInfoVo.extDefense=5;
			//			packageInfoVo.position = itemInfo.position;
			packageInfoVo.stack = 1;
			packageInfoVo.icon = 2002;
			packageInfoVo.starLevel = -1;
			packageInfoVo.templateId=1400000;
			//			packageInfoVo.packageType = itemInfo.packCategory;
			packageInfoVo.maxStack = 1;
			packageInfoVo.itemPage = 1;
			var sl:int = 2;
			var selfCollection:ArrayCollection = new ArrayCollection();
			for(var si:int = 0;si<sl;si++){
				var attributeVo:sceneModule.model.vo.packageVo.PackageSuite = new PackageSuite();
				//attributeVo.id = attribute.id;
				attributeVo.suitItemName = 'yyy';
				attributeVo.hasSiutitem = 1;
				selfCollection.addItem(attributeVo);
			}
//			packageInfoVo.SuiteItems.source = selfCollection.toArray();
			return packageInfoVo;
		}
		
		
		public static function setItemDefaultInfo(packageInfoVo:PackageItem,itemInfo:PackageItem):void{
			packageInfoVo.id=itemInfo.id;//物品的id
			packageInfoVo.type=itemInfo.type;//物品的类型
			packageInfoVo.name=itemInfo.name;//物品的名称
			packageInfoVo.prefixNmae=itemInfo.prefixNmae;//物品的前缀名称
			packageInfoVo.suffixName=itemInfo.suffixName;//物品的后缀名称
			packageInfoVo.bindType=itemInfo.bindType;//物品的绑定类型
			packageInfoVo.isBound=itemInfo.isBound;//是否绑定
			packageInfoVo.description=itemInfo.description;//物品描述
			packageInfoVo.professionRequire=itemInfo.professionRequire;//职业限制
			packageInfoVo.canInjection=itemInfo.canInjection;//可否注魂
			packageInfoVo.bodyType=itemInfo.bodyType;
			packageInfoVo.weaponType=itemInfo.weaponType;
			packageInfoVo.nowQuality=itemInfo.nowQuality;
			packageInfoVo.baseAttack=itemInfo.baseAttack;
			packageInfoVo.extAttack=itemInfo.extAttack;
			packageInfoVo.attackType=itemInfo.attackType;
			packageInfoVo.baseSpeed=itemInfo.baseSpeed;
			packageInfoVo.levelRequire=itemInfo.levelRequire;
			packageInfoVo.baseStr=itemInfo.baseStr;
			packageInfoVo.extStr=itemInfo.extStr;
			packageInfoVo.baseVit=itemInfo.baseVit;
			packageInfoVo.extVit=itemInfo.extVit;
			packageInfoVo.baseDex=itemInfo.baseDex;
			packageInfoVo.extDex=itemInfo.extDex;
			packageInfoVo.baseWis=itemInfo.baseWis;
			packageInfoVo.extWis=itemInfo.extWis;
			packageInfoVo.basePhysicalAttack=itemInfo.basePhysicalAttack;
			packageInfoVo.extPhysicalAttack=itemInfo.extPhysicalAttack;
			packageInfoVo.baseMagicAttack=itemInfo.baseMagicAttack;
			packageInfoVo.extMagicAttack=itemInfo.extMagicAttack;
			packageInfoVo.basePhysicalDefense=itemInfo.basePhysicalDefense;
			packageInfoVo.extPhysicalDefense=itemInfo.extPhysicalDefense;
			packageInfoVo.baseMagicDefense=itemInfo.baseMagicDefense;
			packageInfoVo.extMagicDefense=itemInfo.extMagicDefense;
			packageInfoVo.baseHpAdditional=itemInfo.baseHpAdditional;
			packageInfoVo.extHpAdditional=itemInfo.extHpAdditional;
			packageInfoVo.baseHitAdditional=itemInfo.baseHitAdditional;
			packageInfoVo.extHitAdditional=itemInfo.extHitAdditional;
			packageInfoVo.baseCritAdditional=itemInfo.baseCritAdditional;
			packageInfoVo.extCritAdditional=itemInfo.extCritAdditional;
			packageInfoVo.baseDodgeAdditional=itemInfo.baseDodgeAdditional;
			packageInfoVo.extDodgeAdditional=itemInfo.extDodgeAdditional;
			packageInfoVo.baseSpeedAdditional=itemInfo.baseSpeedAdditional;
			packageInfoVo.extSpeedAdditional=itemInfo.extSpeedAdditional;
			packageInfoVo.equipEffect=itemInfo.equipEffect;
			packageInfoVo.devilEffect=itemInfo.devilEffect;
			packageInfoVo.suiteEffect=itemInfo.suiteEffect;
			packageInfoVo.buyingRateCoin=itemInfo.buyingRateCoin;
			packageInfoVo.baseDurability=itemInfo.baseDurability;
			packageInfoVo.nowDurability=itemInfo.nowDurability;
			packageInfoVo.baseDefense=itemInfo.baseDefense;
			packageInfoVo.extDefense=itemInfo.extDefense;
			//			packageInfoVo.position = itemInfo.position;
			packageInfoVo.stack = itemInfo.stack;
			packageInfoVo.icon = itemInfo.icon;
			packageInfoVo.starLevel = itemInfo.starLevel;
			packageInfoVo.templateId=itemInfo.templateId;
			packageInfoVo.itemPage=itemInfo.itemPage;
			//			packageInfoVo.packageType = itemInfo.packCategory;
			//			packageInfoVo.maxStack = itemInfo.maxstack;
//			var sl:int = itemInfo.SuiteItems.length;
//			var selfCollection:ArrayCollection = new ArrayCollection();
//			for(var si:int = 0;si<sl;si++){
//				var attribute:PackageSuite = itemInfo.SuiteItems[si];
//				var attributeVo:Suite = new Suite();
//				//attributeVo.id = attribute.id;
////				attributeVo.suitItemName = attribute.suitItemName;
////				attributeVo.hasSiutitem = attribute.hasSiutitem;
//				selfCollection.addItem(attributeVo);
//			}
//			packageInfoVo.SuiteItems.source = selfCollection.toArray();
		}
		public static function setItemDefaultInfo2(packageInfoVo:PackageItem,itemInfo:ItemsInfo):void{
			packageInfoVo.id=itemInfo.id;//物品的id
			packageInfoVo.prefixNmae=itemInfo.prefixNmae;//物品的前缀名称
			packageInfoVo.suffixName=itemInfo.suffixName;//物品的后缀名称
			packageInfoVo.isBound=itemInfo.isBound;//是否绑定
			packageInfoVo.extAttack=itemInfo.extAttack;
			packageInfoVo.extStr=itemInfo.extStr;
			packageInfoVo.extVit=itemInfo.extVit;
			packageInfoVo.extDex=itemInfo.extDex;
			packageInfoVo.extWis=itemInfo.extWis;
			packageInfoVo.extPhysicalAttack=itemInfo.extPhysicalAttack;
			packageInfoVo.extMagicAttack=itemInfo.extMagicAttack;
			packageInfoVo.extPhysicalDefense=itemInfo.extPhysicalDefense;
			packageInfoVo.extMagicDefense=itemInfo.extMagicDefense;
			packageInfoVo.extHpAdditional=itemInfo.extHpAdditional;
			packageInfoVo.extHitAdditional=itemInfo.extHitAdditional;
			packageInfoVo.extCritAdditional=itemInfo.extCritAdditional;
			packageInfoVo.extDodgeAdditional=itemInfo.extDodgeAdditional;
			packageInfoVo.extSpeedAdditional=itemInfo.extSpeedAdditional;
			packageInfoVo.buyingRateCoin=itemInfo.buyingRateCoin;
			packageInfoVo.extDefense=itemInfo.extDefense;
			packageInfoVo.stack = itemInfo.stack;
			packageInfoVo.starLevel = itemInfo.starLevel;
			packageInfoVo.templateId=itemInfo.templateId;
			packageInfoVo.extBlock = itemInfo.extBlockAdditional;
			if(itemInfo.xqInfo){
				packageInfoVo.xqDes1 = itemInfo.xqInfo.xqDes1;
				packageInfoVo.xqDes2 = itemInfo.xqInfo.xqDes2;
				packageInfoVo.xqDes3 = itemInfo.xqInfo.xqDes3;
				packageInfoVo.xqDes4 = itemInfo.xqInfo.xqDes4;
				packageInfoVo.xqItemId1 = itemInfo.xqInfo.xqItemId1;
				packageInfoVo.xqItemId2 = itemInfo.xqInfo.xqItemId2;
				packageInfoVo.xqItemId3 = itemInfo.xqInfo.xqItemId3;
				packageInfoVo.xqItemId4 = itemInfo.xqInfo.xqItemId4;
			}
			if(itemInfo.suiteInfo){
				packageInfoVo.SuiteInfo.maxcnt = itemInfo.suiteInfo.maxcnt;
				packageInfoVo.SuiteInfo.nowcnt = itemInfo.suiteInfo.nowcnt;
				packageInfoVo.SuiteInfo.suitename = itemInfo.suiteInfo.suitename;
				var l:int = itemInfo.suiteInfo.suiteeffct.length;
				var sArr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var suitInfoVo:SuiteEffectInfoVO = new SuiteEffectInfoVO();
					suitInfoVo.properName = itemInfo.suiteInfo.suiteeffct[i].effectstr;
					suitInfoVo.enable = itemInfo.suiteInfo.suiteeffct[i].enable;
					sArr.addItem(suitInfoVo);
				}
				packageInfoVo.SuiteInfo.suiteeffctArr.source = sArr.toArray();
			}
			
		}
	}
}
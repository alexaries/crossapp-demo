package sceneModule.model.vo.packageVo
{
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.vo.SuiteInfoVO;

	//import sceneModule.model.vo.Package.PackageSuite;
	[Bindable]//zhiyishixiang_qiu
	public class PackageItem
	{
		public var id:int;//物品的id
		public var position:int;//物品的位置
		public var type:int//物品的类型
		public var name:String;//物品的名称
		public var prefixNmae:String;//物品的前缀名称
		public var suffixName:String;//物品的后缀名称
		public var bindType:int;//物品的绑定类型
		public var isBound:int;//是否绑定
		public var description:String;//物品描述
		public var professionRequire:int;//职业限制
		public var canInjection:int;//可否注魂
		public var bodyType:int;//装备位置
		public var weaponType:int;//武器类型
		public var nowQuality:int;//当前品质
		public var baseAttack:int;//基础攻击
		public var extAttack:int;//附加攻击
		public var attackType:int//攻击类型
		public var baseSpeed:int;//武器速度
		public var levelRequire:int;//等级限制
		public var baseStr:int;//基础力量
		public var extStr:int;//附加力量
		public var baseVit:int;//基础耐力
		public var extVit:int;//附加耐力
		public var baseDex:int;//基础敏捷
		public var extDex:int;//附加敏捷
		public var baseWis:int;//基础智力
		public var extWis:int;//附加智力
		public var basePhysicalAttack:int;//基础物理攻击附加
		public var extPhysicalAttack:int;//附加物理攻击附加
		public var baseMagicAttack:int;//基础魔法攻击附加
		public var extMagicAttack:int;//附加魔法攻击附加
		public var basePhysicalDefense:int;//基础物理防御附加
		public var extPhysicalDefense:int;//附加魔法防御附加
		public var baseMagicDefense:int;//基础魔法攻击附加
		public var extMagicDefense:int;//附加魔法攻击附加
		public var baseHpAdditional:int;//基础HP附加
		public var extHpAdditional:int;//附加HP附加
		public var baseHitAdditional:int;//基础命中附加
		public var extHitAdditional:int;//附加命中附加
		public var baseCritAdditional:int;//基础暴击附加
		public var extCritAdditional:int;//附加暴击附加
		public var baseDodgeAdditional:int;//基础闪避附加
		public var extDodgeAdditional:int;//附加闪避附加
		public var baseSpeedAdditional:int;//基础速度附加
		public var extSpeedAdditional:int;//附加速度附加
		public var equipEffect:String;//装备特效
		public var devilEffect:String;//附魔特效
		public var suiteEffect:String;//套装特效
		public var SuiteInfo:SuiteInfoVO = new SuiteInfoVO();//套装效果
		public var buyingRateCoin:int;//交易价格
		public var baseDurability:int;//基础耐久
		public var nowDurability:int;//当前耐久
		public var baseDefense:int;//基础防御
		public var extDefense:int;//附加防御
		public var stack:int;//物品的层叠数
		public var starLevel:int;//物品的星级
		public var icon:int;//物品的图标
		public var templateId:int;//物品的模板ID
		public var baseBlock:int;//基础抗暴
		public var extBlock:int;//附加抗暴
		//-------------背包格状态------------------
		public var tileState:int;//-1未激活1激活
		//-------------背包类型-------------------
		public var packageType:int;//0 全部 1装备2消耗品3材料4任务
		
		public var remainTime:int;//回购时间  回购时使用
		
		public var maxStack:int;//最大堆叠数
		
		public var itemPage:int;//物品的tips类型 1装备 2消耗品 3材料 4任务
		
		public var isBodyFlag:Boolean;//是否在身上装备
		public var inStrTileFlag:Boolean;//是否在强化栏中
		
		//镶嵌
		public var xqItemId1:int;//镶嵌位置1处的物品id
		public var xqDes1:String;//插槽一处的描述
		public var xqItemId2:int;//镶嵌位置2处的物品id
		public var xqDes2:String;//插槽二处的描述
		public var xqItemId3:int;//镶嵌位置3处的物品id
		public var xqDes3:String;//插槽三处的描述
		public var xqItemId4:int;//镶嵌位置4处的物品id
		public var xqDes4:String;//插槽四处的描述
		
		
		public function PackageItem()
		{
		}
	}
}
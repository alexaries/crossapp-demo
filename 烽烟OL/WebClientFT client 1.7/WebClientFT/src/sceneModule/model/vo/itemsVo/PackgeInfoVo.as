package sceneModule.model.vo.itemsVo
{
	import mx.collections.ArrayCollection;
	import mx.messaging.channels.StreamingAMFChannel;

	/**
	 * 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class PackgeInfoVo
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
		public var baseSpi:int;//基础精神
		public var extSpi:int;//附加精神
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
		public var baseMpAdditional:int;//基础MP附加
		public var extMpAdditional:int;//附加MP附加
		public var baseHitAdditional:int;//基础命中附加
		public var extHitAdditional:int;//附加命中附加
		public var baseCritAdditional:int;//基础暴击附加
		public var extCritAdditional:int;//附加暴击附加
		public var baseDodgeAdditional:int;//基础闪避附加
		public var extDodgeAdditional:int;//附加闪避附加
		public var baseSquelchAdditional:int;//基础反击附加
		public var extSquelchAdditional:int;//附加反击附加
		public var baseSpeedAdditional:int;//基础速度附加
		public var extSpeedAdditional:int;//附加速度附加
		public var baseBogeyAdditional:int;//基础破防附加
		public var extBogeyAdditional:int;//附加破防附加
		public var equipEffect:String;//装备特效
		public var devilEffect:String;//附魔特效
		public var suiteEffect:String;//套装特效
		public var SuiteItems:ArrayCollection = new ArrayCollection();//套装效果
		public var buyingRateCoin:int;//交易价格
		public var baseDurability:int;//基础耐久
		public var nowDurability:int;//当前耐久
		public var baseDefense:int;//基础防御
		public var extDefense:int;//附加防御
		public var stack:int;//物品的层叠数
		public var starLevel:int;//物品的星级
		public var icon:int;//物品的图标
		public var templateId:int;//物品的模板ID
		public var remainTime:int;//物品剩余时间  购回时使用
		public function PackgeInfoVo()
		{
		}
	}
}
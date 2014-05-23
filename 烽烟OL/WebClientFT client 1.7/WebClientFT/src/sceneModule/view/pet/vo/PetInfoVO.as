package sceneModule.view.pet.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 宠物信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class PetInfoVO
	{
		public var petId:int;//宠物id
		public var resPetId:int;//宠物资源id
		public var petName:String;//宠物名称
		public var petLevel:int;//宠物等级
		public var inMatrixFlag:Boolean;//是否在阵法中
		public var petDes:String;//宠物描述
		public var baseHp:int;//基础血量
		public var manualHp:int;//血量加成
		public var basePhyAttack:int;//基础物理攻击
		public var manualPhyAttack:int;//物理攻击加成
		public var baseMagicAttack:int;//基础魔法攻击
		public var manualMagicAttack:int;//魔法攻击加成
		public var basePhyDefense:int;//基础物理防御
		public var manualPhyDefense:int;//物理防御加成
		public var baseMagicDefense:int;//基础魔法防御
		public var manualMagicDefense:int;//魔法防御加成
		public var baseHitRate:int;//基础命中
		public var manualHitRate:int;//命中加成
		public var baseDodgeRate:int;//基础闪避
		public var manualDodgeRate:int;//闪避加成
		public var baseSpeed:int;//基础攻击速度
		public var manualSpeed:int;//基础速度加成
		public var baseCritRate:int;//基础暴击
		public var manualCritRate:int;//暴击加成
		public var icon:int;//宠物的图标
		public var type:int;//宠物的图标类型
		public var flowFlag:Boolean;//是否跟随
		public var skillName:String;
		public var baseBlock:int;//基础抗暴
		public var manualBlock:int;//抗暴加成
		public var liliang:int;//力量
		public var zhili:int;//智力
		public var naili:int;//耐力
		public var minjie:int;//敏捷
		public var maxHp:int;//总血量
		public var curExp:int;//当前经验
		public var maxExp:int;//总经验
		public var curQuality:int;//当前品质0普通1优秀2精良3史诗5传说
		public var texing:String;//特性
		//宠物资质信息
		public var cur_zi_li:int;//当前力量资质
		public var max_zi_li:int;//最大力量资质
		public var cur_zi_zhi:int;//当前智力资质
		public var max_zi_zhi:int;//最大智力资质
		public var cur_zi_nai:int;//当前耐力资质
		public var max_zi_nai:int;//最大耐力资质
		public var cur_zi_min:int;//当前敏捷资质
		public var max_zi_min:int;//最大敏捷资质
		
		public var extendExp:int;//可传承经验
		public var reqCoin:int;//传承所需金币
		
		public var curHun:int;//图鉴当前惊魂
		public var maxHun:int;//图鉴最大惊魂
		public function PetInfoVO()
		{
		}
	}
}
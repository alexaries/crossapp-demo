package sceneModule.model.vo
{
	/**
	 * 其他角色信息 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class OtherRoleInfoVo
	{
		public var roleId:int;     //角色id
		public var isShow:Boolean;
		public var roleName:String;  //用户名
		public var roletype:int; //角色类型（vip）
		public var level:int;//角色等级
		public var profession:int;//角色职业
		public var energy:int;//角色的活力
		public var rank:String;//角色的军衔
		public var guildname:String;// 角色行会的名称
		public var manualStr:int; //玩家自定义加的力量点数
		public var manualVit:int;//玩家自定义加的体质(耐力)点数
		public var manualDex:int;//玩家自定义加的灵巧(敏捷)点数
		public var manualWis:int;//自定义加上的智力
		public var manualSpi:int;//自定义加的精神
		public var sparePoint:int;//剩余点数
		public var maxHp:int;//最大血量
		public var hp:int;//当前血量
		public var maxMp:int;//最大魔法值
		public var mp:int;//当前魔法值
		public var exp:int;//当前经验值
		public var maxExp:int;//升级所需经验值
		public var physicalAttack:Number;//物理攻击
		public var magicAttack:Number;//魔法攻击
		public var physicalDefense:Number;//物理防御
		public var magicDefense:Number;//魔法防御
		public var speed:Number;//速度
		public var squelch:Number;//反击
		public var critRate:Number;//暴击
		public var hitRate:Number;//命中
		public var dodgeRate:Number;//闪避
		public var ignore:Number;//破甲（破防）
		public var gold:int;//魔钻(金币)
		public var coupon:int;//魔晶(礼券)
		public var coin:int;//游戏币
		public var deposit:int;//存款
		public var appellation:AppellationInfoVo = new AppellationInfoVo();//称号
		public function OtherRoleInfoVo()
		{
		}
	}
}
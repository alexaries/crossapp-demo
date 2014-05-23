package sceneModule.model.vo
{
	import flashx.textLayout.formats.Float;
	
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.vo.corpsVO.RoleCorpsInfoVO;

	/**
	 * 角色信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class RoleInfoVo
	{
		public var id:int;     //角色id
		public var isShow:Boolean;
		public var nickname:String;  //用户名
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
		public var maxHp:int;//最大血量
		public var hp:int;//当前血量
		public var exp:int;//当前经验值
		public var maxExp:int;//升级所需经验值
		public var physicalAttack:Number;//物理攻击
		public var magicAttack:Number;//魔法攻击
		public var physicalDefense:Number;//物理防御
		public var magicDefense:Number;//魔法防御
		public var speed:Number;//速度
		public var critRate:Number;//暴击
		public var hitRate:Number;//命中
		public var dodgeRate:Number;//闪避
		public var gold:int;//魔钻(金币)
		public var coin:int;//游戏币
		public var deposit:int;//存款
		public var block:Number;//抗爆

		
		//军团加成数据
		public var exULiliang:int;	//军团加成力量
		public var exUMinjie:int;	//军团加成敏捷
		public var exUZhili:int;	//军团加成智力
		public var exUNaili:int;	//军团加成耐力
		public var exUWugong:int;	//军团加成物攻
		public var exUMogong:int;	//军团加成魔攻
		
		public var unionType:String;	//军团阵营
		
		public var campid:int;
		
		public var roleCorpsInfo:RoleCorpsInfoVO = new RoleCorpsInfoVO();//角色军团信息
		public var appellation:AppellationInfoVo = new AppellationInfoVo();//称号
		public var appellationArr:ArrayCollection = new ArrayCollection();//称号 AppellationInfoVo
		
		public var otherRoleItemsInfo:ArrayCollection = new ArrayCollection();//
		
		public var buyHLcount:int;//已购买活力值次数
		
		public function RoleInfoVo()
		{
		}
	}
}
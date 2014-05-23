package sceneModule.model.vo.shopVo
{
	/**
	 * 商店信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class MainShopInfoVo
	{
		public var id:int;
		public var name:String;
		public var description:String;
		public var icon:String;
		public var qualityLevel:int;//物品品质等级
		public var levelRequire:int;//物品装备需求等级
		public var minDamage:int;//最小伤害
		public var maxDamage:int;//最大伤害
		public var defense:int;//防御值
		public var professionRequire:int;//职业要求
		public var strRequire:int;//力量需求
		public var dexRequire:int;//灵巧需求
		public var vitRequire:int;//体质需求
		public var type:int;//物品类型
		public var druability:int;//耐久度
		public var bind:int;//绑定方式 0=非绑定物品1=拾取即绑定 2=装备即绑定
		public var aliveTime:int;//剩余时间(天) -1：表示无时间限制
		public var bodyType:int;//-1 非装备 0 头部（帽子）1 #身体（上衣） 2 #腰带 3 #下装 4 #鞋子 5 #护腕 6 #披风 7 #项链 8 #腰饰 9 #武器
		public var promotion:int;//促销分类 1=新品2=热卖3=特价4=限量 -1表示没有促销分类
		public var price:int; //价格
		public var priceType:int;// 1为魔钻价格 2为魔晶价格    魔钻价格(人民币) 魔晶价格(礼券)}
		public var restrict:int;//购买数量限制  -1为无限制
	    public var maxstack:int;//物品的最大堆叠数量
		public var remainTime:int;//剩余时间
		public function MainShopInfoVo()
		{
		}
	}
}
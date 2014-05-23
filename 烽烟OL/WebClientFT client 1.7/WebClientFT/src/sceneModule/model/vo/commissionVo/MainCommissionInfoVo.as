package sceneModule.model.vo.commissionVo
{
	import mx.collections.ArrayCollection;
    
	[Bindable]
	public class MainCommissionInfoVo
	{
		public var consignmentTyp:int;//拍卖的物品类型货币需要单独处理 -1金币兑换钻  -2钻兑换金币 0以上的是物品
		public var minLevel:int;//等级下限
		public var maxLevel:int;//等级上限
		public var itemQuality:int;//品质0全部1垃圾(灰色)2较差(白色)普通(绿色)优秀(蓝色)史诗(紫色)神器(橙色)逆天(红色)
		public var sortType:int;//排序方式0为降序1升序
		public var sortName:int;//排序名称0名称1等级2剩余时间3出售者4价格
		public var itemName:String;
		public var searchFlag:Boolean;//是否是搜索
		public var curPage:int;
		public var maxPage:int;
		public var commissionList:ArrayCollection = new ArrayCollection();//CommissionInfoVo
		public function MainCommissionInfoVo()
		{
		}
	}
}
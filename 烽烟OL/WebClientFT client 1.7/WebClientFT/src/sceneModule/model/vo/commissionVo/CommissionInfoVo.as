package sceneModule.model.vo.commissionVo
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 寄卖物品信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindbable]
	public class CommissionInfoVo
	{
		public var consignmentId:int;//拍卖id     
		public var operationTime:String;//剩余时间
		public var ownerName:String;//出售者
		public var moneyType:int;//货币类型0金币1钻石
		public var moneyNum:int;//价格
		public var sellMoneyNum:int;//出售的金币或钻石的数量
		public var item:PackageItem = new PackageItem();
		public function CommissionInfoVo()
		{
		}
	}
}
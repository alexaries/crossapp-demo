package sceneModule.model.vo.commissionVo
{
	/**
	 * 寄卖金币信息VO
	 */
	[Bindable]
	public class CommissionGlodInfoVo
	{
		public var consignmentId:int; //寄卖信息的id
		public var goldNum:int; //金币的数量
		public var ownerId:int; //寄卖者的id
		public var coinPrice:int; //寄卖的价格
		public var operationTime:String; //寄卖的时间
		public function CommissionGlodInfoVo()
		{
		}
	}
}
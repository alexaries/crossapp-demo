package sceneModule.view.zhanxing.vo
{
	import mx.collections.ArrayCollection;
	
//	import proto.zhanxing.XingYunBasicInfo;
	

	[Bindable]
	public class ExchangeInfo
	{
		public var xingYun:XingYunBasicInfoVO= new XingYunBasicInfoVO();//
		public var jifengValue:int; //积分兑换值
		public var wId:int;//物品id
		

		public function ExchangeInfo()
		{
		}
	}
}

package sceneModule.model.vo.commissionVo
{
	/**
	 * 价格走势数据VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class TrendVo
	{
		public var recordData:String; //日期
		public var unitPrice:int;  //平均价格
		public function TrendVo()
		{
		}
	}
}
package sceneModule.model.vo.buffVO
{
	/**
	 * Buff信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class BuffInfoVO
	{
		public var buffId:int;//Buff的id
		public var buffName:String;//Buff名称
		public var buffDes:String;//Buff描述
		public var type:int;//物品的类型
		public var icon:int;//物品的图标
		public var timeAndCountFlag:int;//标志位0时间（秒）1剩余总量
		public var timeOrCount:int;//时间或总量
		public function BuffInfoVO()
		{
		}
	}
}
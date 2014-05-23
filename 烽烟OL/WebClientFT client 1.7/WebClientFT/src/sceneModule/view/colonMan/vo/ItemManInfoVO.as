package sceneModule.view.colonMan.vo
{
	/**
	 * 药剂信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class ItemManInfoVO
	{
		public var status:int;//药剂状态0未激活1激活
		public var remainTime:int;//剩余时间
		public function ItemManInfoVO()
		{
		}
	}
}
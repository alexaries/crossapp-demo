package sceneModule.view.guanjue.vo
{
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.vo.packageVo.PackageItem;

	[Bindable]
	public class Wupin
	{
		public var itemInfo:PackageItem = new PackageItem(); 	//物品
		public var id:int; //物品模板id
		public var name:String; //物品名称
		public var count:int; //物品数量
		public var weiwang:int; //奖励的威望值
		public var adddq:int; //是否可以上交
		public var wy:String; //唯一标识

		public function Wupin()
		{
		}
	}
}

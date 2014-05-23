package sceneModule.view.zhanxing.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class JiFengExch
	{

		public var exchInfo:ArrayCollection=new ArrayCollection();//积分兑换信息
		public var jiFengTotal:int; //总积分
		public var curpage:int; //当前页
		public var totalpage:int; //总页
		

		public function JiFengExch()
		{
		}
	}
}

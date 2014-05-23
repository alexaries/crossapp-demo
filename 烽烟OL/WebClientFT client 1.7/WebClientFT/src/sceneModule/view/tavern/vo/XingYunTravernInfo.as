package sceneModule.view.tavern.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 魔兽酒馆信息幸运值
	 *
	 */
	[Bindable]
	public class XingYunTravernInfo
	{
		public var xingYunwowInfo:ArrayCollection=new ArrayCollection() ; //魔兽信息
		public var page:int;//当前页数
		public var zong:int;//总页数

		public function XingYunTravernInfo()
		{
		}
	}
}

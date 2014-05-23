package sceneModule.view.tavern.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 魔兽酒馆
	 *
	 */
	[Bindable]
	public class WOW
	{
		public var wowInfo:ArrayCollection=new ArrayCollection() ; //魔兽信息
		public var fashiPet:ArrayCollection=new ArrayCollection() ; //法师宠物
		public var zhanshiPet:ArrayCollection=new ArrayCollection() ; //战士宠物
		public var youxiaPet:ArrayCollection=new ArrayCollection() ; //游侠宠物
		public var xingyunzhi:int;//幸运值
		public var refreshTime:int;//刷新时间
		public var isClose:Boolean;//是否关闭提示
		public var shengYuCiShu:int;//刷新剩余次数

		public function WOW()
		{
		}
	}
}

package sceneModule.view.vip.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MainVIPInfoVO
	{
		public var viplevel:int;//VIP的等级
		public var exp:int;//当前的VIP经验
		public var maxexp:int;//升级最大的经验
		public var msg:String;//升级的提示
		public var vipinfoList:ArrayCollection = new ArrayCollection();//VIP权限信息VIPInfoVO
		public function MainVIPInfoVO()
		{
		}
	}
}
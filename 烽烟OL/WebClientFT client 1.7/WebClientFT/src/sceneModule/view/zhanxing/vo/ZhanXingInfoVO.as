package sceneModule.view.zhanxing.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ZhanXingInfoVO
	{
		public var xyList:ArrayCollection = new ArrayCollection();//XingYunBasicInfoVO
		public var curBX:int=1;//当前可以点击的宝箱最大索引
		public var maxCount:int=2;//积分
		public var pkXYInfoList:ArrayCollection = new ArrayCollection();//XingYunPackInfoVO
		public var ropInfoList:ArrayCollection = new ArrayCollection();//RoleOrPetBasicInfoVO
		public var dataCollection:ArrayCollection = new ArrayCollection();
		public function ZhanXingInfoVO()
		{
		}
	}
}
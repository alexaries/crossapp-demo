package sceneModule.view.group.vo
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class MainGroupInfoVO
	{
		public var curPage:int=1;
		public var maxPage:int=1;
		public var duiWuInfo:ArrayCollection = new ArrayCollection();// DuiWuInfoVO
		public var dwmemberInfo:ArrayCollection = new ArrayCollection();//DWMemberInfoVO
		public var inGroupFlag:Boolean = false;//是否在队伍
		public var isLeader:Boolean=false;
		public var memberInfo:ArrayCollection = new ArrayCollection();//DWMemberInfoVO
		public var dwId:int;
		public function MainGroupInfoVO()
		{
		}
	}
}
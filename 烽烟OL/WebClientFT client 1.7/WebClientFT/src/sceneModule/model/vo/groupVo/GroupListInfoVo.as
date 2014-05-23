package sceneModule.model.vo.groupVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 队伍集合信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class GroupListInfoVo
	{
		public var groupList:ArrayCollection = new ArrayCollection();//队伍集合 GroupInfoVo
		public var curPage:int;//当前页
		public var maxPage:int;//总共页数
		public function GroupListInfoVo()
		{
		}
	}
}
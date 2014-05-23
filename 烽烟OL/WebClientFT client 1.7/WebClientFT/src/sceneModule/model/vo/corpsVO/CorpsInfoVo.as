package sceneModule.model.vo.corpsVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 军团信息 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class CorpsInfoVo
	{
		public var curPage:int;//当前页数据
		public var maxPage:int;//总页数
		public var corpsListInfo:ArrayCollection = new ArrayCollection();//军团信息 CorpsListInfoVo
		public var corpsMembersAndAppliList:ArrayCollection = new ArrayCollection();//军团成员列表和申请入团列表CorpsMemberAndAppliVO
		public var corpsEmblemInfo:CorpsEmblemInfoVO = new CorpsEmblemInfoVO();//军徽信息
		public var corpsTechnologyList:ArrayCollection = new ArrayCollection();//军团科技CorpsTechnologyInfoVo
		public function CorpsInfoVo()
		{
		}
	}
}
package sceneModule.view.colonMan.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 殖民管理信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class MainColoManInfoVO
	{
		public var curPage:int;//页数
		public var maxPage:int;//总页数
		public var copyInfoArr:ArrayCollection=new ArrayCollection();//副本列表CopyInfoInfoVO
		public function MainColoManInfoVO()
		{
		}
	}
}
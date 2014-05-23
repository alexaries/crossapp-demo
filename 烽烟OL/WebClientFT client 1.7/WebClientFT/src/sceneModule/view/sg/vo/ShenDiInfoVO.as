package sceneModule.view.sg.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 神邸信息VO 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class ShenDiInfoVO
	{
		public var douqi:int;
		public var des:String;
		public var curPage:int;//当前页
		public var maxPage:int;//最大页
		public var nextBtnFlag:Boolean;//下一页按钮是否可以点击
		public var shenGeList:ArrayCollection = new ArrayCollection();//ShenGeInfo 
		public function ShenDiInfoVO()
		{
		}
	}
}
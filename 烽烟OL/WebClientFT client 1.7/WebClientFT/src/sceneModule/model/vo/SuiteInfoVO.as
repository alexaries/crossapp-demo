package sceneModule.model.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 套装信息VO 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class SuiteInfoVO
	{
		public var suitename:String;//套装名称
		public var nowcnt:int;//套装当前数量
		public var maxcnt:int;//套装总件数
		public var suiteeffctArr:ArrayCollection = new ArrayCollection();//效果列表SuiteEffectInfoVO
		public function SuiteInfoVO()
		{
		}
	}
}
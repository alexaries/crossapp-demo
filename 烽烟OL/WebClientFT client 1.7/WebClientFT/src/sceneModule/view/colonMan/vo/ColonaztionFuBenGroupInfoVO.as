package sceneModule.view.colonMan.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 副本组副本信息VO 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class ColonaztionFuBenGroupInfoVO
	{
		public var curColonaztionDes:String;
		public var fubenList:ArrayCollection = new ArrayCollection();//副本集合 ColonaztionFuBenInfoVO
		public function ColonaztionFuBenGroupInfoVO()
		{
		}
	}
}
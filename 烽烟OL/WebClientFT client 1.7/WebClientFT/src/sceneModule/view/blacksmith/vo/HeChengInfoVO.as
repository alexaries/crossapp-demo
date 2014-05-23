package sceneModule.view.blacksmith.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 合成信息VO
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class HeChengInfoVO
	{
		public var equiplist:ArrayCollection = new ArrayCollection();//合成装备的配方 HeChenInfoVO
		public var gemlist:ArrayCollection = new ArrayCollection();//合成宝石的配方
		public function HeChengInfoVO()
		{
		}
	}
}
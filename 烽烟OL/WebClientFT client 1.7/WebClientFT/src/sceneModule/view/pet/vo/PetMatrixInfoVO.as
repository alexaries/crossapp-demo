package sceneModule.view.pet.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 宠物阵法信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class PetMatrixInfoVO
	{
		public var jwDes:String;//爵位描述
		public var curNum:int;//阵法名称
		public var maxNum:int;//阵法描述
		public var matrixTitleList:ArrayCollection = new ArrayCollection();//阵法格子信息MatrixTitleInfoVO
		public function PetMatrixInfoVO()
		{
		}
	}
}
package sceneModule.view.pet.vo
{
	/**
	 * 阵法格子信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class PetMatrixTitleInfoVO
	{
		public var titlePos:int;//当前格子所在位置默认第一个从0开始
		public var hasPet:Boolean;//是否存在宠物
		public var petId:int;//宠物id
		public var type:int;//宠物资源id
		public var icon:int;
		public function PetMatrixTitleInfoVO()
		{
		}
	}
}
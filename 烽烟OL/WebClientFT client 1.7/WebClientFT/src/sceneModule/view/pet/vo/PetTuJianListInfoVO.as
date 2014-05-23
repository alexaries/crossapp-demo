package sceneModule.view.pet.vo
{
	import mx.collections.ArrayCollection;
    [Bindable]
	public class PetTuJianListInfoVO
	{
		public var sjPro:int;//当前收集完成度
		public var curPage:int;//当前页
		public var maxPage:int;//总页数
		public var sjListPet:ArrayCollection = new ArrayCollection();//宠物信息集合
		public function PetTuJianListInfoVO()
		{
		}
	}
}
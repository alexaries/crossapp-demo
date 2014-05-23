package sceneModule.view.territory.model
{
	[Bindable]
	public class TerritoryPetInfoVO
	{
		public var petId:int;//宠物id
		public var resPetId:int;//宠物资源id
		public var petName:String;//宠物名称
		public var petLevel:int;//宠物等级
		public var icon:int;//宠物的图标
		public var type:int;//宠物的图标类型
		public var runningFlag:Boolean;//是否正在训练中
		public var remainTime:int;//训练剩余时间
		public function TerritoryPetInfoVO()
		{
		}
	}
}
package sceneModule.view.groupBattle.vo
{
	[Bindable]
	public class CityInfoVO
	{
		public var lzName:String;//领主军团名称
		public var lzIcon:int;//领主军团军徽
		public var tzName:String;//挑战军团名称
		public var tzIcon:int;//挑战军团军徽
		public var btnState:int;//按钮状态0挑战1等待征战2征战中
		public var cityId:int;
		public function CityInfoVO()
		{
		}
	}
}
package sceneModule.view.group.vo
{
	[Bindable]
	public class DWMemberInfoVO
	{
		public var roleId:int;
		public var roleName:String;
		public var level:int;
		public var proType:int;//职业类型
		public var pos:int;//所在阵法位置索引
		public var funType:String = 'Create';
		public var dType:int;
		public function DWMemberInfoVO()
		{
		}
	}
}
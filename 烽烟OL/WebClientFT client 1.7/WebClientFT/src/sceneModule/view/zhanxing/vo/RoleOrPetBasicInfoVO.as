package sceneModule.view.zhanxing.vo
{
	[Bindable]
	public class RoleOrPetBasicInfoVO
	{
		public var rpId:int;//角色或宠物id
		public var rpName:String;//角色或宠物名称
		public var rpLevel:int;//角色或宠物等级
		public var icon:int;//图片资源
		public var xyBody1:XingYunBasicInfoVO = new XingYunBasicInfoVO();
		public var xyBody2:XingYunBasicInfoVO = new XingYunBasicInfoVO();
		public var xyBody3:XingYunBasicInfoVO = new XingYunBasicInfoVO();
		public var xyBody4:XingYunBasicInfoVO = new XingYunBasicInfoVO();
		public var xyBody5:XingYunBasicInfoVO = new XingYunBasicInfoVO();
		public var xyBody6:XingYunBasicInfoVO = new XingYunBasicInfoVO();
		public function RoleOrPetBasicInfoVO()
		{
		}
	}
}
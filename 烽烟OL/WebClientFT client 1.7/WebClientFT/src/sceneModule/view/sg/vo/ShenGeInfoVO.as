package sceneModule.view.sg.vo
{
	/**
	 * 神格信息VO 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class ShenGeInfoVO
	{
		public var sgID:int;//神格id
		public var sgType:int;//神格类型1=力量2=自然3=大地4=时间5=命运6=光明7=黑暗
		public var sgName:String;//神格名称
		public var activateFlag:Boolean;//是否激活
		public var reqDQ:int;//所需斗气值
		public var sgDes:String;//神格描述
		public var reqLev:int;//等级需求
		public function ShenGeInfoVO()
		{
		}
	}
}
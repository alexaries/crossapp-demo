package sceneModule.model.vo.corpsVO
{
	/**
	 * 军团科技信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class CorpsTechnologyInfoVo
	{
		public var technologyId:int;//科技id
		public var technologyImg:int;//科技图标
		public var technologyName:String;//科技名称
		public var technologyLevel:int;//科技等级
		public var remainCondition:String;//需求条件
		public var curSchedule:int;//当前进度
		public var maxSchedule:int;//最大进度
		public var technologyDes:String;//科技描述
		public var defaultDonate:Boolean;//是否默认捐献
		public function CorpsTechnologyInfoVo()
		{
		}
	}
}
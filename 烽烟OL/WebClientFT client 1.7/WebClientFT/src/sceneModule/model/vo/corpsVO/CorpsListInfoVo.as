package sceneModule.model.vo.corpsVO
{
	/**
	 * 军团信息 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class CorpsListInfoVo
	{
		public var corpsId:int;//军团id
		public var corpsImg:int;//军徽 
		public var corpsName:String;//军团名称
		public var corpsChief:String;//军团长
		public var corpsLevel:int;//军团等级
		public var curNum:int;//当前军团人数
		public var maxNum:int;//军团总人数
		public var onApplication:Boolean;//是否申请了次军团
		public var corpsTitle:String;//军团称号
		public var corpsAnnouncement:String;//军团公告
		public var corpRunningFlag:Boolean = true;//是否在线
		public var levReq:int;//等级限制
		public function CorpsListInfoVo()
		{
		}
	}
}
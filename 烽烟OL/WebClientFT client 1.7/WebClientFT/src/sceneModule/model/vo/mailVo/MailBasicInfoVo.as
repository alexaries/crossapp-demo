package sceneModule.model.vo.mailVo
{
	/**
	 * 邮件信息vo 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]	
	public class MailBasicInfoVo
	{
		public var mailId:int;//邮件id
		public var mailState:int;//邮件状态 0 为读 1已读
		public var mailFromType:int;//0系统1玩家
		public var mailTitle:String;//邮件标题
		public var mialSendTime:String;//发送邮件时间
		public var mailFrom:int;//发信者
		public var mailContent:String;//邮件内容
		public var outline:String; //邮件内容概要
		public function MailBasicInfoVo()
		{
		}
	}
}
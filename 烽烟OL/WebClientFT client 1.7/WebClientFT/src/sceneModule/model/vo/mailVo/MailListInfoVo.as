package sceneModule.model.vo.mailVo
{
	import mx.collections.ArrayCollection;

	/**
	 * 邮件集合信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class MailListInfoVo
	{
		public var curPage:int;//当前页数
		public var maxPage:int;//总页数
		public var responseMailType:int;//邮件类型
		public var mailinfo:ArrayCollection = new ArrayCollection;//邮件列表 MailBasicInfoVo
		public function MailListInfoVo()
		{
		}
	}
}
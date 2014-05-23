package sceneModule.view.chat.vo
{
	/**
	 * 私聊对象信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class WhisperChatObjectInfoVO
	{
		public var chatObjectId:int;//私聊对象id
		public var name:String;//私聊对象名称
		public var level:String;//私聊对象等级
		public var perfession:String;//私聊对象职业
		public var chatObjectPos:String;//私聊对象所在城镇
		public var  readFlag:Boolean;//是否已读
		public function WhisperChatObjectInfoVO()
		{
		}
	}
}
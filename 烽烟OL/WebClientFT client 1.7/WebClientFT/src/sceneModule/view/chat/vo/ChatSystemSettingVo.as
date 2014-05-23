package sceneModule.view.chat.vo
{
	/**
	 * 聊天系统设置信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class ChatSystemSettingVo
	{
		public var systemCK:Boolean;//是否接受系统讯息
		public var showCK:Boolean;//是否接受提示讯息
		public var commonCK:Boolean;//是否接受一般聊天
		public var groupCK:Boolean;//是否接受队伍频道
		public var corpsCK:Boolean;//是否接受军团讯息
		public var selfCK:Boolean;//是否接受密语讯息
		public function ChatSystemSettingVo()
		{
		}
	}
}
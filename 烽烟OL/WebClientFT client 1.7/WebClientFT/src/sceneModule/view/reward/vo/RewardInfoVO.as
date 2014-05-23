package sceneModule.view.reward.vo
{
	/**
	 * 奖励信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class RewardInfoVO
	{
		public var r_id:int;//奖励信息id
		public var r_type:int;//奖励类型0为副本1为城镇
		public var t_name:String;//城镇或副本名称
		public var t_e1:String;//属性1 如果是城镇则是城镇总收入，如果是副本则是副本通关次数
		public var t_e2:String;//属性2 如果是城镇则是税收比例,如果是副本则是通关奖励
		public var t_e3:String;//属性3 税收
		public var t_e4:Boolean;//属性4 是否达到税收最大值 True or False
		public function RewardInfoVO()
		{
		}
	}
}
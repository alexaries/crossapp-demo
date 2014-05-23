package sceneModule.view.pray.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 祈祷信息VO 
	 * 
	 */	
	[Bindable]
	public class PrayInfoVo
	{
		public var prayDes:String;//祈祷描述
		public var needDiamond:int;//祈祷需要钻
		public var remainTimes:int;//剩余祈祷次数
		public var otherPrayMsg:ArrayCollection=new ArrayCollection();//其他玩家祈祷信息
		public var tempStr:String="";
		public var reTime:int=0;//剩余时间
		public function PrayInfoVo()
		{
		}
	}
}
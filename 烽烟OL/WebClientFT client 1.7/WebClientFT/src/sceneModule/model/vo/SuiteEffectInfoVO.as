package sceneModule.model.vo
{
	[Bindable]
	public class SuiteEffectInfoVO
	{
		public var properName:String;//套装效果描述
		public var enable:Boolean;//效果是否可用
		public var curProper:int = -2;
		public var maxProper:int = -1;
		public function SuiteEffectInfoVO()
		{
		}
	}
}
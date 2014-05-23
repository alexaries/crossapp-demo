package sceneModule.view.guanjue.vo
{
	import mx.collections.ArrayCollection;

	/**
	 * 官爵信息VO 
	 * 
	 */	
	[Bindable]
	public class GuanJueInfoVo
	{
		public var currentJuewei:String;//当前爵位
		public var weiwang:int;//当前威望
		public var currentJinbi:int;//当前金币
		public var currentDouqi:int;//当前斗气
		public var nextJuewei:String;//下级爵位
		public var nextWeiwang:int;//下级威望
		public var nextJinbi:int;//下级金币
		public var nextDouqi:int;//下级斗气
		public var curpage:int;//当前页
		public var totalpage:int;//总共页
		public var isjw:Boolean;//是否可以升级爵位
		public var hasGetSalary:Boolean;//是否领取爵禄
		public var level:int;//限制等级
		public var adddq:ArrayCollection=new ArrayCollection();//当前增加属性及其数值
		public var addxj:ArrayCollection=new ArrayCollection();//下级增加属性及其数值
		public var ftime:ArrayCollection=new ArrayCollection();//爵史时间列表
		public var fcontext:ArrayCollection=new ArrayCollection();//封爵史内容列表
		public var tempStr:String="";
		
		public function GuanJueInfoVo()
		{
		}
	}
}
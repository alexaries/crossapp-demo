package sceneModule.model.vo.taskVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 任务详细信息VO 
	 * @author Yaolx
	 * 
	 */	
	[Bindable]
	public class TaskBasicInfoVo
	{
		public var id:int;
		public var name:String;
		public var description:String;//任务描述
		public var processinfolist:ArrayCollection = new ArrayCollection();//任务进度列表  TaskProcessInfoVo
		public var ExpBound:int;//任务经验奖励
		public var coinBound:int;//游戏币奖励
		public var couponBound:int;//礼券奖励
		public var requiredItemBound:ArrayCollection = new ArrayCollection();//物品奖励   PackgeInfoVo
		public var optionalItemBound:ArrayCollection = new ArrayCollection();//可选物品奖励 packgeInfoVo
		public var gloryBound:int; //军衔值奖励
		public var providerID:int;//任务提供者ID
		public var reporterID:int;//任务完成NPC的ID
		public function TaskBasicInfoVo()
		{
		}
	}
}
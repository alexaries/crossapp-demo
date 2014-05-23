package sceneModule.model.vo.copySceneVo
{
	/**
	 * 副本信息VO 
	 * @author Yaolx
	 */	
	[Bindable]
	public class CopySceneInfoVo
	{
		public var name:String;//副本名称
		public var id:int;//副本id
		public var state:int;//副本状态
		public var numbers:int;//推荐人数
		public var score:int;//通关副本评分
		public function CopySceneInfoVo()
		{
		}
	}
}
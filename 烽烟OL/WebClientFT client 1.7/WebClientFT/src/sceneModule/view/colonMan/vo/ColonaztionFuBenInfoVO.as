package sceneModule.view.colonMan.vo
{
	/**
	 * 殖民特权副本信息 
	 * @author DreamY
	 * 
	 */	
	[Bindable]
	public class ColonaztionFuBenInfoVO
	{
		public var fuBenId:int;//副本id
		public var fuBenName:String;//副本名称
		public var coloCorpsName:String;//殖民军团名称
		public var lingzhu:String;//领主
		public var coloType:int;//占领类型0为占领1己方占领2其他军团占领
		public var _fu_camp:int;//0中立1光明2黑暗
		public function ColonaztionFuBenInfoVO()
		{
		}
	}
}
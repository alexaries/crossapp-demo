
package sceneModule.model.vo.rankingVO
{
	import sceneModule.model.vo.packageVo.PackageItem;

	/**
	 * 评分信息VO 
	 */	
    
	[Bindable]
	public class RankingScoreInfoVO
	{
		public var score:int;//
		public var packgeInfo:PackageItem = new PackageItem();
		public function RankingScoreInfoVO()
		{
		}
	}
}
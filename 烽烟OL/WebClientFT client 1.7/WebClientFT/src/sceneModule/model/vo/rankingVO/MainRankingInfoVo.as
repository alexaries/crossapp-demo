package sceneModule.model.vo.rankingVO
{
	import mx.collections.ArrayCollection;

	/**
	 * 排行榜信息VO 
	 * @author Dream-Y
	 * 
	 */	
	[Bindable]
	public class MainRankingInfoVo
	{
		public var rankingInfoList:ArrayCollection = new ArrayCollection();//RankingInfoVo
		public var myRanking:String;
		public var refreshTime:String;
//		public var workType:int;//职业类型0全部1战士2法师3牧师4游侠
//		public var operType:int;//操作类型 0获取所有 1查询 2我的排名
//		public var rankingType:int;//排行分类类型
//		public var curPage:int;
//		public var maxPage:int;
		public function MainRankingInfoVo()
		{
		}
		
		public static function getRankingTypeOnSelected(selStr:Object):int{
			var index:int;
			switch(selStr){
				case '个人等级':
					index = 1;
					break;
				case '个人战力':
					index = 2;
					break;
				case '军团等级':
					index = 3;
					break;
				case '军团战力':
					index = 4;
					break;
			}
			return index;
		}
	}
}
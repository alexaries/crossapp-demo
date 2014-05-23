package sceneModule.model.vo.battleVo
{
	import mx.collections.ArrayCollection;
	
	import sceneModule.model.vo.packageVo.PackageItem;

    [Bindable]
	public class BattleOverFlipItemInfoVo
	{
		public var cardId:int;     //卡片的id
		public var nickName:String;
		public var coinBounds:int; //铜币奖励
		
		public var itemBound:PackageItem = new PackageItem();
		
		public function BattleOverFlipItemInfoVo()
		{
		}
	}
}
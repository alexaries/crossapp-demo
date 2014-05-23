package sceneModule.view.battle.command
{
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.Suite;
	import proto.battle.battle705.cardsInfo;
	import proto.battle.battle705.getAllCardInfoResponse;
	
	import resource.CrotaItemConfig;
	
	import sceneModule.model.vo.battleVo.BattleOverFlipItemInfoVo;
	import sceneModule.model.vo.packageVo.PackageSuite;
	import sceneModule.view.battle.event.BattleOverGetItemInfoResponseEvent;
	
	import util.PackageIitemInfoSettingUtil;

	/**
	 * 获取战后结束物品信息返回值处理事件 
	 * @author Yaolx
	 * 
	 */	
	public class BattleOverGetItemInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:BattleOverGetItemInfoResponseEvent;
		public function BattleOverGetItemInfoResponseCommand()
		{
			super();
		}
		
		override public function execute():void{
			var responseData:getAllCardInfoResponse = new getAllCardInfoResponse();
			responseData.readExternal(evt.byteArray);
			if(responseData.result && responseData.data){
				var l:int = responseData.data.card.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int =0;i<l;i++){
					var cardsInfoVo:cardsInfo = responseData.data.card[i];
					var battleOverFlipItemVo:BattleOverFlipItemInfoVo = new BattleOverFlipItemInfoVo();
					    battleOverFlipItemVo.cardId = cardsInfoVo.cardId;
						battleOverFlipItemVo.coinBounds =cardsInfoVo.coinBounds;
						if(cardsInfoVo.itemBound){
							battleOverFlipItemVo.itemBound = CrotaItemConfig.getItemInfoByTempleteId(cardsInfoVo.itemBound.itemId);
							if(battleOverFlipItemVo.itemBound){
								battleOverFlipItemVo.itemBound.stack = cardsInfoVo.itemBound.stack;
							}
						}
												
						arr.addItem(battleOverFlipItemVo);
				}
				SystemDataModel.battleOverItemInfoCollection.source = arr.toArray();
			}
		}
	}
}
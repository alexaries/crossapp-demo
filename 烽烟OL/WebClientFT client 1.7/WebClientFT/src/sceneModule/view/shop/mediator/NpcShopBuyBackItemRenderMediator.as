package sceneModule.view.shop.mediator
{
	/**
	 * NPC商店回购Mediator 
	 */	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.shop.view.NpcShopBuyBackItemRender;
	
	import service.ISocketServer;

	public class NpcShopBuyBackItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:NpcShopBuyBackItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		public function NpcShopBuyBackItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.btnBackBuy,MouseEvent.CLICK,onBuyBack);
		}
		/**
		 * 物品回购
		 */
		private function onBuyBack(evt:MouseEvent):void{
			//TODO
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
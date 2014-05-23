package sceneModule.view.battle.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.battle.battle707.TurnCardRequest;
	import proto.battle.battle707.TurnCardResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.battle.event.BattleFlipSendSelectedEvemt;
	import sceneModule.view.popupWin.IPopUpShow;
	
	import service.ISocketServer;

	public class BattleFlipItemRenderMediator extends Mediator
	{
		[Inject]
		public var socketService:ISocketServer; 
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		public function BattleFlipItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.addViewListener(BattleFlipSendSelectedEvemt.SENDSELECTEDCOMMAND,onSendSelectedItem);
		}
		
		/**
		 * 发送选中牌子事件请求
		 */
		private var selectIndex:int;
		private function onSendSelectedItem(evt:BattleFlipSendSelectedEvemt):void{
			//发送翻牌子请求
			selectIndex = evt.selectedIndex;
			if(SystemDataModel.flipCount >=1){
				if(SystemDataModel.roleInfo.roletype > SystemDataModel.flipCount){
					popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_fdpz')+
						(SystemDataModel.flipCount)*2+CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_zhuan')+"！！"+
							CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_isfan')+"？"
							,CrotaResourceConfig.getInstance().getTextByModuleAndId('battle','bfIRM_xxts'),null,
							CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qd'),
							CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_qx'),onSubmit);
				}
			}else{
				onSubmitHandler();
			}
			
		}
		private function onSubmit(evt:MouseEvent):void{
			onSubmitHandler();
		}
		private function onSubmitHandler():void{
			var turnCardRequest:TurnCardRequest = new TurnCardRequest();
			turnCardRequest.cardId = selectIndex;
			turnCardRequest.characterId = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			turnCardRequest.writeExternal(byteArray);
			socketService.send(new mx.rpc.Responder(resultHandler,faultHandler),URLConst.TURN_ITEM_COMMANDID,byteArray);
		}
		private function resultHandler(data:Object):void{
			var turnCardByteArray:ByteArray = data as ByteArray;
			var turnCardResponse:TurnCardResponse = new TurnCardResponse();
			turnCardResponse.readExternal(turnCardByteArray);
			if(!turnCardResponse.result){
				popUpShow.show(turnCardResponse.message);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
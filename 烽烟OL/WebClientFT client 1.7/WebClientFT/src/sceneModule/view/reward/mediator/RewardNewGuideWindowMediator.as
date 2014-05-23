package sceneModule.view.reward.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.activation.activation3000.ActivationRequest;
	
	import sceneModule.view.reward.view.RewardNewGuideWindow;
	
	import service.ISocketServer;

	public class RewardNewGuideWindowMediator extends Mediator
	{
		[Inject]
		public var comp:RewardNewGuideWindow;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		public function RewardNewGuideWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.obAllReBtn,MouseEvent.CLICK,onBaRe);
		}
		
		private function onBaRe(evt:MouseEvent):void{
			onObtainNewReward();
			onCloseWindow();
		}
		
		private function onObtainNewReward():void{
			var getNewReq:ActivationRequest = new ActivationRequest();
			getNewReq.id = SystemDataModel.roleId;
			getNewReq.keyType = 0;
			getNewReq.activation = comp.numTxt.text;
			var byteArray:ByteArray = new ByteArray();
			getNewReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(newRewardHandler,faultHandler),URLConst.REWARD_OBTAIN_NEW_COMMANDID,byteArray);
		}
		
		private function newRewardHandler(data:Object):void{
			
		}
		
		private function onCloseWindow(evt:MouseEvent = null):void{
			WindowManager.closeWindow(RewardNewGuideWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
package sceneModule.view.task.mediator
{
	import Animation.AnimationOnceManager;
	
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.task.task1402.applyQuestRequest;
	import proto.task.task1402.applyQuestResponse;
	
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.task.view.NewTaskComponent;
	
	import service.ISocketServer;

	public class NewTaskMediator extends Mediator
	{
		[Inject]
		public var comp:NewTaskComponent;
		
		[Inject]
		public var socketServer:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function NewTaskMediator()
		{
			super();
		}
		override public function onRegister():void{
			this.eventMap.mapListener(comp.accessBtn,MouseEvent.CLICK,onAccessClick);
		}
		/**
		 * 接受任务
		 */
		private function onAccessClick(evt:MouseEvent):void{
			var applyRequest:applyQuestRequest = new applyQuestRequest();
			applyRequest.id = SystemDataModel.roleId;
			applyRequest.taskId = comp.getTaskId;
			var applyByte:ByteArray = new ByteArray();
			applyRequest.writeExternal(applyByte);
			socketServer.send(new mx.rpc.Responder(applyHandler,faultHandler),URLConst.ACCESS_TASK_COMMANDID,applyByte);
			//关闭窗口
			comp.onCloseWindow();
		}
		private function applyHandler(data:Object):void{
			var responseByte:ByteArray = data as ByteArray;
			var responseData:applyQuestResponse = new applyQuestResponse();
			responseData.readExternal(responseByte);
			if(responseData.result){
				//添加接受任务动画
				var animation:AnimationOnceManager = new AnimationOnceManager(URLConst.ACCESS_TASK_URL);
				animation.addToParent();
				animation.setPosition(400,200);
				animation.play();
				//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACCEPT_TASK,responseData.data.taskId));
			}else{
				popUpShow.show(responseData.message);
			}
		}
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
package sceneModule.view.task.mediator
{
	import Animation.AnimationOnceManager;
	
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.task.task1402.applyQuestRequest;
	import proto.task.task1402.applyQuestResponse;
	import proto.task.task1403.commitQuestRequest;
	import proto.task.task1403.commitQuestResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.model.vo.taskVO.TaskInfoVo;
	import sceneModule.view.popupWin.IPopUpShow;
	import sceneModule.view.task.view.NewTaskComponent;
	import sceneModule.view.task.view.TaskNpcInfoComponent;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;

	public class TaskNpcInfoMediator extends Mediator
	{
		[Inject]
		public var comp:TaskNpcInfoComponent;
		
		[Inject]
		public var socketService:ISocketServer;
		
		[Inject]
		public var popUpShow:IPopUpShow;
		public function TaskNpcInfoMediator()
		{
			super();
		}
		override public function onRegister():void{
			eventMap.mapListener(comp.taskList,IndexChangeEvent.CHANGE,onListItemClick);
			eventMap.mapListener(comp.acceptBtn,MouseEvent.CLICK,onAcceptTask);
		    eventMap.mapListener(comp.functionBtn,MouseEvent.CLICK,onChangeDesClick);
		}
		
		private var taskInfoVo:TaskInfoVo;
		[Bindable]
		public var taskDes:String = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','tniM_des');
		
		private function onListItemClick(evt:IndexChangeEvent):void{			
			taskInfoVo = evt.currentTarget.selectedItem as TaskInfoVo;
			//根据任务类型做出相应的操作
			switch(taskInfoVo.taskType){
				case ProConst.NPCSELF:
//					onOpenNpcChatWindow(taskInfoVo.taskId,taskInfoVo.taskname);
					break;
				case ProConst.ACCESSTASK:
//					var newTaskComp:NewTaskComponent = new NewTaskComponent();
//					this.contextView.addChild(newTaskComp);
//					newTaskComp.x = FlexGlobals.topLevelApplication.width/2 - newTaskComp.width/2;
//					newTaskComp.y = FlexGlobals.topLevelApplication.height/2 - newTaskComp.height/2;
//					newTaskComp.setData = taskInfoVo;
					onClickTaskFunction();
					//可接
					//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_CONTROL, GuideInfo.ACTION_CLICK_ACCEPTED_TASK));
					break;
				case ProConst.PROGRESSTASK:
					//正在进行的任务
					//TODO
					break;
				case ProConst.FAILTASK:
					//失败的任务
					//TODO
					break;
				case ProConst.CANSUBMITTASK:
					//可提交的任务
					onSubmitTask(taskInfoVo.taskId);
					break;
			}
		}
		/**
		 * 点击任务后的操作
		 */
		private function onChangeDesClick(evt:MouseEvent):void{
			onClickTaskFunction();
		}
		private var nowShowType:int;//0显示任务对话1显示任务奖励
		private function onClickTaskFunction():void{
			comp.taskList.visible = false;
			comp.iLabel.visible = true;
			comp.functionBtn.visible = true;
			comp.acceptBtn.visible = true;
			if(nowShowType == 0){
				comp.iLabel.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','tniM_rwdh');
			}else{
				comp.iLabel.text = CrotaResourceConfig.getInstance().getTextByModuleAndId('task','tniM_rwjl');
			}
			
			comp.iDesLabel.visible = true;
			comp.iDesLabel.text = taskDes;
			if(nowShowType == 0){
				comp.functionBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('task','tniM_rwjl');
			}else{
				comp.functionBtn.label=CrotaResourceConfig.getInstance().getTextByModuleAndId('task','tniM_rwdh');
			}
			if(nowShowType == 0){
				nowShowType = 1;
			}else{
				nowShowType = 0;
			}
		}
		/**
		 * 接受任务
		 */
		private function onAcceptTask(evt:MouseEvent):void{
			var applyRequest:applyQuestRequest = new applyQuestRequest();
			applyRequest.id = SystemDataModel.roleId;
			applyRequest.taskId = taskInfoVo.taskId;
			var applyByte:ByteArray = new ByteArray();
			applyRequest.writeExternal(applyByte);
			socketService.send(new mx.rpc.Responder(applyHandler,faultHandler),URLConst.ACCESS_TASK_COMMANDID,applyByte);
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
		/**
		 * 提交任务
		 */
		private function onSubmitTask(taskId:int):void{
			var commitTaskRequest:commitQuestRequest = new commitQuestRequest();
			commitTaskRequest.id = SystemDataModel.roleId;
			commitTaskRequest.taskId = taskId;
			var commitTaskByte:ByteArray = new ByteArray();
			commitTaskRequest.writeExternal(commitTaskByte);
			socketService.send(new mx.rpc.Responder(commitTaskHandler,faultHandler),URLConst.COMMIT_TASK_COMMANDID,commitTaskByte);
		}
		/**
		 * 提交任务返回处理
		 */
		private function commitTaskHandler(data:Object):void{
			var commitByte:ByteArray = data as ByteArray;
			var taskResponseCom:commitQuestResponse = new commitQuestResponse();
			taskResponseCom.readExternal(commitByte);
			if(taskResponseCom.result){
				var animation:AnimationOnceManager = new AnimationOnceManager(URLConst.TASK_COMPLETE_URL);
				animation.addToParent();
				animation.setPosition(400,200);
				animation.play();
				//GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_FINISH_TASK,taskResponseCom.data.taskId));
			}
//			popUpShow.show(taskResponseCom.message);
		}
		/**
		 * faultHandler
		 */
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
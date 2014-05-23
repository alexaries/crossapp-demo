package sceneModule.view.task.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.task.task1404.ProcessInfo;
	import proto.task.task1404.QuestProcess;
	import proto.task.task1404.pushQuestProcessList;
	
	import sceneModule.model.vo.taskVO.TaskMainTrackingInfoVo;
	import sceneModule.model.vo.taskVO.TaskTrackingInfoVo;
	import sceneModule.view.task.event.TaskTrackingEvent;

	/**
	 * 任务追踪,服务器返回的已接受的任务列表 
	 * @author Yaolx
	 * 
	 */	
	public class TaskTrackingCommand extends Command
	{
		[Inject]
		public var evt:TaskTrackingEvent;
		public function TaskTrackingCommand()
		{
			super();
		}
		override public function execute():void{
			var mainTaskByte:ByteArray = evt._obj as ByteArray;
			var pushMainTask:pushQuestProcessList = new pushQuestProcessList();
			pushMainTask.readExternal(mainTaskByte);
			var tl:int = pushMainTask.questprocesslist.length;
			var mainTaskArr:ArrayCollection = new ArrayCollection();
			for(var ti:int=0;ti<tl;ti++){
				var questProcess:QuestProcess = pushMainTask.questprocesslist[ti];
				var taskMainTrackingInfoVo:TaskMainTrackingInfoVo = new TaskMainTrackingInfoVo();
				taskMainTrackingInfoVo.taskId = questProcess.taskId;
				taskMainTrackingInfoVo.taskName = questProcess.taskname;
				taskMainTrackingInfoVo.taskType = questProcess.tasktype;
				taskMainTrackingInfoVo.hasFinished = questProcess.hasFinished;
				taskMainTrackingInfoVo.finishedNpcId = questProcess.finishedNpcId;
				var ql:int = questProcess.processinfolist.length;
				var taskArr:ArrayCollection = new ArrayCollection();
				for(var qi:int = 0;qi<ql;qi++){
					var processInfo:ProcessInfo = questProcess.processinfolist[qi];
					var taskTrackingInfoVo:TaskTrackingInfoVo = new TaskTrackingInfoVo();
					taskTrackingInfoVo.achieveNum = processInfo.achieveNum;
					taskTrackingInfoVo.questGoalId = processInfo.questGoalId;
					taskTrackingInfoVo.requireNum = processInfo.requireNum;
					taskTrackingInfoVo.trackDesc = processInfo.trackDesc;
					taskTrackingInfoVo.trackID = processInfo.trackID;
					taskArr.addItem(taskTrackingInfoVo);
				}
				taskMainTrackingInfoVo.processinfolist.source = taskArr.toArray();
				//任务环数------------先放在此次需要修改-------------------
				taskMainTrackingInfoVo.circulatingCount = pushMainTask.circulatingCount;
				mainTaskArr.addItem(taskMainTrackingInfoVo);
			}
			SystemDataModel.taskMainTrackingList.source = mainTaskArr.toArray();
		}
	}
}
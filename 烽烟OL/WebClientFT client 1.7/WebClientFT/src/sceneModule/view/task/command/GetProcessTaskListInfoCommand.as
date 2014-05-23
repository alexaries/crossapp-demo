package sceneModule.view.task.command
{
	import flash.utils.ByteArray;
	
	import model.ProConst;
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.task.task1406.ProcessQuest;
	import proto.task.task1406.getProcessQuestListResponse;
	
	import sceneModule.model.vo.taskVO.TaskInfoVo;
	import sceneModule.view.task.event.GetProcessTaskListInfoEvent;

	/**
	 * 获取正在进行的任务列表信息 
	 * @author Yaolx
	 * 
	 */	
	public class GetProcessTaskListInfoCommand extends Command
	{
		[Inject]
		public var evt:GetProcessTaskListInfoEvent;
		public function GetProcessTaskListInfoCommand()
		{
			super();
		}
		
		override public function execute():void{
			var byteArray:ByteArray = evt._obj as ByteArray;
			var responseData:getProcessQuestListResponse = new getProcessQuestListResponse();
			responseData.readExternal(byteArray);
			if(responseData.result && responseData.data && responseData.data.progressingquestList){
				var taskArr:ArrayCollection = new ArrayCollection();
				//主线任务
				var mainTaskInfo:Object = new Object();
				mainTaskInfo.taskname = "主线任务";
				mainTaskInfo.children = new ArrayCollection();
				//支线任务
				var oneTaskInfo:Object = new Object();
				oneTaskInfo.taskname = "支线任务";
				oneTaskInfo.children = new ArrayCollection();
				//行会任务
				var familyTaskInfo:Object = new Object();
				familyTaskInfo.taskname = "行会任务";
				familyTaskInfo.children = new ArrayCollection();
				//环任务
				var cirTaskInfo:Object = new Object();
				cirTaskInfo.taskname = "环任务";
				cirTaskInfo.children = new ArrayCollection();
				
				var l:int = responseData.data.progressingquestList.length;
				for(var i:int = 0;i<l;i++){
					var taskInfo:ProcessQuest = responseData.data.progressingquestList[i];
					var taskInfoVo:TaskInfoVo = new TaskInfoVo();
					taskInfoVo.taskId = taskInfo.taskId;
					taskInfoVo.taskname = taskInfo.taskname;
					var taskType:int = SystemDataModel.taskInfoXML.row.(@id == taskInfo.taskId).task_type;
					taskInfoVo.taskType = taskType;
					switch(taskType){
						case ProConst.MAINTASKLINE:
							mainTaskInfo.children.addItem(taskInfoVo);
							break;
						case ProConst.ONETASKLINE:
							oneTaskInfo.children.addItem(taskInfoVo);
							break;
						case ProConst.CIRCLETASKLINE:
							familyTaskInfo.children.addItem(taskInfoVo);
							break;
						case ProConst.FAMILYTASKLINE:
							cirTaskInfo.children.addItem(taskInfoVo);
							break;
					}
				}
				
				taskArr.addItem(mainTaskInfo);
				taskArr.addItem(oneTaskInfo);
				taskArr.addItem(familyTaskInfo);
				taskArr.addItem(cirTaskInfo);
				
				SystemDataModel.mainTaskInfoList.source = taskArr.toArray();
			}
		}
	}
}
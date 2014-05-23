package sceneModule.view.task.mediator
{
	import event.GuidClearEvent;
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.TextEvent;
	
	import model.GuideInfo;
	import model.ProConst;
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.task.command.TaskMessage;
	import sceneModule.view.task.view.TaskComponent;
	
	import util.xtrace;

	public class TaskMediator extends Mediator
	{
		[Inject]
		public var comp:TaskComponent;
		
		public function TaskMediator()
		{
			super();
		}
		override public function onRegister():void{
			eventMap.mapListener(comp.taskTxt,TextEvent.LINK,onLink);
		}
		
		private function onLink(evt:TextEvent):void{
			var link_str:String = evt.text;
			xtrace("任务追踪寻路",link_str);
			
			if(ProConst.MAX_CITY_ID < SystemDataModel.placeId){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('task','tM_fbwf'));
				return;
			}
			
			TaskMessage.getInstance().find_path(link_str);
			//characterOp.findPath(SystemDataModel.roleId,trackId);
		}
	}
}
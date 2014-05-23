package sceneModule.view.calendar.command
{
	import flash.utils.ByteArray;
	
	import model.SystemDataModel;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	import proto.calendar.Bound;
	import proto.calendar.GetCalendarTaskInfoResponse;
	import proto.calendar.Schedule;
	
	import sceneModule.view.calendar.event.CalendarEvent;

	public class GetCalendarInfoResponseCommand extends Command
	{
		[Inject]
		public var evt:CalendarEvent;

		public function GetCalendarInfoResponseCommand()
		{
			super();
		}

		override public function execute():void
		{
			var byteArray:ByteArray=evt._obj as ByteArray;
			var responseData:GetCalendarTaskInfoResponse=new GetCalendarTaskInfoResponse();
			responseData.readExternal(byteArray);
			if (responseData.result && responseData.data)
			{
				var unfin:int=responseData.data.unfinished.length;
				var fin:int=responseData.data.finished.length;
				var bou:int=responseData.data.scheduleBound.length;
				
				var unfinArr:ArrayCollection=new ArrayCollection();
				var finArr:ArrayCollection=new ArrayCollection();
				var boundArr:ArrayCollection=new ArrayCollection();
				var totalLivenessNum:int
				
				for (var i:int=0; i < unfin; i++)
				{
					var unscheduleInfoVo:Schedule = responseData.data.unfinished[i];
					var unfinished:Schedule=new Schedule();
					unfinished.activity=unscheduleInfoVo.activity;
					unfinished.desc=unscheduleInfoVo.desc;
					unfinished.now=unscheduleInfoVo.now;
					unfinished.total=unscheduleInfoVo.total;
					unfinArr.addItem(unfinished);
				}

				for (var j:int=0; j < fin; j++)
				{
					var finscheduleInfoVo:Schedule = responseData.data.finished[j];
					var finished:Schedule=new Schedule();
					finished.activity=finscheduleInfoVo.activity;
					finished.desc=finscheduleInfoVo.desc;
					finished.now=finscheduleInfoVo.now;
					finished.total=finscheduleInfoVo.total;
					finArr.addItem(finished);
				}
				
				for(var k:int=0;k<bou;k++)
				{
					var boundVo:Bound=responseData.data.scheduleBound[k];
					var bound:Bound=new Bound();
					bound.step=boundVo.step;
					bound.received=boundVo.received;
					boundArr.addItem(bound);
				}
				SystemDataModel.calendarTaskInfo.unfinished.source=unfinArr.toArray();
				SystemDataModel.calendarTaskInfo.finished.source=finArr.toArray();
				SystemDataModel.calendarTaskInfo.scheduleBound.source=boundArr.toArray();
				SystemDataModel.calendarTaskInfo.totalLivenessNum=responseData.data.totalLivenessNum;
			}
		}
	}
}

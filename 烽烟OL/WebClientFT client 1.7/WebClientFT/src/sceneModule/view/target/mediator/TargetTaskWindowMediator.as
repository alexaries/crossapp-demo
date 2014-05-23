package sceneModule.view.target.mediator
{
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.events.ItemClickEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.guaji.guaji3203.DayListTaskInfo;
	import proto.guaji.guaji3203.DayTaskInfo;
	import proto.guaji.guaji3203.GetTargetInfoRequest;
	import proto.guaji.guaji3203.GetTargetInfoResponse;
	import proto.guaji.guaji3203.RewardInfo;
	import proto.guaji.guaji3204.ObtainTargetRewardRequest;
	import proto.guaji.guaji3204.ObtainTargetRewardResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.event.MediatorRegisterItemEuipmentEvent;
	import sceneModule.view.target.view.TargetTaskWindow;
	import sceneModule.view.target.vo.DayListTaskInfoVO;
	import sceneModule.view.target.vo.DayTaskInfoVO;
	import sceneModule.view.target.vo.RewardInfoVO;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;

	public class TargetTaskWindowMediator extends Mediator
	{
		[Inject]
		public var comp:TargetTaskWindow;
		
		[Inject]
		public var socket:ISocketServer;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function TargetTaskWindowMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onSetTaskListData);
			
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCloseWindow);
			
			this.eventMap.mapListener(comp.rBtn,MouseEvent.CLICK,onObtainReward);
			
			this.eventMap.mapListener(comp.taskList,IndexChangeEvent.CHANGE,onIndexChange);
			
			getTargetInfo();
			comp.addEventListener(MediatorRegisterItemEuipmentEvent.MEDIATORREGISTERCOMMISSIONITEMEUIPMENT,onRegisterMediatorItem);
		}
		
		private function onRegisterMediatorItem(evt:MediatorRegisterItemEuipmentEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
			setTaskInfo(comp.taskList.selectedIndex);
		}
		
		private function onObtainReward(evt:MouseEvent):void{
			if(comp.taskList.selectedItem){
				var obtainReq:ObtainTargetRewardRequest = new ObtainTargetRewardRequest();
				obtainReq.id = SystemDataModel.roleId;
				obtainReq.taskId = comp.taskList.selectedItem.taskId;
				var byteArray:ByteArray = new ByteArray();
				obtainReq.writeExternal(byteArray);
				socket.send(new mx.rpc.Responder(obtainHandler,faultHandler),URLConst.TARGET_OBTAIN_REWARD_COMMANDID,byteArray);
			}
		}
		
		private function obtainHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:ObtainTargetRewardResponse = new ObtainTargetRewardResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				getTargetInfo();
				
				//comp.rBtn.visible = false;
				comp.obImg.visible = true;
			}
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(TargetTaskWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function onSetTaskListData(evt:ItemClickEvent):void{
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_1'):
					comp.curIndex = 0;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_2'):
					comp.curIndex = 1;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_3'):
					comp.curIndex = 2;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_4'):
					comp.curIndex = 3;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_5'):
					comp.curIndex = 4;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_6'):
					comp.curIndex = 5;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_7'):
					comp.curIndex = 6;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_8'):
					comp.curIndex = 7;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_9'):
					comp.curIndex = 8;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('target','ttWM_0'):
					comp.curIndex = 9;
					break;
			}
			setTaskInfo();
		}
		
		private function setTaskInfo(index:int=0):void{
			if(comp.taskList.selectedItem){
				comp.taskList.selectedIndex = index;
				comp.l_msg0.text = comp.taskList.selectedItem.taskDes;
				comp.rewardList.dataProvider = comp.taskList.selectedItem.rewardInfoList;
			}
		}
		
		private function onJiaShuJu():void{
				var l:int = 10;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var dayTaskInfoVo:DayTaskInfoVO = new DayTaskInfoVO();
					dayTaskInfoVo.isOpenFlag = true;
					dayTaskInfoVo.isSucFlag = false;
					
					var l2:int = 5;
					var arr2:ArrayCollection = new ArrayCollection();
					for(var i2:int=0;i2<l2;i2++){
						var dayListTaskInfoVo:DayListTaskInfoVO = new DayListTaskInfoVO();
						dayListTaskInfoVo.icon = '5001.png';
						dayListTaskInfoVo.isCompleteFlag = false;
						dayListTaskInfoVo.isObtainFlag = false;
						dayListTaskInfoVo.taskDes = '大法官拉丝粉';
						dayListTaskInfoVo.taskId = i2;
						var l3:int = 3;
						var arr3:ArrayCollection = new ArrayCollection();
						for(var i3:int=0;i3<l3;i3++){
							var rewardInfoVo:RewardInfoVO = new RewardInfoVO();
							rewardInfoVo.icon = 110001;
							rewardInfoVo.itemId = i3;
							rewardInfoVo.stack = i3;
							rewardInfoVo.type = 110000;
							arr3.addItem(rewardInfoVo);
						}
						dayListTaskInfoVo.rewardInfoList.source = arr3.toArray();
						arr2.addItem(dayListTaskInfoVo);
					}
					dayTaskInfoVo.dayListTaskInfo.source = arr2.toArray();
					arr.addItem(dayTaskInfoVo);
				}
				SystemDataModel.targetInfoList.source = arr.toArray();
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		private function getTargetInfo():void{
			var getTargetInfoReq:GetTargetInfoRequest = new GetTargetInfoRequest();
			getTargetInfoReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getTargetInfoReq.writeExternal(byteArray);
			socket.send(new mx.rpc.Responder(targetHandler,faultHandler),URLConst.TARGET_GETINFO_COMMANDID,byteArray);
		}
		private var firstFlag:Boolean = true;
		private function targetHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetTargetInfoResponse = new GetTargetInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.dayTaskInfo.length;
				var arr:ArrayCollection = new ArrayCollection();
				for(var i:int=0;i<l;i++){
					var dayTaskInfo:DayTaskInfo = responseData.dayTaskInfo[i];
					var dayTaskInfoVo:DayTaskInfoVO = new DayTaskInfoVO();
					dayTaskInfoVo.isOpenFlag = dayTaskInfo.isOpenFlag;
					dayTaskInfoVo.isSucFlag = dayTaskInfo.isSucFlag;
					
					var l2:int = dayTaskInfo.dayListTaskInfo.length;
					var arr2:ArrayCollection = new ArrayCollection();
					for(var i2:int=0;i2<l2;i2++){
						var dayListTaskInfo:DayListTaskInfo = dayTaskInfo.dayListTaskInfo[i2];
						var dayListTaskInfoVo:DayListTaskInfoVO = new DayListTaskInfoVO();
						dayListTaskInfoVo.icon = dayListTaskInfo.icon;
						dayListTaskInfoVo.isCompleteFlag = dayListTaskInfo.isCompleteFlag;
						dayListTaskInfoVo.isObtainFlag = dayListTaskInfo.isObtainFlag;
						dayListTaskInfoVo.taskDes = dayListTaskInfo.taskDes;
						dayListTaskInfoVo.taskId = dayListTaskInfo.taskId;
						var l3:int = dayListTaskInfo.rewardInfo.length;
						var arr3:ArrayCollection = new ArrayCollection();
						for(var i3:int=0;i3<l3;i3++){
							var rewardInfo:RewardInfo = dayListTaskInfo.rewardInfo[i3]; 
							var rewardInfoVo:RewardInfoVO = new RewardInfoVO();
							rewardInfoVo.icon = rewardInfo.icon;
							rewardInfoVo.itemId = rewardInfo.itemId;
							rewardInfoVo.stack = rewardInfo.stack;
							rewardInfoVo.type = rewardInfo.type;
							rewardInfoVo.rewardType = rewardInfo.rewardType;
							arr3.addItem(rewardInfoVo);
						}
						dayListTaskInfoVo.rewardInfoList.source = arr3.toArray();
						arr2.addItem(dayListTaskInfoVo);
					}
					dayTaskInfoVo.dayListTaskInfo.source = arr2.toArray();
					arr.addItem(dayTaskInfoVo);
				}
				SystemDataModel.targetInfoList.source = arr.toArray();
				comp.taskList.selectedIndex = 0;
				if(firstFlag){
					comp.l_msg0.text = SystemDataModel.targetInfoList.getItemAt(0).dayListTaskInfo[0].taskDes;
					comp.rewardList.dataProvider = SystemDataModel.targetInfoList.getItemAt(0).dayListTaskInfo[0].rewardInfoList;
					firstFlag = false;
				}
			}
		}
	}
}
package sceneModule.view.territory.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.territory.territory2805.GetAramListInfoRequest;
	import proto.territory.territory2805.GetAramListInfoResponse;
	import proto.territory.territory2805.PetAramInfo;
	import proto.territory.territory2806.AramStartXunLianRequest;
	import proto.territory.territory2806.AramStartXunLianResponse;
	import proto.territory.territory2807.JiaJiXunLianRequest;
	import proto.territory.territory2807.JiaJiXunLianResponse;
	import proto.territory.territory2808.AramLevelUpSpeedWaJueRequest;
	import proto.territory.territory2808.AramLevelUpSpeedWaJueResponse;
	import proto.territory.territory2809.AramNowSuccWaJueRequest;
	import proto.territory.territory2809.AramNowSuccWaJueResponse;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.nmall.model.MallMessage;
	import sceneModule.view.territory.event.RefreshTerritoryListInfoEvent;
	import sceneModule.view.territory.model.TerritoryPetInfoVO;
	import sceneModule.view.territory.view.AramWindow;
	
	import service.ISocketServer;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class AramWindowMediator extends Mediator
	{
		[Inject]
		public var comp:AramWindow;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		
		[Inject]
		public var socketServer:ISocketServer;
		public function AramWindowMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.clokeBtn,MouseEvent.CLICK,onCloseWindow);
			this.eventMap.mapListener(comp.petList,IndexChangeEvent.CHANGE,onIndexChange);
			this.eventMap.mapListener(comp.mySelf,MouseEvent.CLICK,onMySelfTer);
			this.eventMap.mapListener(comp.nowBtn,MouseEvent.CLICK,onNowSuc);
			this.eventMap.mapListener(comp.stBtn,MouseEvent.CLICK,onStartSuc);
			this.eventMap.mapListener(comp.dishiBtn,MouseEvent.CLICK,onJiaJiSuc);
//			this.eventMap.mapListener(comp.showPromptCB,FlexEvent.CHANGING,onChange);
			this.addViewListener(RefreshTerritoryListInfoEvent.REFRESHTERRITORYLISTINFOEVENT,onRefreshTer);
			getAramListInfo();
		}
		
		
		private function getAramFunType():int{
			if(comp.petList.selectedIndex == -1){
				return 0;//没有选择宠物
			}
			return 1;//选择宠物
		}
		
		private function getAramFunId():int{
			if(comp.petList.selectedIndex == -1){
				return SystemDataModel.roleId;
			}
			return comp.petList.selectedItem.petId;
		}
		
		private function onRefreshTer(evt:RefreshTerritoryListInfoEvent):void{
			getAramListInfo();
		}
		
		private function nowFinish(data:MouseEvent):void
		{
			var nowSucReq:AramNowSuccWaJueRequest = new AramNowSuccWaJueRequest();
			nowSucReq.id = SystemDataModel.roleId;
			nowSucReq.funId = getAramFunId();
			nowSucReq.type = getAramFunType();
			var byteArray:ByteArray = new ByteArray();
			nowSucReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(nowSucHandler,faultHandler),URLConst.TERRITORY_ARAM_NOWSUC_COMMANDID,byteArray);
		}
		
		//立即结束训练
		private function onNowSuc(evt:MouseEvent):void{
			if(comp.showPromptCB.selected)
			{
				nowFinish(evt);
			}else if(SystemDataModel.roleInfo.gold>=80&&comp.rb1.selected)
					{
						MallMessage.getInstance().popUpShow.show((comp.petList.selectedIndex == -1 ?CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf80')+SystemDataModel.roleInfo.level*600*8+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy'):CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf80')+comp.petList.selectedItem.petLevel*600*8+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy')),
							null, null, null, null, nowFinish, null);
					}
			else if(SystemDataModel.roleInfo.gold>=120&&comp.rb2.selected)
					{
						MallMessage.getInstance().popUpShow.show((comp.petList.selectedIndex == -1 ?CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf120')+SystemDataModel.roleInfo.level*600*12+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy'):CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf120')+comp.petList.selectedItem.petLevel*600*12+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy')),
							null, null, null, null, nowFinish, null);
					}
			else if(SystemDataModel.roleInfo.gold>=160&&comp.rb3.selected)
					{
						MallMessage.getInstance().popUpShow.show((comp.petList.selectedIndex == -1 ?CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf160')+SystemDataModel.roleInfo.level*600*16+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy'):CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf160')+comp.petList.selectedItem.petLevel*600*16+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy')),
							null, null, null, null, nowFinish, null);
					}
			else if(SystemDataModel.roleInfo.gold>=240&&comp.rb4.selected)
					{
						MallMessage.getInstance().popUpShow.show((comp.petList.selectedIndex == -1 ?CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf240')+SystemDataModel.roleInfo.level*600*24+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy'):CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_sf240')+comp.petList.selectedItem.petLevel*600*24+CrotaResourceConfig.getInstance().getTextByModuleAndId('common','comm_jy')),
							null, null, null, null, nowFinish, null);
					}
			
			else
				{
					CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_wfjs'));
				}
			
		}
		
		private function nowSucHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:AramNowSuccWaJueResponse = new AramNowSuccWaJueResponse();
			responseData.readExternal(byteArray);
			//结束训练后清除剩余时间和提示（针对宠物）
//			comp.ter_tile.text="";
//			comp.reward_tile0.text="";
			
			if(responseData.result){
//				comp.nowBtn.visible=false;
//				comp.rb1.enabled=true;
//				comp.rb2.enabled=true;
//				comp.rb3.enabled=true;
//				comp.rb4.enabled=true;
//				SystemDataModel.isPracbool=true;
				getAramListInfo();
			}else
			{
				
			}
			
		}
		
		
		//开始训练
		private function onStartSuc(evt:MouseEvent):void{
			
			var startReq:AramStartXunLianRequest = new AramStartXunLianRequest();
			startReq.id = SystemDataModel.roleId;
			startReq.type = getCurSelectedType();
			startReq.funId = getAramFunId();
			startReq.funType = getAramFunType();
			var byteArray:ByteArray = new ByteArray();
			startReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(startHandler,faultHandler),URLConst.TERRITORY_ARAM_STARTXUNLIAN_COMMANDID,byteArray);
		}
		private function startHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:AramStartXunLianResponse = new AramStartXunLianResponse();
			responseData.readExternal(byteArray);
			//开始训练后显示剩余时间和提示（针对宠物）
//			comp.ter_tile.visible=true;
			comp.reward_tile0.visible=true;
			
			
			if(responseData.result){
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_yks'));
//				setRb();
				
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_EXCUTE_QIANGHUA)]);
				getAramListInfo();
//				comp.rb1.enabled=false;
//				comp.rb2.enabled=false;
//				comp.rb3.enabled=false;
//				comp.rb4.enabled=false;
			}
			
//			trace("comp.ter_tile.visible__________"+comp.ter_tile.visible);
//			trace("comp.reward_tile0.visible__________"+comp.reward_tile0.visible);
			
			if(comp.petList.selectedIndex==0&&comp.petList.selectedItem>0)
			{
//				comp.ter_tile.visible=true;
				comp.reward_tile0.visible=true;
				getAramListInfo();
			}
		}
		
//		private function setRb():void
//		{
//			comp.rb1.enabled=false;
//			comp.rb2.enabled=false;
//			comp.rb3.enabled=false;
//			comp.rb4.enabled=false;
//		}
		
		//加急训练
		private function onJiaJiSuc(evt:MouseEvent):void{
			if(SystemDataModel.roleInfo.gold>0&&SystemDataModel.aramInfoVo.sptimes>0)
			{
				var jiajiReq:JiaJiXunLianRequest = new JiaJiXunLianRequest();
				jiajiReq.id = SystemDataModel.roleId;
				jiajiReq.funId = getAramFunId();
				jiajiReq.type = getAramFunType();
				var byteArray:ByteArray = new ByteArray();
				jiajiReq.writeExternal(byteArray);
				socketServer.send(new mx.rpc.Responder(jiajiHandler,faultHandler),URLConst.TERRITORY_ARAM_JIAJIXUNLIAN_COMMANDID,byteArray);
			}else if(SystemDataModel.roleInfo.gold>0&&SystemDataModel.aramInfoVo.sptimes<=0)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_csyw'));
			}else if(SystemDataModel.aramInfoVo.sptimes>0&&SystemDataModel.roleInfo.gold<=0)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_zbz'));
			}else if(SystemDataModel.aramInfoVo.sptimes<=0&&SystemDataModel.roleInfo.gold<=0)
			{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('territory','aWM_dbz'));
			}
			
		}
		
		private function jiajiHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:JiaJiXunLianResponse = new JiaJiXunLianResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				CrotaCommonAlert.createCrotaBasicAlert(responseData.message);
				getAramListInfo();
			}
		}
		
		//钻加速
//		private function onSpeedSuc(evt:MouseEvent):void{
//			var speedReq:AramLevelUpSpeedWaJueRequest = new AramLevelUpSpeedWaJueRequest();
//			speedReq.id = SystemDataModel.roleId;
//			speedReq.type = getCurSelectedType();
//			speedReq.funId = getAramFunId();
//			speedReq.funType = getAramFunType();
//			var byteArray:ByteArray = new ByteArray();
//			speedReq.writeExternal(byteArray);
//			socketServer.send(new mx.rpc.Responder(speedHandler,faultHandler),URLConst.TERRITORY_ARAM_LEVELUP_COMMANDID,byteArray);
//		}
//		private function speedHandler(data:Object):void{
//			var byteArray:ByteArray = data as ByteArray;
//			var responseData:AramLevelUpSpeedWaJueResponse = new AramLevelUpSpeedWaJueResponse();
//			responseData.readExternal(byteArray);
//			if(responseData.result){
//				getAramListInfo();
//			}
//		}
		
		private function getCurSelectedType():int{
			var iType:int;
			switch(comp.cardtype.selectedValue){
				case 'no1':
					iType = 1;
					break;
				case 'no2':
					iType = 2;
					break;
				case 'no3':
					iType = 3;
					break;
				case 'no4':
					iType = 4;
					break;
			}
			return iType;
		}
		
		private function getAramListInfo():void{
//			if(comp.nowBtn.visible==true)
//			{
//				setRb();
//			}
			
			var getAramListReq:GetAramListInfoRequest = new GetAramListInfoRequest();
			getAramListReq.id = SystemDataModel.roleId;
			var byteArray:ByteArray = new ByteArray();
			getAramListReq.writeExternal(byteArray);
			socketServer.send(new mx.rpc.Responder(getAramHandler,faultHandler),URLConst.TERRITORY_ARAM_GETLIST_COMMANDID,byteArray);
			
			
		}
		
		private function getAramHandler(data:Object):void{
			var byteArray:ByteArray = data as ByteArray;
			var responseData:GetAramListInfoResponse = new GetAramListInfoResponse();
			responseData.readExternal(byteArray);
			if(responseData.result){
				var l:int = responseData.petAramInfo.length;
				var petArr:ArrayCollection = new ArrayCollection();
				for(var i:int = 0;i<l;i++){
					var petInfo:PetAramInfo = responseData.petAramInfo[i];
					var terPetInfoVo:TerritoryPetInfoVO = new TerritoryPetInfoVO();
					terPetInfoVo.icon = petInfo.icon;
					terPetInfoVo.petId = petInfo.petId;
					terPetInfoVo.petLevel = petInfo.petLevel;
					terPetInfoVo.petName = petInfo.petName;
					terPetInfoVo.remainTime = petInfo.remainTime;
					terPetInfoVo.resPetId = petInfo.resPetId;
					terPetInfoVo.runningFlag = petInfo.runningFlag;
					terPetInfoVo.type = petInfo.type;
					petArr.addItem(terPetInfoVo);
					
					
				}
				SystemDataModel.aramInfoVo.roleRunningFlag = responseData.roleRunningFlag;
				SystemDataModel.aramInfoVo.roleRunTime = responseData.roleRunTime;
				SystemDataModel.aramInfoVo.sptimes = responseData.sptimes;
				SystemDataModel.aramInfoVo.expbound = responseData.expbound;
				SystemDataModel.aramInfoVo.goldreq = responseData.goldreq;
				
				SystemDataModel.aramInfoVo.petAramInfo.source = petArr.toArray();
//				comp.ter_tile.text='';
				comp.petList.selectedIndex = tempSlectedIndex;
				comp.setButtonAndLabelEnable();
				SystemDataModel.isPracbool=onCheckFlag();
				
				 
				 
			}
		}
		
		private function onCheckFlag():Boolean{
			if(SystemDataModel.aramInfoVo.roleRunningFlag)
			{
				return false;
			}else
			{
				for each(var petObj:TerritoryPetInfoVO in SystemDataModel.aramInfoVo.petAramInfo)
				{
					if(petObj.runningFlag)
					{
						return false;
					}
					
				}
			}
			return true;
		} 
		
		private function onMySelfTer(evt:MouseEvent):void{
			if(!comp.mySelf.selectedImg.visible){
				comp.mySelf.selectedImg.visible = true;
			}
			comp.petList.selectedIndex = -1;
			comp.setButtonAndLabelEnable();
		}
		private var tempSlectedIndex:int=-1;
		private function onIndexChange(evt:IndexChangeEvent):void{
			if(comp.mySelf.selectedImg.visible){
				comp.mySelf.selectedImg.visible = false;
//				comp.petList.selectedIndex = 0;
			}
			tempSlectedIndex = comp.petList.selectedIndex;
			if(comp.petList.selectedIndex==0)
			{
				getAramListInfo();
			}
			comp.setButtonAndLabelEnable();
			
//			getAramListInfo();
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(AramWindow.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
	}
}
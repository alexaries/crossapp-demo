package sceneModule.view.pet.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.events.ItemClickEvent;
	import mx.managers.DragManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.AssetCenter;
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.Alert.view.CrotaCommonAlert;
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.event.MediatorRegisterPetEvent;
	import sceneModule.view.pet.view.PetComponent;
	import sceneModule.view.pet.view.PetMatrixItemRender;
	import sceneModule.view.pet.vo.PetInfoVO;
	
	import spark.events.IndexChangeEvent;
	
	import util.DelayExcuter;

	public class PetComponentMediator extends Mediator
	{
		[Inject]
		public var comp:PetComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function PetComponentMediator()
		{
			super();
		}
		
		override public function preRegister():void{
			this.eventMap.mapListener(comp.cardtype,ItemClickEvent.ITEM_CLICK,onCardType);
			this.eventMap.mapListener(comp.petList,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(comp.petList,DragEvent.DRAG_DROP,onDragDrop);
			this.eventMap.mapListener(comp.petList,IndexChangeEvent.CHANGE,onIndexChange);
			comp.addEventListener(MediatorRegisterPetEvent.MR_PET_INFO,onRegisterMediatorItem);
			this.eventMap.mapListener(comp,MediatorRegisterPetEvent.MR_PET_ITEMRENDER,onCreatePetMediator);
			this.eventMap.mapListener(comp,MediatorRegisterPetEvent.MR_PET_MATRIXITEMRENDER,onCreatePetMediator);
			this.eventMap.mapListener(comp.closeBtn,MouseEvent.CLICK,onCloseWindow);
			onGetPetListInfo();
			comp.petList.selectedIndex = -1;
			SystemDataModel.otherPetInfoVo = new PetInfoVO();
		}
		private function onDragEnter(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(PetMatrixItemRender.DRAGFROMMATRIX)){
				var matrixComp:PetMatrixItemRender = evt.dragInitiator as PetMatrixItemRender;
				if(matrixComp.dataInfo && matrixComp.dataInfo.petId != 0){
					//如果宠物id为0 则说明是角色本身。角色本身一直处于出战中
					DragManager.acceptDragDrop(IUIComponent(evt.target));
				}
			}
		}
		
		private function onDragDrop(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(PetMatrixItemRender.DRAGFROMMATRIX)){
				var matrixComp:PetMatrixItemRender = evt.dragInitiator as PetMatrixItemRender;
//				onSettingPetInfo(matrixComp.dataInfo.petId,false);
				matrixComp.dataInfo.hasPet = false;
				matrixComp.dataInfo.petId = -1;
				matrixComp.dataInfo.type = 0;
				matrixComp.dataInfo.icon = 0;
				PetMessage.getInstance().sendModifyMatrixInfo(1,matrixComp.dataInfo.petId,matrixComp.dataInfo.titlePos);
			}
		}
		private function onCreatePetMediator(evt:MediatorRegisterPetEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onRegisterMediatorItem(evt:MediatorRegisterPetEvent):void{
			mediatorMap.createMediator(evt.view);
		}
		
		private function onGetPetListInfo():void{
			PetMessage.getInstance().getPetInfo();
		}
		
		private function onIndexChange(evt:IndexChangeEvent):void{
//			PetMessage.getInstance().getOnePetInfoJia();
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_sx'):
					PetMessage.getInstance().getOnePetInfo(comp.petList.selectedItem.petId,SystemDataModel.roleId);
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_py'):
					PetMessage.getInstance().getOnePetInfo(comp.petList.selectedItem.petId,SystemDataModel.roleId);
					
					if(comp.py.tLi.htmlText!=null)
					{
						comp.py.tLi.htmlText='';
						comp.py.tZhi.htmlText='';
						comp.py.tNai.htmlText='';
						comp.py.tMin.htmlText='';
						
						comp.py.trBtn.visible=true;
						comp.py.weiBtn.visible=false;
						comp.py.tiBtn.visible=false;
					}
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_bz'):
					
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_cc'):
					PetMessage.getInstance().getOnePetInfo(comp.petList.selectedItem.petId,SystemDataModel.roleId);
					PetMessage.getInstance().getBeiChuanChengList(comp.petList.selectedItem.petId);

					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_tj'):
					
					break;
			}
			
			
			
		}
		
		private function onCardType(evt:ItemClickEvent):void{
			comp.petList.selectedIndex = -1;
			SystemDataModel.otherPetInfoVo = new PetInfoVO();
			switch(comp.cardtype.selectedValue){
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_sx'):
					comp.iViewStack.selectedIndex = 0;
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_py'):
					setPeiYang();
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_bz'):
					onSetMatrix();
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_cc'):
					setChuanCheng();
					break;
				case CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_tj'):
					onOpenTuJian();
					
					break;
			}
			comp.curSelectedIndex = comp.cardtype.selectedValue;
		}
		
		private function setChuanCheng():void{
			if(SystemDataModel.roleInfo.level>=25){
				comp.iViewStack.selectedIndex = 3;
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.UI_PEI_CHUANGCHENG)]);

			}else{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('copyScene','cbbcSC_djbz25'));
			}
		}
		
		private function setPeiYang():void{
			if(SystemDataModel.roleInfo.level>=10){
				comp.iViewStack.selectedIndex = 1;
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.PET_PEIYANG)]);
			}else{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_djbz10'));
			}
			
		}
		
		private function to_prop():void{
			
		}
		
		private function onOpenTuJian():void{
			if(SystemDataModel.roleInfo.level>=4){
				comp.iViewStack.selectedIndex = 4;
				PetMessage.getInstance().getTuJianListInfo();
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_TUJIAN)]);
			}else{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_djbz4'));
			}
		}
		
		private function onSetMatrix():void{
			if(SystemDataModel.roleInfo.level>=4){
				comp.iViewStack.selectedIndex = 2;
				PetMessage.getInstance().getMatrixListInfo();
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_BUZHEN)]);
			}else{
				CrotaCommonAlert.createCrotaBasicAlert(CrotaResourceConfig.getInstance().getTextByModuleAndId('pet','pCM_djbz4'));
			}
		}
		
		private function onCloseWindow(evt:MouseEvent):void{
			WindowManager.closeWindow(PetComponent.NAME,false,false,WindowManager.CACHE_POLICY_NOT_CACHE,popUpWindowLayer,mediatorMap);
		}
	}
}
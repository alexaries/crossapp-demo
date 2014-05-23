package sceneModule.view.blacksmith.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.events.MouseEvent;
	
	import managers.WindowManager;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.blacksmith.command.BlacksmithMessage;
	import sceneModule.view.blacksmith.event.XiangQianDataChangeEvent;
	import sceneModule.view.blacksmith.view.XiangQianAndUnloadConfimComponent;
	import sceneModule.view.blacksmith.view.XiangQianComponent;
	import sceneModule.view.blacksmith.view.XiangQianItemRender;
	
	import spark.events.IndexChangeEvent;
	
	import util.CommonTools;
	import util.DelayExcuter;

	public class XiangQianComponentMediator extends Mediator
	{
		[Inject]
		public var comp:XiangQianComponent;
		
		[Inject]
		public var popUpWindowLayer:PopUpWindowLayer;
		public function XiangQianComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.s1,DragEvent.DRAG_ENTER,onDragS1Enter);
			this.eventMap.mapListener(comp.s2,DragEvent.DRAG_ENTER,onDragS1Enter);
			this.eventMap.mapListener(comp.s3,DragEvent.DRAG_ENTER,onDragS1Enter);
			this.eventMap.mapListener(comp.s4,DragEvent.DRAG_ENTER,onDragS1Enter);
			this.eventMap.mapListener(comp.s1,DragEvent.DRAG_DROP,onDragS1Drop);
			this.eventMap.mapListener(comp.s2,DragEvent.DRAG_DROP,onDragS2Drop);
			this.eventMap.mapListener(comp.s3,DragEvent.DRAG_DROP,onDragS3Drop);
			this.eventMap.mapListener(comp.s4,DragEvent.DRAG_DROP,onDragS4Drop);
			this.eventMap.mapListener(comp.equipment,IndexChangeEvent.CHANGE,onIndexChange);
			
			this.eventMap.mapListener(comp.s1,MouseEvent.CLICK,onMouseS1Down);
			this.eventMap.mapListener(comp.s2,MouseEvent.CLICK,onMouseS2Down);
			this.eventMap.mapListener(comp.s3,MouseEvent.CLICK,onMouseS3Down);
			this.eventMap.mapListener(comp.s4,MouseEvent.CLICK,onMouseS4Down);
			
			this.eventMap.mapListener(comp.unloadBtn,MouseEvent.CLICK,onUnload);
			
			BlacksmithMessage.getInstance().addEventListener(XiangQianDataChangeEvent.XIANGQIANDATACHANGE,onDataChange);
			
			this.eventMap.mapListener(comp.e_pre_btn,MouseEvent.CLICK,onPreEPage);
			this.eventMap.mapListener(comp.e_next_btn,MouseEvent.CLICK,onNextEPage);
			this.eventMap.mapListener(comp.s_pre_btn,MouseEvent.CLICK,onPreSPage);
			this.eventMap.mapListener(comp.s_next_btn,MouseEvent.CLICK,onNextSPage);
		}
		
		private function onPreEPage(evt:MouseEvent):void{
			BlacksmithMessage.getInstance().getXQPackInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.curPage - 1);
		}
		private function onNextEPage(evt:MouseEvent):void{
			BlacksmithMessage.getInstance().getXQPackInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_pack_info.curPage + 1);
		}
		private function onPreSPage(evt:MouseEvent):void{
			BlacksmithMessage.getInstance().getXQStoreInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.curPage - 1);
		}
		private function onNextSPage(evt:MouseEvent):void{
			BlacksmithMessage.getInstance().getXQStoreInfo(SystemDataModel.mainStrInfoVo.xqInfoVo.xq_store_info.curPage + 1);
		}
		
		
		
		private function onDataChange(evt:XiangQianDataChangeEvent):void{
			onIndexChange();
		}
		
		private function onMouseS1Down(evt:MouseEvent):void{
			if(comp.s1.data){
				comp.slStore = 1;
				comp.reqCoin.text=CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','hcCM_sxjb')+"："+CommonTools.getZhaiXiaReqCoin(comp.s1.data.levelRequire);
			}else{
				comp.slStore = 0;
			}
		}
		
		private function onMouseS2Down(evt:MouseEvent):void{
			if(comp.s2.data){
				comp.slStore = 2;
				comp.reqCoin.text=CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','hcCM_sxjb')+"："+CommonTools.getZhaiXiaReqCoin(comp.s2.data.levelRequire);
			}else{
				comp.slStore = 0;
			}
		}
		
		private function onMouseS3Down(evt:MouseEvent):void{
			if(comp.s3.data){
				comp.slStore = 3;
				comp.reqCoin.text=CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','hcCM_sxjb')+"："+CommonTools.getZhaiXiaReqCoin(comp.s3.data.levelRequire);
			}else{
				comp.slStore = 0;
			}
		}
		
		private function onMouseS4Down(evt:MouseEvent):void{
			if(comp.s4.data){
				comp.slStore = 4;
				comp.reqCoin.text=CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','hcCM_sxjb')+"："+CommonTools.getZhaiXiaReqCoin(comp.s4.data.levelRequire);
			}else{
				comp.slStore = 0;
			}
		}
		
		private function onMouseDown(evt:MouseEvent):void{
//			if(data && data.id){
//				var iu:IUIComponent=evt.target as IUIComponent;
//				var ds:DragSource=new DragSource();
//				ds.addData(data, XiangQianItemRender.DRAGNAME);
//				var dragProxy:Image = new Image();
//				dragProxy.width = 42;
//				dragProxy.height = 42;
//				dragProxy.source = (evt.targete as XiangQianItemRender).equipImg.source;
//				DragManager.doDrag(iu, ds, evt,dragProxy); // 开始拖动这个物体
//			}
		}
		
		private function onUnload(evt:MouseEvent):void{
			if(comp.slStore == 0)return;
			switch(comp.slStore){
				case 1:
					onUnLoad(comp.s1.data.id,1,comp.s1.data.name);
					break;
				case 2:
					onUnLoad(comp.s2.data.id,2,comp.s2.data.name);
					break;
				case 3:
					onUnLoad(comp.s3.data.id,3,comp.s3.data.name);
					break;
				case 4:
					onUnLoad(comp.s4.data.id,4,comp.s4.data.name);
					break;
				case 0:
					
					break;
			}
			comp.slStore = 0;
		}
		
		private function onIndexChange(evt:IndexChangeEvent = null):void{
			comp.itemComp.data = comp.equipment.selectedItem;
			comp.onSetXiangQianInfo();
			if(comp.itemComp.data!=null)
			{
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.XQ_CHOOSEBAO)]);
			}

		}
		
		private function onDragS1Enter(evt:DragEvent):void{
			if(evt.dragSource.dataForFormat(XiangQianItemRender.DRAGNAME)){
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}
		}
		
		private function onDragS1Drop(evt:DragEvent):void{
			onXiangQian(evt,1);
		}
		
		private function onDragS2Drop(evt:DragEvent):void{
			onXiangQian(evt,2);
		}
		
		private function onDragS3Drop(evt:DragEvent):void{
			onXiangQian(evt,3);
		}
		
		private function onDragS4Drop(evt:DragEvent):void{
			onXiangQian(evt,4);
		}
		
		private function onXiangQian(evt:DragEvent,pos:int):void{
			if(comp.itemComp.data){
				var itemObj:Object = evt.dragSource.dataForFormat(XiangQianItemRender.DRAGNAME);
				var obj:Object = new Object();
				obj.type = 0;//镶嵌
				if(comp.itemComp.data.isBodyFlag){
					obj.isBodyFlag = 2;
				}else{
					obj.isBodyFlag = 1;
				}
				obj.itemId = comp.itemComp.data.id;
				obj.sId = itemObj.id;
				obj.pos = pos;
				obj.des = CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','xqCM_sfj')+itemObj.name+CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','xqCM_xqz')+comp.itemComp.data.name+CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','xqCM_xyxh')+CommonTools.getXiangQianReqCoin(itemObj.levelRequire);
				WindowManager.createWindow(XiangQianAndUnloadConfimComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
				new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_OPEN_UI, GuideInfo.UI_QINGLUE_JIEGUO_CHENGGONG)]);

			}
		}
		private function onUnLoad(sId:int,pos:int,name:String):void{
			if(comp.itemComp.data){
				var obj:Object = new Object();
				obj.type = 1;//卸载
				if(comp.itemComp.data.isBodyFlag){
					obj.isBodyFlag = 2;
				}else{
					obj.isBodyFlag = 1;
				}
				obj.itemId = comp.itemComp.data.id;
				obj.sId = sId;
				obj.pos = pos;
				obj.des = CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','xqCM_iszc')+comp.itemComp.data.name+CrotaResourceConfig.getInstance().getTextByModuleAndId('blacksmith','xqCM_de')+name;
				WindowManager.createWindow(XiangQianAndUnloadConfimComponent.NAME,obj,null,false,false,false,null,mediatorMap,popUpWindowLayer,true);
			}
		}
	}
}
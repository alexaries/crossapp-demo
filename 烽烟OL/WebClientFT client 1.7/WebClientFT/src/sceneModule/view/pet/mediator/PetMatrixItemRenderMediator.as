package sceneModule.view.pet.mediator
{
	import event.GuidEvent;
	import event.GuidEventCenter;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import mediator.TaskGuideMediator;
	
	import model.GuideInfo;
	import model.SystemDataModel;
	import model.URLConst;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	import org.robotlegs.mvcs.Mediator;
	
	import proto.pet.pet2307.SettingMatrixRequest;
	import proto.pet.pet2307.SettingMatrixResponse;
	
	import sceneModule.view.pet.command.PetMessage;
	import sceneModule.view.pet.view.PetItemRender;
	import sceneModule.view.pet.view.PetMatrixItemRender;
	import sceneModule.view.pet.vo.PetMatrixInfoVO;
	import sceneModule.view.pet.vo.PetMatrixTitleInfoVO;
	
	import service.ISocketServer;
	
	import util.DelayExcuter;

	public class PetMatrixItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:PetMatrixItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		public function PetMatrixItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onDragStart);
			this.eventMap.mapListener(comp,DragEvent.DRAG_ENTER,onDragEnter);
			this.eventMap.mapListener(comp,DragEvent.DRAG_DROP,onDragDrop);
			this.eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
		}
		
		private var n:int;
		private function onMouseOver(evt:MouseEvent):void{
			n++;
//			trace("-------------------------onMouseOver"+n);
		}
		
		/**
		 * onDragStart 
		 * @param evt
		 * 
		 */		
		private function onDragStart(evt:MouseEvent):void{
			if(comp.dataInfo.hasPet){
				var ds:DragSource = new DragSource();
				ds.addData(comp.dataInfo as Object,PetMatrixItemRender.DRAGFROMMATRIX);
//				var dragProxy:PetMatrixItemRender = new PetMatrixItemRender();
//				dragProxy.width = comp.width;
//				dragProxy.height = comp.height;
//				dragProxy.dataInfo = comp.dataInfo;
//				dragProxy.mouseEnabled = false;
//				dragProxy.mouseChildren = false;
				var dragProxy:Image = new Image();
				dragProxy.width = 55;
				dragProxy.height = 55;
				dragProxy.source = comp.petImg.source;
				dragProxy.mouseEnabled = false;
				dragProxy.mouseChildren = false;
				DragManager.doDrag(comp,ds,evt,dragProxy);
				
				//去除拖拽的x号按钮
				var mgr:IStyleManager2  = FlexGlobals.topLevelApplication.styleManager;
				var selector:String = "mx.managers.DragManager";
				var decl:CSSStyleDeclaration = mgr.getStyleDeclaration(selector);
				if (!decl)
					decl = new CSSStyleDeclaration(selector);
				decl.setStyle("rejectCursor", Sprite);
				mgr.setStyleDeclaration(selector, decl, false);
			}
		}
		
		/**
		 *onDragEnter 
		 */		
		private function onDragEnter(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(PetItemRender.DRAGNAME) || evt.dragSource.hasFormat(PetMatrixItemRender.DRAGFROMMATRIX)){
				DragManager.acceptDragDrop(IUIComponent(evt.target));
			}
		}
		
		private function faultHandler(evt:FaultEvent):void{
			
		}
		
		/**
		 * onDragDrop 
		 */		
		private function onDragDrop(evt:DragEvent):void{
			if(evt.dragSource.hasFormat(PetItemRender.DRAGNAME)){
//				var petRender:PetItemRender = evt.dragInitiator as PetItemRender;
				var petObj:Object = evt.dragSource.dataForFormat(PetItemRender.DRAGNAME);
				
				
				//从宠物列表拖入的宠物 发送出战指令 TODO
				PetMessage.getInstance().sendModifyMatrixInfo(0, petObj.petId, 0, comp.dataInfo.titlePos,function():void{
					comp.dataInfo.petId = petObj.petId;
					comp.dataInfo.type = petObj.type;
					comp.dataInfo.icon = petObj.icon;
					comp.dataInfo.hasPet = true;
					//将宠物拖动到阵列
					new DelayExcuter(TaskGuideMediator.MAIN_PLAYER_DELAY, GuidEventCenter.getInstance().dispatchEvent, [new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_GET_PET)]);

				});
				//将宠物拖动到阵列后显示点击关闭指引
				GuidEventCenter.getInstance().dispatchEvent(new GuidEvent(GuideInfo.TYPE_ACTION_EXCUTE, GuideInfo.ACTION_DROP_PET));
			}else if(evt.dragSource.hasFormat(PetMatrixItemRender.DRAGFROMMATRIX)){
//				var fromComp:PetMatrixItemRender = evt.dragInitiator as PetMatrixItemRender;
				var fromComp:Object = evt.dragSource.dataForFormat(PetMatrixItemRender.DRAGFROMMATRIX);
				var tempInfo:PetMatrixTitleInfoVO = new PetMatrixTitleInfoVO();
				tempInfo.hasPet = comp.dataInfo.hasPet;
				tempInfo.petId = comp.dataInfo.petId;
				tempInfo.type = comp.dataInfo.type;
				tempInfo.icon = comp.dataInfo.icon;
				tempInfo.titlePos = comp.dataInfo.titlePos;
				if(comp.dataInfo.hasPet){
					
					
					//从宠物列表拖入的宠物 发送出战指令 TODO
					PetMessage.getInstance().sendModifyMatrixInfo(2, fromComp.petId, fromComp.titlePos, comp.dataInfo.titlePos,function():void{
						
						comp.dataInfo.hasPet = fromComp.hasPet;
						comp.dataInfo.petId = fromComp.petId;
						comp.dataInfo.type = fromComp.type;
						comp.dataInfo.icon = fromComp.icon;
						
						//从宠物列表拖入的宠物 发送出战指令 TODO
						
						
						fromComp.hasPet = tempInfo.hasPet;
						fromComp.petId = tempInfo.petId;
						fromComp.type = tempInfo.type;
						fromComp.icon = tempInfo.icon;
						
					});
				}else{
					
					
					//从宠物列表拖入的宠物 发送出战指令 TODO
					PetMessage.getInstance().sendModifyMatrixInfo(2,fromComp.petId,fromComp.titlePos,comp.dataInfo.titlePos,function():void{
						comp.dataInfo.hasPet = fromComp.hasPet;
						comp.dataInfo.petId = fromComp.petId;
						comp.dataInfo.type = fromComp.type;
						comp.dataInfo.icon = fromComp.icon;
						
						//从宠物列表拖入的宠物 发送出战指令 TODO
						
						fromComp.hasPet = false;
						fromComp.petId = -1;
						fromComp.type = 0;
						fromComp.icon = 0;
					});
				}
			}
			
		}
		
	}
}
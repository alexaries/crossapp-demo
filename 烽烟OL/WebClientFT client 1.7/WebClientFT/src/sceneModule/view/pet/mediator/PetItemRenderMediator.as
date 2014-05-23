package sceneModule.view.pet.mediator
{
	import flash.events.MouseEvent;
	
	import managers.ToolTipManager;
	
	import mx.controls.Image;
	import mx.core.DragSource;
	import mx.core.FlexGlobals;
	import mx.managers.DragManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sceneModule.view.pet.view.PetItemRender;
	import sceneModule.view.pet.view.PetToolTipComponent;
	import sceneModule.view.pet.vo.PetInfoVO;
	
	import service.ISocketServer;

	/**
	 * PetItemRenderMediator 
	 * @author Dream-Y
	 * 
	 */	
	public class PetItemRenderMediator extends Mediator
	{
		[Inject]
		public var comp:PetItemRender;
		
		[Inject]
		public var socketService:ISocketServer;
		
		private var petTooltipComp:PetToolTipComponent;
		public function PetItemRenderMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp,MouseEvent.MOUSE_DOWN,onClickStartDrag);
			
//			this.eventMap.mapListener(comp,MouseEvent.MOUSE_OVER,onMouseOver);
//			this.eventMap.mapListener(comp,MouseEvent.MOUSE_OUT,onMouseOut);
//			this.eventMap.mapListener(comp,MouseEvent.MOUSE_MOVE,onMouseMove);
		}
		
		private function onMouseOver(evt:MouseEvent):void{
			if(!petTooltipComp){
				petTooltipComp = ToolTipManager.showToolTip(PetToolTipComponent.NAME) as PetToolTipComponent;
			}
			petTooltipComp.curPetInfo(comp.data as PetInfoVO);
			FlexGlobals.topLevelApplication.addElement(petTooltipComp);
			onSetToolTipPos();
		}
		
		private function onMouseOut(evt:MouseEvent):void{
			if(petTooltipComp){
				FlexGlobals.topLevelApplication.removeElement(petTooltipComp);
			}
		}
		
		private function onSetToolTipPos():void{
			if(petTooltipComp){
				petTooltipComp.x = FlexGlobals.topLevelApplication.mouseX + 8;
				if(petTooltipComp.height + FlexGlobals.topLevelApplication.mouseY + 8 > 570){
					petTooltipComp.y = 570 - petTooltipComp.height;
				}else{
					petTooltipComp.y = FlexGlobals.topLevelApplication.mouseY + 8;
				}
				
			}
		}
		
		private function onMouseMove(evt:MouseEvent):void{
			onSetToolTipPos();
		}
		
		/**
		 * 开始拖拽 
		 */		
		private function onClickStartDrag(evt:MouseEvent):void{
			if(comp.data){
				var ds:DragSource = new DragSource();
				ds.addData(comp.data,PetItemRender.DRAGNAME);
//				var dragProxy:PetItemRender = new PetItemRender();
//				dragProxy.width = comp.width;
//				dragProxy.height = comp.height;
//				dragProxy.data = comp.data;
//				dragProxy.mouseEnabled = false;
//				dragProxy.mouseChildren = false;
				var dragProxy:Image = new Image();
				dragProxy.width = 55;
				dragProxy.height = 55;
				dragProxy.source = comp.petImg.source;
				DragManager.doDrag(comp,ds,evt,dragProxy);
			}
		}
	}
}
package sceneModule.view.ui.mediator
{
	import flash.events.MouseEvent;
	
	import managers.ToolTipManager;
	
	import model.SystemDataModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	import resource.CrotaResourceConfig;
	
	import sceneModule.view.pack.view.MainSmallDesTooltip;
	import sceneModule.view.ui.SoundComponent;

	public class SoundComponentMediator extends Mediator
	{	
		[Inject]
		public var comp:SoundComponent;
		public function SoundComponentMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(comp.shImg,MouseEvent.CLICK,image2_clickHandler);
			this.eventMap.mapListener(comp.shImg,MouseEvent.MOUSE_OVER,onMouseOver);
			this.eventMap.mapListener(comp.shImg,MouseEvent.MOUSE_OUT,onMouseOut);
			
			this.eventMap.mapListener(comp.musicbtn,MouseEvent.MOUSE_OVER,onMusicMouseOver);
			this.eventMap.mapListener(comp.musicbtn,MouseEvent.MOUSE_OUT,onMusicMouseOut);
		}
		private var tips:MainSmallDesTooltip;
		private function onMouseOver(evt:MouseEvent):void{
			if (!tips)
			{
				tips=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			if(SystemDataModel.hideOtherPlayer){
				tips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui_main_game','umg_show');
			}else{
				tips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui_main_game','umg_hide');
			}
			
			comp.addElement(tips);
			tips.x = comp.mouseX - tips.width - 5;
			tips.y = comp.mouseY;
		}
		
		private function onMouseOut(evt:MouseEvent):void{
			if (tips)
			{
				comp.removeElement(tips);
			}
		}
		
		private function onMusicMouseOver(evt:MouseEvent):void{
			if (!tips)
			{
				tips=ToolTipManager.showToolTip(MainSmallDesTooltip.NAME) as MainSmallDesTooltip;
			}
			if(comp.isOpenFlag){
				tips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui_main_game','umg_soundoff');
			}else{
				tips.curDes=CrotaResourceConfig.getInstance().getTextByModuleAndId('ui_main_game','umg_soundon');
			}
			
			comp.addElement(tips);
			tips.x = comp.mouseX - tips.width - 5;
			tips.y = comp.mouseY;
		}
		
		private function onMusicMouseOut(evt:MouseEvent):void{
			if (tips)
			{
				comp.removeElement(tips);
			}
		}
		
		protected function image2_clickHandler(event:MouseEvent):void
		{
			if(SystemDataModel.hideOtherPlayer){
				SystemDataModel.hideOtherPlayer = false;
			}else{
				SystemDataModel.hideOtherPlayer = true;
			}
		}
	}
}
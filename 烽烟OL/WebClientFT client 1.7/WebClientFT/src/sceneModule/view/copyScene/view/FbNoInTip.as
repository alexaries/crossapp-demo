package sceneModule.view.copyScene.view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import util.CommonTools;
	
	/**
	 * 副本不允许进入tip
	 * @author hao
	 */
	public class FbNoInTip extends Sprite 
	{
		private var bg:Bitmap;
		private var tf:TextField;
		
		public function FbNoInTip() 
		{
			init_view();
		}
		private function init_view():void {
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, add_to_stage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
			
			bg = new Bitmap();
			this.addChild(bg);
			
			tf = CommonTools.createTF();
			this.addChild(tf);
		}
		
		private function remove_from_stage(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, enter_frame);
		}
		
		private function add_to_stage(e:Event):void 
		{
			this.addEventListener(Event.ENTER_FRAME, enter_frame);
		}
		
		private function enter_frame(e:Event):void 
		{
			if (stage) {
				this.x = stage.mouseX;
				this.y = stage.mouseY;
			}
		}
		
		public function refresh(s:String):void {
			tf.text = s;
		}
		
	}

}
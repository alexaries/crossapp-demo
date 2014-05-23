package util
{
	import flash.events.MouseEvent;
	
	import managers.SoundConst;
	import managers.SoundManager;
	
	import spark.components.Button;

	public class CommonButton extends Button
	{
		public function CommonButton()
		{
			super();
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.CLICK,onMouseClickHandler);
		}
		
		private function onMouseClickHandler(evt:MouseEvent):void{
			SoundManager.getInstance().play(SoundConst.UI_SOUND);
		}
	}
}
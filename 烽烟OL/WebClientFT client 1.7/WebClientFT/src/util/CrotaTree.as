package util
{
	import flash.display.Sprite;
	import mx.controls.Tree;
	import mx.events.FlexEvent;
	
	public class CrotaTree extends Tree
	{
		public function CrotaTree()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, on_create_ok);
		}
		
		private function on_create_ok(e:FlexEvent):void {
			selectionLayer.alpha = 0;
		}
	}
}
package sceneModule.rcommand.debug
{
	import com.pblabs.box2D.Box2DDebugComponent;
	
	public class MyBox2DDebugComponent extends Box2DDebugComponent
	{
		public function MyBox2DDebugComponent()
		{
			super();
		}
		override public function get layerIndex():int 
		{
			return _layerIndex;
		}
		
		override public function set layerIndex(value:int):void 
		{
			_layerIndex = value;
		}
	}
}
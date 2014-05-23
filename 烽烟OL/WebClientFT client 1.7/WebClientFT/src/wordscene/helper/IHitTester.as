package wordscene.helper {
	import flash.display.DisplayObject;	
	
	/**
	 * @author CYPL
	 */
	public interface IHitTester {
		function getDisplay(posX : Number, posY : Number) : DisplayObject;
		function clear() : void;
	}
}

package sceneModule.rcommand.scene.bg.renderes
{
	import com.pblabs.rendering2D.*;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.core.FlexGlobals;
	
	import sceneModule.rcommand.scene.bg.RepeatingRenderComponent;
	
	/**
	 * A render component that takes a single image and tiles a background with it.
	 *
	 * Useful for scrolling game backgrounds, and can even be used for layered parallax backgrounds.
	 *
	 * Note: Does not support rotation
	 */
	public class RepeatingRenderComponentXOnlyPre extends RepeatingRenderComponent
	{   
		
		// offset the drawing by his much
		public var locationOffset:Point = new Point(0, 0);
		
		/**
		 * Instantiates a new RepeatingRenderComponent.
		 */
		public function RepeatingRenderComponentXOnlyPre():void
		{
			// After most things, but before the scene.
			updatePriority = -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onFrame( elapsed:Number ):void
		{
			
			if ( alpha == 0 )
			{
				displayObject.alpha=_alpha;
				displayObject.visible=( alpha > 0 );
				return;
			}
			
			if ( !spriteSheet || !spriteSheet.isLoaded )
				return;
			
			if ( !displayObject )
				displayObject=new Sprite();
			
			updateProperties();
			
			// Now that we've read all our properties, apply them to our transform.
			if ( _transformDirty )
				updateTransform();
			
			var doSprite:Sprite=displayObject as Sprite;
			
			// update the scroll factor 
			doSprite.x = locationOffset.x;
			doSprite.y = locationOffset.y;
			
			//对Y进行操作 -- 原
			//doSprite.y = locationOffset.y-scene.sceneViewBounds.top*( 1 - scrollFactor.y );
			//doSprite.y = locationOffset.y-scene.sceneViewBounds.top*( 1 - scrollFactor.y );
			
			var m:Matrix=new Matrix();
			var bitmapData:BitmapData = this.spriteSheet.getFrame(0);
			//匹配X,Y
			//m.translate( scene.sceneViewBounds.left * ( 1 - scrollFactor.x ), scene.sceneViewBounds.top*( 1 - scrollFactor.y ) );
			//只匹配X -- 原
			//m.translate( scene.sceneViewBounds.left * ( 1 - scrollFactor.x ), scene.sceneViewBounds.top );
			m.translate( scene.sceneViewBounds.left * ( 1 - scrollFactor.x ), scene.sceneViewBounds.top );
			
			// Position to match scene view.
			doSprite.graphics.clear();
			doSprite.scaleX = 5;
			doSprite.scaleY = 5;
			doSprite.graphics.beginBitmapFill( bitmapData, m );
			var sW:Number = scene.sceneViewBounds.width;
			var sH:Number = scene.sceneViewBounds.height;
			doSprite.graphics.drawRect( 0, 0, sW, sH );
			doSprite.graphics.endFill();
			
		}
		
		override protected function updateProperties():void
		{
			//单纯场景资源，不刷新其他资源
			return;
		}
		override public function updateTransform(param1:Boolean = false) : void
		{
			//单纯场景资源，不刷新其他
			return;
		}// end function
	}
}
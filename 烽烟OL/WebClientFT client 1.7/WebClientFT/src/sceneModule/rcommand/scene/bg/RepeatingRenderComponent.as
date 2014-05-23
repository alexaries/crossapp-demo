package sceneModule.rcommand.scene.bg
{
	import com.pblabs.rendering2D.*;
	import com.pblabs.rendering2D.spritesheet.*;
	
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.setTimeout;
	
	public class RepeatingRenderComponent extends DisplayObjectRenderer
	{
		public var scrollFactor:Point;
		public var spriteSheet:SpriteContainerComponent;
		public var repeatX:Boolean = true;
		public var repeatY:Boolean = false;
		
		public function RepeatingRenderComponent()
		{
			this.scrollFactor = new Point(1, 1);
			updatePriority = -1;
			//setTimeout(test,1000);
		}// end function
		
		override public function onFrame(param1:Number) : void
		{
			if (!this.spriteSheet || !this.spriteSheet.isLoaded)
			{
				return;
			}
			if (!displayObject)
			{
				displayObject = new Sprite();
			}
			updateProperties();
			if (_transformDirty)
			{
				this.updateTransform();
			}
			this.updateTransform();
			var doSprite:Sprite = displayObject as Sprite;
			var m:Matrix = new Matrix();
			var bitmapData:BitmapData = this.spriteSheet.getFrame(0);
			m.translate(scene.sceneViewBounds.left * (1 - this.scrollFactor.x), scene.sceneViewBounds.top * (1 - this.scrollFactor.y));
			doSprite.graphics.clear();
			doSprite.graphics.beginBitmapFill(bitmapData, m);
			var sW:Number = scene.sceneViewBounds.width;
			var sH:Number = scene.sceneViewBounds.height;
			doSprite.graphics.drawRect(scene.sceneViewBounds.left, scene.sceneViewBounds.top, sW, sH);
			doSprite.graphics.endFill();
		}// end function
		
		override public function updateTransform(param1:Boolean = false) : void
		{
			if (!displayObject)
			{
				return;
			}
			if (param1)
			{
				updateProperties();
			}
			displayObject.alpha = _alpha;
			displayObject.blendMode = _blendMode;
			displayObject.visible = alpha > 0;
			_transformDirty = false;
		}// end function
		
		private function test():void{
			trace("------------------------------------------------");
			
			var doSprite:Sprite = displayObject as Sprite;
			var m:Matrix = new Matrix();
			var bitmapData:BitmapData = this.spriteSheet.getFrame(0);
			m.translate(scene.sceneViewBounds.left * (1 - 1.2), scene.sceneViewBounds.top * (1 -1));
			doSprite.graphics.clear();
			doSprite.graphics.beginBitmapFill(bitmapData, m);
			var sW:Number = scene.sceneViewBounds.height;
			var sH:Number = scene.sceneViewBounds.width;
			doSprite.graphics.drawRect(scene.sceneViewBounds.left, scene.sceneViewBounds.top, sH, sW);
			doSprite.graphics.endFill();
			setTimeout(test,200);
		}
		
	}
}

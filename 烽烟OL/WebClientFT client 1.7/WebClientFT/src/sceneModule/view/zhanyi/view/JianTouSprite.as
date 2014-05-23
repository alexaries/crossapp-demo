package sceneModule.view.zhanyi.view 
{
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import resource.AssetCenter;
	
	/**
	 * ...
	 * @author hao
	 */
	public class JianTouSprite extends Sprite 
	{
		private var _img:Bitmap;
		public function JianTouSprite() 
		{
			_img = new Bitmap();
			this.addChild(_img);
			_img.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', 'jiantou');
			movedown();
		}
		
		private function movedown():void {
			TweenLite.to(_img, 1, {y:10, onComplete:moveup});
		}
		
		private function moveup():void {
			TweenLite.to(_img, 1, {y:0, onComplete:movedown});
		}
		
	}

}
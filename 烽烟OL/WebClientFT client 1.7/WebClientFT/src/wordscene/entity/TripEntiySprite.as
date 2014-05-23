package wordscene.entity 
{
	import flash.display.Sprite;
	import sceneModule.model.rvo.RSwitchVo;
	import wordscene.loader.EffectSp;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class TripEntiySprite extends Sprite 
	{
		private var _vo:RSwitchVo;
		private var _dis:EffectSp;
		public function TripEntiySprite(vo:RSwitchVo) 
		{
			_vo = vo;
			_dis = SAssetManager.getInstance().getEffect('default', 'trippoint');
			this.addChild(_dis);
			_dis.play();
		}
		
		public function clear():void {
			if (_dis && _dis.parent) {
				_dis.parent.removeChild(_dis);
				_dis.clear();
			}
		}
		
		public function get vo():RSwitchVo 
		{
			return _vo;
		}
		
	}

}
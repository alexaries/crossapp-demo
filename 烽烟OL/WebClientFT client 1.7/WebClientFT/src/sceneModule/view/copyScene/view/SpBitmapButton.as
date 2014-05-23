package sceneModule.view.copyScene.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import managers.SoundConst;
	import managers.SoundManager;
	
	import resource.AssetCenter;
	
	import util.CommonTools;
	
	/**
	 * ...
	 * @author hao
	 */
	public class SpBitmapButton extends Sprite 
	{
		private var _bg_bitmap:Bitmap;
		
		private var _package_id:String;
		private var _nomal:String;
		private var _over:String;
		private var _down:String;
		private var _disable:String;
		
		private var _is_disable:Boolean;
		private var _is_over:Boolean;
		private var _is_down:Boolean;
		
		private var _tf:TextField;
		
		public function SpBitmapButton(package_id:String, nomal:String, over:String, down:String, disbale:String = null, label:String = null ) 
		{
			_package_id = package_id;
			_nomal = nomal;
			_over = over;
			_down = down;
			_disable = disbale;
			init_view();
			if (null != label) {
				_tf = CommonTools.createFTF();
				_tf.text = label;
				this.addChild(_tf);
				_tf.x = (get_bg_w() - _tf.width) / 2;
				_tf.y = (get_bg_h() - _tf.height) / 2;
				_tf.mouseEnabled = false;
			}
			init_event();
		}
		
		private function init_view():void {
			this.buttonMode = true;
			_bg_bitmap = new Bitmap();
			this.addChild(_bg_bitmap);
			refresh();
		}
		
		private function init_event():void {
			this.addEventListener(MouseEvent.ROLL_OVER, mouse_over);
			this.addEventListener(MouseEvent.ROLL_OUT, mouse_out);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mosue_down);
			this.addEventListener(MouseEvent.MOUSE_UP, mouse_up);
		}
		
		private function mouse_over(e:MouseEvent):void {
			_is_over = true;
			refresh();
		}
		private function mouse_out(e:MouseEvent):void {
			_is_over = false;
			refresh();
		}
		private function mosue_down(e:MouseEvent):void {
			_is_down = true;
			SoundManager.getInstance().play(SoundConst.UI_SOUND);
			refresh();
		}
		private function mouse_up(e:MouseEvent):void {
			_is_down = false;
			refresh();
		}
		
		private function refresh():void {
			if (_is_disable) {
				set_bitmap(_disable);
			}
			else {
				if (_is_down) {
					set_bitmap(_down);
				}
				else{
					if (_is_over) {
						set_bitmap(_over);
					}
					else {
						set_bitmap(_nomal);
					}
				}
			}
		}
		
		private function set_bitmap(id:String):void {
			if (null == id) {
				id == _nomal;
			}
			_bg_bitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge(_package_id, id);
		}
		
		public function set_disable(is_disable:Boolean):void {
			_is_disable = is_disable;
			this.buttonMode = !is_disable;
			refresh();
		}
		
		public function get_bg_w():int {
			return  AssetCenter.getInstance().get_img_form_pacakge(_package_id, _nomal).width;
		}
		
		public function get_bg_h():int {
			return  AssetCenter.getInstance().get_img_form_pacakge(_package_id, _nomal).height;
		}
		
		public function get is_disable():Boolean 
		{
			return _is_disable;
		}
		
	}

}
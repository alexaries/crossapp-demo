package sceneModule.view.copyScene.view 
{
	import com.greensock.TweenLite;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	import sceneModule.view.copyScene.model.FubenChoseItemVo;
	
	import spark.components.Button;
	import spark.components.Group;
	
	import style.Skin_CrotaCommonButton3;
	
	/**
	 * ...
	 * @author hao
	 */
	public class NCopySceneItemView extends Group 
	{
		public static const TOP_LEFT_PATH:String = "assets/fb/fb_item_bg_top_left.png";
		public static const TOP_RIGHT_PATH:String = "assets/fb/fb_item_bg_top_right.png";
		public static const BOTTOM_LEFT_PATH:String = "assets/fb/fb_item_bg_bottom_left.png";
		public static const BOTTOM_RIGHT_PATH:String = "assets/fb/fb_item_bg_bottom_right.png";
		
		public static const STAR_IMG_PATH:String = "assets/fb/fb_icon_star.png";
		
		public static const PASS_IMG_PATH:String = "assets/nfuben/passImg.png";
		
		
		public static const TOP_LEFT_POS:Array = [0,-50];
		public static const TOP_RIGHT_POS:Array = [150,-50];
		public static const BOTTOM_LEFT_POS:Array = [0,100];
		public static const BOTTOM_RIGHT_POS:Array = [150, 100];
		
		public static const FIX_Y:int = 18;
		public static const UP_DES:int = 30;
		
		private var _is_selected:Boolean;
		private var _is_mouse_over:Boolean;
		
		private var icon_img:Image;
		private var border_img:Image;
		private var star_img:Image;
		
		public var low_btn:Button;
		public var mid_btn:Button;
		public var hi_btn:Button;
		
		private var _info:FubenChoseItemVo;
		
		
		private var _bg_w:int = 226;
		private var _bg_h:int = 97;
		private var _fix_y:int; //原始y值
		
		public function NCopySceneItemView() 
		{
			this.graphics.beginFill(0xFFFF00, 0);
			this.graphics.drawRect(0, 0, _bg_w, _bg_h);
			this.graphics.endFill();
			
			icon_img = new Image();
			border_img = new Image();
			star_img = new Image();
			
			
			low_btn = new Button();
			mid_btn = new Button();
			hi_btn = new Button();
			
			low_btn.skinClass = Skin_CrotaCommonButton3;
			
			this.addElement(star_img);
			this.addElement(border_img);
			this.addElement(low_btn);
			this.addElement(mid_btn);
			this.addElement(hi_btn);
			
			this.addElement(icon_img);
			
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouse_ovew);
			this.addEventListener(MouseEvent.ROLL_OUT, mouse_out);
		}
		
		public function setInfo(item:FubenChoseItemVo):void {
			_info = item;
			star_img.source = STAR_IMG_PATH;
			switch (_info.point) 
			{
				case FubenChoseItemVo.TOP_LEFT:
					star_img.x = TOP_LEFT_POS[0];
					star_img.y = TOP_LEFT_POS[1];
					border_img.source = TOP_LEFT_PATH;
					_fix_y = FIX_Y;
					break;
				case FubenChoseItemVo.TOP_RIGHT:
					star_img.x = TOP_RIGHT_POS[0];
					star_img.y = TOP_RIGHT_POS[1];
					border_img.source = TOP_RIGHT_PATH;
					_fix_y = FIX_Y;
					break;
				case FubenChoseItemVo.BOTTOM_LEFT:
					star_img.x = BOTTOM_LEFT_POS[0];
					star_img.y = BOTTOM_LEFT_POS[1];
					border_img.source = BOTTOM_LEFT_PATH;
					break;
				case FubenChoseItemVo.BOTTOM_RIGHT:
					star_img.x = BOTTOM_RIGHT_POS[0];
					star_img.y = BOTTOM_RIGHT_POS[1];
					border_img.source = BOTTOM_RIGHT_PATH;
					break;
				default:
			}
			icon_img.y = _fix_y;
			
			refresh();
		}
		
		private function refresh():void {
			if (_is_selected) {
			}
			else if (_is_mouse_over) {
				icon_img.source = _info.down_bg_path;
			}
			else {
				icon_img.source = _info.nomal_bg_path;
			}
		}
		
		private function to_selected():void {
			TweenLite.to(icon_img, 3, { y:_fix_y + UP_DES } );
		}
		
		private function to_nomal():void {
			TweenLite.to(icon_img, 3, { y:_fix_y } );
		}
		
		public function set_selected(b:Boolean):void {
			if (_is_selected == b) {
				return;
			}
			_is_selected = b;
			if (_is_selected) {
				to_selected();
			}
			else {
				to_nomal();
			}
		}
		
		private function mouse_ovew(e:MouseEvent):void {
			_is_mouse_over = true;
			refresh();
		}
		private function mouse_out(e:MouseEvent):void {
			_is_mouse_over = false;
			refresh();
		}
	}

}
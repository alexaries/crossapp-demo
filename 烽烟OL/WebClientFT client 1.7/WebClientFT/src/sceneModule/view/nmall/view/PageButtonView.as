package sceneModule.view.nmall.view 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import sceneModule.view.copyScene.view.BitmapButton;
	import util.CommonTools;
	
	/**
	 * ...
	 * @author hao
	 */
	public class PageButtonView extends Sprite 
	{
		private var _pre_btn:BitmapButton;
		private var _next_btn:BitmapButton;
		private var _page_num_tf:TextField;
		
		public function PageButtonView() 
		{
			init_view();
		}
		
		private function init_view():void {
			_pre_btn = new BitmapButton('ui_mall', 'btn_pre_nomal', 'btn_pre_nomal', 'btn_pre_nomal', 'btn_pre_disable');
			
			_next_btn = new BitmapButton('ui_mall', 'btn_next_nomal', 'btn_next_nomal', 'btn_next_nomal', 'btn_next_disable');
			_next_btn.x = 55;
			//
			_page_num_tf = CommonTools.createFTF();
			_page_num_tf.autoSize = TextFieldAutoSize.CENTER;
			_page_num_tf.width = 40;
			_page_num_tf.x = 15;
			_page_num_tf.text = "1/1";
			//
			
			this.addChild(_page_num_tf);
			this.addChild(_pre_btn);
			this.addChild(_next_btn);
			
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawRect(0, 0, 20, 20);
		}
		
	}

}
package sceneModule.view.copyScene.view 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import proto.copyScene.copyScene1506.FItemInfo;
	import proto.copyScene.copyScene1506.FMonsterInfo;
	import resource.AssetCenter;
	import sceneModule.view.copyScene.mediator.NCopySceneChoseMediator;
	import util.CommonTools;
	import util.xtrace;
	
	/**
	 * 副本怪物信息tip
	 * @author hao
	 */
	public class FbMonsterTip extends Sprite 
	{
		private var _icon_w:int = 63;
		
		private var _tf_x:int = 90;
		private var _tf_y:int = 23;
		
		private var _icon_c_x:int = 30;
		private var _icon_c_y:int = 112;
		
		
		private var _bg:Bitmap;
		private var _icon_contain:Sprite;
		private var _tf:TextField;
		private var _droptf:TextField;
		
		public function FbMonsterTip() 
		{
			init_view();
		}
		private function init_view():void {
			this.mouseEnabled = false;
			this.mouseChildren = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, add_to_stage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, remove_from_stage);
			
			_bg = new Bitmap();
			_bg.bitmapData = AssetCenter.getInstance().get_img_form_pacakge(
					NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE,
					NCopySceneChoseMediator.FUBEN_CHOSE_AEEST_PACKAGE + "_BORDER_" + "Fb_MONSTER_BG"
				);
			this.addChild(_bg);
			
			_tf = CommonTools.createTF();
			_tf.x = _tf_x;
			_tf.y = _tf_y;
			var t:TextFormat = new TextFormat();
			//t.bold = true;
			t.size = 12;
			t.color = 0x04fe1c;
			_tf.defaultTextFormat = t;
			this.addChild(_tf);
			
			_droptf = CommonTools.createTF();
			_droptf.wordWrap = true;
			var dt:TextFormat = new TextFormat();;
			dt.bold = false;
			dt.size = 12;
			dt.color = 0xFFFFFF;
			_droptf.defaultTextFormat = dt;
			_droptf.multiline = true;
			_droptf.x = 21;
			_droptf.y = 95;
			_droptf.width = 185;
			this.addChild(_droptf);
			
			_icon_contain = new Sprite();
			_icon_contain.x = _icon_c_x;
			_icon_contain.y = _icon_c_y;
			this.addChild(_icon_contain);
		}
		
		private function remove_from_stage(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, enter_frame);
		}
		
		private function add_to_stage(e:Event):void 
		{
			this.addEventListener(Event.ENTER_FRAME, enter_frame);
		}
		
		private function enter_frame(e:Event):void 
		{
			if (stage) {
				this.x = stage.mouseX;
				this.y = stage.mouseY;
			}
		}
		
		private function clear_sp(dis:DisplayObjectContainer):void {
			while (dis.numChildren > 0) {
				var c:DisplayObject = dis.removeChildAt(0);
				if (c is Loader) {
					(c as Loader).unloadAndStop();
				}
			}
		}
		
		public function refresh_info(info:FMonsterInfo):void {
			clear_sp(_icon_contain);
			_tf.text = info.name + " Lv." + info.lv + "";
			_droptf.text = "    ";
			var len:int = info.items.length;
			for (var i:int = 0; i < len; i++) 
			{
				var item:FItemInfo = info.items[i] as FItemInfo;
				var oldindex:int = _droptf.text.length;
				_droptf.appendText(item.name);
				var e_color:uint = CommonTools.get_equipement_color(item.nowQuality);
				var t:TextFormat = new TextFormat();
				t.size = 12;
				t.color = e_color;
				_droptf.setTextFormat(t, oldindex, oldindex + item.name.length);
				if (len - 1 != i) {
					oldindex = _droptf.text.length;
					_droptf.appendText(", ");
					t.color = 0xFFFFFF;
					_droptf.setTextFormat(t, oldindex, oldindex + "，".length);
				}
			}
		}
		
	}

}
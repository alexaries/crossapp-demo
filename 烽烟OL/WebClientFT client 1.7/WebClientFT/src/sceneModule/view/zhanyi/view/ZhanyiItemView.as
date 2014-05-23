package sceneModule.view.zhanyi.view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import proto.zhanyi.GetNowZhanYiInfo4500.ZhangJieInfo;
	import resource.AssetCenter;
	import util.DisplayUtils;
	import wordscene.event.PlusEvent;
	
	/**
	 * ...
	 * @author hao
	 */
	public class ZhanyiItemView extends Sprite 
	{
		private var _img:String;
		private var _id:int;
		private var _vo:ZhangJieInfo;
		
		private var _isdisable:Boolean;
		private var _isover:Boolean;
		
		private var _bgBitmap:Bitmap;
		private var _levelLimteTxt:TextField;
		private var _nameTxt:TextField;
		
		public function ZhanyiItemView(img:String, id:int, siteminfo:ZhangJieInfo) 
		{
			_img = img;
			_id = id;
			_vo = siteminfo;
			
			_bgBitmap = new Bitmap();
			this.addChild(_bgBitmap);
			
			var descolor:uint = 0xFFFFFF;
			if (1 == _vo.state) {
				descolor = 0xFF0000;
			}
			
			_levelLimteTxt = DisplayUtils.createLabel(12, descolor);
			_levelLimteTxt.filters = [DisplayUtils.TextBorderFilte];
			_levelLimteTxt.x = 90;
			_levelLimteTxt.y = 19;
			_levelLimteTxt.text = _vo.desc;
			this.addChild(_levelLimteTxt);
			
			_nameTxt = DisplayUtils.createLabel(14, 0xFFFF00);
			_nameTxt.filters = [DisplayUtils.TextBorderFilte];
			_nameTxt.x = 90;
			_nameTxt.y = 42;
			_nameTxt.text = _vo.name;
			this.addChild(_nameTxt);
			
			refresh();
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (!_isdisable) {
				//派发战斗事件
				this.dispatchEvent(new PlusEvent(PlusEvent.PlusEvent_ZhanyiItemClick, { id:_id } ));
			}
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			_isover = false;
			refresh();
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			_isover = true;
			refresh();
		}
		
		public function setDisable():void {
			_isdisable = true;
			refresh();
		}
		
		public function setEnable():void {
			_isdisable = false;
			refresh();
		}
		
		private function refresh():void {
			if (_isdisable) {
				_bgBitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', _img + 'ds');
			}
			else {
				if (_isover) {
					_bgBitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', _img + 'over');
				}
				else {
					_bgBitmap.bitmapData = AssetCenter.getInstance().get_img_form_pacakge('zhanyi', _img + 'up');
				}
			}
			
		}
		
	}

}
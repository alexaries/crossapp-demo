package zhushen.ui.roleCreate
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BitmapFilter;
	import flash.filters.GlowFilter;
	
	import t4game.utils.BitmapText;
	import t4game.utils.Filters;
	
	import zhushen.zhushengame.Game;
	import zhushen.zhushengame.common.font.FontText;
	import zhushen.zhushengame.core.IFrameUpdateTask;

	public class CreateCareerInfo extends Sprite implements IFrameUpdateTask
	{
//		private var _selectedEffect:GlowFilter = new GlowFilter(0xa7d8cd,0.8,15,15,5);
//		private var _selectedEffect1:GlowFilter = new GlowFilter(0x77684e,0.8,15,15,5);
		private var bt:Bitmap;
		private var bt1:Bitmap;
		private var _name:BitmapText = new BitmapText();
		private var _word:BitmapText = new BitmapText();
		public function CreateCareerInfo()
		{
			super();
			initListener();
			initText();
		}
		private function initListener():void
		{
			addEventListener(Event.ADDED_TO_STAGE,addedEvent);
			addEventListener(Event.REMOVED_FROM_STAGE,removeEvent);
		}
		private function removeEvent(e:Event):void
		{
			bt.alpha = 0;
			bt.x = 10;
			bt.y = 20;
			
			bt1.alpha = 0;
			bt1.y = 60;
			Game.instance.removeUpdateTask(this);
		}
		private function addedEvent(e:Event):void
		{
			Game.instance.addUpdateTask(this);
			addChild(bt1);
			addChild(bt);
		}
		private function initText():void
		{
			var _textFilter:BitmapFilter;
            _textFilter = Filters.glow(0x000000, 1, 1.2, 1.2, 1);
			
//			_name.x = 10;
//			_name.y = 20;
			_name.font = FontText.LI_SHU;
			_name.size = 24;
			_name.textColor = 0x37291b;
			_name.textFilters = [_textFilter];
			
			bt = new Bitmap(new BitmapData(55,35,true,0x0));
			bt.alpha = 0;
			bt.x = 10;
			bt.y = 20;
			bt.filters = [new GlowFilter(0xffffff,1,3,3,6)];
			
			_word.textWidth = 25;
			_word.textColor = 0x37291b;
			_word.size = 18;
			_word.font = FontText.LI_SHU;
			_word.height = 150;
			_word.textFilters = [_textFilter];
			
			bt1 = new Bitmap(new BitmapData(55,130,true,0x0));
			bt1.x = 180;
			bt1.y = 60;
			bt1.alpha = 0;
			bt1.filters = [new GlowFilter(0xffffff,1,3,3,6)];
		}
		public function setText(name:String,word:String):void
		{
			_name.text = name;
			bt.bitmapData.draw(_name);
			_word.text = word;
			bt1.bitmapData.draw(_word);
		}
		public function frameUpdate(frameNum:int):void
		{
			if(bt.alpha < 1)
			{
				bt.alpha += 0.05;
				bt.x += 2;
				
				bt1.alpha += 0.05;
				bt1.y += 2;
			}else{
				Game.instance.removeUpdateTask(this);
			}
		}
		
	}
}
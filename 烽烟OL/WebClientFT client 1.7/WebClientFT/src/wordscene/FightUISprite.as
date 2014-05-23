package wordscene 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import model.SystemDataModel;
	import proto.battle.battle703.BuffInfo;
	import proto.battle.battle703.InitBattleData;
	import proto.battle.battle703.SettlementData;
	import util.HashMap;
	import wordscene.entity.FightEntitySprite;
	import wordscene.fight.ui.FightBuffIconSprite;
	import wordscene.fight.ui.FightBuffTipsSprite;
	import wordscene.fight.ui.FightFailureSprite;
	import wordscene.fight.ui.FightHeadSprite;
	import wordscene.fight.ui.FightTipSprite;
	import wordscene.fight.ui.FightWinSprite;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightUISprite extends Sprite 
	{
		
		public static const HEAD_SIZE:int = 75;
		
		private var _enitymap:HashMap;
		
		private var _upheadContain:Sprite;
		private var _downheadContain:Sprite;
		private var _mouseBlock:Sprite;
		private var _winContain:Sprite;
		private var _tipsContain:Sprite;
		
		
		private var _tipsSprite:FightTipSprite;
		private var _buftipsSprite:FightBuffTipsSprite;
		private var _winResSprite:FightWinSprite;
		private var _failResSprite:FightFailureSprite;
		
		public function FightUISprite() 
		{
			_enitymap = new HashMap();
			
			_upheadContain = new Sprite();
			this.addChild(_upheadContain);
			_downheadContain = new Sprite();
			this.addChild(_downheadContain);
			_mouseBlock = new Sprite();
			this.addChild(_mouseBlock);
			_winContain = new Sprite();
			this.addChild(_winContain);
			_tipsContain = new Sprite();
			_tipsContain.mouseEnabled = false;
			_tipsContain.mouseChildren = false;
			this.addChild(_tipsContain);
			
			_tipsSprite = new FightTipSprite();
			_buftipsSprite = new FightBuffTipsSprite();
			_winResSprite = new FightWinSprite();
			_failResSprite = new FightFailureSprite();
			
			if (stage) {
				getStage();
			}
			else {
				this.addEventListener(Event.ADDED_TO_STAGE, getStage);
			}
		}
		
		private function getStage(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, getStage);
			stage.addEventListener(Event.RESIZE, stageResize);
		}
		
		private function stageResize(e:Event):void 
		{
			resetpos();
			if (_mouseBlock.width > 0) {
				addMouseBlock();
			}
		}
		
		public function showHeads(entitys:Array):void {
			_enitymap.clear();
			var len:int = entitys.length;
			var upindex:int = 0;
			var downindex:int = 0;
			for (var i:int = 0; i < len; i++) 
			{
				var d:InitBattleData = entitys[i] as InitBattleData;
				var v:FightHeadSprite = new FightHeadSprite();
				v.refresh(d);
				if (1 != d.chaDirection) {
					//朝左,显示在上方
					v.x = upindex * HEAD_SIZE;
					_upheadContain.addChild(v);
					upindex++;
				}
				else {
					//朝右,在下方
					v.x = downindex * HEAD_SIZE;
					_downheadContain.addChild(v);
					downindex++;
				}
				_enitymap.put(d.chaBattleId, v);
			}
			resetpos();
		}
		
		public function showTips(v:FightEntitySprite):void {
			_tipsSprite.refresh(v);
			fixtipos(_tipsSprite);
			_tipsContain.addChild(_tipsSprite);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mousemove);
		}
		
		public function hideTips(v:FightEntitySprite = null):void {
			if (null != v) {
				if (v.vo.chaBattleId != _tipsSprite.id) {
					return;
				}
			}
			this.removeEventListener(MouseEvent.MOUSE_MOVE, mousemove);
			if (_tipsSprite.parent) {
				_tipsSprite.parent.removeChild(_tipsSprite);
			}
		}
		
		public function removeChar(id:int):void {
			var headv:FightHeadSprite = _enitymap.get(id);
			headv.refreshBuf([]);
		}
		
		public function showBufTips(v:FightBuffIconSprite):void {
			_buftipsSprite.refresh(v);
			fixtipos(_buftipsSprite);
			_tipsContain.addChild(_buftipsSprite);
			this.addEventListener(MouseEvent.MOUSE_MOVE, mousemove);
		}
		
		public function hideBufTips(v:FightBuffIconSprite):void {
			if (_buftipsSprite.v == v) {
				this.removeEventListener(MouseEvent.MOUSE_MOVE, mousemove);
				if (_buftipsSprite.parent) {
					_buftipsSprite.parent.removeChild(_buftipsSprite);
				}
			}
		}
		
		public function refreshPlayerBuf(v:FightEntitySprite, bufs:Array):void {
			var vhead:FightHeadSprite = _enitymap.get(v.vo.chaBattleId);
			vhead.refreshBuf(bufs);
		}
		
		public function showWin(arr:Array):void {
			addMouseBlock();
			var t:SettlementData;
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++) 
			{
				var cur:SettlementData = arr[i] as SettlementData;
				if (cur.id == SystemDataModel.roleId) {
					t = cur;
					break;
				}
			}
			_winResSprite.refresh(t);
			_winResSprite.x = (this.stage.stageWidth - _winResSprite.width) / 2;
			_winResSprite.y = (this.stage.stageHeight - _winResSprite.height) / 2;
			_winContain.addChild(_winResSprite);
		}
		
		public function showFailure(arr:Array):void {
			addMouseBlock();
			_failResSprite.refresh();
			_failResSprite.x = (this.stage.stageWidth - _failResSprite.width) / 2;
			_failResSprite.y = (this.stage.stageHeight - _failResSprite.height) / 2;
			_winContain.addChild(_failResSprite);
		}
		
		public function clear():void {
			clearHead(_upheadContain);
			clearHead(_downheadContain);
			hideTips();
			_enitymap.clear();
			while (_winContain.numChildren > 0) {
				_winContain.removeChildAt(0);
			}
			clearMouseBlock();
		}
		
		private function addMouseBlock():void {
			_mouseBlock.graphics.beginFill(0xFF0000, 0.0);
			_mouseBlock.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			_mouseBlock.graphics.endFill();
		}
		private function clearMouseBlock():void {
			_mouseBlock.graphics.clear();
		}
		
		private function clearHead(dis:Sprite):void {
			while (dis.numChildren > 0) {
				var headv:FightHeadSprite = dis.removeChildAt(0) as FightHeadSprite;
				headv.clear();
			}
		}
		
		private function mousemove(e:MouseEvent):void {
			var tip:DisplayObject;
			if (_tipsSprite.parent) {
				tip = _tipsSprite;
			}
			else {
				tip = _buftipsSprite;
			}
			fixtipos(tip);
		}
		
		private function fixtipos(dis:DisplayObject):void {
			var tx:int = _tipsContain.mouseX;
			var ty:int = _tipsContain.mouseY;
			if (dis.width + tx > this.stage.stageWidth) {
				tx -= dis.width;
			}
			if (dis.height + ty > this.stage.stageHeight) {
				ty -= dis.height;
			}
			dis.x = tx;
			dis.y = ty;
		}
		
		public function resetpos():void {
			_upheadContain.x = 110;
			_upheadContain.y = 10;
			_downheadContain.x = this.stage.stageWidth - _downheadContain.width - 50;
			_downheadContain.y = this.stage.stageHeight - _downheadContain.height - 10;
		}
		
	}

}
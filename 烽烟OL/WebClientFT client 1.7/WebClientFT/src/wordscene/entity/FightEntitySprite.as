package wordscene.entity 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import proto.battle.battle703.InitBattleData;
	import wordscene.fight.FightAction;
	import wordscene.fight.ui.JumpNumberSprite;
	import wordscene.FightSceneSprite;
	import wordscene.helper.QHitTestManager;
	import wordscene.WordSceneSprite;
	
	import proto.battle.battle703.BuffInfo;
	
	import util.DelayExcuter;
	import util.HashMap;
	
	import wordscene.fight.ui.FightHPBarView;
	import wordscene.loader.EffectSp;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class FightEntitySprite extends Sprite 
	{
		public static const EVENT_MOUSE_OVER:String = "EVENT_MOUSE_OVER";
		public static const EVENT_MOUSE_OUT:String = "EVENT_MOUSE_OUT";
		
		private var _vo:InitBattleData;
		
		private var _curhp:int;
		private var _maxhp:int;
		private var _curpower:int;
		private var _maxpower:int;
		
		private var _staticX:int;
		private var _staticY:int;
		private var _bufMap:HashMap;
		
		private var _enititySprite:EntitySprite;
		private var _hpBarSprite:FightHPBarView;
		private var _jumpNumberSprite:JumpNumberSprite;
		private var _attackResultBitmap:Bitmap;
		private var _buffContainSprite:Sprite;
		private var _effectContainSprite:Sprite;
		
		public function FightEntitySprite(vo:InitBattleData) 
		{
			_curhp = vo.chaCurrentHp;
			_maxhp = vo.chaTotalHp;
			_curpower = vo.chaCurrentPower;
			_maxpower = vo.chaTotalPower;
			
			_staticX = vo.chaPos[0];
			_staticY = vo.chaPos[1];
			_bufMap = new HashMap();
			
			_vo = vo;
			_enititySprite = new EntitySprite(0, 0, EntitySprite.TYPE_FIGHTENTITY, vo);
			_enititySprite.x = 0;
			_enititySprite.y = 0;
			this.addChild(_enititySprite);
			QHitTestManager.getInstance().register(_enititySprite);
			
			_hpBarSprite = new FightHPBarView();
			this.addChild(_hpBarSprite);
			
			_jumpNumberSprite = new JumpNumberSprite();
			this.addChild(_jumpNumberSprite);
			
			_attackResultBitmap = new Bitmap();
			this.addChild(_attackResultBitmap);
			
			_buffContainSprite = new Sprite();
			_buffContainSprite.mouseEnabled = false;
			_buffContainSprite.mouseChildren = false;
			this.addChild(_buffContainSprite);
			
			_effectContainSprite = new Sprite();
			_effectContainSprite.mouseEnabled = false;
			_effectContainSprite.mouseChildren = false;
			this.addChild(_effectContainSprite);
			
			_hpBarSprite.setValue(vo.chaCurrentHp, vo.chaTotalHp);
			_enititySprite.setHp(vo.chaCurrentHp, vo.chaTotalHp, true);
			
			_enititySprite.addEventListener(QHitTestManager.Q_MOUSE_OVER, mouseOver);
			_enititySprite.addEventListener(QHitTestManager.Q_MOUSE_OUT, mouseOut);
		}
		
		private function mouseOut(e:Event):void 
		{
			this.dispatchEvent(new Event(EVENT_MOUSE_OUT));
		}
		
		private function mouseOver(e:Event):void 
		{
			this.dispatchEvent(new Event(EVENT_MOUSE_OVER));
		}
		
		public function resetPos():void {
			var r:Rectangle = _enititySprite.getBounds(this);
			//this.graphics.beginFill(0xFFFF00);
			//this.graphics.drawRect(r.x, r.y, r.width, r.height);
			//this.graphics.endFill();
			_enititySprite.resetPos();
			_hpBarSprite.x = r.x + (r.width - _hpBarSprite.width) / 2;
			_hpBarSprite.y = r.y - 30;
			_jumpNumberSprite.y = r.y - 50;
			_effectContainSprite.x = r.x + r.width / 2;
			_effectContainSprite.y = r.y + r.height;
			_buffContainSprite.x = _effectContainSprite.x;
			_buffContainSprite.y = _effectContainSprite.y;
			
			_attackResultBitmap.y = r.y;
			
		}
		
		private function test():void {
			this.graphics.beginFill(0xFF00FF);
			this.graphics.drawRect( -10, -10, 20, 20);
			this.graphics.endFill();
		}
		
		public function clear():void {
			_enititySprite.removeEventListener(QHitTestManager.Q_MOUSE_OVER, mouseOver);
			_enititySprite.removeEventListener(QHitTestManager.Q_MOUSE_OUT, mouseOut);
			QHitTestManager.getInstance().unregister(_enititySprite);
			_enititySprite.clear();
			_hpBarSprite.clear();
			clearEff();
			clearBuf();
		}
		
		private function clearEff():void{
			while(_effectContainSprite.numChildren > 0){
				var eff:EffectSp = _effectContainSprite.removeChildAt(0) as EffectSp;
				eff.removeEventListener(EffectSp.EFFECTOVER_EVENT, effectOver);
				eff.clear();
			}
		}
		
		private function clearBuf():void{
			_bufMap.clear();
			while(_buffContainSprite.numChildren > 0){
				_buffContainSprite.removeChildAt(0);
			}
		}
		
		public function changeHP(action:FightAction):void {
			_curhp = action.arg4;
			_maxhp = action.arg5;
			_hpBarSprite.setValue(action.arg4, action.arg5, true);
			_enititySprite.setHp(action.arg4, action.arg5);
			_jumpNumberSprite.show(action.arg3 + "");
		}
		
		public function changepower(action:FightAction):void {
			_curpower = action.arg4;
			_maxpower = action.arg5;
		}
		
		public function refreshBuf(arr:Array, func:Function, args:Array):void{
			var arrMap:HashMap = new HashMap();
			var addBuffs:Array = [];
			var removeBuffIDs:Array = [];
			
			var len:int = arr.length;
			var keys:Array = _bufMap.keys();
			var i:int = 0;
			for(i = 0; i < len; i++){
				var d:BuffInfo = arr[i] as BuffInfo;
				if(-1 == keys.indexOf(d.buffId)){
					//添加到待加数组
					addBuffs.push(d);
					arrMap.put(d.buffId, 1);
				}
			}
			
			var keylen:int = keys.length;
			for(i = 0; i < keylen; i++){
				var curKey:int = keys[i] as int;
				if(!arrMap.containsKey(curKey)){
					removeBuffIDs.push(curKey);
				}
			}
			
			var addlen:int = addBuffs.length;
			for(i = 0; i < addlen; i++){
				var currAddD:BuffInfo = addBuffs[i] as BuffInfo;
				var id:int = 1003;
				var v:EffectSp
				if (SAssetManager.getInstance().hasRes(SAssetManager.ASSET_EFFECT_ID + id, SAssetManager.ASSET_EFFECT_ID)) {
					v = SAssetManager.getInstance().getEffect(SAssetManager.ASSET_EFFECT_ID + id, SAssetManager.ASSET_EFFECT_ID);
				}
				else {
					v = SAssetManager.getInstance().getEffect('default', 'sblank');
					SAssetManager.getInstance().addToList(SAssetManager.ASSET_EFFECT_ID + id, resetBuf, [id]);
				}
				
				_buffContainSprite.addChild(v);
				v.play();
				_bufMap.put(currAddD.buffId, [currAddD, v]);
			}
			
			var rmLen:int = removeBuffIDs.length;
			for(i = 0; i < rmLen; i++){
				var ck:int = removeBuffIDs[i] as int;
				var curBufData:Array = _bufMap.remove(ck);
				var curv:EffectSp = curBufData[1] as EffectSp;
				curv.parent.removeChild(curv);
				curv.clear();
			}
			var delay:int = FightSceneSprite.CHAR_ADDBUFF_TIME;
			if (0 == addlen && 0 == rmLen) {
				delay = 1;
			}
			new DelayExcuter(delay, func, args);
		}
		
		public function showAttaceRes(action:FightAction):void {
			var resid:int = action.arg2;
			var res:String = "";
			switch (resid) 
			{
				case 9999:
					res = "miss";
					break;
				case 9998:
					res = "breakattack";
					break;
				case 9996:
					res = "crits";
					WordSceneSprite.getInstance().shock();
					break;
				default:
			}
			var bmd:BitmapData = SAssetManager.getInstance().getBitmapData('default', res);
			_attackResultBitmap.bitmapData = bmd;
			var r:Rectangle = _enititySprite.getBounds(this);
			_attackResultBitmap.x = r.x + (r.width - _attackResultBitmap.width) / 2;
			new DelayExcuter(1000, clearAttackedRes, []);
		}
		
		private function clearAttackedRes():void {
			_attackResultBitmap.bitmapData = null;
		}
		
		private function resetBuf(id:int):void {
			var arr:Array = _bufMap.get(id);
			if (null != arr) {
				var v:EffectSp = arr[1];
				v.parent.removeChild(v);
				v.clear();
				v = SAssetManager.getInstance().getEffect(SAssetManager.ASSET_EFFECT_ID + id, SAssetManager.ASSET_EFFECT_ID);
				_buffContainSprite.addChild(v);
				v.play();
				_bufMap.put(id, [arr[0], v]);
			}
		}
		
		public function addEffect(effname:String, func:Function, args:Array = null):void {
			var eff:EffectSp;
			if (SAssetManager.getInstance().hasRes(effname, SAssetManager.ASSET_EFFECT_ID)) {
				eff = SAssetManager.getInstance().getEffect(effname, SAssetManager.ASSET_EFFECT_ID);
			}
			else {
				eff = SAssetManager.getInstance().getEffect('default', 'sblank');
				SAssetManager.getInstance().addToList(effname);
			}
			eff.setPos(0, 10);
			var activefunc:Function = function(e:Event):void {
				eff.removeEventListener(EffectSp.EFFECTACTIVE_EVENT, activefunc);
				func.apply(null, args);
			}
			eff.addEventListener(
				EffectSp.EFFECTACTIVE_EVENT, 
				activefunc
			);
			eff.addEventListener(EffectSp.EFFECTOVER_EVENT, effectOver);
			_effectContainSprite.addChild(eff);
			eff.play();
		}
		
		private function effectOver(e:Event):void 
		{
			var effect:EffectSp = e.currentTarget as EffectSp;
			effect.removeEventListener(EffectSp.EFFECTOVER_EVENT, effectOver);
			effect.parent.removeChild(effect);
			effect.clear();
		}
		
		public function get vo():InitBattleData 
		{
			return _vo;
		}
		
		public function get enititySprite():EntitySprite 
		{
			return _enititySprite;
		}
		
		public function get hpBarSprite():FightHPBarView 
		{
			return _hpBarSprite;
		}
		
		public function get curhp():int 
		{
			return _curhp;
		}
		
		public function get staticX():int 
		{
			return _staticX;
		}
		
		public function get staticY():int 
		{
			return _staticY;
		}
		
		public function get maxhp():int 
		{
			return _maxhp;
		}
		
		public function get curpower():int 
		{
			return _curpower;
		}
		
		public function get maxpower():int 
		{
			return _maxpower;
		}
		
	}

}
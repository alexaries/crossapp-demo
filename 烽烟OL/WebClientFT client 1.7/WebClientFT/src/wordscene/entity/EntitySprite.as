package wordscene.entity 
{
	import adobe.utils.CustomActions;
	import Animation.ResourceLoadEvent;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.printing.PrintJob;
	import flash.text.TextField;
	import model.SceneData;
	import model.SystemDataModel;
	import proto.battle.battle703.InitBattleData;
	import sceneModule.command.ChangeSceneController;
	import util.DelayExcuter;
	import wordscene.config.EntityInfo;
	import wordscene.config.SConfigCenter;
	import wordscene.fight.ui.FightBitmapButton;
	
	import proto.battle.battle703.InitBattleData;
	
	import sceneModule.model.rvo.RNpcVo;
	import sceneModule.model.rvo.RUpdateCharacterVo;
	
	import util.DisplayUtils;
	import util.Logging;
	
	import wordscene.WordSceneSprite;
	import wordscene.helper.FindPathPlus;
	import wordscene.helper.QHitTestManager;
	import wordscene.loader.SAssetManager;
	
	/**
	 * ...
	 * @author hao
	 */
	public class EntitySprite extends Sprite 
	{
		public static const TYPE_HEARO:int = 1;
		public static const TYPE_NPC:int = 2;
		public static const TYPE_FIGHTENTITY:int = 3;
		
		public static const CHANGE_HP_TIME:Number = 0.8;
		
		public var _hearoVo:RUpdateCharacterVo;
		private var _npcVo:RNpcVo;
		private var _fightVo:InitBattleData;
		private var _type:int;
		private var _action:String;
		private var _direct:int;
		private var _name:String;
		private var _npcHeadTaskStateFlag:int;
		private var _resid:int;
		private var _npcfuncType:int;
		
		private var _targetPos:Point;
		private var _linePath:Vector.<Point>;
		
		private var _nearPos:Point;
		private var _func:Function;
		private var _args:Array;
		
		private var _playersContain:Sprite;
		private var _bitmapPlayers:Vector.<InnerBitmapItem>;
		private var _nameTxt:TextField;
		private var _nameBmTxt:Bitmap;
		private var _npcHeadTypeIcon:BitmapPlayer;
		private var _npcHeadTaskState:BitmapPlayer;
		private var _charWordSprite:EntityWordSprite;
		private var _curHp:int;
		private var _maxHp:int;
		
		private var _testPoint:Sprite;
		public function EntitySprite(tx:int, ty:int, type:int, vo:*) 
		{
			_type = type;
			_direct = 4;
			_npcfuncType = -1;
			_curHp = -1;
			_maxHp = -1;
			
			var namecolor:uint;
			
			var tmpid:int = -1;
			switch (type) 
			{
				case TYPE_HEARO:
					_hearoVo = vo;
					tmpid = _hearoVo.professionType;
					if (_hearoVo.isMySelf) {
						namecolor = WordSceneSprite.HEARO_SELF_COLOR;
					}
					else if (_hearoVo.isSelfPet) {
						namecolor = WordSceneSprite.HEARO_SELF_COLOR;
					}
					else if (SceneData.ENTITY_TYPE_MONSTER == _hearoVo.chaType) {
						namecolor = WordSceneSprite.FIGHT_MONSTER_NAME;
						if (_hearoVo.campid == WordSceneSprite.getInstance().playerCoutainSp.hearo._hearoVo.campid) {
							namecolor = WordSceneSprite.HEARO_NAME_COLOR;
						}
					}
					else {
						namecolor = WordSceneSprite.HEARO_NAME_COLOR;
					}
					break;
				case TYPE_NPC:
					_npcVo = vo;
					tmpid = _npcVo.professionType;
					namecolor = WordSceneSprite.NPC_NAME_COLOR;
					break;
				case TYPE_FIGHTENTITY:
					_fightVo = vo;
					tmpid = _fightVo.chaProfessionType;
					if (1 == _fightVo.chaDirection) {
						//朝右
						namecolor = WordSceneSprite.HEARO_SELF_COLOR;
					}
					else {
						namecolor = WordSceneSprite.FIGHT_MONSTER_NAME;
					}
					break;
				default:
			}
			
			Logging.log("创建实体", Logging.o2s(vo));
			
			_linePath = new Vector.<Point>();
			
			_targetPos = new Point(tx, ty);
			getFixPos(_targetPos);
			this.x = _targetPos.x;
			this.y = _targetPos.y;
			
			_playersContain = new Sprite();
			this.addChild(_playersContain);
			
			resetRes(tmpid);
			
			if (TYPE_NPC == _type) {
				_npcHeadTypeIcon = new BitmapPlayer('default', 'default');
				this.addChild(_npcHeadTypeIcon);
				
				_npcHeadTaskState = new BitmapPlayer('default', 'default');
				this.addChild(_npcHeadTaskState);
			}
			else if (TYPE_HEARO == _type) {
				_charWordSprite = new EntityWordSprite();
			}
			
			_testPoint = new Sprite();
			this.addChild(_testPoint);
			
			_nameTxt = DisplayUtils.createLabel(12, namecolor);
			_nameTxt.filters = [DisplayUtils.TextBorderFilte];
			_nameBmTxt = new Bitmap();
			_nameBmTxt.y = 10;
			this.addChild(_nameBmTxt);
			
			playAction(SAssetManager.HEARO_ACTION_arise, 4);
			//test();
		}
		
		public function resetRes(tmpid:int, isresetaction:Boolean = false):void {
			_resid = tmpid;
			clearBitmaps();
			_bitmapPlayers = new Vector.<InnerBitmapItem>();
			var iteminfos:Vector.<EntityInfo> = SConfigCenter.getInstance().getItemsInfoOfEntity(tmpid);
			var len:int = iteminfos.length;
			for (var i:int = 0; i < len; i++) 
			{
				var d:EntityInfo = iteminfos[i];
				var v:BitmapPlayer = new BitmapPlayer();
				var innerd:InnerBitmapItem = new InnerBitmapItem();
				v.setAssetID(d.id);
				v.x = d.posx * WordSceneSprite.MATRIXS_DES_X;
				v.y = d.posy * WordSceneSprite.MATRIXS_DES_Y;
				innerd.v = v;
				innerd.x = v.x;
				innerd.y = v.y;
				innerd.index = d.index;
				_bitmapPlayers.push(innerd);
				_playersContain.addChild(v);
			}
			if (isresetaction) {
				playAction(_action, _direct);
			}
		}
		
		public function setHp(cur:int, max:int, force:Boolean = false):void {
			if (0 == max) {
				return;
			}
			if (cur == _curHp && max == _maxHp) {
				return;
			}
			_curHp = cur;
			_maxHp = max;
			if (0 == cur) {
				Logging.log("死亡,不重新设置人物个数");
				return;
			}
			Logging.log("设置人物个数", num);
			_bitmapPlayers.sort(rmSort);
			var len:int = _bitmapPlayers.length;
			var num:int = Math.ceil(1.0 * cur / max * len);
			for (var i:int = 0; i < len; i++) 
			{
				var v:BitmapPlayer = _bitmapPlayers[i].v;
				var res:int = 0;
				if (i < num) {
					res = 1;
				}
				if (force) {
					v.alpha = res;
				}
				else {
					TweenLite.to(v, CHANGE_HP_TIME, { alpha : res} );
				}
			}
		}
		
		private function mouseOut(e:Event):void 
		{
			setName(null, "false");
		}
		
		private function mouseOver(e:Event):void 
		{
			setName(null, "true");
		}
		
		public function playAction(action:String, direct:int = -1, force:Boolean = false, nextAction:String = null, isStop:Boolean = false):void {
			if (-1 == direct) {
				direct = _direct;
			}
			if (_direct == direct && action == _action && !force) {
				return;
			}
			_action = action;
			_direct = direct;
			var m:Matrix = WordSceneSprite.CHANGEPOS_MATRIX[_direct];
			var len:int = _bitmapPlayers.length;
			for (var i:int = 0; i < len; i++) 
			{
				var vd:InnerBitmapItem = _bitmapPlayers[i];
				var v:BitmapPlayer = vd.v;
				var tp:Point = m.transformPoint(new Point(vd.x, vd.y));
				var pt:Pt = new Pt(tp.x, tp.y);
				IsoMath.isoToScreen(pt);
				v.x = pt.x;
				v.y = pt.y;
				v.playAction(action, direct, force, nextAction, isStop);
			}
			_bitmapPlayers.sort(posSort);
			for (var j:int = 0; j < len; j++) 
			{
				var svd:InnerBitmapItem = _bitmapPlayers[j];
				if (svd.v.parent.getChildIndex(svd.v) != j) {
					svd.v.parent.setChildIndex(svd.v, j);
				}
			}
			resetPos();
		}
		
		private function posSort(tx:InnerBitmapItem, ty:InnerBitmapItem):Number {
			return tx.v.y - ty.v.y;
		}
		
		private function rmSort(tx:InnerBitmapItem, ty:InnerBitmapItem):Number {
			return tx.index - ty.index;
		}
		
		public function setName(s:String, isOver:String = ""):void {
			if (null == s) {
				
			}
			else {
				_name = s;
			}
			if (s != _nameTxt.text) {
				_nameTxt.text = _name + isOver;
				if (null != _nameBmTxt.bitmapData) {
					_nameBmTxt.bitmapData.dispose();
				}
				_nameBmTxt.bitmapData = DisplayUtils.createBitmapTxt(_nameTxt);
			}
			_nameBmTxt.x = -_nameBmTxt.width / 2;
		}
		
		public function setNpcHeadType(functype:int = -1):void {
			if (-1 == functype) {
				functype = _npcfuncType;
			}
			_npcfuncType = functype;
			
			_npcHeadTypeIcon.setAssetID('npcheadtype' + functype, false);
			_npcHeadTypeIcon.playAction('action', -2);
			
			resetPos();
		}
		
		public function setNPCHeadState(type:int = -1):void {
			if (-1 == type) {
				type = _npcHeadTaskStateFlag;
			}
			_npcHeadTaskStateFlag = type;
			
			_npcHeadTaskState.setAssetID('npcheadtaskstate' + type, false);
			_npcHeadTaskState.playAction('action', -2);
			
			resetPos();
		}
		
		public function resetPos():void {
			var b:Rectangle = _playersContain.getBounds(_playersContain);
			if (TYPE_NPC == _type) {
				_npcHeadTypeIcon.x = -_npcHeadTypeIcon.width / 2;
				_npcHeadTypeIcon.y = -b.height - _npcHeadTypeIcon.width;
				
				_npcHeadTaskState.x = -_npcHeadTaskState.width / 2;
				_npcHeadTaskState.y = _npcHeadTypeIcon.y - _npcHeadTaskState.height;
			}
			_nameBmTxt.x = (b.width - _nameBmTxt.width) / 2 + b.x;
			_nameBmTxt.y = b.y - _nameBmTxt.height;
			resetWordPos();
		}
		
		public function say(str:String):void {
			if (null != _charWordSprite) {
				_charWordSprite.setTxt(str);
				_charWordSprite.alpha = 1;
				resetWordPos();
				this.addChild(_charWordSprite);
				TweenLite.killTweensOf(_charWordSprite);
				new DelayExcuter(2000, disshowWord, null);
			}
		}
		
		private function disshowWord():void {
			if (_charWordSprite) {
				TweenLite.to(_charWordSprite, 1, {alpha:0, onComplete:removeWordSprite} );
			}
		}
		
		private function removeWordSprite():void {
			if (_charWordSprite && _charWordSprite.parent) {
				_charWordSprite.parent.removeChild(_charWordSprite);
			}
		}
		
		private function resetWordPos():void {
			if (TYPE_HEARO == _type) {
				var b:Rectangle = _playersContain.getBounds(_playersContain);
				_charWordSprite.x = (b.width - _charWordSprite.width) / 2 + b.x;
				_charWordSprite.y = b.y - _charWordSprite.height - 20;
			}
		}
		
		public function move(detention:int):void {
			if (_linePath.length > 0) {
				var point:Point = _linePath[0];
				var tx:int = point.x;
				var ty:int = point.y;
				var flag:int = WordSceneSprite.getInstance().pathinfo[ty][tx];
				if (1 == flag) {
					//半透
					_playersContain.alpha = 0.5;
				}
				else {
					_playersContain.alpha = 1;
				}
				
				var nextPoint:Point = null;
				var nextTx:int = -1;
				var nextTy:int = -1;
				if (_linePath.length > 1) {
					nextPoint = _linePath[1];
					nextTx = nextPoint.x;
					nextTy = nextPoint.y;
				}
				var px:int = int((tx + 0.5) * WordSceneSprite.GRID_SIZE);
				var py:int = int((ty + 0.5) * WordSceneSprite.GRID_SIZE);
				
				var direct:int = _direct;
				
				if(px > this.x){
					//1,2,3
					if(py < this.y){
						direct = 1;
					}
					else if(py == this.y){
						direct = 2;
					}
					else if(py > this.y){
						direct = 3;
					}
				}
				else if(px == this.x){
					//4, 8
					if(py < this.y){
						direct = 8;
					}
					else if(py > this.y){
						direct = 4;
					}
				}
				else if(px < this.x){
					//5,6,7
					if(py < this.y){
						direct = 7;
					}
					else if(py == this.y){
						direct = 6;
					}
					else if(py > this.y){
						direct = 5;
					}
				}
				playAction(SAssetManager.HEARO_ACTION_run, direct);
				
				var isStepOver:Boolean = false;
				
				var changeX:int = px - this.x;
				var changeY:int = py - this.y;
				var changeXAbs:int = Math.abs(changeX);
				var changeYAbs:int = Math.abs(changeY);
				if (0 != changeXAbs && 0 != changeYAbs) {
					//斜方向移动
					if (changeXAbs <= WordSceneSprite.MOVE_Oblique_DES && changeYAbs <= WordSceneSprite.MOVE_Oblique_DES) {
						isStepOver = true;
						if ( null != nextPoint) {
							var nextchangex:int = nextTx - px;
							var nextchangey:int = nextTy - py;
							if (nextchangex * changeX > 0 && nextchangey * changeY > 0) {
								changeX = WordSceneSprite.MOVE_Oblique_DES * (changeX / changeXAbs);
								changeY = WordSceneSprite.MOVE_Oblique_DES * (changeY / changeYAbs);
							}
						}
					}
					if(changeYAbs > WordSceneSprite.MOVE_Oblique_DES) {
						changeY = WordSceneSprite.MOVE_Oblique_DES * (changeY / changeYAbs);
					}
					if (changeXAbs > WordSceneSprite.MOVE_Oblique_DES) {
						changeX = WordSceneSprite.MOVE_Oblique_DES * (changeX / changeXAbs);
					}
				}
				else if (0 == changeYAbs) {
					//x方向移动
					if (changeXAbs < WordSceneSprite.MOVE_LINE_DES) {
						isStepOver = true;
						if (null != nextPoint && nextTx == px) {
							changeX = WordSceneSprite.MOVE_LINE_DES * (changeX / changeXAbs);
						}
					}
					else {
						changeX = WordSceneSprite.MOVE_LINE_DES * (changeX / changeXAbs);
					}
				}
				else if (0 == changeXAbs) {
					//y方向移动
					if (changeYAbs < WordSceneSprite.MOVE_LINE_DES) {
						isStepOver = true;
						if (null != nextPoint && nextTy == py) {
							changeY = WordSceneSprite.MOVE_LINE_DES * (changeY / changeYAbs);
						}
					}
					else {
						changeY = WordSceneSprite.MOVE_LINE_DES * (changeY / changeYAbs);
					}
				}
				this.x += changeX;
				this.y += changeY;
				
				if (isStepOver) {
					_linePath.shift();
				}
				
				
				if (null != _nearPos ) {
					if (_nearPos.x == this.x && _nearPos.y == this.y) {
						if (null != _func) {
							_func.apply(null, _args);
							clearNearFunc();
						}
					}
				}
			}
			else {
				playAction(SAssetManager.HEARO_ACTION_arise, _direct);
			}
		}
		public function setTarget(p:Point):void {
			getFixPos(p);
			if (_targetPos.equals(p)) {
				return;
			}
			_targetPos = p.clone();
			var startx:int = this.x / WordSceneSprite.GRID_SIZE;
			var starty:int = this.y / WordSceneSprite.GRID_SIZE;
			if (_linePath.length > 0) {
				var point:Point = _linePath[0];
				startx = point.x;
				starty = point.y;
			}
			var endx:int = _targetPos.x / WordSceneSprite.GRID_SIZE;
			var endy:int = _targetPos.y / WordSceneSprite.GRID_SIZE;
			var tmp:Array = WordSceneSprite.getInstance().pathTool.getPath8X(new Point(startx, starty), new Point(endx, endy));
			if (null == tmp) {
				return;
			}
			var len:int = tmp.length;
			_linePath.length = 0;
			for (var i:int = 0; i < len; i++) 
			{
				var curint:int = tmp[i];
				var linecount:int = WordSceneSprite.getInstance().pathTool.w;
				var px:int = curint % linecount;
				var py:int = curint / linecount;
				_linePath.push(new Point(px, py));
			}
		}
		
		public function setNearFunc(pos:Point, func:Function, args:Array = null):void {
			getFixPos(pos);
			_nearPos = pos.clone();
			_func = func;
			_args = args;
		}
		
		public function clearNearFunc():void {
			_nearPos = null;
			_func = null;
			_args = null;
		}
		
		public function stopMove():void {
			_linePath.length = 0;
			_targetPos = getFixPos(new Point(this.x, this.y));
		}
		
		public function clear():void {
			var len:int = _bitmapPlayers.length;
			for (var i:int = 0; i < len; i++) 
			{
				var vd:InnerBitmapItem = _bitmapPlayers[i];
				var v:BitmapPlayer = vd.v;
				v.parent.removeChild(v);
				v.clear();
			}
			clearBitmaps();
		}
		
		private function clearBitmaps():void {
			while (_playersContain.numChildren > 0) {
				var v:BitmapPlayer = _playersContain.getChildAt(0) as BitmapPlayer;
				v.clear();
			}
			if (null != _bitmapPlayers) {
				_bitmapPlayers.length = 0;
			}
		}
		
		public function isTargetEqueNear():Boolean {
			if (null != _targetPos) {
				if (null != _nearPos) {
					var xdex:int = Math.abs(_targetPos.x - _nearPos.x);
					var ydex:int = Math.abs(_targetPos.y - _nearPos.y);
					if (xdex < WordSceneSprite.GRID_SIZE && ydex < WordSceneSprite.GRID_SIZE) {
						return true;
					}
				}
			}
			return false;
		}
		
		private function test():void {
			_testPoint.graphics.beginFill(0xFFFF00);
			_testPoint.graphics.drawRect( -10, -10, 20, 20);
			_testPoint.graphics.endFill();
		}
		
		private function getFixPos(p:Point):Point {
			p.x = (int(p.x / WordSceneSprite.GRID_SIZE) + 0.5) * WordSceneSprite.GRID_SIZE;
			p.y = (int(p.y / WordSceneSprite.GRID_SIZE) + 0.5) * WordSceneSprite.GRID_SIZE;
			return p;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function get npcVo():RNpcVo 
		{
			return _npcVo;
		}
		
		public function get hearoVo():RUpdateCharacterVo 
		{
			return _hearoVo;
		}
		
		public function get vo():* 
		{
			switch (_type) 
			{
				case TYPE_HEARO:
					return _hearoVo;
				case TYPE_NPC:
					return _npcVo;
				default:
			}
			return null;
		}
		
		public function get fightVo():InitBattleData 
		{
			return _fightVo;
		}
		
		public function get resid():int 
		{
			return _resid;
		}
	}
}
import wordscene.entity.BitmapPlayer;
class InnerBitmapItem {
	public var v:BitmapPlayer;
	public var x:int;
	public var y:int;
	public var index:int;
}
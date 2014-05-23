package sceneModule.rcommand.rcharacter 
{
	import com.pblabs.animation.Animator;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.core.InputKey;
	import com.pblabs.engine.core.InputManager;
	import com.pblabs.engine.core.InputMap;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.rendering2D.SpriteRenderer;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	import com.pblabs.rendering2D.spritesheet.SpriteSheetComponent;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import sceneModule.rcommand.trigger.PlayerLogic;
	import sceneModule.model.rvo.RDirectionVo;
	import sceneModule.model.rvo.RUpdateCharacterVo;
	import sceneModule.rcommon.RChaMcRender;
	import sceneModule.rfactory.RCharacterOp;
	import sceneModule.rresource.RBattleConst;
	import sceneModule.rresource.RCharacterConst;
	import sceneModule.rresource.RCharacterRes;
	
	/**
	 * 角色控制类 
	 * @author mutou
	 * 
	 */	
	public class ROtherCharacterController extends EntityComponent implements ITickedObject
	{
		public function ROtherCharacterController()
		{
			super();
		}
		
		public var isActive:Boolean = true;
		
		private var _left:Number = 0;
		private var _right:Number = 0;
		private var _up:Number = 0;
		private var _down:Number = 0;
		private var _mouseValue:Number = 0;
		
		private const MOVE_VELOCITY_X:int = 10;
		private const MOVE_VELOCITY_Y:int = 8;
		
		/*[TypeHint(type="flash.geom.Point")]
		public var velocityReference:PropertyReference;*/
		
		//角色实体中的Box2DSpatialComponent
		private var spatial:Box2DSpatialComponent;
		//当前鼠标所点击的坐标
		private var mousePos:Point;
		
		private var render:SpriteSheetRenderer;
		private var idleSheet:SpriteSheetComponent;//站立资源
		private var walkSheet:SpriteSheetComponent;//跑动资源
		private var currentSheet:SpriteSheetComponent;//当前资源
		private var currentDirect:int;//角色跑动或站立方向
		private var gemRender:SpriteSheetRenderer;
		
		private var characterAnimator:AnimatorComponent;
		private var infoCmp:RCharacterInfoComponent;
		
		
		public function onTick(deltaTime:Number):void
		{
			if(isActive)
			{
				//角色当前的坐标
				var pos:Point = new Point(Math.round(spatial.position.x),Math.round(spatial.position.y));
				if(pos&&mousePos){
					
					/*trace("--- "+pos.x);
					trace("--- "+mousePos.x);*/
					var idleActionIsPlaying:Boolean = (render.spriteSheet == idleSheet);
					if((Math.abs(pos.x-mousePos.x)<10) && !idleActionIsPlaying){
						_left=0;
						_right=0;
						onAction();
					}
					if((Math.abs(pos.y-mousePos.y)<10) && !idleActionIsPlaying){
						_down=0;
						_up=0;
						onAction();
					}
					// Math.abs(pos.y-mousePos.y)<10
				}
				var moveX:Number = _right-_left;
				var moveY:Number = _down - _up;
				//var velocity:Point = owner.getProperty(velocityReference);
				//var p:Point = new Point();
				if(PlayerLogic.collisionFlag){
					/*velocity.x = 0;
					velocity.y = 0;*/
					/*p.x = 0;
					p.y = 0;*/
					onAction(true);
				}else{
					/*velocity.x = moveX*MOVE_VELOCITY_X;
					velocity.y = moveY*MOVE_VELOCITY_Y;*/
					/*p.x = moveX*MOVE_VELOCITY_X;
					p.y = moveY*MOVE_VELOCITY_Y;*/
					spatial.position = new Point(spatial.position.x+moveX*MOVE_VELOCITY_X,spatial.position.y+moveY*MOVE_VELOCITY_Y);
				}
				//owner.setProperty(velocityReference, velocity);
				/*if(!PlayerLogic.detectVisible(spatial.position)){
					owner.destroy();
				}*/
			}
		}
		public function updatePosition(ent:IEntity,targetPos:Point):void{
			isActive = true;
			infoCmp = ent.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			idleSheet = ent.lookupComponentByName(RCharacterConst.CHA_IDLE_SHEET_NAME) as SpriteSheetComponent;
			walkSheet = ent.lookupComponentByName(RCharacterConst.CHA_WALK_SHEET_NAME) as SpriteSheetComponent;
			render = ent.lookupComponentByName(RCharacterConst.CHA_RENDER_NAME) as SpriteSheetRenderer;
			gemRender = ent.lookupComponentByName(RCharacterConst.CHA_GEM_RENDER_NAME) as SpriteSheetRenderer;
			characterAnimator = ent.lookupComponentByName(RCharacterConst.CHA_ANIMATOR_NAME) as AnimatorComponent;
			
			updatePositionHandler(1,targetPos);
			//是否要添加坐标相等判断？相等则不移动 
		}
		//测试鼠标点击确定方向
		private function updatePositionHandler(value:Number,targetPos:Point):void{
			/*trace("testMouse:"+value);*/
			_mouseValue = value;
			if(value==1){
				var pos:Point = new Point(Math.round(spatial.position.x),Math.round(spatial.position.y));
				var posX:int = targetPos.x;
				var posY:int = targetPos.y;
				mousePos = new Point(posX,posY);
				/*trace("posPos:"+pos.toString());
				trace("mousePos:"+(mousePos.toString()));*/
				var tempPos:Point;
				if(pos&&mousePos){
					/*trace(pos.x);
					trace(mousePos.x);*/
					if(Math.abs(pos.y-mousePos.y)>10){
						if(pos.y<mousePos.y){
							tempPos = mousePos;
							mousePos = PlayerLogic.getNotScenePos(tempPos);
							if(pos.y<mousePos.y){
								_up=0;
								_OnMouseDown(1);
							}
						}else if(pos.y>mousePos.y){
							tempPos = new Point(mousePos.x,(mousePos.y-10));
							mousePos = PlayerLogic.getNotScenePos(tempPos);
							if(pos.y>mousePos.y){
								_down=0;
								_OnMouseUp(1);
							}
						}
					}
					if(Math.abs(pos.x-mousePos.x)>10){
						if(pos.x<mousePos.x){
							tempPos = new Point(mousePos.x,mousePos.y);
							mousePos = PlayerLogic.getNotScenePos(tempPos);
							if(pos.x<mousePos.x){
								_left=0;
								_OnMouseRight(1);
							}
						}else if(pos.x>mousePos.x){
							tempPos = new Point(mousePos.x,mousePos.y);
							mousePos = PlayerLogic.getNotScenePos(tempPos);
							if(pos.x>mousePos.x){
								_right=0;
								_OnMouseLeft(1);
							}
						}
					}
				}
			}else{
				
			}
			
		}
		private function onAction(stopFlag:Boolean=false):void{
			if((_left == 0 && _right == 0 && _up == 0 && _down == 0) || stopFlag){
				isActive = false;
				currentSheet = idleSheet;
				setChaAction();
			}
		}
		
		//鼠标操作左移动作
		private function _OnMouseLeft(value:Number):void{
			/*trace("_OnLeft"+value);
			trace(_right);*/
			_left = value;
			if(_left==1){
				if(_right==1){
					onAction(true);
				}else{
					runLeft();
					onAction();
				}
			}else if(_left==0){
				if(_right==1){
					runRight();
					onAction();
				}else{
					onAction();
				}
			}
		}
		//鼠标操作右移动作
		private function _OnMouseRight(value:Number):void{
			/*trace("_OnRight"+value);
			trace(_left);*/
			_right = value;
			if(_right==1){
				if(_left==1){
					onAction(true);
				}else{
					runRight();
					onAction();
				}
			}else if(_right==0){
				if(_left==1){
					runLeft();
					onAction();
				}else{
					onAction();
				}
			}
		}
		//鼠标操作上移动作
		private function _OnMouseUp(value:Number):void{
			/*trace("_OnUp"+value);
			trace(_down);*/
			_up = value;
			if(_up==1){
				if(_down==1){
					onAction(true);
				}else{
					runUp();
					onAction();
				}
			}else if(_up==0){
				if(_down==1){
					runDown();
					onAction();
				}else{
					onAction();
				}
			}
		}
		//鼠标操作下移动作
		private function _OnMouseDown(value:Number):void{
			/*trace("_OnDown"+value);
			trace(_up);*/
			_down = value;
			if(_down==1){
				if(_up==1){
					onAction(true);
				}else{
					runDown();
					onAction();
				}
			}else if(_down==0){
				if(_up==1){
					runUp();
					onAction();
				}else{
					onAction();
				}
			}
		}
		
		//左
		private function runLeft():void{
			//trace("left");
			currentSheet = walkSheet;
			currentDirect = RDirectionVo.LEFT_DIRECTION;
			/*if(render.spriteSheet == walkSheet){
				return;
			}*/
			setChaAction();
		} 
		//右
		private function runRight():void{
			//trace("right");
			currentSheet = walkSheet;
			currentDirect = RDirectionVo.RIGHT_DIRECTION;
			/*if(render.spriteSheet == walkSheet){
				return;
			}*/
			setChaAction();
		}
		//上
		private function runUp():void{
			//trace("up");
			if(_left==1 || _right==1 || _down==1){//如果有其他按键，只不响应动画，直接返回
				return;
			}
			currentSheet = walkSheet;
			setChaAction();
		}
		//下
		private function runDown():void{
			//trace("down");
			if(_left==1 || _right==1 || _up==1){//如果有其他按键，只不响应动画，直接返回
				return;
			}
			currentSheet = walkSheet;
			setChaAction();
		}
		/**
		 * 设置当前角色的状态 
		 * 
		 */		
		private function setChaAction():void{
			if(!render){
				return;
			}
			render.spriteSheet = currentSheet;
			if(currentSheet == idleSheet){
				if(!(characterAnimator.animations[RCharacterConst.IDLE_STR] as Animator).isAnimating){
					characterAnimator.play(RCharacterConst.IDLE_STR);
				}
			}else if(currentSheet == walkSheet){
				if(!(characterAnimator.animations[RCharacterConst.WALK_STR] as Animator).isAnimating){
					characterAnimator.play(RCharacterConst.WALK_STR);
				}
			}
			if(infoCmp.chaProfessionType<RCharacterConst.NORMAL_MONSTER_TYPE){
				if(currentDirect == RDirectionVo.LEFT_DIRECTION){
					render.scale = new Point(-1,1);
					if(gemRender){
						gemRender.scale = new Point(-1,1);
					}
					//render.scale = new Point(-Math.abs(render.scale.x),render.scale.y);
				}else{
					render.scale = new Point(1,1);
					if(gemRender){
						gemRender.scale = new Point(1,1);
					}
					//render.scale = new Point(Math.abs(render.scale.x),render.scale.y);
				}
			}else{
				if(currentDirect == RDirectionVo.RIGHT_DIRECTION){
					render.scale = new Point(-1,1);
					if(gemRender){
						gemRender.scale = new Point(-1,1);
					}
					//render.scale = new Point(-Math.abs(render.scale.x),render.scale.y);
				}else{
					render.scale = new Point(1,1);
					if(gemRender){
						gemRender.scale = new Point(1,1);
					}
					//render.scale = new Point(Math.abs(render.scale.x),render.scale.y);
				}
			}
		}
		
		protected override function onAdd():void {
			PBE.processManager.addTickedObject(this);
			spatial = owner.lookupComponentByName("Spatial") as Box2DSpatialComponent;
		}
		
		protected override function onRemove():void {
			PBE.processManager.removeTickedObject(this);
			super.onRemove();
		}
		
	}
}
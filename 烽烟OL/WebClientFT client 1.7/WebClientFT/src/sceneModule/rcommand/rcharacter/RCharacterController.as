package sceneModule.rcommand.rcharacter 
{
	import com.pblabs.animation.Animator;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	import com.pblabs.rendering2D.spritesheet.SpriteSheetComponent;
	
	import flash.geom.Point;
	
	import sceneModule.model.rvo.RDirectionVo;
	import sceneModule.rcommand.revent.RCharacterEvent;
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnly;
	import sceneModule.rcommand.trigger.PlayerLogic;
	import sceneModule.rcommon.RMouseEffectMcRender;
	import sceneModule.rcommon.SceneHelper;
	import sceneModule.rfactory.RCharacterOp;
	import sceneModule.rfactory.RPBELevel;
	import sceneModule.rresource.RCharacterConst;
	import sceneModule.rresource.RCharacterRes;
	import sceneModule.rresource.RSceneConst;
	
	/**
	 * 角色控制类 
	 * @author mutou
	 * 
	 */	
	public class RCharacterController extends EntityComponent implements ITickedObject
	{
		public function RCharacterController()
		{
			super();
		}
		//切换到战斗场景则鼠标操作忽略。
		public static var mouseInputEnabled:Boolean = true;
		
		public var isActive:Boolean = true;
		
		private var _left:Number = 0;
		private var _right:Number = 0;
		private var _up:Number = 0;
		private var _down:Number = 0;
		
		private const MOVE_VELOCITY_X:int = 10;
		private const MOVE_VELOCITY_Y:int = 8;
		
		/*[TypeHint(type="flash.geom.Point")]
		public var velocityReference:PropertyReference;*/
		
		private var characterLayerArr:Array = new Array();
		
		//角色实体中的Box2DSpatialComponent
		private var spatial:Box2DSpatialComponent;
		//当前鼠标所点击的坐标
		private var mousePos:Point;
		
		private var chaEventType:String = "";//如果事件有效，应该是弹出NPC对话窗口事件
		private var npcId:int=-1;//如果chaEventType有效，即NPC事件有效 npc id
		private var npcName:String="";//如果chaEventType有效，即NPC事件有效 npc name
		private var npcFunctionType:int=-1;//如果chaEventType有效，即NPC事件有效 npc 功能类型
		
		private var render:SpriteSheetRenderer;
		private var idleSheet:SpriteSheetComponent;//站立资源
		private var walkSheet:SpriteSheetComponent;//跑动资源
		private var currentSheet:SpriteSheetComponent;//当前资源
		public var currentDirect:int;//角色跑动或站立方向
		private var mouseEffectShowFlag:Boolean;//是否显示鼠标点击效果
		private var gemRender:SpriteSheetRenderer;
		
		private var characterAnimator:AnimatorComponent;
		private var info:RCharacterInfoComponent;
		
		public function onTick(deltaTime:Number):void
		{
			if(isActive)
			{
				//角色当前的坐标
				var pos:Point = new Point(Math.round(spatial.position.x),Math.round(spatial.position.y));
				if(pos&&mousePos){
					var idleActionIsPlaying:Boolean = (currentSheet == idleSheet);
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
					if(_left==0&&_right==0&&_up==0&&_down==0){
						if(getMouseEffectRender()&& mouseEffectShowFlag){
							getMouseEffectRender().alpha = 0;
							mouseEffectShowFlag = false;
						}
						if(chaEventType==""){
							
						}else{
							dispatchGuideEvent();
						}
					}
				}
				var moveX:Number = _right-_left;
				var moveY:Number = _down - _up;
				//var velocity:Point = owner.getProperty(velocityReference);
				//var p:Point = new Point();
				//setCharacterLayerIndex();
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
				//spatial.position = new Point(spatial.position.x+p.x,spatial.position.y+p.y);
				//owner.setProperty(velocityReference, velocity);
			}
		}
		
		/**
		 * 派发事件 
		 */		
		private function dispatchGuideEvent():void{
			trace("派发事件");
			var chatWithNpcEvent:RCharacterEvent = new RCharacterEvent(chaEventType,npcId,npcName,npcFunctionType);
			PBE.mainClass.dispatchEvent(chatWithNpcEvent);
			chaEventType = "";
			npcId = -1;
			npcName = "";
			npcFunctionType = -1;
		}
		public function updateLongPressPosition(targetPos:Point,ent:IEntity,firstPress:Boolean=false,eventType:String="",npcId:int=-1,npcName:String="",npcfunctionType:int=-1):void{
			isActive = true;
			RPBELevel.setBgFrame(false);
			mouseEffectShowFlag = true;
			if(firstPress){
				info = ent.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
				idleSheet = ent.lookupComponentByName(RCharacterConst.CHA_IDLE_SHEET_NAME) as SpriteSheetComponent;
				walkSheet = ent.lookupComponentByName(RCharacterConst.CHA_WALK_SHEET_NAME) as SpriteSheetComponent;
				render = ent.lookupComponentByName(RCharacterConst.CHA_RENDER_NAME) as SpriteSheetRenderer;
				gemRender = ent.lookupComponentByName(RCharacterConst.CHA_GEM_RENDER_NAME) as SpriteSheetRenderer;
				characterAnimator = ent.lookupComponentByName(RCharacterConst.CHA_ANIMATOR_NAME) as AnimatorComponent;
				//spatial = owner.lookupComponentByName("Spatial") as Box2DSpatialComponent;
				
				//初始化弹出NPC窗口事件
				this.chaEventType = eventType;
				this.npcId = npcId;
				this.npcName = npcName;
				this.npcFunctionType = npcfunctionType;
			}
			
			_OnMouseInput(1,targetPos);
		}
		/**
		 * 外部传进目标坐标 
		 * @param mousePos 要移动到的鼠标坐标
		 * 
		 */		
		public function updatePosition(targetPos:Point,ent:IEntity,eventType:String="",npcId:int=-1,npcName:String="",npcfunctionType:int=-1):void{
			isActive = true;
			RPBELevel.setBgFrame(false);
			mouseEffectShowFlag = true;
			
			info = ent.lookupComponentByName(RCharacterConst.CHA_INFO_COMPONENT_NAME) as RCharacterInfoComponent;
			idleSheet = ent.lookupComponentByName(RCharacterConst.CHA_IDLE_SHEET_NAME) as SpriteSheetComponent;
			walkSheet = ent.lookupComponentByName(RCharacterConst.CHA_WALK_SHEET_NAME) as SpriteSheetComponent;
			render = ent.lookupComponentByName(RCharacterConst.CHA_RENDER_NAME) as SpriteSheetRenderer;
			gemRender = ent.lookupComponentByName(RCharacterConst.CHA_GEM_RENDER_NAME) as SpriteSheetRenderer;
			characterAnimator = owner.lookupComponentByName(RCharacterConst.CHA_ANIMATOR_NAME) as AnimatorComponent;
			//spatial = owner.lookupComponentByName("Spatial") as Box2DSpatialComponent;
			
			//初始化弹出NPC窗口事件
			this.chaEventType = eventType;
			this.npcId = npcId;
			this.npcName = npcName;
			this.npcFunctionType = npcfunctionType;
			
			_OnMouseInput(1,targetPos);
		}
		//鼠标点击确定方向
		private function _OnMouseInput(value:Number,targetPos:Point):void{
			if(!mouseInputEnabled){
				return;
			}
			if(value==1){
				var pos:Point = new Point(Math.round(spatial.position.x),Math.round(spatial.position.y));
				mousePos = SceneHelper.getInstance().myScene.transformScreenToScene(targetPos);
				var tempPos:Point;
				if(pos&&mousePos){
					if(Math.abs(pos.y-mousePos.y)>10){
						if(pos.y<mousePos.y){
							tempPos = mousePos;
							mousePos = PlayerLogic.detectBounds(tempPos);
							if(pos.y<mousePos.y){
								_up=0;
								_OnMouseDown(1);
							}
						}else if(pos.y>mousePos.y){
							tempPos = new Point(mousePos.x,(mousePos.y));
							mousePos = PlayerLogic.detectBounds(tempPos);
							if(pos.y>mousePos.y){
								_down=0;
								_OnMouseUp(1);
							}
						}
					}
					if(Math.abs(pos.x-mousePos.x)>(10)){
						if(pos.x<mousePos.x){
							tempPos = new Point(mousePos.x,mousePos.y);
							mousePos = PlayerLogic.detectBounds(tempPos);
							if(pos.x<mousePos.x){
								_left=0;
								_OnMouseRight(1);
							}
						}else if(pos.x>mousePos.x){
							tempPos = new Point(mousePos.x,mousePos.y);
							mousePos = PlayerLogic.detectBounds(tempPos);
							if(pos.x>mousePos.x){
								_right=0;
								_OnMouseLeft(1);
							}
						}
					}
				}
			}
		}
		private function onAction(stopFlag:Boolean=false):void{
			if((_left == 0 && _right == 0 && _up == 0 && _down == 0) || stopFlag){
				isActive = false;
				RPBELevel.setBgFrame();
				currentSheet = idleSheet;
				setChaAction();
				if(getMouseEffectRender() && mouseEffectShowFlag){
					getMouseEffectRender().alpha = 0;
					mouseEffectShowFlag = false;
				}
			}
		}
		/**
		 * 获取鼠标效果实体中的Render 
		 * @return 
		 * 
		 */		
		public function getMouseEffectRender():RMouseEffectMcRender{
			var mouseEffectEnt:IEntity = 
				PBE.nameManager.lookup(RSceneConst.MOUSE_EFFECT_ENTITY_NAME);
			if(mouseEffectEnt){
				var render:RMouseEffectMcRender = 
					mouseEffectEnt.lookupComponentByName("rMouseEffectMcRender") as RMouseEffectMcRender;
				return render;
			}
			return null;
		}
		
		//鼠标操作左移动作
		private function _OnMouseLeft(value:Number):void{
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
			if(_left==1 || _right==1 || _down==1){//如果有其他按键，只不响应动画，直接返回
				return;
			}
			currentSheet = walkSheet;
			setChaAction();
		}
		//下
		private function runDown():void{
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
				//设置站立动画
				if(!(characterAnimator.animations[RCharacterConst.IDLE_STR] as Animator).isAnimating){
					characterAnimator.play(RCharacterConst.IDLE_STR);
				}
				
			}else if(currentSheet == walkSheet){
				//设置跑动动画
				if(!(characterAnimator.animations[RCharacterConst.WALK_STR] as Animator).isAnimating){
					characterAnimator.play(RCharacterConst.WALK_STR);
				}
			}
			if(currentDirect == RDirectionVo.LEFT_DIRECTION){
				if(render.scale.x==1){
					render.scale = new Point(-1,1);
					if(gemRender){
						gemRender.scale = new Point(-1,1);
					}
				}
				//render.scale = new Point(-Math.abs(render.scale.x),render.scale.y);
			}else{
				if(render.scale.x==-1){
					render.scale = new Point(1,1);
					if(gemRender){
						gemRender.scale = new Point(1,1);
					}
				}
				//render.scale = new Point(Math.abs(render.scale.x),render.scale.y);
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
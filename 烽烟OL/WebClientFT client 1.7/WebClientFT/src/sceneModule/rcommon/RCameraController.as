package sceneModule.rcommon
{
	
	import com.pblabs.animation.Animator;
	import com.pblabs.animation.AnimatorComponent;
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.core.InputKey;
	import com.pblabs.engine.core.InputManager;
	import com.pblabs.engine.core.InputMap;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.EntityComponent;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.IEntityComponent;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.rendering2D.DisplayObjectRenderer;
	import com.pblabs.rendering2D.SpriteRenderer;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import sceneModule.rcommand.scene.bg.renderes.RepeatingRenderComponentXOnly;
	
	public class RCameraController extends EntityComponent implements ITickedObject
	{
		public function RCameraController()
		{
			super();
		}
		
		private const CAMERA_NAME:String = "CameraControl";
		
		public var isActive:Boolean = true;
		
		private var _left:Number = 0;
		private var _right:Number = 0;
		private var _up:Number = 0;
		private var _down:Number = 0;
		private var _mouseValue:Number = 0;
		
		private const MOVE_VELOCITY_X:int = 20;//如果镜头速度参数为空，则取此X速度
		private const MOVE_VELOCITY_Y:int = 20;//如果镜头速度参数为空，则取此Y速度
		
		private var moveVelocityX:int;//镜头X轴移动速度
		private var moveVelocityY:int;//镜头Y轴移动速度
		
		[TypeHint(type="flash.geom.Point")]
		public var velocityReference:PropertyReference;
		
		private var characterLayerArr:Array = new Array();
		
		//角色实体中的Box2DSpatialComponent
		private var spatial:Box2DSpatialComponent;
		private var spatialPos:Point;
		//当前镜头要移动到的坐标
		private var targetPos:Point;
		
		public function onTick(deltaTime:Number):void
		{
			
			if(isActive)
			{
				var moveX:Number = _right-_left;
				var moveY:Number = _down - _up;
				var velocity:Point = owner.getProperty(velocityReference);
				velocity.x = moveX*moveVelocityX;
				velocity.y = moveY*moveVelocityY;
				//trace("velocity: "+velocity.x+" -- "+velocity.y);
				owner.setProperty(velocityReference, velocity);
				//trace(isMouseAction);
				//当前的坐标
				spatialPos = new Point(Math.round(spatial.position.x),Math.round(spatial.position.y));
				if(_left==1&&(spatialPos.x<targetPos.x||spatialPos.x==targetPos.x)){
					_left=0;
					_right=0;
				}
				if(_right==1&&(spatialPos.x>targetPos.x||spatialPos.x==targetPos.x)){
					_left=0;
					_right=0;
				}
				if(_up==1&&(spatialPos.y<targetPos.y||spatialPos.y==targetPos.y)){
					_up=0;
					_down=0;
				}
				if(_down==1&&(spatialPos.y>targetPos.y||spatialPos.y==targetPos.y)){
					_up=0;
					_down=0;
				}
				if(_left==0&&_right==0&&_up==0&&_down==0){
//					trace("stop");
					return;
				}
//				trace("Camera current positoin："+spatialPos.toString());
			}
		}
		/**
		 * 更新camera的坐标 
		 * @param posStart 镜头的起始坐标
		 * @param posTarget 镜头的终点坐标
		 * @param moveVerlocity 镜头的移动速度
		 * 
		 */		
		public function updateCameraPos(posStart:Point,posTarget:Point,moveVelocity:Point):void{
			if(moveVelocity){
				moveVelocityX = moveVelocity.x;
				moveVelocityY = moveVelocity.y;
			}else{
				moveVelocityX = MOVE_VELOCITY_X;
				moveVelocityY = MOVE_VELOCITY_Y;
			}
			
			if(posStart==posTarget){
				spatial.position=posStart;
				_right=0;
				_left=0;
				_up=0;
				_down=0;
				return;
			}
			if(posStart.x-posTarget.x>0){
				_left=1;
				_right=0;
			}else if(posStart.x-posTarget.x<0){
				_right=1;
				_left=0;
			}else{
				_right=0;
				_left=0;
			}
			
			if(posStart.y-posTarget.y>0){
				_up=1;
				_down=0;
			}else if(posStart.y-posTarget.y<0){
				_down=1;
				_up=0;
			}else{
				_up=0;
				_down=0;
			}
			
			targetPos = posTarget;
		}
		
		protected override function onAdd():void {
			PBE.processManager.addTickedObject(this);
			spatial = owner.lookupComponentByName("Spatial") as Box2DSpatialComponent;
			spatialPos = new Point(Math.round(spatial.position.x),Math.round(spatial.position.y));
		}
		
		protected override function onRemove():void {
			PBE.processManager.removeTickedObject(this);
		}
	}
}
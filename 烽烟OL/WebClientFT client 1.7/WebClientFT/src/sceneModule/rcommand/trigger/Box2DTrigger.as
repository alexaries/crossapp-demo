/*******************************************************************************
 * Level Master 2000
 * Copyright (C) 2010 Christian Herzog
 * For more information see http://code.google.com/p/levelmaster2000/
 *
 * This file is licensed under the terms of the MIT license, see
 * http://www.opensource.org/licenses/mit-license.php for further information.
 ******************************************************************************/

package sceneModule.rcommand.trigger
{
    import com.pblabs.box2D.Box2DSpatialComponent;
    import com.pblabs.box2D.CollisionEvent;
    import com.pblabs.box2D.PolygonCollisionShape;
    import com.pblabs.engine.PBE;
    import com.pblabs.engine.core.ObjectType;
    import com.pblabs.engine.debug.Logger;
    import com.pblabs.engine.entity.Entity;
    import com.pblabs.engine.entity.EntityComponent;
    import com.pblabs.engine.entity.IEntity;
    import com.pblabs.engine.entity.PropertyReference;
    import com.pblabs.rendering2D.SpriteRenderer;
    import sceneModule.rcommand.trigger.EventArguments;
    
    import flash.events.Event;
    import flash.geom.Point;
    import flash.utils.getDefinitionByName;
    
    //TODO: kill spatialComp.
    //Make it a compRef?
    //or just independant!
    
    /**
     * Fires events of class eventClassName with type eventType,
     * if the trigger is touched (Box2D box).
     */
    public class Box2DTrigger extends EntityComponent
    {
        /**
         * Gets and sets the position.
         * Wrapper for Box2D spatial component
         */
        public function get position():Point
        {
            if(spatialComp)
            {
                return spatialComp.position;
            }
            else
            {
//                Logger.error(this, "set position", "Add component first!");
                return new Point();
            }
        }

        public function set position(value:Point):void
        {
            if(spatialComp)
            {
                spatialComp.position = value;
            }
            else
            {
//                Logger.error(this, "set position", "Add component first!");
            }
        }
        
        /**
         * Gets and sets the size.
         * Wrapper for Box2D spatial component
         */
        public function get size():Point
        {
            if(spatialComp)
            {
                return spatialComp.size;
            }
            else
            {
//                Logger.error(this, "set size", "Add component first!");
                return new Point();
            }
        }

        public function set size(value:Point):void
        {
            if(spatialComp)
            {
                spatialComp.size = value;
            }
            else
            {
//                Logger.error(this, "set size", "Add component first!");
            }
        }
        
        /**
         * Get and set the collision type. 
         * Wrapper for Box2D spatial component
         */
        public function get collisionType():ObjectType
        {
            if(spatialComp)
            {
                return spatialComp.collisionType;
            }
            else
            {
//                Logger.error(this, "set collisionType", "Add component first!");
                return new ObjectType();
            }            
        }
        
        public function set collisionType(value:ObjectType):void
        {
            if(spatialComp)
            {
                spatialComp.collisionType = value;
            }
            else
            {
//                Logger.error(this, "set collisionType", "Add component first!");
            }            
        }
        
        /**
        * Get and set the collides with types. 
        * Wrapper for Box2D spatial component
        */
        public function get collidesWithTypes():ObjectType
        {
            if(spatialComp)
            {
                return spatialComp.collidesWithTypes;
            }
            else
            {
//                Logger.error(this, "set collidesWithTypes", "Add component first!");
                return new ObjectType();
            }   
        }
        
        public function set collidesWithTypes(value:ObjectType):void
        {
            if(spatialComp)
            {
                spatialComp.collidesWithTypes = value;
            }
            else
            {
//                Logger.error(this, "set collidesWithTypes", "Add component first!");
            }            
        }        
        
        /**
         * Gets and sets the name of the event class which should be fired on collision.
         */
        public function get eventClassName():String
        {
            return _eventClassName;
        }
        
        public function set eventClassName(value:String):void
        {
            _eventClassName = value;
           // _eventIsDirty = true;

            try 
            {
                _eventClassReference = getDefinitionByName(_eventClassName) as Class;
                _isValidEventClass = true;
            }
            catch (e:Error )
            {
                Logger.error(this, "eventClassName", e.toString() + "\nEvent not going to fire on collision!" );
                _isValidEventClass = false;
            }
        }
        
        /**
         * Gets and sets the event type.
         */
        public function get eventType():String
        {
            return _eventType;
        }
        
        public function set eventType(value:String):void
        {
            _eventType = value;
        } 
        
        /*
        public function get eventArguments():Array
        {
            var _tmpArguments:Array = new Array();
            
            for each (var obj:Object in _eventArguments)
            {
                _tmpArguments.push(obj);
            }
            
            return _tmpArguments;
        }

        public function set eventArguments(value:Array):void
        {
            _eventArguments = new Array();
            
            for each (var obj:Object in value)
            {
                _eventArguments.push(obj);
            }
        }*/

        //private var _eventArguments:Array = new Array();
                

        public var args:EventArguments;
        private var _argsString:String;
        
        public function set argsString(value:String):void
        {
            _argsString = value;
            
        }
        
        public function get argsString():String
        {
            return _argsString;
        }
        
        //Privates:
        private var spatialComp:Box2DSpatialComponent;
        private var shape:PolygonCollisionShape;

        private var _event:Event = null;
        private var _eventClassName:String = "";
        private var _eventType:String = "";
        private var _eventClassReference:Class = null; 
        private var _isValidEventClass:Boolean = false;
        
        /**
         * We check how much contact points we have. 
         * The trigger is only executed once per onCollision,
         * and not with every new contact point.
         */
        private var _hasCollider:int = 0;
        
        private function createEvent():void
        {
            if(_isValidEventClass)
            {
                if(_eventType == "")
                {
                    _event = new _eventClassReference();
                }
                else
                {
                    _event = new _eventClassReference(_eventType);
                }

                args = new EventArguments(_event);
                args.evaluateString(_argsString);
            }
        }
        
        protected override function onAdd():void
        {
            super.onAdd();
      
            //Ugly hack to work when created per AS as well as per deserialization:
            //if(!owner.lookupComponentByName("Spatial"))
            if(!owner.lookupComponentByName("Spatial"))
            {
				trace("sceneModule.trigger.Box2DTrigger.as 创建spatial 需要打开下面的注释");
                //Create our spatial component / body:
//                spatialComp = new Box2DSpatialComponent();
//                spatialComp.spatialManager= PBE.spatialManager as Box2DManagerComponent;
//                spatialComp.position = new Point(0, 0);
//                spatialComp.size = new Point(2048, 128);
//                spatialComp.collisionType = new ObjectType("Platform");
//                spatialComp.canMove = false;
//                spatialComp.canRotate = false;
//                spatialComp.canSleep = true;
//                spatialComp.collidesWithTypes = new ObjectType();
//                
//                //We also need a collision shape, which collides with the world (meaning other shapes):
//                shape = new PolygonCollisionShape();
//                shape.friction = 1.0;
//                shape.isTrigger = true;
//                shape.vertices = new Array();
//                shape.vertices.push( new Point( -1, -1) );
//                shape.vertices.push( new Point( 1, -1) );
//                shape.vertices.push( new Point( 1, 1) );
//                shape.vertices.push( new Point( -1, 1) );
//                
//                //Now we add the shape to the spatial component / body:
//                spatialComp.collisionShapes = new Array();
//                spatialComp.collisionShapes.push(shape);
//                 
//                //Add the component to the entity:
//                owner.addComponent( spatialComp, "Spatial" ); 			
//
//                //don't forget to build the collision shapes after adding component:		
//                spatialComp.buildCollisionShapes(); 
//                
//                var renderComp:SpriteRenderer = new SpriteRenderer();
//                renderComp.fileName = "../assets/icons/trigger.png";
//                renderComp.positionProperty = new PropertyReference("@Spatial.position");
//                owner.addComponent( renderComp, "Render" ); 			
			}
            else
            {
                spatialComp = owner.lookupComponentByName("Spatial") as Box2DSpatialComponent;
            }
         
            owner.eventDispatcher.addEventListener(CollisionEvent.COLLISION_EVENT, onCollision);		
            owner.eventDispatcher.addEventListener(CollisionEvent.COLLISION_STOPPED_EVENT, onStoppedCollision);		
        }
        
		protected override function onRemove():void
		{
			super.onRemove();
            
            owner.eventDispatcher.removeEventListener(CollisionEvent.COLLISION_EVENT, onCollision);
            owner.eventDispatcher.removeEventListener(CollisionEvent.COLLISION_STOPPED_EVENT, onStoppedCollision);		
		}
        
		private function onCollision(event:CollisionEvent):void
		{
            var collider:Box2DSpatialComponent = event.collider;
            var otherCollider:Box2DSpatialComponent = event.collidee;
            
            if(spatialComp == otherCollider)
            {
                otherCollider = event.collider;
                collider = event.collidee;
            }
            
            if(PBE.objectTypeManager.doTypesOverlap(collider.collisionType, otherCollider.collidesWithTypes)
                && _isValidEventClass)
            {
                _hasCollider++;
                
                if (_hasCollider == 1)
                {
					trace("检测到并分发碰撞事件");
                    createEvent();
                    otherCollider.owner.eventDispatcher.dispatchEvent(_event);
                }
            }
            else if(!_isValidEventClass)
            {
                Logger.warn(this, "onCollision", "Collision with trigger happened, but event class " + _eventClassName + " is not valid.\n"
                    + "Entity: " + owner.name + " component: " + name);
            }
        }
        
		private function onStoppedCollision(event:CollisionEvent):void
		{
            var collider:Box2DSpatialComponent = event.collider;
            var otherCollider:Box2DSpatialComponent = event.collidee;
            
            if(spatialComp == otherCollider)
            {
                otherCollider = event.collider;
                collider = event.collidee;
            }
                
            if(PBE.objectTypeManager.doTypesOverlap(collider.collisionType, otherCollider.collidesWithTypes))                
            {
                _hasCollider--;
            }
        }        
    }
}
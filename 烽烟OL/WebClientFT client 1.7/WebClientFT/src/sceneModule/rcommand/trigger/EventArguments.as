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
    import com.pblabs.engine.entity.IEntityComponent;
    import com.pblabs.engine.entity.PropertyReference;
    import flash.geom.Point;
    import com.pblabs.engine.entity.IEntity;
    import com.pblabs.engine.PBE;
    import flash.events.Event;
	import com.pblabs.engine.debug.Logger;
    
    public class EventArguments 
    {
        private var _argumentString:String = "";
        
        public function EventArguments(event:Event) 
        {
			this.event = event;
		}        
        
        public function evaluateString(argsString:String):void
        {
			//Logger.print(this, "evaluateString:" + argsString);
			
            //EVENT ARGS:
            //[NAME]|[TYPE]|[VALUE],[NAME]|[TYPE]|[VALUE],...
            //position|flash.geom::Point|10.3/23.5,health|Number|25,rotation|Ref|#Player.Spatial.rotation
            //position|Point|#Player.Spatial.position
            var args:Array = argsString.split(",");
            
            for each(var arg:String in args)
            {
                //e.g. position|flash.geom::Point|10.3/23.5
                var paramBits:Array = arg.split("|");
                if (event == null)
                {
                    continue;
                }
                
                try
                {
                    event[paramBits[0]];
                }
                catch (e:Error)
                {
                    continue;
                }
                
                var component:IEntityComponent = checkForComponentReference(paramBits[2]);
                var curLookup:String = "";
                var names:Array = null;
                
                switch(paramBits[1])
                {
                    case "Number":
                    {
                        if (component != null)
                        {
                            curLookup = paramBits[2].slice(1);
                            names = curLookup.split(".");

                            var n:Number;
                            //Player.Spatial.position
                            switch(names.length)
                            {
                                case 3:
                                {
                                    n = component[names[2]];
                                }
                                break;
                                
                                case 4:
                                {
                                    n = component[names[2]][names[3]];
                                }
                                break;
                            }
                            event[paramBits[0]] = n;
                        }
                        else
                        {
                            event[paramBits[0]] = parseFloat(paramBits[2]);
                        }
                    }
                    break;
                    
                    case "Point":
                    {
                        if (component != null)
                        {
                            curLookup = paramBits[2].slice(1);
                            names = curLookup.split(".");

                            var p:Point = component[names[2]];
                            event[paramBits[0]] = (component[names[2]] as Point);
                        }
                        else
                        {
                            var values:Array = paramBits[2].split("/");
                            event[paramBits[0]] = new Point( parseFloat(values[0]), parseFloat(values[1]));
                        }
                    }
                    break;
                }
            }
            
            _argumentString = argsString;
        }
        
        private function checkForComponentReference(path:String):*
        {
            var c:IEntityComponent = null;
            
            var startChar:String = path.charAt(0);
            if(startChar == "#")
            {
                var curLookup:String = path.slice(1);
                var names:Array = curLookup.split(".");
                var ent:IEntity = PBE.nameManager.lookup(names[0]);
                c = ent.lookupComponentByName(names[1]);
            }
            
            return c;
        }
        
        private var event:Event;
    }
}
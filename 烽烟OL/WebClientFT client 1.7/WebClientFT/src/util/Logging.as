package util 
{
	import com.adobe.serialization.json.JSON;
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.KeyBind;
	import flash.display.DisplayObject;
	import wordscene.WordSceneSprite;
	/**
	 * ...
	 * @author hao
	 */
	public class Logging 
	{
		public static function init(dis:DisplayObject):void {
			Cc.config.commandLineAllowed = true;
			Cc.config.tracing = true;
			Cc.config.maxLines = 2000;
			Cc.config.commandLineAutoScope = true;
			Cc.startOnStage(dis, "asd");
			Cc.commandLine = true;
			Cc.width = 700;
			Cc.height = 260;
			
			Cc.store("scene", WordSceneSprite.getInstance());
			
			Cc.setRollerCaptureKey("l");
			Cc.addSlashCommand("dis", function():void{ Cc.displayRoller = !Cc.displayRoller;} );
			Cc.addSlashCommand("cls", function():void{ Cc.clear()} );
		}
		
		public static function stor(name:String, obj:Object):void {
			Cc.store(name, obj);
		}
		
		public static function log(...args):void {
			var d:Date = new Date();
			args.unshift(d.hours + ":" + d.minutes + ":" + d.seconds + ":" + d.milliseconds);
			Cc.log(args);
		}
		
		public static function o2s(o:*):String {
			return JSON.encode(o);
		}
	}

}
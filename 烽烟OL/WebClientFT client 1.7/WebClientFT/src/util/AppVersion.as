package util
{
	import flash.external.ExternalInterface;
	
	public class AppVersion
	{
		public function AppVersion()
		{
		}
		/**
		 * 当前资源的版本号 
		 */		
		//private static var _versionStr:String = "CrotaII(C_alpha) Ver 1.0.1 06131500";
		public static function get versionStr():String{
			var verObj:Object = {};
			verObj = getVersionObj();
			var ver:String="";
			if(verObj){
				ver = String(verObj.resVer);
			}
			return ver;
		}
		public static function get appVersionStr():String{
			var verObj:Object = {};
			verObj = getVersionObj();
			var ver:String="";
			if(verObj){
				ver = String(verObj.appVer);
			}
			else {
				ver = "";
			}
			return "";
		}
		/**
		 * 获取版本对象 
		 * @return 
		 * 
		 */		
		public static function getVersionObj():Object{
			var verObj:Object = {};
			if(ExternalInterface.available){
				try {
					verObj = ExternalInterface.call("getVer");
				} catch(e:Error) {
					trace(e)
				}
			}
			return verObj;
		}
	}
}
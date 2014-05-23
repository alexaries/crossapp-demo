package logonModule.module.vo
{
	/**
	 * 用户信息
	 * @author Yaolx
	 */
	public class User
	{
		public function User()
		{
			
		}
		
		private var _username:String;
		public function get username():String{
			return _username;
		}
		public function set username(value:String):void{
		    _username = value;
		}
		
		private var _password:String;
		public function get password():String{
			return _password;
		}
		public function set password(value:String):void{
		    _password = value;
		}
		
		private var _userId:int;
		public function get userId():int{
		    return _userId;
		}
		public function set userId(uId:int):void{
		    _userId = uId;
		}
	}
}
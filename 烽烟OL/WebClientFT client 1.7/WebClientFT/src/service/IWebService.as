package service
{
	public interface IWebService
	{
		/**
		 * 设置基础地址及端口 
		 * @param url
		 * @param port
		 * 
		 */		
		function setUrl(url:String, port:String):void;
		
		/**
		 * 新用户注册 
		 * @param username 用户名
		 * @param password 密码
		 * @param email    邮箱
		 * 
		 */		
		function registNewUser(actionUrl:String, username:String, password:String, email:String,validateCode:String):void;
		
	}
}
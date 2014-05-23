package service
{
	public interface IRemoteService
	{
		/**
		 * 连接服务器
		 * @param url 地址
		 * @param destination 目标名
		 * 
		 */		
		function connect(url:String, destination:String):void;
		
		/**
		 * 断开服务器 
		 * 
		 */		
		function disconnect():void;
		
		/**
		 * 登陆游戏 
		 * @param username 用户名
		 * @param password 密码
		 * 
		 */		
		function login(username:String, password:String):void;
		
		/**
		 * 登出 
		 * 
		 */		
		function logout():void;
		
		/**
		 * 动态调用service方法 
		 * @param name	方法名
		 * @param arg	参数
		 * @return 
		 * 
		 */		
		function callService(name:String, ...arg:Array):*;
		
		/**
		 * 订阅消息
		 * @topic 
		 * @handler 反调函数
		 * 
		 */
		function subscribe(topic:String,handler:Function):void;
		
		/**
		 * 取消订阅消息
		 * @topic
		 */
		function unsubscribe( topic:String ):void;
	}
}
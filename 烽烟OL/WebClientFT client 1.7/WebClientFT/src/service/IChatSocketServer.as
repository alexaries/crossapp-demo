package service
{
	import flash.utils.ByteArray;
	
	import mx.rpc.IResponder;

	/**
	 * ISocketServer 
	 * @author Yaolx
	 * 
	 */	
	public interface IChatSocketServer
	{
		/**
		 * 链接服务器 
		 * 
		 */		
		function connect():void;
		/**
		 * 向服务器发送信息 
		 * @param responder  回调函数
		 * @param functionName  方法名
		 * @param data 传递的信息数据
		 * 
		 */		
		function send(responder:IResponder, commandID:int, data:ByteArray=null, isSend:Boolean=true):void;
		/**
		 * 获取服务器地址 
		 * @return 
		 * 
		 */		
		function get host():String;
		/**
		 * 设置服务器地址 
		 * @param value
		 * 
		 */		
		function set host(value:String):void;
		/**
		 * 获取端口号 
		 * @return 
		 * 
		 */		
		function get port():int;
		/**
		 * 设置端口号 
		 * @param value
		 * 
		 */		
		function set port(value:int):void;
		/**
		 * 关闭链接 
		 * 
		 */		
		function close():void;
	}
}
package service
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.Consumer;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.events.MessageEvent;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.robotlegs.mvcs.Actor;
	
	import service.responder.LoginResponder;
	import service.responder.LogoutResponder;
	
	/**
	 * Remoting Service实现 
	 * @author Linus
	 * 
	 */	
	public class RemoteServer extends Actor implements IRemoteService
	{
		private var _consumers:Dictionary = new Dictionary();
		/**
		 * Remoting对象 
		 */		
		public var _remoteObject:RemoteObject;
		
		/**
		 * AMF通道 
		 */		
		protected var _channel:AMFChannel;
		
		/**
		 * 通道集合 
		 */		
		protected var _channelSet:ChannelSet;
		
		/**
		 * construction 
		 * 
		 */		
		public function RemoteServer()
		{
			super();
		}
		
		/**
		 * 连接 
		 * @param url 地址
		 * @param destination 描述
		 * 
		 */		
		public function connect(url:String, destination:String):void
		{
			_channel = new AMFChannel('amf-channel', url);
			
			_channelSet = new ChannelSet;
			_channelSet.addChannel(_channel);
			
			_remoteObject = new RemoteObject(destination);
			_remoteObject.showBusyCursor = true;
			_remoteObject.channelSet = _channelSet;

			_remoteObject.addEventListener(ResultEvent.RESULT, onConnectResult);
			_remoteObject.addEventListener(FaultEvent.FAULT, onFault);
			_remoteObject.addEventListener(InvokeEvent.INVOKE, onInvoke);
			
		}
		
		private function getConsumerByTopic(topic:String):Consumer{
		    return _consumers[topic];
		}
		/**
		 * 订阅topic频道的消息
		 * 
		 */
		public function subscribe(topic:String,handler:Function):void{
		    if(getConsumerByTopic(topic) == null){
				_consumers[topic] = new Consumer();
				getConsumerByTopic(topic).destination = topic;
				getConsumerByTopic(topic).channelSet = this._channelSet;
				getConsumerByTopic(topic).subscribe();
			}
			getConsumerByTopic(topic).addEventListener(MessageEvent.MESSAGE, handler, false, 0 , true);
		}
		
		/**
		 * 取消topic频道的消息
		 * 
		 */
		public function unsubscribe( topic:String ):void {
			if( getConsumerByTopic(topic) != null && getConsumerByTopic(topic).subscribed ) {
				getConsumerByTopic(topic).unsubscribe();
				delete this._consumers[topic];
			}
		}
		
		/**
		 * 断开服务器 
		 * 
		 */		
		public function disconnect():void
		{
			_remoteObject.disconnect();
		}
		
		/**
		 * 登陆服务器 
		 * @param username 用户名
		 * @param password 密码
		 * 
		 */		
		public function login(username:String, password:String):void
		{
			var token:AsyncToken = _remoteObject.channelSet.login(username, password);
			token.addResponder(new LoginResponder);
		}
		
		/**
		 * 登出 
		 * 
		 */		
		public function logout():void
		{
			var token:AsyncToken = _remoteObject.channelSet.logout();
			token.addResponder(new LogoutResponder);
		}
		
		/**
		 * 动态调用service方法 
		 * @param name	方法名
		 * @param arg	参数
		 * @return 
		 * 
		 */			
		public function callService(name:String, ...arg:Array):*
		{
			return new DefaultTokenHandler(_remoteObject.getOperation(name).send.apply(null, arg));
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function onConnectResult(event:ResultEvent):void
		{
			trace(event.message);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function onFault(event:FaultEvent):void
		{
			trace(event.message);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		protected function onInvoke(event:InvokeEvent):void
		{
			trace(event.message);
		}
	}
}
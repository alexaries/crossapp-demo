package service
{
	
	import event.ChangeModuleEvent;
	import event.GuidClearEvent;
	import event.GuidEventCenter;
	
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import logonModule.command.LoginMessage;
	import logonModule.event.NLoginEvent;
	
	import managers.WindowManager;
	
	import model.ServerConfig;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	import org.robotlegs.mvcs.Actor;
	
	import resource.CrotaResourceConfig;
	import resource.ModuleList;
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	import util.ByteArrayUtil;
	import util.xtrace;
	
	public class SocketService extends Actor implements ISocketServer
	{
		
		public static const HEAD_0:int=78;
		public static const HEAD_1:int=37;
		public static const HEAD_2:int=38;
		public static const HEAD_3:int=48;
		
		public static const HEAD_CHUNK_LENGTH:int=17;
		public static const HEAD_LENGTH:int=4;
		public static const SESSION_ID_LENGTH:int=8;
		
		public static const PROTOCAL_VERSION:int=9;
		public static const SERVER_VERSION:int=0;
		
		public static const COMMAND_COUNT:int=10;
		
		public static const LONG_CONNECTION:int=1;
		public static const SHORT_CONNECTION:int=0;
		//脉冲
		public static const TIMEOUT:int=60000;
		
		public var timer:Timer;
		
		protected var sessionIDBytes:ByteArray;
		protected var serverVersion:int=SERVER_VERSION;
		
		protected var _connetionStatus:int=LONG_CONNECTION;
		
		protected var responderDictionary:Dictionary;
		
		public var socket:Socket;
		
		protected var data:ByteArray;
		
		protected var _host:String;
		
		protected var _port:int;
		
		protected var cache:ArrayCollection;
		
		private var sendQueue:Array; //待发送的指令数组
		private var sendTimer:Timer; //指令发送计时器
		private const SEND_INTERVAL:int=10; //每条指令的发送间隔
		
		[Inject]
		public var popUpShow:IPopUpShow;
		
		[Inject]
		public var moduleList:ModuleList;
		
		private var _on_server_fun:Function;
		private var _on_server_args:Array;
		
		public function SocketService()
		{
			
			responderDictionary=new Dictionary();
			
			socket=new Socket();
			sessionIDBytes=new ByteArray();
			sessionIDBytes.length=SESSION_ID_LENGTH;
			cache=new ArrayCollection();
			
			timer=new Timer(TIMEOUT);
			timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			timer.start();
	
			sendQueue=[];
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			if (_connetionStatus == SHORT_CONNECTION)
			{
				timer.stop();
				return;
			}
			
			sendHeartData();
		}
		
		protected function sendHeartData():void
		{
			var byteArray:ByteArray=new ByteArray();
			var bodySize:int=0;
			
			byteArray.writeByte(HEAD_0);
			byteArray.writeByte(HEAD_1);
			byteArray.writeByte(HEAD_2);
			byteArray.writeByte(HEAD_3);
			
			byteArray.writeByte(9);
			byteArray.writeInt(-1);
			
			byteArray.writeBytes(sessionIDBytes, 0, SESSION_ID_LENGTH);
			byteArray.writeInt(21);
			
			if (socket && socket.connected)
			{
				socket.flush();
			}
		}
		
		private function startSendTimer():void
		{
			sendTimer=new Timer(SEND_INTERVAL);
			sendTimer.addEventListener(TimerEvent.TIMER, sendTimerHandler);
			sendTimer.start();
		}
		
		private function releaseSendTimer():void
		{
			if (sendTimer != null)
			{
				sendTimer.stop();
			}
			sendTimer=null;
		}
		
		//向服务器发送指令
		private function sendTimerHandler(event:TimerEvent = null):void
		{
			if (sendQueue.length > 0)
			{
				var sendData:ByteArray=sendQueue.shift() as ByteArray;
				if (sendData != null)
				{
					if (socket != null && socket.connected)
					{
						// 发送数据
						try
						{
							socket.writeBytes(sendData, 0, sendData.length);
							socket.flush();
						}
						catch (err:IOError)
						{
							trace(err);
							onIOError(null);
						}
					}
				}
			}
		}
		
		//安全策略文件加载
		private function getPolicyFile():void{
		    Security.loadPolicyFile("xmlsocket://"+host+":843");
		}
		
		public function connect(on_server_func:Function,args:Array = null):void
		{
			xtrace("请求连接到服务器", _host, ":", port.toString());
			//清理已存在的socket信息,用于重连
			if (null != socket) {
				close();
			}
			
			getPolicyFile();
			socket = new Socket();
			sendQueue.length=0;
			socket.addEventListener(Event.CLOSE, onClose, false, 0, true);
			socket.addEventListener(Event.CONNECT, onConnect, false, 0, true);
			
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onData, false, 0, true);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, true);
			
			_on_server_fun = on_server_func;
			_on_server_args = args;
			
			LoginMessage.getInstance().dispatchEvent(new NLoginEvent(NLoginEvent.NLoginEvent_SHOW_SOCKET_CON));
			
			socket.connect(host, port);
			
		}
		//socket断开连接处理
		public function close():void
		{
			xtrace("清理socket信息");
			releaseSendTimer();
			
			if (socket && socket.connected)
			{
				socket.close();
			}
			
			socket.removeEventListener(Event.CLOSE, onClose);
			socket.removeEventListener(Event.CONNECT, onConnect);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			socket=null;
		}
		//与服务器建立连接
		public function onConnect(event:Event):void
		{
			xtrace("成功连接到服务器");
			//执行连接到服务器的函数
			_on_server_fun.apply(null, _on_server_args);
			LoginMessage.getInstance().dispatchEvent(new NLoginEvent(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER));
			//连接上后，开始启动发送指令的时间线程
			startSendTimer();
		}
		
		public function onClose(e:Event):void
		{
			GuidEventCenter.getInstance().dispatchEvent(new GuidClearEvent(GuidClearEvent.SOCKET_CLOSE));
			popUpShow.show(CrotaResourceConfig.getInstance().getTextByModuleAndId('service','css_fwqzd'));
			WindowManager.closeAllWindows();
			
//			LoginMessage.getInstance().dispatchEvent(new NLoginEvent(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER));
//			
//			dispatch(new ChangeModuleEvent(moduleList.LOGON_MODULE));
		}
		
		public function onIOError(event:IOErrorEvent):void
		{
//			dispatchEvent(event);
		}
		
		public function onData(event:ProgressEvent):void
		{
			processData();
		}
		
		public function onSecurityError(event:SecurityErrorEvent):void
		{
			LoginMessage.getInstance().dispatchEvent(new NLoginEvent(NLoginEvent.NLoginEvent_SHOW_SOCKET_ON_SERVER));
		}
		
		public function get connectionStatus():int
		{
			return _connetionStatus;
		}
		
		public function set connectionStatus(value:int):void
		{
			_connetionStatus=value;
		}
		
		public function send(responder:IResponder, commandID:int, data:ByteArray=null, isSend:Boolean = true):void
		{
			//responderDictionary 回调函数字典 responder回调函数
			responderDictionary[commandID]=responder;
			
			if (data && isSend)
			{
				data.position=0;
				// 获得消息内容长度
				const bodySize:int=data.bytesAvailable;
				
				var byteArray:ByteArray=new ByteArray();
				
				byteArray.writeByte(HEAD_0);
				byteArray.writeByte(HEAD_1);
				byteArray.writeByte(HEAD_2);
				byteArray.writeByte(HEAD_3);
				
				byteArray.writeByte(9);
				byteArray.writeInt(0);
//				byteArray.writeBytes(sessionIDBytes, 0, SESSION_ID_LENGTH);
				
				//消息内容长度+4  之所以加4是因为消息内容前加有指令号commandId 即接下来的byteArray.writeInt(commandID);
				byteArray.writeInt(bodySize + 4);
				//消息指令号
				byteArray.writeInt(commandID);
				
				// 指令数据
				byteArray.writeBytes(data, 0, bodySize);
				
				//存放到发送数组中
				sendQueue.push(byteArray);
				return;
				//直接发送
				if (socket != null && socket.connected)
				{
					// 发送数据
					try
					{
						byteArray.position = 0;
						socket.writeBytes(byteArray, 0, byteArray.length);
						socket.flush();
						Logger.print(this,'SocketService:sendMessage...');
					}
					catch (err:IOError)
					{
						trace(err);
						onIOError(null);
					}
				}else{
					//存放到发送数组中
					sendQueue.push(byteArray);
				}
				
			}
			else
			{
				//监听服务器推送消息时的时间差问题（服务器广播的消息在客户端注册事件监听之前广播的情况下使用该方法处理）
				if (responder)
				{
					
					var len:int=cache.length;
					
					while (len--)
					{
						if (cache.getItemAt(len).label == commandID)
						{
							responder.result(cache.getItemAt(len).data);
							cache.removeItemAt(len);
						}
					}
				}
			}
		}
		
		
		private function processData():void
		{
			var bytes:ByteArray=new ByteArray();
			socket.readBytes(bytes, 0, socket.bytesAvailable);
			//这个地方取值貌似没有用到
			bytes.position=0;
			
			if (data == null)
			{
				data=new ByteArray();
			}
			
			data.position=data.length;
			data.writeBytes(bytes, 0, bytes.bytesAvailable);
			data.position=0;
			var isEnd:Boolean=false;
			while (!isEnd)
			{
				isEnd=processOneData(data);
				
				if (data.position > 0)
				{
					var tmp:ByteArray=new ByteArray();
					tmp.writeBytes(data, data.position, data.bytesAvailable);
					tmp.position=0;
					data=tmp;
				}
			}
		}
		
		public function processOneData(allData:ByteArray):Boolean
		{
			
			if (allData.bytesAvailable <= HEAD_CHUNK_LENGTH)
			{
				return true;
			}
			
			var head0:int=allData.readByte();
			var head1:int=allData.readByte();
			var head2:int=allData.readByte();
			var head3:int=allData.readByte();
			
			
			var isHead:Boolean=false;
			while (!isHead)
			{
				if (head0 != HEAD_0 || head1 != HEAD_1 || head2 != HEAD_2 || head3 != HEAD_3)
				{
					
					if (allData.bytesAvailable <= 0)
					{
						return true;
					}
					head0=head1;
					head1=head2;
					head2=head3;
					head3=allData.readByte();
				}
				else
				{
					isHead=true;
				}
			}
			
			if (allData.bytesAvailable < HEAD_CHUNK_LENGTH - HEAD_LENGTH)
			{
				this.data=getCheckedDataWithoutDataLength(head0, head1, head2, head3, allData);
				return true;
			}
			
			var version:int=allData.readByte();
			var serverVersion:int=allData.readInt();
//			var sessionIdBytes:ByteArray=ByteArrayUtil.readIdBytes(allData, SESSION_ID_LENGTH);
			
			if (version != PROTOCAL_VERSION)
			{
				var datatmp:ByteArray=new ByteArray();
				datatmp.writeBytes(allData, allData.position, allData.bytesAvailable);
				datatmp.position=0;
				data=datatmp;
				return true;
			}
			
//			this.sessionIDBytes=sessionIdBytes;
			this.serverVersion=serverVersion;
			
			var dataLength:int=allData.readInt();
			
//			sessionIdBytes.position=0;
			if (dataLength > allData.bytesAvailable)
			{
				this.data=getCheckedData(head0, head1, head2, head3, version, serverVersion, dataLength, allData);
				return true;
			}
			//获取指定长度的字节流，防止黏包
			var cmdData:ByteArray=new ByteArray();
			allData.readBytes(cmdData, 0, dataLength);
//			trace(dataLength+'--length'+cmdData.bytesAvailable+'--');
			cmdData.position=0;
			//相应的回调函数处理数据
			processCommand(cmdData);
			return data != null && data.position >= data.length;
		}
		
		private function getCheckedDataWithoutDataLength(head0:int, head1:int, head2:int, head3:int, allData:ByteArray):ByteArray
		{
			var data:ByteArray=new ByteArray();
			data.writeByte(head0);
			data.writeByte(head1);
			data.writeByte(head2);
			data.writeByte(head3);
			data.writeBytes(allData, allData.position, allData.bytesAvailable);
			data.position=0;
			return data;
		}
		
		private function getCheckedData(head0:int, head1:int, head2:int, head3:int, version:int, appid:int, dataLength:int, allData:ByteArray):ByteArray
		{
			
			var data:ByteArray=new ByteArray();
			data.writeByte(head0);
			data.writeByte(head1);
			data.writeByte(head2);
			data.writeByte(head3);
			data.writeByte(version);
			data.writeInt(appid);
//			ByteArrayUtil.writeIdBytes(data, sessionId);
			data.writeInt(dataLength);
			data.writeBytes(allData, allData.position, allData.bytesAvailable);
			data.position=0;
			
			return data;
		}
		
		protected function processCommand(data:ByteArray):void
		{
			
			if (data){
				//获取指令号
				var commandId:int=data.readInt();
				var commandData:ByteArray=new ByteArray();
				data.readBytes(commandData, 0, data.bytesAvailable);
					
				var responder:IResponder=null;
				if (responderDictionary.hasOwnProperty(commandId))
				{
					responder=responderDictionary[commandId] as IResponder;
				}
					
				if (responder)
				{
					var len:int=cache.length;
						
					while (len--)
					{
						if (cache.getItemAt(len).label == commandId)
						{
							cache.removeItemAt(len);
						}
					}
					responder.result(commandData);
						
				}
				else
				{
					cache.addItem({label: commandId, data: commandData});
				}
			}
		}
		
		public function get host():String
		{
			return _host;
		}
		
		public function set host(value:String):void
		{
			_host=value;
		}
		
		public function get port():int
		{
			return _port;
		}
		
		public function set port(value:int):void
		{
			_port=value;
		}
	}
}
package service
{
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.xml.XMLNode;
	
	import model.ProtocolConst;
	
	import mx.controls.Button;
	import mx.core.mx_internal;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
//	import registModule.event.GetRegValidateCodeEvent;    2012.3.1
//	import registModule.event.RegPageEvent;    2012.3.1
	
	import sceneModule.view.popupWin.IPopUpShow;
	
	/**
	 * Web 服务器 
	 * @author Linus
	 * 
	 */	
	public class WebServer extends Actor implements IWebService,IResponder
	{
		[Inject]
		public var popUpShow:IPopUpShow;
		
		/**
		 * 服务器对象 
		 */		
		
		public var _server:HTTPService;
		
		/**
		 * 访问基础地址 
		 */		
		private var _baseUrl:String;
		
		/**
		 * 端口 
		 */		
		private var _port:String;
		
		/**
		 * constructor 
		 * @param baseUrl：server地址
		 * 
		 */		
		
		public function WebServer(baseUrl:String=null)
		{
			_server = new HTTPService;
			_baseUrl = baseUrl;
			super();
		}
		
		/**
		 * 设置基础url和端口 
		 * @param url
		 * @param port
		 * 
		 */		
		public function setUrl(url:String,port:String):void
		{
			_baseUrl = url;
			_port = port;
		}
		
		/**
		 * 注册 
		 * @param actionUrl	注册调用位置
		 * @param username	用户名
		 * @param password	密码
		 * @param email		邮箱
		 * 
		 */		
		public function registNewUser(actionUrl:String, username:String, password:String, email:String,validateCode:String):void
		{
			_server.url = actionUrl;
			var variables:URLVariables = new URLVariables();
			variables.username = username;
			variables.password = password;
			variables.email = email;
			variables.validateCode = validateCode;
			_server.method =  URLRequestMethod.POST;
			_server.resultFormat =  "object";
			_server.send(variables).addResponder(this);
			_server.xmlDecode = decodeXML;
			
		}
		
		public function result(data:Object):void
		{
			//trace("注册成功"+data.toString());
			
		}
		
		public function fault(info:Object):void
		{
			trace(FaultEvent(info).fault);
			//trace("注册失败"+info.toString());
			
		}
		/**
		 * 注册返回结果处理，对XML进行解析行到相应结果 
		 * @param dataNode 要解析的
		 * @return 
		 * 
		 */		
		private function decodeXML(dataNode:XMLNode):String
		{
			var resultStr:String="";
			for each (var item:XML in XML(dataNode).message)
			{
				if(item.hasOwnProperty("result")){
					var resultType:String="";//返回结果的类型 0-失败，1-成功
					resultType = item.result;
					if(resultType == ProtocolConst.SUCCESS_TYPE){//返回成功操作
//						dispatch(new RegPageEvent(RegPageEvent.REG_SUCCESS));   2012.3.1
					}else if(resultType == ProtocolConst.FAIL_TYPE){//返回失败操作
//						dispatch(new RegPageEvent(RegPageEvent.REG_FAIL));    2012.3.1
					}else if(resultType == ProtocolConst.VALIDATE_CODE_EXPIRE){//验证码失效，重新请求
						trace("重新获取验证码");
//						dispatch(new GetRegValidateCodeEvent(GetRegValidateCodeEvent.GET_REG_VALIDATE_CODE));2012.3.1
					}
					if(item.hasOwnProperty("reason")){
						resultStr = item.reason;
//						var flags:uint = Alert.YES|Alert.CANCEL;
//						Alert.yesLabel = "确定";
//						Alert.cancelLabel = "取消";
//						flags |= Alert.NONMODAL;
						popUpShow.show(resultStr);
//						myAlert.width = 683;
//						myAlert.height = 353;						

					}else{
						trace("没有返回结果，请检查注册后服务器返回的XML");
					}
					return resultStr;
				}
			}
			return resultStr;
		} 
	}
}
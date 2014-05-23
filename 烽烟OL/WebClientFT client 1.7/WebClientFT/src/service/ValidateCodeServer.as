package service
{
	
	import com.adobe.crypto.MD5;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.xml.XMLNode;
	
	import model.ProtocolConst;
	
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.robotlegs.mvcs.Actor;
	
	import registModule.event.GetRegValidateCodeEvent;
	import registModule.event.RegPageEvent;
	
	import utility.CommonUtils;
		
	//import utility.CommonUtils;
	
	/**
	 * Web 服务器 
	 * @author Linus
	 * 
	 */	
	public class ValidateCodeServer extends Actor implements IResponder,IValidateCodeService
	{
		/**
		 * 服务器对象 
		 */		
		
		public var _server:HTTPService;
		
		/**
		 * 访问基础地址 
		 */		
		private var _baseUrl:String;
		
		/**
		 * constructor 
		 * @param baseUrl：server地址
		 * 
		 */		
		public function ValidateCodeServer(baseUrl:String=null)
		{
			_server = new HTTPService();
			_baseUrl = baseUrl;
			super();
		}
		
		/**
		 * 获取注册需要的验证码 
		 * 
		 */		
		public function getRegistValidateCode(actionUrl:String):void{
			//请求验证码要求不同的URL，否则请求的为缓存，不向服务器发送。所以生成随机字符 格式为：MD5(六位随机码+当前时间戳)
			_server.url = actionUrl+"?"+MD5.hash(CommonUtils.generateRanCode(6)+CommonUtils.generateDateCode());
			_server.method =  URLRequestMethod.POST;
			_server.resultFormat =  "object";
			_server.send().addResponder(this);
			_server.xmlDecode = decodeXML;
		}
		
		public function result(data:Object):void
		{
			
		}
		
		public function fault(info:Object):void
		{
			trace(FaultEvent(info).fault);
			
		}
		/**
		 * 返回结果处理，对XML进行解析行到相应结果 
		 * @param dataNode 要解析的
		 * @return 
		 * 
		 */		
		private function decodeXML(dataNode:XMLNode):String
		{
			var resultStr:String="";
			for each (var item:XML in XML(dataNode).message)
			{
				if(item.hasOwnProperty("validateCode")){
					resultStr = item.validateCode;
					trace("返回的验证码："+resultStr);
					//发送验证码。
					dispatch(new GetRegValidateCodeEvent(GetRegValidateCodeEvent.GET_REG_VALIDATE_CODE_SUCCESS,resultStr));
					return resultStr;
				}
			}
			return resultStr;
		}
		
	}
}
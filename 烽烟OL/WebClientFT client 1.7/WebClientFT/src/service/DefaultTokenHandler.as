package service
{
	import mx.rpc.AsyncToken;

	/**
	 * 默认处理服务调用反馈 
	 * @author Linus
	 * 
	 */	
	public class DefaultTokenHandler
	{
		/**
		 * 待处理令牌 
		 */		
		private var _token:AsyncToken
		
		/**
		 * constructor 
		 * @param token
		 * 
		 */		
		public function DefaultTokenHandler(token:AsyncToken)
		{
			_token = token;
		}
		
		public function getToken():AsyncToken{
		   return _token;
		}
		
		/**
		 * 默认处理，未完成 
		 * @param resultHandler
		 * @param type
		 * @param faultHandler
		 * 
		 */		
		public function addHandler(resultHandler:Function, type:Boolean = true, faultHandler:Function = null):void
		{
			
		}
		
	}
}
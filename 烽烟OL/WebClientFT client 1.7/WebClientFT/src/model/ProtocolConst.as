package model
{
	/**
	 * 协议常量，比如定义返回结果0为失败，1为成功 
	 * @author mutou
	 * 
	 */	
	public class ProtocolConst
	{
		public function ProtocolConst()
		{
		}
		/**
		 * 注册成功 
		 */		
		public static const FAIL_TYPE:String = "0";
		/**
		 * 注册失败 
		 */		
		public static const SUCCESS_TYPE:String = "1";
		/**
		 * 验证码过期 
		 */		
		public static const VALIDATE_CODE_EXPIRE:String = "2";
	}
}